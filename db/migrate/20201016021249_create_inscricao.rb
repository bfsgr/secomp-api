class CreateInscricao < ActiveRecord::Migration[6.0]
  def change
    create_table :inscricaos do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :cpf
      t.string :ra
      t.string :unsubscribe_token
    end
  end
end
