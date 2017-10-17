class InvoicesController < ApplicationController
  def index
    invoices = Invoice.all!
    render json: invoices
  end
  
  def show
    invoice = Invoice.find_by_client(params[:id])
    render json: invoice
  end
end
