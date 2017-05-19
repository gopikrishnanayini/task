class IncomesController < ApplicationController
	def index
			@incomes = Income.all
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
		@income = Income.find(params[:id])
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
	def income_params
		params.require(:income).permit(:source, :income)
	end
end
