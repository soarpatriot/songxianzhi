class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :value
      t.timestamps
    end
  end
end
