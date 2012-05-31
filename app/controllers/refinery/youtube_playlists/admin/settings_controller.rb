module Refinery
  module YoutubePlaylists
    module Admin
      class SettingsController < ::Refinery::AdminController

        def edit
          @youtube_userid = Refinery::Setting.get(:youtube_userid, scoping: :youtube_playlists)
        end

        def update
          @youtube_userid = Refinery::Setting.set(:youtube_userid, :value => params[:youtube_userid], :scoping => :youtube_playlists)
          flash[:notice] = t('updated', :scope => 'refinery.youtube_playlists.admin.settings.update',
                             :youtube_userid => @youtube_userid)
          unless request.xhr? or from_dialog?
            redirect_back_or_default(refinery.youtube_playlists_admin_youtube_playlists_path)
          else
            render :text => "<script type='text/javascript'>parent.window.location = '#{refinery.youtube_playlists_admin_youtube_playlists_path}';</script>",
                   :layout => false
          end
        end

        def retrieve_playlist
          playlists_retrieval_service = ::Refinery::YoutubePlaylists::PlaylistsRetrieval.new
          playlists_retrieval_service.retrieve_playlists.import_playlists.populate_playlist_details
          respond_to do |format|
            format.html { redirect_back_or_default(refinery.youtube_playlists_admin_youtube_playlists_path) }
          end
        end

      end
    end
  end
end

