require 'sidekiq/cron/job'

schedule_file = "config/sidekiq.yml"

if File.exist?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)[:schedule]
end