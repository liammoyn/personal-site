# rails-8-template

For your AppDev Projects!

All files are covered by the MIT license, see [LICENSE.txt](LICENSE.txt).


- Ability to sign in / out
- Create new topics
- Add note documents to a topic
- Generate AI article on a topic


## Steps to run locally on mac

```bash
# Install ruby and version manager
brew install rbenv ruby-build
rbenv global 3.4.1

# Install postgres
brew install posgresql@15

# Install gems for project
gem install bundler

# Start background db server on mac
brew services start postgresql@15

# Create default user "postgres"
createuser -s postgres

# Setup database URL read from ./config/database.yml
export DATABASE_URL="postgresql://localhost/personal-site_development"

# Create db and apply migrations
rails db:create
rails db:migrate

# Run app
rails s
```

```bash
# Stop db server on mac
brew services stop postgresql@15
```
