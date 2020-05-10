class CreateCsvExports < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_exports do |t|
      t.boolean :finished

      t.timestamps
    end
  end
end
