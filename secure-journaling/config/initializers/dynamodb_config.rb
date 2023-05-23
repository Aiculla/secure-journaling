require 'aws-sdk-dynamodb'

Aws.config.update({
    region: 'us-east-1',
    credentials: Aws::Credentials.new('','')
  })