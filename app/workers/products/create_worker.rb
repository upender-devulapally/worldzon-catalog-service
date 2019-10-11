# frozen_string_literal: true

# This job will run after recurring task is created.
# Purpose is creating task_occurrences with due_date from schedule(form ice-cube gem) recurring_rules
module Products
  # Bulk insert records using activerecord-import gem after recurring task is created
  class CreateWorker
    include Sidekiq::Worker
    sidekiq_options queue: :create_product # , retry: false, backtrace: true

    def perform(product_id)
      product = Product.find(product_id)
      puts "New Product is created: #{product.name}"
    rescue ActiveRecord::RecordNotFound => e
      log_error_trace(product_id, e.message)
    end

    def log_error_trace(product_id, msg)
      log_msg = <<-DOC

       ----- ****   ERROR: Running Products::CreateWorker *****--------------
       |     Don't find product with ID: #{product_id}                                  |
       |     May be task is deleted immediately                                   |
       |     ActualError: #{msg}                                                  |
       ------------------------ ****************** --------------------------------
      DOC
      Rails.logger.error log_msg
    end

  end
end