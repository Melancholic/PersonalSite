class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.references :role, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.index [:role_id,:user_id], unique: true;
    end
  end
end
