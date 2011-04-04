# Launchpad

### CSCI 4448 -- Spring 2011 -- Ben Limmer & Zachary Clark

Launchpad is a rails app designed to be a one-stop spot for seeing what you need to do today. The app integrates various services (RTD bus times, Google Calendar, Wunderground weather) into helpful widgets. The application can be installed to the iOS homescreen and provides at-a-glance information about your day.

## Configuration

### Devise

Launchpad uses [https://github.com/plataformatec/devise](Devise) for authentication. Specifically, we're using `:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable`. The base urls are as follows:

- `/users/sign_in` -- Sign in
- `/users/sign_out` -- Sign out
- `/` -- Everything else