class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :user # if user is retired, this column is null
      t.references :event, null: false, foreign_key: true, index: false
      t.string :comment

      t.timestamps
    end

    # not allow to user join same event duplicate
    add_index :tickets, %i[event_id user_id], unique: true
  end
end
