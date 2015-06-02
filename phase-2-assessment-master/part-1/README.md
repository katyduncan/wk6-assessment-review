# Part 1:  AJAX

## Summary
In Part 1 we'll take a functioning Sinatra application and enhance the user experience by adding some AJAX calls.

## Releases
###Release 0 : Current Site and Tests

The code for this portion has already been written. The application is a simple site where users can write posts.  If a user wanted to write a post, here's the process.

1. User visits the site root.
2. User clicks on the "Share Your Thoughts" link which triggers a request.
3. User is taken to a new page with a form.
4. User fills out and submits the form which triggers another request.
5. User is taken to a new page where the saved post is displayed.

Feature tests have been written to describe the `Post` class (see `spec/models/post_spec.rb`) and the feature of writing a new post (see `spec/features/writing_a_post_spec.rb`).

The feature tests for writing a new post include two contexts:  without javascript and with javascript.  The code you are provided with will pass the scenario where javascript is not being used.  The with-javascript scenario fails with just the provided code.

Run the tests from the command line by navigating to the `part-1` directory of the phase 2 assessment.  Once there, run ...


0. `$ brew update && brew install phantomjs`
0. `$ bundle`
0. `$ bundle exec rake db:create`
0. `$ bundle exec rake db:migrate`
0. `$ bundle exec rake db:migrate RACK_ENV=test`
0. `$ bundle exec rspec`


Verify that the tests in the without javascript context pass.  Once you have, move on to the next section where you will write the AJAX code needed for the second set of tests to pass.

### Release 1: AJAX

Now we'll take our application and enhance its functionality. Our enhancements will make it so the user never leaves the homepage.  All the requests from the original code will be replaced with AJAX requests, and we'll update the DOM based on the responses.  After the site is updated, here's what the user experience will be.

1. User visits the site root.
2. User clicks on the "Share Your Thoughts" link which triggers an AJAX request.
3. The "Share Your Thoughts" link is no longer visible on the page.
4. In place of the link is the form for writing a new post.
5. User fills out and submits the form which triggers an AJAX request.
6. Details of the saved post are added to the DOM.
7. The form is removed from the DOM.
8. The "Share Your Thoughts" link is again visible.

Your task is to implement the AJAX requests and make the tests in the with-javascript scenario pass.  When our site is functioning properly with AJAX, both scenarios should pass.  Don't break the without-javascript test to pass the with-javascript test.

Run the tests on the existing code from the command line by typing

```
$ bundle exec rspec
```

## Conclusion
Once all the tests have passed, you have completed Part 1 of the assessment. If you haven't done so already, commit your changes and move on to Part 2.
