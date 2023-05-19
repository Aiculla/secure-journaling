require_relative '../../config/initializers/dynamodb_config'
require 'securerandom'

class DynamoDBManager
  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
  end

  def dynamodb
    @dynamodb
  end
end

class JournalEntriesController < ApplicationController
  def initialize
    @dynamodb_manager = DynamoDBManager.new
  end

  def create
    dynamodb_client = @dynamodb_manager.dynamodb
    table_name = 'journal_entry'
    item = {
      'user_id' => params[:user_id],
      'timestamp' => Time.now.to_i,
      'entry' => params[:entry],
      'title' => params[:title],
      'entry_id' => SecureRandom.uuid,
      'tags' => params[:tags]
    }
    params = {
      table_name: table_name,
      item: item
    }
    begin
      dynamodb_client.put_item(params)
      render json: {Success: true, Message: 'Entry Successfully Created', Error: nil , Data: item }
    rescue Aws::DynamoDB::Errors::ServiceError => e
      render json: {Success: false, Message: 'Error When Creating Entry', Error: e.message , Data: nil }
    end
  end

  def delete
    dynamodb_client = @dynamodb_manager.dynamodb
    parameters = {
      table_name: 'journal_entry',
      key: {
        'user_id' => params[:user_id],
        'timestamp' => params[:timestamp]
      }
    }
    begin
      dynamodb_client.delete_item(parameters)
      render json: {Success: true, Message: 'Entry Successfully Deleted', Error: nil , Data: nil }
    rescue Aws::DynamoDB::Errors::ServiceError => e
      render json: {Success: false, Message: 'Error When Deleting Entry', Error: e.message , Data: nil }
    end
  end

  def update
    dynamodb_client = @dynamodb_manager.dynamodb
    update_params = {
      table_name: 'journal_entry',
      key: {
        'user_id' => params[:user_id],
        'timestamp' => params[:timestamp]
      },
      expression_attribute_values: {
        ':entry' => params[:entry],
        ':title' => params[:title],
        ':tags' => params[:tags]
      },
      update_expression: 'SET entry = :entry, title = :title, tags = :tags'
    }
    begin
      dynamodb_client.update_item(update_params.to_h)  # Convert params to a hash using to_h
      render json: { Success: true, Message: 'Entry Successfully Updated', Error: nil, Data: update_params[:expression_attribute_values] }
    rescue Aws::DynamoDB::Errors::ServiceError => e
      render json: { Success: false, Message: 'Error When Updating Entry', Error: e.message, Data: nil }
    end
  end
  
  
  def get
    dynamodb_client = @dynamodb_manager.dynamodb
    parameters = {
      table_name: 'journal_entry',
      key_condition_expression: '#user_id = :user_id and #timestamp > :timestamp',
      expression_attribute_names: {
        '#user_id' => 'user_id',
        '#timestamp' => 'timestamp'
      },
      expression_attribute_values: {
        ':user_id' => params[:user_id],
        ':timestamp' => params[:timestamp]
      },
      limit: 20,
      scan_index_forward: false  # to get the results in descending order
    }
    
    if params[:title].present?
      parameters[:filter_expression] = 'contains(title, :title)'
      parameters[:expression_attribute_values][":title"] = params[:title]
    end
    
    if params[:tags].present?
      filter_expression = parameters[:filter_expression].to_s
      
      params[:tags].each_with_index do |tag, index|
        tag_symbol = ":tag#{index}"
        if !filter_expression.empty?
          filter_expression += " AND contains(tags, #{tag_symbol})"
        else
          filter_expression = "contains(tags, #{tag_symbol})"
        end
        parameters[:expression_attribute_values][tag_symbol] = tag
      end

      parameters[:filter_expression] = filter_expression
    end
    puts parameters
    begin
      resp = dynamodb_client.query(parameters)
      render json: { Success: true, Message: 'Entries Successfully Retrieved', Error: nil, Data: resp.items }
    rescue Aws::DynamoDB::Errors::ServiceError => e
      render json: { Success: false, Message: 'Error When Retrieving Entries', Error: e.message, Data: nil }
    end
  end

  
  
  
end