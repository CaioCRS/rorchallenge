require 'rails_helper' 

describe Cnab do 
    it "Valida campos obrigatórios" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: 12.0, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).to be_valid 
    end

    it "Garante que o campo tipo é obrigatório" do 
        user = Cnab.new(tipo: nil, data: Time.now, valor: 12.0, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end
    
    it "Garante que o campo data é obrigatório" do 
        user = Cnab.new(tipo: 1, data: nil, valor: 12.0, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo valor é obrigatório" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: nil, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo cpf é obrigatório" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: 12.0, cpf: nil, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo cartao é obrigatório" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: 12.0, cpf: 68764554082, cartao: nil, nome_proprietario: 'Nome teste', nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo nome_proprietario é obrigatório" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: 12.0, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: nil, nome_loja: 'Loja teste') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo nome_loja é obrigatório" do 
        user = Cnab.new(tipo: 1, data: Time.now, valor: 12.0, cpf: 68764554082, cartao: '3333****4444', nome_proprietario: 'Nome teste', nome_loja: nil) 
        expect(user).not_to be_valid 
    end
end