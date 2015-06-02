# Part 3: Build a CRUD App

## Summary
In Part 3 of the assessment, we'll demonstrate our proficiency in building Sinatra applications: user authentication, associations, validations, controllers, views, etc. Even a little bit of CSS.

### Site Overview

We'll be building a simplified version of a blind auction site—in a blind
auction, bidders do not see how much other bidders have bid.  For the sake of
agility, we will begin with the assumption that there is only one active
auction.

The required functionality of the site will be described in more detail in the *Releases* section, but here's a basic overview.

**Unregistered Users**

- Register a new account.
- See bids on items in the auction.

**Registered Users**

- Sign in and out.
- See bids on items in the auction.
- Place bids on items in auction.
- Create, update and delete items.

### Provided Code

For this part of the assessment, you are provided with a Sinatra skeleton.  All
but one of the migrations have been provided for you.  Some empty models have
also been provided, but you will need to create models for any additional
migrations you create.

### Completing the App

Complete as much of this CRUD app as possible in the time allowed. At each step, complete only the parts defined.  In particular, **do not add any CSS** until asked to do so. If time is running out and it looks like the app will not be completed, continue to work through the releases in order and complete as much as possible. Be sure to ask questions, if you find yourself stuck.

## Releases

### Pre-release:  Setup

We'll need to make sure that everything is set up before we begin working on
the application.  From the command line, navigate to the `part-3` directory of
the phase 2 assessment.  Once there, run ...

0. `$ bundle`
0. `$ bundle exec rake db:drop db:create`

### Release 0: Add User Model, Migration and Validations

Create both an empty `User` model and a migration to create the corresponding
`users` table.  Our `users` table will only need to store data related to
authentication: a `username` and a non-plain-text password.

After the model and migration have been written, run the migrations by running the following commands.

0. `$ bundle exec rake db:migrate`
0. `$ bundle exec rake db:migrate RACK_ENV=test`

Add validations to the User Model.

- A user must have a username.
- A user must have a unique username.

To test these validations, run:
```
rspec --tag user_validations
```

Add validations to the Bid Model.

- An bid must have an amount which is positive

To test this validation, run:
```
rspec --tag bid_validations
```


### Release 1: CRUD and User Authentication

We'll begin building the user authentication interface for our application by
creating views around user sign up, sign in, and sign out.  This will also
require us to Create and Read Users (there is no Update or Delete at this
point). Do not worry about CSS or AJAX in this release.

**Sign up**
- Users can create a new account for our site.
  - If sign up is successful, a new user is created and the user is taken to their profile page.
  - If sign up fails, the user is taken back to the sign up page and given information about what went wrong.

**Sign in**
- Users with accounts can sign into their accounts.
  - If sign in is successful, the user is taken to their profile page.
  - If sign in fails, the user is taken back to the sign in page and given information about what went wrong.

**Sign out**
- After signing in, users can sign out.

### Release 2:  Associations

We will be working with three models: `Bid`, `Item`, and `User`.  Create the
associations between the models based on the following descriptions.  It might
be beneficial to create a visual representation of the database schema, based
on the migrations.

* A User can Bid on many Items.
* The user that bids on an item is a bidder.

####Association Methods

Since this application is built on legacy code, site member data are stored in
a table called `users`.  Use associations that allow us to reflect the
application's business logic and naming conventions i.e.  "Users are accessed
via a call to 'bidders'".


- `bid.bidder` returns the user who placed the bid.

To test this association, from the root directory run:
```
rspec --tag bid_associations
```

**Item**

- `item.bids` returns the bids on an item
- `item.bidders` returns the `User`s who have bid on it

To test these associations, run:
```
rspec --tag item_associations
```

**User**

- `user.bids` returns the bids the user has placed
- `user.bid_on_items` returns the items on which the user has placed bids
- `user.posted_items` returns the items a user created

To test these associations, run:
```
rspec --tag user_associations
```

### Release 3: Additional Model Behaviors

Once the associations have been written, let's add some additional behaviors to our models.  Some of the behaviors will be for the class itself (e.g.,
`Bid`) while others will be for instances (e.g., `user`).

**Bid Class**

- `Bid.highest` returns the bid with the highest amount.
- `Bid.highest_bidder` returns the user who placed the highest bid.

To test these behaviors, run:
```
rspec --tag bid_behaviors
```

**User Instances**
- `user.total_bids` total amount of all bids a user has  placed

To test these behaviors, run:
```
rspec --tag user_behaviors
```

### Release 4: Items

Now we'll add some functionality around items. You only need to style views when requested and you **DO NOT** have to use AJAX.

- Create pages so a user can create, edit and delete items.  You **DO NOT** have to style these pages.

- Create a page showing a single item.  You need to style this page so it looks similar to the [mockup](mockup-auction.png).

### Release 5: Bids

Let's add the functionality to allow signed-in users to bid on items.

We'll modify the single item view page to support bidding for logged in users.
If the user is not logged in, the view should remain as is.

If a user is signed in ...
  - If the user has not already bid on an item, display a form for creating a new bid (see [mockup](mockup-auction-with-new-bid-form.png)).
  - If the user has already bid on that item, display the value of the bid, a form for editing the bid, and a form for deleting the bid (see [mockup](mockup-auction-with-edit-and-delete-forms.png)).

## Conclusion

Part-3 wraps up the assessment.  If you haven't already done so, commit your
changes.  Please wait until the end of the assessment period to submit your
solution.
