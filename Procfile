redis: redis-server ./config/SERVICES/development/redis.config
sidekiq: RAILS_ENV=development bundle exec bin/sidekiq -e development -C ./config/SERVICES/development/sidekiq.yml
ts_sphinx: RAILS_ENV=development bundle exec rake ts:start NODETACH=true
