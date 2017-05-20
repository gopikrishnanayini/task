class IncomesController < ApplicationController
	before_action :set_income, only: [:show, :edit, :update, :destroy]
	def index
		@incomes = Income.all
		require "prawn"
		require "prawn/table"

		def download_pdf
			@incomes = Income.all
			respond_to do |format|
				format.pdf do
					pdf = Prawn::Document.new
					table_data = Array.new
					table_data << ["Source", "Income", "Total_income"]
					@incomes.each do |i|
						table_data << [i.source, i.income, i.total_income]
					end
					pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
					send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
				end
			end
		end
	end
    def download_income
    pdf = WickedPdf.new.pdf_from_string(
    render_to_string(‘incomes/index.html.erb’, layout: false)
     )
    send_data pdf, :filename => “income.pdf”, :type => “application/pdf”, :disposition => “attachment”
    end
	def new
		@income = Income.new
	end
	def create
		@income = Income.new(income_params)
		respond_to do |format|
			if @income.save
				format.html { redirect_to @income, notice: "Income was successfully created."}
				format.json { render json: show }
			else
				format.html { render action: "new"}
				format.json { render json: @income.errors, :status => :unprocessable_entity}
			end
		end
	end
	def show
    @commentable =@income
    @comments = @commentable.comments
    @comment = Comment.new
	end
	def edit
		@income = Income.find(params[:id])
	end
	def update
		@income = Income.find(params[:id])
		respond_to do |format|
			if @income.update(income_params)
				format.html { redirect_to @income, notice: "income was successfully updated."}
				format.json { render json: edit }
			else
				format.html { render action: "new"}
				format.json { render json: @income.errors, :status => :unprocessable_entity }
			end
		end
	end
	def destroy
		@income= Income.find(params[:id])
		@income.destroy
		redirect_to @incomes_path
	end

	private
	  def set_income
      @income = Income.find(params[:id])
    end
	def income_params
		params.require(:income).permit(:source, :income, :bankstatement)
	end
end
