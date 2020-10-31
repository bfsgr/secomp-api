class AddCampeonato < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :campeonatos, :string, array: true
  end
end
