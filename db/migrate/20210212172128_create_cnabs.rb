class CreateCnabs < ActiveRecord::Migration[6.0]
  def change
    create_table :cnabs do |t|
      t.integer :tipo
      t.datetime :data
      t.decimal :valor
      t.bigint :cpf
      t.string :cartao
      t.string :nome_proprietario
      t.string :nome_loja

      t.timestamps
    end
  end
end
