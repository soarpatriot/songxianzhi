class PhotosController < ApplicationController


  def index
    @photos = Photo.all
    render :json => @photos.collect { |p| p.to_jq_upload }.to_json
  end

  def upload
    create
  end

  def create

    @photo = Photo.new(photo_params)
    if @photo.save
      respond_to do |format|
        format.html {

          render :json => [@photo.to_jq_upload].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {

          render :json => [@photo.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def update

    ids =photo_params[:ids].split(',')
    photos = Photo.where(id: ids)
    photos.update_all cover:false

    id = photo_params[:id]
    @photo = Photo.find(id)
    @photo.update cover:true
    @covered = true
    render "i/information/cover"
  end
  def cover

  end

  def destroy

    @photo = Photo.find(params[:id])
    @photo.destroy
    render :json => true
  end



  def photo_params

    params.require(:photo).permit(:id, :image, :ids)
  end
end
