`dry_open_api`

Providing a [dry](https://dry-rb.org/) version of th [open_api gem](https://github.com/ngtk/open_api).
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry_open_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry_open_api

## Usage
It has two use case:

1. Serializing from PORO to yaml
2. Deserializing yaml to PORO

### Serializing

```rb
spec = DryOpenApi::Specification.new(
  openapi: "3.0.1",
  info: DryOpenApi::Info.new(
    title: "Awesome API",
    description: "It provides something awesome",
    version: "1.0.0",
  ),
  paths: DryOpenApi::Paths.new(
    "/pets": DryOpenApi::PathItem.new(
      get: DryOpenApi::Operation.new(
        description: "Returns all pets from the system that the user has access to",
        responses: DryOpenApi::Responses.new(
          "200": DryOpenApi::Response.new(
            description: "A list of pets.",
            content: {
              "application/json": DryOpenApi::MediaType.new(
                schema: DryOpenApi::Schema.new(
                  type: "array",
                  items: DryOpenApi::Reference.new(ref: "#/components/schemas/pet"),
                )
              )
            }
          )
        )
      )
    )
  )
)

yaml = DryOpenApi::Serializers::YamlSerializer.serialize(spec)
File.write("spec.yml", yaml)
```

### Deserializing

```rb
yaml = File.read("spec.yml")
spec = DryOpenApi::Serializers::YamlSerializer.deserialize(yaml)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, run `bundle exec rake bump:patch` to update the version, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/talentplatforms/dry_open_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpenApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/talentplatforms/dry_open_api/blob/master/CODE_OF_CONDUCT.md).
