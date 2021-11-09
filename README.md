

----

# Dori
Dori is an "unidirectional" web application framework. For quickly building a data-processing application.

# How to use

## Constructs

There're two types of primitives in Dori. `Dori::Read` and `Dori::Write`.
Depending on your application idea, start from either one of them.

## Read first approach

`Dori::Read` encapsulates the data retrieval logic for supported data sources.
Currently it supports:

- (idea) URL
- (idea) Postgres
- (idea) Webhooks

```ruby
class WeatherRead < Dori::Read
end
```

```ruby
response = WeatherRead.call
=> { }
```

## Write first approach

TBC

## Scaffolding

```
$ bin/dori create application_name
```

produces

```
application_name
|-- main.rb
|-- 1reader
|-- 2reader
    |-- 1writer
    |-- 2writer
        |-- 3reader
```
