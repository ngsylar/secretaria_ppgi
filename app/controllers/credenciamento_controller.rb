class CredenciamentoController < ApplicationController
    skip_before_action :verify_authenticity_token

    def show_form
        puts current_user.id
        if Credenciamento.where(:iduser => current_user.id).exists?
            render 'credenciamento/alreadyhascredenciamento'
        else
            render 'credenciamento/show_form'
        end
    end

    def create_credenciamento
        Credenciamento.create(iduser: current_user.id)
        redirect_to '/'
    end

    def show_pedidos
        render 'credenciamento/show_pedidos'
    end

    def aproved
        @credencial = Credenciamento.find(params[:id])
        @credencial.aproved = true
        @credencial.rejected = false
        @credencial.save
        render 'credenciamento/show_pedidos'
    end

    def rejected
        @credencial = Credenciamento.find(params[:id])
        @credencial.rejected = true
        @credencial.aproved = false
        @credencial.save
        render 'credenciamento/show_pedidos'
    end
end