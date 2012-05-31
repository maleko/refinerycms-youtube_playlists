# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "YoutubePlaylists" do
    describe "Admin" do
      describe "youtube_playlists" do
        login_refinery_user

        describe "youtube_playlists list" do
          before(:each) do
            FactoryGirl.create(:youtube_playlist, :title => "UniqueTitleOne")
            FactoryGirl.create(:youtube_playlist, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.youtube_playlists_admin_youtube_playlists_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.youtube_playlists_admin_youtube_playlists_path

            click_link "Add New Youtube Playlist"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::YoutubePlaylists::YoutubePlaylist.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::YoutubePlaylists::YoutubePlaylist.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:youtube_playlist, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.youtube_playlists_admin_youtube_playlists_path

              click_link "Add New Youtube Playlist"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::YoutubePlaylists::YoutubePlaylist.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:youtube_playlist, :title => "A title") }

          it "should succeed" do
            visit refinery.youtube_playlists_admin_youtube_playlists_path

            within ".actions" do
              click_link "Edit this youtube playlist"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:youtube_playlist, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.youtube_playlists_admin_youtube_playlists_path

            click_link "Remove this youtube playlist forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::YoutubePlaylists::YoutubePlaylist.count.should == 0
          end
        end

      end
    end
  end
end
