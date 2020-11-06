class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all.order(:id)
  end

  def new
    @candidates = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to candidates_path, nodice: "create candidate successfully"
    else
      render :new
    end
  end

  def edit
    @candidate = Candidate.find_by(id: params[:id])
  end

  def update
    @candidate = Candidate.find_by(id: params[:id])
    if @candidate.update(candidate_params)
      # 成功
      redirect_to candidates_path, notice: "資料更新成功!"
    else
      # 失敗
      render :edit
    end
  end

  def destroy
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "deleted! "
  end

  def vote 
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
    redirect_to candidates_path, notice: "voted!"
  end


  private 
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end
end
