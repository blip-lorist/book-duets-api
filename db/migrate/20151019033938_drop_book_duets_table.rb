class DropBookDuetsTable < ActiveRecord::Migration
  def change
    drop_table :book_duets
  end
end
