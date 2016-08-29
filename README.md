# Dataset analysis app

This is dataset analysis api. You can use it there
[https://dataset-analyser.herokuapp.com/](https://dataset-analyser.herokuapp.com/)
or you can use it on your local machine.

## Local installation instructions

For running app on your local machine you need
to have [PostgeSQL installed](https://help.ubuntu.com/community/PostgreSQL).

    $ git clone https://github.com/pavel-zhuravlyov/test_api
    $ cd test_api
    $ bundle install
    $ bundle exec rake db:setup
    $ rspec
    $ rails server


## API

API for user registration and authentication: [https://github.com/lynndylanhurley/devise_token_auth#usage-tldr](https://github.com/lynndylanhurley/devise_token_auth#usage-tldr)

| path | method | description |
|:-----|:-------|:--------|
| /analyser/analyse | POST   | Requires **`dataset`** param. Returns result of dataset analysis which includes max value, min value, average value, median, quartiles and outliers of dataset  |
| /analyser/correlation | POST   | Requires **`first_dataset`**,  **`second_dataset`** params. Returns correlation.  |
