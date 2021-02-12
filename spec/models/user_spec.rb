require 'rails_helper' 
describe User do 
    it "Valida campos obrigatórios" do 
        user = User.new(username: 'Adm test', password_digest: 'Password test') 
        expect(user).to be_valid 
    end

    it "Garante que o campo username é obrigatório" do 
        user = User.new(username: nil, password_digest: 'Password test') 
        expect(user).not_to be_valid 
    end

    it "Garante que o campo password_digest é obrigatório" do 
        user = User.new(username: 'Adm test', password_digest: nil) 
        expect(user).not_to be_valid 
    end
end