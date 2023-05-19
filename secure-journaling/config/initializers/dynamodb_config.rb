require 'aws-sdk-dynamodb'

Aws.config.update({
    region: 'us-east-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY'],ENV['AWS_SECRET_KEY'])
  })