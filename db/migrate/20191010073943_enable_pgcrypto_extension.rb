# frozen_string_literal: true

# UUID as a primary key instead autoincrement integer for PostgreSQL
# En required extensions for UUID as primary key
class EnablePgcryptoExtension < ActiveRecord::Migration[6.0]
  # def change
  #   enable_extension 'uuid-ossp'
  #   enable_extension 'pgcrypto'
  # end

  def up
    enable_extension('uuid-ossp') unless extensions.include?('uuid-ossp')
    enable_extension('pgcrypto') unless extensions.include?('pgcrypto')
  end

  def down
    disable_extension('uuid-ossp') if extensions.include?('uuid-ossp')
    disable_extension('pgcrypto') if extensions.include?('pgcrypto')
  end
end
