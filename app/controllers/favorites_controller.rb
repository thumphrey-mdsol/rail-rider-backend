class FavoritesController < ApplicationController
    def show
        favorite = Favorite.find(params[:id])
        render json: favorite, include: [:user, :stop]
    end

    def get_status
        lines_formated = []

        response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
        puts "Got response"
        response_string.gsub!("NQR","NQRW")
        response = JSON.parse(Hash.from_xml(response_string).to_json)
        puts "Made it JSON"
        response["service"]["subway"]["line"][0..-2].each do |line|
            
            if line["text"] === nil
                lines_formated.push(line)
            else
                line["text"] = line["text"].gsub("<br clear=left>"," ")
                text = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
                lines_formated.push({status: line["status"], name:line["name"], Date: line["Date"],Time: line["Time"], text: text })
            end
        end
        render json: lines_formated
    end

    def index
        favorites = Favorite.all
        render json: favorites, include: [:user, :stop]
    end

    def create
        favorite = Favorite.create(favorite_params)

        render json: favorite
    end

    def update
        favorite = Favorite.find(params[:id])
        favorite.update(favorite_params)
        render json: favorite
    end

    def destroy
        favorite = Favorite.find(params[:id])
        unless favorite.nil?
            favorite.destroy
            render json: favorite
          else
            render json: { error: "Favorite not Found!" }, status: 404
          end
    end


    private
    def favorite_params
        params.require(:favorite).permit(:user_id, :name, :stop_id)
    end

end
