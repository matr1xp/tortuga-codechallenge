# tortuga-codechallenge

This is a simple expert search tool built with the Ruby on [Rails](http://rubyonrails.org) framework.

## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io) and the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed.

```sh
git clone https://github.com/matr1xp/tortuga-codechallenge.git
cd tortuga-codechallenge
bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails s
```

Your app should now be running on [localhost:3000](http://localhost:3000/).

### Testing

To setup the unit tests run the following:

```sh
RAILS_ENV=test bundle exec rake db:migrate
RAILS_ENV=test bundle exec rake db:seed
```

To run all tests:

```sh
bundle exec rspec -f d
```

or simply

```
rspec
```

## Deploying to Heroku

```
heroku create
git push heroku master
heroku run rake db:migrate
heroku run rake db:seed
heroku open
```

Alternatively, you can deploy your own copy of the app using the web-based flow:

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Documentation

For more information about using Ruby on Heroku, see these Dev Center articles:

- [Ruby on Heroku](https://devcenter.heroku.com/categories/ruby)
- [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby)
- [Heroku Ruby Support](https://devcenter.heroku.com/articles/ruby-support)

## TODOs

- Mobile responsive design
- Caching of search results
- Unit testing
