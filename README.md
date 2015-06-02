# wk6-assessment-review


**** OO wk 5 monday breadlist ******************************************
function TodoList() {
	this.tasks = [];
};

// functions can be defined this way too!
// var TodoList = function() {
//   this.tasks = [];
// };

TodoList.prototype.add = function(item) {
  this.tasks.push({description: item, completed: false});
};

TodoList.prototype.list = function() {
  return this.tasks;
};

TodoList.prototype.indexOf = function(item) {
  for ( var i in this.tasks){
    if(this.tasks[i].description == item){
      console.log(i);
      return i;
    }
  }
}

// In Javascript, hash keys can be accessed by using dot notation or using brackets and the key.
// TodoList.prototype.indexOf = function(item) {
//   for ( var i in this.tasks){
//     if(this.tasks[i]["description"] == item){
//       console.log(i);
//       return i;
//     }
//   }
// }

TodoList.prototype.get = function(index) {
  console.log(this.tasks[index]);
  return this.tasks[index];
}

TodoList.prototype.complete = function(index) {
  this.tasks[index]["completed"] = true;
  console.log(this.tasks[index]);
  return this.tasks[index];
}

TodoList.prototype.remove = function(index) {
  this.tasks.splice(index, 1);
  console.log(this.tasks);
  return this.tasks;
}

// Driver code

var groceryList = new TodoList();

groceryList.add('bread');
groceryList.add('cheese');
groceryList.add('milk');
groceryList.list(); //-> [
// {description: 'bread', completed: false},
// {description: 'cheese', completed: false},
// {description: 'milk', completed: false},
// ];
groceryList.indexOf('cheese'); //-> 1
groceryList.get(1); //-> {description: 'cheese', completed: false}
groceryList.complete(1);
groceryList.list(); //-> [
// {description: 'bread', completed: false},
// {description: 'cheese', completed: true},
// {description: 'milk', completed: false},
// ];
groceryList.remove(1);
groceryList.list(); //-> [
// {description: 'bread', completed: false},
// {description: 'milk', completed: false},
// ];¡



****** OO wk 5 wednesday racer ***************************
var Game = function() {
  this.player1pos = 0;
  this.player2pos = 0;
  this.MAX_POSITION = 8;
}

Game.prototype.init = function() {
  var game = this;
  $(window).on('keyup', function(event){

    if (event.keyCode === 65) {
      game.advancePlayer1();
    }

    if (event.keyCode === 76) {
      game.advancePlayer2();
    }
  })
}

Game.prototype.restart = function(){
  $('#player1_strip td').removeClass('active');
  $('#player2_strip td').removeClass('active');
  this.player1pos = 0;
  this.player2pos = 0;
}

Game.prototype.checkFinish = function(){
  if (this.player1pos == this.MAX_POSITION){
    alert("Player 1 Wins!");
    this.restart();
  }
  if (this.player2pos == this.MAX_POSITION){
    alert("Player 2 Wins!");
    this.restart();
  }
}

Game.prototype.advancePlayer1 = function() {
  this.player1pos++;
  $('#player1_strip td').removeClass('active');
  $('#player1_strip td:nth-child('+this.player1pos+')').addClass('active');
  this.checkFinish();
}

Game.prototype.advancePlayer2 = function() {
  this.player2pos++;
  $('#player2_strip td').removeClass('active');
  $('#player2_strip td:nth-child('+this.player2pos+')').addClass('active');
  this.checkFinish();
}

game = new Game();
game.init();



****** AJAX passion proj ***********************

$(document).ready(function() {
  goToLogin("#enter");
  // goToGame("#sign_in");
  goToGame("#sign_up");
  goToLogin("#sign_out");

});

goToLogin = function(buttonId) {
  $('.main_screen').on("click", buttonId, function(e){
    e.preventDefault();
    var enterSite = $.ajax({
            url: $(this).parent().attr('action')
          })
    enterSite.done(function(response){
      $('.to_sign_in_button').remove();
      $('.main_screen').html(response);
      })
    enterSite.fail(function(response){
      alert("You Encountered An Error!");
    })
  })
}


goToGame = function(buttonId) {
  $('.main_screen').on("click", buttonId, function(e){
    debugger
    e.preventDefault();
    var loadGame = $.ajax({
      url: $(this).parent().attr('action'),
      type: 'POST',
      data: $(this).parent().serialize()
    })
    loadGame.done(function(response){
      $('.login_page').remove();
      $('.main_screen').html(response)
    })
    loadGame.fail(function(){
      alert("You've Encountered An Error")
    })
  })
}



**** with JSON ***** wk5 wed. ajaxifying hacker
get '/posts/:id/vote' do
  post = Post.find(params[:id])
  post.votes.create(value: 1)
  content_type :json
  {id: post.id, count: post.votes.count}.to_json
end

delete '/posts/:id' do
  post = Post.find(params[:id])
  post.destroy
  content_type :json
  {id: post.id}.to_json
end

