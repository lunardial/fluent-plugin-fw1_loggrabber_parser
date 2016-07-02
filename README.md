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

The following is a sample of td-agent configuration for input FW1-LogGrabber logs
```xml
<source>
  @type     tail
  path      /var/log/fw1.log
  pos_file  /var/log/td-agent/fw1.log.pos
  tag       fw1.log
  format    fw1_loggrabber
</source>
```

The following is a sample of td-agent configuration for output to a elasticsearch
```xml
<match fw1.log>
  @type  copy

  <store>
    @type    forest
    subtype  elasticsearch

    <template>
      host                 localhost
      port                 9200
      logstash_format      true
      logstash_prefix      ${tag}
      logstash_dateformat  %Y.%m.%d
      utc_index            true
      include_tag_key      false

      type_name            ${tag}
      buffer_path          /var/log/td-agent/buffer/elasticsearch-${tag}.buffer

      flush_interval       1s
      request_timeout      15s
      buffer_type          file
      buffer_chunk_limit   8m
      buffer_queue_limit   256
      retry_limit          5

      <secondary>
        @type  file
        path   /var/log/td-agent/error/elasticsearch-${tag}_error.log
      </secondary>

    </template>

  </store>

  <store>
    @type    forest
    subtype  file

    <template>
      format                       json
      path                         /var/log/td-agent/${tag}.log
      include_time_key             true
      append                       true
      localtime                    true
      buffer_type                  file
      buffer_path                  /var/log/td-agent/buffer/file-${tag}.buffer
      flush_interval               1s
      try_flush_interval           1
      retry_limit                  17
      disable_retry_limit          true
      retry_wait                   1.0
      num_threads                  1
      queued_chunk_flush_interval  1
      buffer_chunk_limit           8m
      buffer_queue_limit           256
    </template>

  </store>

</match>
```

## parameters
- n/a
