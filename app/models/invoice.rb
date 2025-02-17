class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["in progress", "cancelled", "completed"]

  def invoice_items_and_names
    invoice_items.joins(:item)
    .select("invoice_items.*, items.name")
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def self.incomplete_invoices
    Invoice.joins(:invoice_items)
      .where.not(invoice_items: {status: 2})
      .distinct
      .order(:created_at)
  end
end
