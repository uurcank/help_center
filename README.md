# HelpCenter

### 📖 Knowledge Base for your Ruby on Rails App 

HelpCenter is a Rails wiki gem with Trix editor support for creating a knowledge base for your project. It includes support categories, support articles, simple moderation, the ability to leave comments to support articles and more.

Out of the box, HelpCenter comes with styling for TailwindCSS 2.0 but you're free to customize the UI as much as you like by installing the views and tweaking the HTML.

## Requirements

```
Rails >= 6.0.0
tailwindcss >= 2.0.0
```

## Installation

Before you get started, HelpCenter requires a `User` model in your application (for now).

Add this line to your application's Gemfile:

```ruby
gem 'help_center'
```

And then execute:

```bash
bundle
```

Install the migrations and migrate:

```bash
rails help_center:install:migrations
rails db:migrate
```

Add HelpCenter to your `User` model. The model **must** have `name` method which will be used to display the user's name on comments & discussions (if enabled). Currently only a model named `User` will work.

```ruby
class User < ActiveRecord::Base
  include HelpCenter::SupportUser

  def name
    "#{first_name} #{last_name}"
  end
end
```

Next add a `moderator` or `admin` flag to the `User` model.

```bash
rails g migration AddModeratorToUsers moderator:boolean
rails db:migrate
```
Only moderators or admins can add support articles.

```
if current_user.admin? || current_user.moderator?
```

Add the following line to your `config/routes.rb` file:

```ruby
mount HelpCenter::Engine => "/docs"
```

Add routes for active storage with your custom prefix

```ruby
get "/support/rails/active_storage/blobs/:signed_id/*filename" =>
     "active_storage/blobs#show"
get "/support/rails/active_storage/representations/:signed_blob_id/:variation_key/*filename" =>
     "active_storage/representations#show"
```

Lastly, add the CSS to your `application.css` to load some default styles.

```scss
*= require help_center
```

## Usage

To get all the basic functionality, the only thing you need to do is add a link to HelpCenter in your navbar.

```erb
<%= link_to "Docs", help_center_path %>
```

This will take the user to the views inside the Rails engine and that's all you have to do!

### Customizing

If you'd like to customize the views that HelpCenter uses, you can install the views to your Rails app:

```bash
rails g help_center:views
```

You can also install a copy of the HelpCenter controllers for advanced customization:

```bash
rails g help_center:controllers
```

Helpers are available for override as well. They are used for rendering the user avatars, text formatting, and more.

```bash
rails g help_center:helpers
```

**NOTE:** Keep in mind that the more customization you do, the tougher gem upgrades will be in the future.

### User comments & Notifications

You can enable user comments and questions for support articles. HelpCenter will attempt to send email and slack notifications for users who leave comments when a new reply posted.

To turn these off you can do the following in `config/initializers/help_center.rb`

```ruby
HelpCenter.setup do |config|
  config.article_dicussions = false # Default: false
  config.send_email_notifications = false # Default: true
  config.send_slack_notifications = false # Default: true
end
```

Slack notifications require you to set `help_center_slack_url` in your `config/secrets.yml`. If you don't have this value set, it will not attempt Slack notifications even if they are enabled.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Roadmap / Upcoming features
Your support is appreciated for this project. Consider backing the project via GitHub Sponsors.

We plan to release following features:

- Contact form
- Built-in search
- Versioning Support
- Themes
- Dark Mode Support

## Acknowledgment

[simple_discussion](https://github.com/excid3/simple_discussion) by [Chris Oliver](https://github.com/excid3)

[Trix editor](https://github.com/basecamp/trix) by [Basecamp](https://github.com/basecamp)

[TailwindCSS](https://github.com/basecamp/trix) by [Tailwind Labs](https://github.com/tailwindlabs/tailwindcss)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uurcank/help_center This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HelpCenter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pasilobus/help_center/blob/master/CODE_OF_CONDUCT.md).
