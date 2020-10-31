class DeleteCampeonatos < ActiveRecord::Migration[6.0]
  def change
    remove_column :inscricaos, :campeonatos
  end
end
