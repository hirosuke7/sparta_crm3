class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [ :show, :edit, :update, :destroy]
  def index
    @q = Customer.includes(:post, :company).ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if  @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def update
    if  @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @comment = Comment.new
    # @comments = Comment.where(customer_id: params[:id].to_i)
    # 下記を追加
    @comments = @customer.comments
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  def set_customer
  end

  private

  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email,
      :company_id,
      :post_id)
    end

  end
