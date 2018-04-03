include ActionController::HttpAuthentication::Token

module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session, except: [:create_new_session]

      def create_new_session
        api_key = params[:token]

        if params[:user_id] && params[:username]
          user = User.find_or_create_api_user(
            params[:user_id], 
            params[:username], 
            api_key)

          sign_in(user, store: true)

          if params[:campaign_id]
            campaign = Campaign.find(params[:campaign_id])
            redirect_to campaign.valid? ? campaign_path(campaign) : setup_campaign_path(campaign)
          else
            redirect_to campaigns_path
          end
        else
          @error_code = 22
          @error_message = 'User id and username required'

          render 'api/v1/error', formats: [:json], status: 401
        end
      end
    end
  end
end
