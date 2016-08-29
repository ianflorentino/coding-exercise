class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :prynt_auth_token
      t.string :oauth_token
      t.datetime :oauth_token_expires_at

      t.timestamps
    end
  end
end
