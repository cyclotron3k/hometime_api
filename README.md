# Hometime API

## Setup & Run

```sh
git clone https://github.com/cyclotron3k/hometime_api.git
cd hometime_api

# Start Rails server:
docker-compose -f docker-compose.dev.yaml --profile rails up --build
# Teardown:
docker-compose -f docker-compose.dev.yaml --profile rails down

# Run unit tests:
docker-compose -f docker-compose.dev.yaml run hometime-rails-test
```

## How to add another parser

Make a copy of `services/interfaces/sample.rb` and fill in the blanks.

Each parser must:
* Inherit from `ParserBase`
* Define const `SCHEMA`, set to an appropriate JSON schema
* Define `create_entities!` method, responsible for creating/updating entities

Don't forget to add unit tests.

## Notes & possible improvements

### Better reporting of validation errors
The API currently returns only a success or fail message to the consumer. Rails endpoints typically respond with detailed information about validation failures, but since this an API, to be consumed by machines, and not one that will be used by 3rd parties, I think this will be sufficient.
That said, it might be useful for developers working on the code base to get better debugging info

### Implement custom exception types for the various validation failures
Currently we're relying on RuntimeErrors, but implementing a range of custom exceptions would help with debugging and ergonomics.

### Rubocop & bundler-audit
Necessary in long-lived code bases, and code bases that are worked on by multiple developers.

### Input sanitization, validations & security.
- Validations could be a lot tighter; for example, `currency` should use the official ISO 4217 list - not a hard coded list. That said, the data is coming from third party systems that already apply validations, so the value would be minimal.
- Furthermore, when we receive a new reservation from our partners, that indicates that it's passed all their validations, and it's a legitimate booking - there should be no scenario where we are rejecting it.
- It's possible to do strict validation in the JSON schemas, but it's better to do it in the models.
- There is no endpoint security, and this would be a requirement for a public-facing or multi-user system.
- It would probably be useful to create a common mapping of the `status` fields.
