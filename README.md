## Deploy.RB / Rails 5 App

This is a part of the [Deploy.RB](https://deployrb.github.io/) project.

Deploy.RB consists of:

1. [Rails 5 App](https://github.com/DeployRB/Rails5App) (**You are here**)
2. [Server Installation Script & Manual](https://github.com/DeployRB/SetupServer)
3. [Deployment Tool](https://github.com/DeployRB/DeployTool)

Please, visit [Deploy.RB](https://deployrb.github.io/) page to get more information.

```
```

# Rails 5 App

Simple Rails 5 App for `deploy.rb` project

With this App we demonstrate how basic Rails 5 can be configurated for deployment process

The app uses the following tools:

* PostgreSQL (as main DB Storage)
* Devise (Authentication)
* Redis (Cache store and store for SideKiq)
* SideKiq (Delayed jobs)
* Thinking Sphinx (Full-text search)
* `mysql2` adapter to work with `Thinking Sphinx`
* `foreman` to start/stop services
* WebSockets (ActionCable)
* Whenever (Cron tasks)
* `kaminari` for pagination

## How to run on local machine

### System requirements

- Unix like OS
- Redis (http://redis.io)
- Sphinx (http://sphinxsearch.com)
- PostgreSQL (http://postgresql.org)
- MySQL (http://mysql.com)

<details>
  <summary>[open ▾] How to check required software?</summary>

```
$ which rvm
/Users/$HOME/.rvm/bin/rvm

$ which redis-server
/usr/local/bin/redis-server

$ which searchd
/usr/local/bin/searchd

$ which psql
/usr/local/bin/psql

$ which mysql
/usr/local/bin/mysql
```

</details>

### 1. Clone & install

```sh
git clone https://github.com/DeployRB/Rails5App.git
cd Rails5App

gem install bundler
bundle install
```

### 2. Copy and configure SETTINGS


```
cp -av config/SETTINGS/environment.example/* config/SETTINGS/development
```

Edit files and set required parameters

### 3. Copy and configure SERVICES

```
cp -av config/SERVICES/environment.example/* config/SERVICES/development
```

Edit files and replace `/ABS/PATH/TO` with real absolute path to your Rails5App

### 4. Setup `database.yml`

```
cp config/database.yml.example config/database.yml
```

Edit file and set required parameters.

<details>
  <summary>[open ▾] How to create PQSL user?</summary>

```
psql -U postgres
CREATE USER "USER.NAME" WITH PASSWORD 'PaSssWorD!';
ALTER ROLE "USER.NAME" SUPERUSER CREATEDB;
\q
```

</details>

### 5. Initialize your App

```
bundle exec rake app:init
```

### 6. Build Search index

```
bundle exec rake ts:configure && bundle exec rake ts:index
```

### 7. Start services

Start cron tasks

<details>
  <summary>[open ▾] CRON. Notes</summary>

* tasks list `crontab -l`
* remove all tasks `crontab -r`

</details>

```sh
whenever --update-crontab \
         --load-file config/SERVICES/development/schedule.rb \
         --set 'environment=development'
```

Start services with `foreman`

```
bundle exec foreman start
```

### 8. Start Rails server

```
puma -b tcp://localhost -p 3000
```

or just

```
rails s
```

### Finally App is ready to use

```
http://localhost:3000
```
