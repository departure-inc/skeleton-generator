require 'ddtrace'
Datadog.configure do |c|
  c.tracing.instrument :active_record
  c.service = 'my-rails-app'
  c.env = 'production'
  c.tags = { 'team' => 'sre' }
end
# agent export env
# export DD_API_KEY=your_datadog_api_key
# export DD_APM_ENABLED=true
# export DD_APM_NON_LOCAL_TRAFFIC=true
