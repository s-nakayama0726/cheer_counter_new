class CreateCheers < ActiveRecord::Migration[5.1]
  def change
    create_table :cheers do |t|

      t.timestamps
    end
  end
end
