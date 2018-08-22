## Secure Planet API

A Ruby on Rails API to process web requests and run the Secure Planet engine for the Secure Planet Web Platform.

## Technology Stack / Requirements
- Ruby 2.3.3
- Rails 4.2.7.1
- PostgreSQL 9.6

## App Setup

### Installing Dependencies
To install dependencies run:
```
$ bundle install
```

### Database Configuration
The app uses PostgreSQL.
To set the databases enviroments you need to create a file called `database.yml` in the config directory (`/config/database.yml`).
The format of this file is yml based and you can get an example from the `/config/database.yml.example` file. You also need to have your PostgreSQL server running.

### Credentials
In order to properly set up the app you will need a `secrets.yml` file with a secret_key_base for the particular environments. You need to create the file in the config directory (`/config/secrets.yml`). You can use the example from the `/config/secrets.yml.example` file by copying it or create your own secret keys by running:
```
$ bundle exec rake secret
```
You should also provide a superuser `email` and `password` if you want to create a basic seeds setup for the app.

### Database Setup
To create the applications database and load the schema run:
```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```
Note: To use attribute encryption the creation of the database needs to be separated from seeding the database with data.

### Database Seeds - Basic Setup
In order to create the basic setup of the app with a `super_company`, a `default_customer_company` and a `super_user` you need to seed the database with appropriate data. In order to do so you need to run:
```
$ bundle exec rake db:seed:basic_setup
```
### Start Server
In order to start the server on http://localhost:3000/ you will need to run:
```
$ rails server
```
## Tests
[RSpec][1] and [RSpec-Rails][2] are used for testing, following [Test-Driven Development][3] methodologies.
To run the tests use:
```
$ bundle exec rspec
```

### Authentication
The SecurePlanet API uses [Devise Gem - Flexible authentication solution for Rails with Warden][5]
for authentication, and [Doorkeeper][6] for token generation and verification.
Doorkeeper is an OAuth 2 provider for Rails. It's built on top of Rails engines. The gem is in active development.

### CORS
To allow API consumption from other domains in Javascript we need to supply support for [CORS][7].
CORS support is provided by the Cors Rack middleware.
If you want to restrict the communication only to a particular domain, you need to add a `client_app_origin` key to the `config/config.yml` file that specifies a particular host. A `client_ssl` key should be added and set to true if the client origin uses ssl.

$ rake docs:generate
```
This command will create a `/doc/api` directory in the main app directory that will contain the necessary documenation in html format. You can then open the 'index.html' file in the browser to read through the documentation.

[1]: http://rspec.info/
[2]: https://github.com/rspec/rspec-rails
[3]: http://agiledata.org/essays/tdd.html
[4]: https://github.com/colszowka/simplecov
[5]: https://github.com/plataformatec/devise
[6]: https://github.com/doorkeeper-gem/doorkeeper
[7]: https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
