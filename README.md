# Expense Management

[![Code Climate](https://codeclimate.com/github/boddhisattva/expenses/badges/gpa.svg)](https://codeclimate.com/github/boddhisattva/expenses) [![Test Coverage](https://codeclimate.com/github/boddhisattva/expenses/badges/coverage.svg)](https://codeclimate.com/github/boddhisattva/expenses/coverage) [![Circle CI](https://circleci.com/gh/boddhisattva/expenses.svg?style=svg)](https://circleci.com/gh/boddhisattva/expenses)

<hr />

## About

This is an app to help better track your expenses. With this app one can -
* Maintain a list of user expenses that can be searched, sorted and paginated through
* Calculate the total cost of expenses within a specified time period

One can try using the app wrt the work done so far on [this link][website link]

## Usage

### Dependencies

1. Ruby 2.3
2. Rails 4.2.5.1
3. PostgreSQL 9.4.1
3. For other dependencies, please check the [Gemfile][gemfile]

### Setup

#### Development
1. Clone the repo, and `cd` into the same
2. Run -
 1. `bundle install`
 2. `cp config/database.yml.example config/database.yml`
 3. `rake db:create`
 4. `rake db:migrate`

#### Test
1. From the project root directory run -
 1. `rake db:migrate RAILS_ENV=test`(this step assumes you've run `rake db:create` already)

### Get the app up and running

#### Development
1. From the project root directory run -
 1. `rails s` to kickstart your app web server
 2. Navigate to `http://localhost:3000` in your browser

### Running your specs
1. From the project root directory -
 1. Use `bundle exec rspec` to run all your specs

<hr />

## Future Scope

1. Add a Forgot password feature
2. Add admin capabilities to the app
3. Send e-mails about one's periodical(e.g., monthly) expenses

## Feedback

* Feel free to mail me your thoughts about the app on mail4mohnish@gmail.com

[gemfile]: https://github.com/boddhisattva/expenses/blob/master/Gemfile
[website link]: https://trackyourexpenses.herokuapp.com/
