class GuidesController < ApplicationController
	caches_page :show
	def show
		@article = Guide.find(params[:id])
	    #redirection of old permalinks
	    if request.path != guide_path( @article )
	      logger.info "Old permalink: #{request.path}"
	      return redirect_to @article, status: :moved_permanently
	    end

	    @article.delay.increment! :access_count
	    @article.delay.category.increment!(:access_count) if @article.category   

	    @content_html = BlueCloth.new(@article.content).to_html
	    @bodyclass = "results"

	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @article }
	    end 
  end
end