class Public::AddressesController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def index
    @addresses = current_customer.addresses.page(params[:page]).per(10) #ページネーション追記
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
    redirect_to request.referer, notice: "配送先登録に成功しました"
    else
      @addresses = current_customer.addresses.page(params[:page]).per(10) #ログインしている会員のアドレスを全て@addressesに入れる
      render 'index'
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.customer_id = current_customer.id
    address.destroy
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.update(address_params)
     redirect_to addresses_path, notice: "更新に成功しました"
    else
      render 'edit'
    end
  end

  private
  def address_params
    params.require(:address).permit(:name, :post_code, :address)
  end

  def ensure_correct_customer
     @address = Address.find(params[:id])
      unless @address.customer == current_customer
       redirect_to addresses_path
      end
  end
end