post '/posts' do
  new_post = Post.create( title: params[:title],
               username: Faker::Internet.user_name,
               comment_count: rand(1000) )
  erb(:_article, locals: {post: new_post})
end


click_create = function() {$( "#posts" ).on( "submit", function( event ) {
  event.preventDefault();
  var create = $.ajax({
    url: '/posts',
    type: 'POST',
    data: $('#posts').serialize()
  })

  create.done(function(response){
    $('.post-container').append(response)
  })
  create.fail(function(){
    console.log("fail");
  })
  });
}



*** b crypt *******************************

FORGOT SOMETHING CRUCIAL!!!!

shaikhmajdi [9:31 AM]
gem 'bcrypt' #ADD TO GEMFILE
require 'bcrypt' #ADD TO ENVIRONMENT
include BCrypt #ADD TO USER MODEL
###without the above 3, none of this will work.

shaikhmajdi [9:34 AM]
also, both <form> tags are missing a closing '>'.


=begin
-sessions are a way to persist some* data
-sessions and cookies SIMULATE state
-keeping track of users and their state is nice

-data refreshes between pages (how do we save our shopping cart?)

-session is a HASH
-keep info to a minimum
-NOT for objects, just primitives
-stay away from session.clear (NO!)
-instead use session[:some_key] = nil


GREAT RESOURCES
github.com/codahale/bcrypt-ruby
railstutorial.org/book/log_in_log_out
=end

enable :sessions #(IN ENVIRONMENT.RB FILE ALREADY)

###HELPER.RB FILES###

def log_in(user)
  session[:user_id] = user.id
end

#this tests if a user is logged in. use in get routes
def logged_in?
  !current_user.nil?
end

#this allows us to reference the current_user object and its attributes
def current_user
  @current_user ||= User.find_by(id: session[:user_id])
  #use User.find(session[:user_id]) if you want to use a conditional. #find will raise an error because it returns nil for people not browsing with a login. This is to privatize pages
end

#this is all you need to end a session, so include in your post logout
def log_out
  session[:user_id] = nil
  @current_user = nil
end

### EXAMPLE ###
#MODEL
class User < Activerecord::Base
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end

#***create new account***#
#CONTROLLER#
get '/users/new' do
  erb :sign_up_view #these aren't named restfully. just go with it.
end

post '/users' do
  @user = User.create(username: params[:username], password: params[:password]) #this initiates the User.password method
  redirect '/something' #login page or actually log them in and redirect to profile, etc.
end

#VIEW#
#sign_up_view.erb
<form id="sign-up" method="post" action="/something" #where model is, eg post '/something'
  <label class="label" for="username">Username</label>
  <input type="text" name="username" placeholder="gray text in box">
  <br>
  <label class="label" for="password">Password</label>
  <input type="password" name="password" placeholder="gray text in box">#type=password makes the dot characters to replace input letters
  #input types can be 'email' 'text' 'password' 'datetime', look these up
  <input type="submit" value="Sign Up">
</form>

#***logging in***#
#CONTROLLER#
get '/sessions/new' do
  erb :sign_in_view
end

get 'sessions/sign_in/error' do
  erb :sign_in_error_view #build something to say "hey, you effed up"
end

post '/sessions' do
  #conditional for if a password and/or username is entered or not
  @user = User.find_by(username: params[:username])
  if @user && @user.password == (params[:password])
    # def log_in(user)
    #   session[:user_id] = user.id
    # end      ###IF THIS HELPER METHOD is included in helpers,
    # log_in(@user) ###THIS is all we need instead of the following:
    session[:user_id] = @user.id #give_token in the bcrypt doc
    redirect '/#profile or wherever once logged in'
  else
    redirect 'sessions/sign_in/error'
  end
end

#VIEW#
#sign_in_view.erb
<form id="sign-in" method="post" action="/something" #where model is, eg post '/something'
  <label class="label" for="username">Username</label>
  <input type="text" name="username" placeholder="gray text in box">
  <br>
  <label class="label" for="password">Password</label>
  <input type="password" name="password" placeholder="gray text in box">#type=password makes the dot characters to replace input letters
  #input types can be 'email' 'text' 'password' 'datetime', look these up
  <br>
  <input type="submit" value="Sign Up">
</form>
#since these two erb's are the same, a partial would be best




******* RESTful ***********************************
#display all photos - photos#index
get '/photos' do
end

#return form for new photo - photos#new
get '/photos/new' do
end

#create a new photo - photos#create
post '/photos' do
end

#display specific photo - photos#show
get '/photos/:id' do
end

#return form for editing photo - photos#edit
get '/photos/:id/edit' do
end

#update specific photo - photos#update
patch/put '/photos/id' do
end

#delete specific photo - photos#destroy
delete '/photos/:id' do
end




******* alias *******************************************
class Survey < ActiveRecord::Base
  # Remember to create a migration!
  has_many :questions
  belongs_to :creator, foreign_key: :creator_id, class_name: 'User'

  has_many :respondent_surveys
  has_many :respondents, through: :respondent_surveys, foreign_key: :user_id, class_name: 'User'

end
