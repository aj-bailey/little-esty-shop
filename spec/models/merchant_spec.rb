require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '::Class Methods' do
    before(:each) do
      @merchant = create(:merchant, name: "Trader Bob's")

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id)
      @invoice_7 = create(:invoice, customer_id: @customer_6.id)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: "Sun, 25 Jan 2023 00:28:40")
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: "Mon, 26 Jan 2023 00:28:41")
      @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: "Tues, 27 Jan 2023 00:28:42")
      @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_4, quantity: 1, status: "packaged", created_at: "Wed, 28 Jan 2023 00:28:43")
      @invoice_item_5 = create(:invoice_item, item: @item_1, invoice: @invoice_5, quantity: 1, status: "packaged", created_at: "Thur, 29 Jan 2023 00:28:44")
      @invoice_item_6 = create(:invoice_item, item: @item_2, invoice: @invoice_6, quantity: 1, status: "packaged", created_at: "Fri, 30 Jan 2023 00:28:45")
      @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_7, quantity: 1, status: "shipped", created_at: "Sat, 31 Jan 2023 00:28:46")

      create(:transaction, invoice_id: @invoice_1.id, result: 0)
      2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
      3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
      4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
      5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }
      3.times { create(:transaction, invoice_id: @invoice_7.id, result: 1) }
    end

    describe '::top_five_merchant_customers' do
      it 'returns the top five customers, ordered by successful transactions' do
        expect(@merchant.top_five_merchant_customers).to eq([@customer_5, @customer_4, @customer_3, @customer_2, @customer_1])
      end
    end

    describe "::items_ready_to_ship" do
      it "returns all ordered items that have not been shiped from oldest to newest" do
        expect(@merchant.invoice_items_ready_to_ship).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4, @invoice_item_5, @invoice_item_6])
      end
    end
  end
end
