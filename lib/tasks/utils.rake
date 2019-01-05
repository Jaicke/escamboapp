namespace :utils do
  desc "GENERATE ADMINS"
  task generate_admin: :environment do
    puts "Cadastrando admins"
    10.times do
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.free_email,
        password: "123456",
        password_confirmation: "123456",
        role: [0,0,1,1,1].sample
      )
    end
    puts "Cadastrado com sucesso"
  end

end
