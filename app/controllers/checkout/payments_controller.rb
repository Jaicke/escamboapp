class Checkout::PaymentsController < ApplicationController
    
    def create
        # Email: c08293368758373520967@sandbox.pagseguro.com.br
        # Senha: 24DbydnE3fb1fhlL
        # Cartão: Número: 4111111111111111 Bandeira: VISA Válido até: 12/2030 CVV: 123
        ad = Ad.find(params[:ad_id])
        ad.processing!  # esse processo do enum já salva, por isso não é utilizado o .save

        order = Order.create( ad: ad, buyer_id: current_member.id )
        order.waiting!

        payment = PagSeguro::PaymentRequest.new

        payment.reference = order.id
        payment.notification_url = checkout_notifications_url 
        payment.redirect_url = site_ad_detail_url(ad)

        payment.items << {
            id: ad.id,
            description: ad.title,
            amount: ad.price.to_s.gsub(',', '.') # 12.00, "to_s.gsub" para trocar a virgula por ponto 
        }
        response = payment.register

        if response.errors.any?
            redirect_to site_ad_detail_url(ad), alert: "Erro ao processar compra!"
        else
            redirect_to response.url
        end 
        


    end
    
end
