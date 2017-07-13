class CreateCheers < ActiveRecord::Migration[5.1]
  def change
    create_table :cheers do |t|
      t.references :player, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
