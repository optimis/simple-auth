simple-auth
===========

simple-auth is a simple authentication library for applications that run under the same domain.

simple-auth can be used with any authentication provider, like - Authlogic, Devise, Restful Authentication,
and any others that use cookie based authentication.

simple-auth can be used to redirect a browser application to the authentication provider for login and session management.

simple-auth can also be used to recieve persistent tokens from the authenticator application,
which in turn can be used to make requests on behalf of a user even when they are logged off.

Sample Configuration
====================

simple-auth authenticator host and paths can be configured for multiple environments as shown below.

    SimpleAuth.configure do
      host do
        development 'test.domain.local'
        test 'test.domain.local'
        production 'test.domain.local'
      end

      paths do
        login 'login'
        logout 'logout'
      end
    end

In the example configuration above, simple-auth configures "test.domain.local" as the host of the authenticator application.

The #host method is the helper to set the authenticator host for multiple environments.

    host do
      development 'development.domain.local'
      test 'test.domain.local'
    end

The #paths method is the helper to set the relative paths for endpoints in the authenticator application.

    paths do
      login 'login'
      logout 'logout'
    end

This example sets the login and logout paths in the authenticator application.
These endpoints can now be accessed in the consumer application just as rails routes.

    login_path, login_url
    logout_path, logout_url

As a bonus, you can also use the configuration to setup non authentication related paths.

    paths do
      logo 'images/logo.png'
    end

    logo_path, logo_url

This is a contrived example, but you get the point ...

Usage
=====

In the consumer application, set up your Gemfile to use the simple-auth gem.

    gem 'simple-auth', :require => 'simple_auth'

Run 'bundle install', and you should have the following helpers available in your controllers and views.

api, A RestClient::Resource instance pointing to the host endpoint.
login, The #login method uses the cookie in the browser request to authenticate the user, and follow redirection from the authenticator application.

Controller Usage
================

To use the simple-auth gem to redirect to an endpoint in the authenticator application enforced by a before filter, you can use a before filter in the consumer application.

    before_filter :require_login

    private

    def require_login
      login unless current_user
    end

You could choose not to save the session returned in the consumer application, however, all you requests will be authenticated and so will effect performance.

Pre-Requisite
=============

The authenticator application should define a route for a method #show in the user sessions controller. This method can return the desired session information and enforce authorization rules.

  class UserSessionsController
    def show
      render :json => { :session => 'secret' }
    end
  end

Note on Patches/Pull Requests
=============================
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
=========

Copyright (c) 2010 Umang Chouhan
Copyright (c) 2010 Ehren Murdick
Copyright (c) 2010 OptimisCorp.

See LICENSE for details.
