require 'rails_helper'

RSpec.describe MembersController do
  describe "GET index" do
    it "assigns @members, @current" do
      member = Member.includes(:friends).all
      if Member.first.nil?
        member = create(:member, :member1)
        current = member.id
      else
        current = Member.first.id
      end
      
      get :index
      expect(assigns(:members)).to eq([member])
      expect(assigns(:current)).to eq(current)
    end

    it "renders the `index` template" do
      get :index
      expect(response).to render_template("index")
    end    
  end

  describe "GET show" do
    it "assigns @member, @friends, @current" do
      member1 = create(:member, :member1)
      member2 = create(:member, :member2)
      Friendship.create(member_id: member1.id, friend_id: member2.id)
      member = Member.find_by_id(member1.id)
      friends = member.friends
      current = member.id
      get :show, params: { id: member.id }
      expect(assigns(:member)).to eq(member)
      expect(assigns(:friends)).to eq(friends)
      expect(assigns(:current)).to eq(current)
    end

    it "renders the `show` template" do
      member = create(:member, :member1)
      get :show, params: { id: member.id }
      expect(response).to render_template(:show)
    end    
  end

  describe "GET new" do
    it "renders the `new` template, assigns @member" do
      member = Member.new
      get :new
      expect(assigns(:member).to_json).to eql(member.to_json)
      expect(response).to render_template(:new)
    end    
  end

  describe "GET edit" do
    it "renders the `edit` template, assigns @current" do
      member = create(:member, :member1)
      get :edit, params: { id: member.id }
      expect(response).to render_template(:edit)
      expect(assigns(:member)).to eq(member)
    end    
  end

  describe "POST create with valid parameters" do
    it "renders the `show` template, assigns @member, short_url" do
      member = build(:member, :member1)
      post :create, params: { :member => { id: member.id, name: member.name, heading: member.heading, website: member.website }}
      expect(response).to redirect_to(assigns(:member))
      url = response.headers['Location'].split('/')
      id = url[url.length-1].to_i
      expect(flash[:notice]).to include("Member was successfully created.")
      expect(assigns(:member).id).to eq(id)
      expect(assigns(:member).short_url).to include("http://shorturl.at/")
    end    
  end

  describe "POST create with invalid parameters" do
    it "renders the `new` template" do
      member = build(:member, :member1)
      post :create, params: { :member => { id: member.id, name: '', heading: '', website: '' }}
      expect(response).to render_template(:new) 
    end    
  end

  describe "PUT update with valid parameters" do
    it "renders the `show` template, assigns changed @member, short_url and updates member record" do
      member = create(:member, :member1)
      member2 = member.clone
      member2.name = "My Precious"
      member2.website = "http://lotr.com/gollum"
      put :update, params: { id: member2.id, :member => { id: member2.id, name: member2.name, heading: member2.heading, website: member2.website }} 
      expect(response).to redirect_to(assigns(:member))
      expect(flash[:notice]).to include("Member was successfully updated.")
      expect(assigns(:member).name).to eq(member2.name)
      expect(assigns(:member).short_url).to_not eql(member.short_url)
    end    
  end

  describe "PUT update with invalid parameters" do
    it "renders the `edit` template with original member values unchanged" do
      member = create(:member, :member1)
      member2 = member.clone
      member2.name = "My Precious"
      member2.heading = "Short"
      member2.website = ""
      put :update, params: { id: member2.id, :member => { id: member2.id, name: member2.name, heading: member2.heading, website: member2.website }} 
      expect(response).to render_template(:edit) 
      member = Member.find_by_id(member.id)
      expect(assigns(:member).id).to eq(member.id)
      expect(assigns(:member).name).to_not eq(member.name)
      expect(assigns(:member).name).to_not eq(member.heading)
      expect(assigns(:member).website).to_not eq(member.website)
    end    
  end

  describe "DELETE create with invalid parameters" do
    it "renders the `show` template and deletes member record created" do
      member = create(:member, :member1)
      delete :destroy, params: { id: member.id }
      expect(response).to redirect_to(assigns(:member))
      expect(flash[:notice]).to include("Member was successfully deleted.")
      member = Member.find_by_id(member.id)
      expect(member).to eql(nil)
      expect(assigns(:member)).to_not eql(member)
    end    
  end

end