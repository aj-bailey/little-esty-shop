class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.all
    @enabled_items = @merchant.items.enabled
    @disabled_items = @merchant.items.disabled
    @top_5_items = @merchant.top_five_merchant_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = @item.merchant
    @item.update(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} Information has been Updated"
      if params[:item][:status]
        redirect_to "/merchants/#{@merchant.id}/items"
      else
        redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      end
    end
  end

  def new 
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items"
      flash[:notice] = "#{@item.name} has been Created!"
    else
      redirect_to "/merchants/#{@merchant.id}/items/new"
      flash[:notice] = "Missing Information! Cannot be Created!"
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end