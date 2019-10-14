# frozen_string_literal: true

# ==> Namespaced redis db
# Sidekiq configuration(project specific) for redis server to use
#  different db with namespace -> where 4 is the db name

# ==> Life in the Cloud
# One problem with cloud-based systems like EC2 and Heroku is unpredictable network performance.
# You should tune your network timeouts to be a little more lenient
# if you are seeing occasional timeout errors, it defaults to 1 second.
# config.redis = { url: 'redis://...', network_timeout: 5 }

# ==> Disabled CLIENT command
# Some Redis servers have all CLIENT commands disabled for security purposes (to avoid accidental CLIENT KILLs, etc).
# In this case, you may disable Sidekiq's CLIENT SETNAME command by setting id option to nil:
#  config.redis = { url: 'redis://...', id: nil }

# ==> Custom Error handler
# Sidekiq.configure_server do |config|
#   config.error_handlers << Proc.new {|ex,ctx_hash| MyErrorService.notify(ex, ctx_hash) }
# end
# @example: https://github.com/mperham/sidekiq/issues/2261

# ==> Tricks for using sidekiq & redis
# https://medium.com/handy-tech/sidekiq-best-practices-cbc2d070a7d4
# https://medium.com/@et3216/9-ways-to-boost-sidekiq-performance-correctly-in-practical-experiences-bfebe9ee0f28
# https://github.com/mhenrixon/sidekiq-unique-jobs
# https://dev.to/jamby1100/coding-sidekiq-workers-the-right-way-4jij
# *** https://dev.to/appaloosastore/active-record-sidekiq-pools-and-threads-18d5

# ==> Clear Redis db follow below steps
# -> Delete default or currently selected database (usually `0) with
#    $ redis-cli flushdb
# -> Delete specific redis database with (e.g. 4 as my target database):
#    $ redis-cli -n 4 flushdb
# -> Delete all redis databases with
#    $ redis-cli flushall

# ==> To clear out everything in Sidekiq, run the following from the rails console:
# NOTE: don't run below in production env
# -> Sidekiq::Queue.all.each(&:clear)
# -> Sidekiq::RetrySet.new.clear
# -> Sidekiq::ScheduledSet.new.clear
# -> Sidekiq::DeadSet.new.clear

# Use redis DB 20 for all job data
# redis = { url: 'redis://localhost:6379/4' }
redis_db = case Rails.env.to_sym
           when :development then 10
           when :production then 1
           else
             1
           end
# DOCKER fix:
# https://stackoverflow.com/questions/48802444/rails-docker-sidekiq-error-connecting-to-redis-on-127-0-0-16379-errnoe?rq=1
redis = { url: "redis://redis:6379/#{redis_db}",
          # namespace: "doo-date-#{Rails.env}", # enable while dealing with multiple projects
          network_timeout: 5 }
# SERVER
Sidekiq.configure_server do |config|
  config.redis = redis
end
# CLIENT
Sidekiq.configure_client do |config|
  config.redis = redis
end

# TODO: work on logging for sidekiq jobs
# Sidekiq::Logging.logger = Rails.logger
