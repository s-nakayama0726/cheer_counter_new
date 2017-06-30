class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :player_name
      t.integer :play_flg

      t.timestamps
    end
  end
end
