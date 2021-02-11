class CreateCnabs < ActiveRecord::Migration[6.0]
  def change
    create_table :cnabs do |t|
      t.integer :tipo
      t.date :data
      t.decimal :valor
      t.integer :cpf
      t.string :cartao
      t.time :hora
      t.string :nome_proprietario
      t.string :nome_loja

      t.timestamps
    end
  end
end
