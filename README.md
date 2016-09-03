# Logstash Base64 Filter Documentation

[![Travis Build Status](https://travis-ci.org/tiwilliam/logstash-filter-base64.svg)](https://travis-ci.org/tiwilliam/logstash-filter-base64)
[![Gem Version](https://badge.fury.io/rb/logstash-filter-base64.svg)](https://badge.fury.io/rb/logstash-filter-base64)

This filter helps you to base64 decode/encode your fields.

## Decode field

```
base64 {
    field => "blob"
}
```

## Encode field

```
base64 {
    field => "blob"
    action => "encode"
}
```

## Tags your event on failure

This filter will by default tag your event with `_base64failure` in-case the field fails to encode/decode. This usually happens when you are trying to decode a broken or non-base64 message or encode something else than a string. You can override the tag set like this:

```
base64 {
    field => "blob"
    tag_on_failure => ["my_fail_tag"]
}
```

## Filter options

* **action**

  The type of base64 transformation (`decode` or `encode`). Defaults to `decode`.

* **field**

  The field to encode/decode in-place. Defaults to `message`.

* **tag_on_failure**

  Append values to the `tags` field on encode/decode failure. Defaults to `["_base64failure"]`.

## Changelog

You can read about all changes in [CHANGELOG.md](CHANGELOG.md).

## Need help?

Need help? Try #logstash on freenode IRC or the [Logstash discussion forum](https://discuss.elastic.co/c/logstash).

## Want to contribute?

Get started by reading [BUILD.md](BUILD.md).
