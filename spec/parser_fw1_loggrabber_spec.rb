# -*- coding: utf-8 -*-

require 'helper'

class TestFw1LoggrabberParser
  RSpec.describe Fluent::TextParser::Fw1LoggrabberParser do

    CONFIG = %[]

    def create_driver(conf=CONFIG, tag='test')
      Fluent::Test::ParserTestDriver.new(Fluent::TextParser::Fw1LoggrabberParser, tag).configure(conf)
    end

    def create_parser
      @parser = Fluent::TextParser::Fw1LoggrabberParser.new
    end
    
    before :all do
      Fluent::Test.setup
    end

    before :each do
      @log = 'time=2016-04-18 17:11:20|action=drop|orig=192.168.0.155|i/f_dir=inbound|i/f_name=eth1|has_accounting=0|uuid=<00000000,00000000,00000000,00000000>|product=VPN-1 & FireWall-1|rule=4|rule_uid={6F779801F-9827-4084-A513-8C6094CCDF29}|src=192.168.0.90|s_port=54438|dst=224.0.0.252|service=5355|proto=udp|__policy_id_tag=product=VPN-1 & FireWall-1[db_tag={EFBF0C12-72BB-5542-909E-6976080402E5};mgmt=mgmt_4400;date=1460945227;policy_name=Standard]|origin_sic_name=cn=cp_mgmt,o=4400..wewbq8'
      @log_with_escaped_separator = 'time=2016-04-18 17:11:20|action=drop|orig=192.168.0.155|i/f_dir=inbound|i/f_name=eth1|has_accounting=0|uuid=<00000000,00000000,00000000,00000000>|product=VPN-1 & FireWall-1|rule=4|rule_uid={6F779801F-9827-4084-A513-8C6094CCDF29}|src=192.168.0.90|s_port=54438|dst=224.0.0.252|service=5355|proto=udp|__policy_id_tag=product=VPN-1 & FireWall-1[db_tag={EFBF0C12-72BB-5542-909E-6976080402E5};mgmt=mgmt_4400;date=1460945227;policy_name=Standard\|Irregular]|origin_sic_name=cn=cp_mgmt,o=4400..wewbq8'

      @driver = create_driver
      @parser = create_parser()

    end





    context "#parse" do
      it "returns record because of good text" do
        text = @log
        expect_result = {
          '__policy_id_tag' => 'product=VPN-1 & FireWall-1[db_tag={EFBF0C12-72BB-5542-909E-6976080402E5};mgmt=mgmt_4400;date=1460945227;policy_name=Standard]',
          'action'          => 'drop',
          'dst'             => '224.0.0.252',
          'has_accounting'  => '0',
          'i/f_dir'         => 'inbound',
          'i/f_name'        => 'eth1',
          'orig'            => '192.168.0.155',
          'origin_sic_name' => 'cn=cp_mgmt,o=4400..wewbq8',
          'product'         => 'VPN-1 & FireWall-1',
          'proto'           => 'udp',
          'rule'            => '4',
          'rule_uid'        => '{6F779801F-9827-4084-A513-8C6094CCDF29}',
          's_port'          => '54438',
          'service'         => '5355',
          'src'             => '192.168.0.90',
          'time'            => '2016-04-18 17:11:20',
          'uuid'            => '<00000000,00000000,00000000,00000000>',
        }
        result = @driver.parse(text) { |time, record|
          record
        }
        expect(result).to match(expect_result)
      end

      it "returns record with escaped separator because of good text" do
        text = @log_with_escaped_separator
        expect_result = {
          '__policy_id_tag' => 'product=VPN-1 & FireWall-1[db_tag={EFBF0C12-72BB-5542-909E-6976080402E5};mgmt=mgmt_4400;date=1460945227;policy_name=Standard\|Irregular]',
          'action'          => 'drop',
          'dst'             => '224.0.0.252',
          'has_accounting'  => '0',
          'i/f_dir'         => 'inbound',
          'i/f_name'        => 'eth1',
          'orig'            => '192.168.0.155',
          'origin_sic_name' => 'cn=cp_mgmt,o=4400..wewbq8',
          'product'         => 'VPN-1 & FireWall-1',
          'proto'           => 'udp',
          'rule'            => '4',
          'rule_uid'        => '{6F779801F-9827-4084-A513-8C6094CCDF29}',
          's_port'          => '54438',
          'service'         => '5355',
          'src'             => '192.168.0.90',
          'time'            => '2016-04-18 17:11:20',
          'uuid'            => '<00000000,00000000,00000000,00000000>',
        }
        result = @driver.parse(text) { |time, record|
          record
        }
        expect(result).to match(expect_result)
      end

      it "returns empty record because of empty text" do
        text = ""
        expect_result = {}
        result = @driver.parse(text) { |time, record|
          record
        }
        expect(result).to match(expect_result)
      end

      it "returns empty record because of text is nil" do
        text = nil
        expect_result = {}
        result = @driver.parse(text) { |time, record|
          record
        }
        expect(result).to match(expect_result)
      end

    end
    
  end

end
