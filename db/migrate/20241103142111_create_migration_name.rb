class CreateMigrationName < ActiveRecord::Migration[6.1]
  def change
    create_table :migration_names do |t|

      t.timestamps
    end
  end
end
