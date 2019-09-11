# Arroyo

Arroyo is a stream-oriented Ruby client for [Amazon S3][s3]. When uploading and downloading, Arroyo
exposes the underlying HTTP request and response body streams, enabling efficient and flexible
data transfer.

Currently, this library is an incomplete sketch. Only downloading is implemented.

[s3]: https://aws.amazon.com/s3/

## Usage

Instantiate an `Arroyo::Client` with service account credentials:

```ruby
client = Arroyo::Client.new(access_key_id: "...", secret_access_key: "...", region: "us-east-1")
```

Open a bucket:

```ruby
bucket = client.buckets.open("my-bucket")
```

Download an object to disk:

```ruby
bucket.download("README.md", "/path/to/README.md")
```

Download an object to a tempfile:

```ruby
require "tempfile"

Tempfile.open(["README", ".md"]) do |tempfile|
  bucket.download("README.md", tempfile)
end
```

Compute an object’s checksum 1 MB at a time:

```ruby
checksum = Digest::SHA256.new.tap do |digest|
  bucket.download("README.md") do |io|
    io.each(1.megabyte) { |chunk| digest << chunk }
  end
end.base64digest
```

## License

Copyright (c) 2019 George Claghorn.

Arroyo is released under the terms of the MIT license. See `LICENSE` for details.