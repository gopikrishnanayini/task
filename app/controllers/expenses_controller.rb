class ExpensesController < ApplicationController
	 before_action :set_expense, only: [:show, :edit, :update, :destroy]
	def index
		@expenses = Expense.all
		require "prawn"
		require "prawn/table"

		def export_pdf
			@expenses = Expense.all
			respond_to do |format|
				format.pdf do
					pdf = Prawn::Document.new
					table_data = Array.new
					table_data << ["Accomidation", "travelling", "Food", "Othercharges"]
					@expenses.each do |i|
						table_data << [i.accomidation, i.travelling, i.food, i.othercharges ]
					end
					pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
					send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
				end
			end
		end
	end
	def export_pdf
    pdf = WickedPdf.new.pdf_from_string(
    render_to_string(‘expenses/index.html.erb’, layout: false)
    )
    send_data pdf, :filename => “expense.pdf”, :type => “application/pdf”, :disposition => “attachment”
    end
	def new
		@expense = Expense.new
	end
	def create
		@expense = Expense.new(expense_params)
		respond_to do |format|
		if @expense.save
			format.html { redirect_to @expense, notice: "Expense was successfully created."}
			format.json { render json: show }
		else
			format.html { render action: "new"}
			format.json { render json: @expense.errors, :status => :unprocessable_entity}
		end
	  end
	end
	def show
        @commentable =@expense
        @comments = @commentable.comments
        @comment = Comment.new
	end
	def edit
		@expense = Expense.find(params[:id])
	end
	def update
		@expense = Expense.find(params[:id])
		respond_to do |format|
		if @expense.update(expense_params)
			format.html { redirect_to @expense, notice: "expense was successfully updated."}
			format.json { render json: edit }
		else
			format.html { render action: "new"}
			format.json { render json: @expense.errors, :status => :unprocessable_entity }
		end
	  end
	end
	def destroy
		@expense = Expense.find(params[:id])
	    @expense.destroy
	    redirect_to @expenses_path
	end

	private
	def set_expense
      @expense = Expense.find(params[:id])
    end
	def expense_params
		params.require(:expense).permit(:accomidation, :travelling, :food, :othercharges)
	end
end
