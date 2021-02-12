class Cnab < ApplicationRecord
  validates :tipo, presence: true
  validates :data, presence: true
  validates :valor, presence: true
  validates :cpf, presence: true
  validates :cartao, presence: true
  validates :nome_proprietario, presence: true
  validates :nome_loja, presence: true
end
