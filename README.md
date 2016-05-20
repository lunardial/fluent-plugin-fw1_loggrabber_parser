# fluent-plugin-fw1_loggrabber_parser

Parsing a LEA format file from FW1-LogGrabber.
https://github.com/certego/fw1-loggrabber

A separator of a LEA format file should be '|'(0x7c).


## Installation

```bash
# for fluentd
gem install fluent-plugin-fw1_loggrabber_parser

# for td-agent2
td-agent-gem install fluent-plugin-fw1_loggrabber_parser
```

## Usage

```xml
<source>
  @type tail
  path /var/log//fw1.log
  pos_file /var/log/td-agent/fw1.log.pos
  tag fw1.log
  format fw1_loggrabber
</source>
```

## parameters
- n/a
