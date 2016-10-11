redis: redis-server ./config/SERVICES/development/redis.config
sidekiq: RAILS_ENV=development bin/sidekiq -e development -C ./config/SERVICES/development/sidekiq.yml
ts_sphinx: RAILS_ENV=development rake ts:start NODETACH=true
