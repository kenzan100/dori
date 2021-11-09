What’s the characteristic of these apps (CRUD based apps)

Why AR won’t be a good fit


ActiveJob exists, but ActivePipeline doesn’t exist 
Ruby doesn’t have opinionated way of data intensive applications
ActiveJob, Sidekiq, but that’s about it

——
Killer apps

- Web crawler?
- Automation (IFTTT, on web apps)
- Data aggregation 
- Google Trends
- Blogosphere
- NomadList, Stats reporting
- CryptoTracker (Stonk aggregator, “Text me when some of these stones gets above/below threshold)
- Trading strategies (when X is a, Y is b, sell/buy Z stock) HFT 

Implementing in Rails first
And see how much of a “pattern” we could be discovering that’s not being addressed by Rails



——

“Many applications mis-categorized as CRUDs”

Data processing/intensive applications benefit (scale better) if it’s designed group-up as:
Unidirectional flow of constants inserts

Models:
```
 A -> B -> C -> D
     -> E ->
                    -> G
     -> F ->
```

——
Who’s audience

How you transform the data
Adapter —sidekiq 
This is ActiveJob extention?


Let’s talk about CM application


Scaffolding 
Rails g scaffold (routing, controllers views migrations, models, ….)

——

Mental models

External-(explicit mapping)->A->B->C

In the end, here’s what I want (in terms of JSON schema)
[
  {
     city_name: “Nagano”,
     max_tempature: Integer(),
  }
]

——

Code example

They need following “config files” (hopefully config files are so simple that you can one-liner it?)
Final destination JSON schema (data end-product)
DAG
    A(city, temperature) ->
                                              -> C(sorted comfortable rank by cities))
    B(city, raining rate) -> 
Run Scaffolding command
For A, B, and C, you would have to fill in A (API key, …), B(local file storage path, ….)
Access localhost:8000/data.json

It’s also defined by what it doesn’t provide
INSERT
DESTROY



——

What’s already out there

Spark pipelines
https://ballerina.io/
https://github.com/alphagov/content-data-api
https://github.com/spotify/luigi




Simplest form of PoC:
Single process, Inline mode (see what it’s like to traverse the DAG)
One web process, one job process is prob. The way to go



——

Bin/rails scaffold —??? 

Datasources
 A Stripe(type: external API)
 B Braintree(…)
 C Recurly(…)

 A,B,C -> CustomerMRRReading???? (type: Postgresql)

 MrrEdits, CustomerMRRReading -> MrrIntervals

 MrrIntervals -> JSON/GraphQL (final destination)

class Stripe < ????
  def connect
    ???
  end
end

Run-time validation 
Given Stirpe -> CustomerMRRReading
  def mapping(stripe data model)
    {
      … -> …
    }
  end
end

 —

Event sourcing baked in to 

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
