# Launchpad

### CSCI 4448 -- Spring 2011 -- Ben Limmer & Zachary Clark

Launchpad is a rails app designed to be a one-stop spot for seeing what you need to do today. The app integrates various services (RTD bus times, Google Calendar, Wunderground weather) into helpful widgets. The application can be installed to the iOS homescreen and provides at-a-glance information about your day.

## Configuration

### Devise

Launchpad uses [Devise](https://github.com/plataformatec/devise) for authentication. Specifically, we're using `:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable`. The base urls are as follows:

- `/users/sign_in` -- Sign in
- `/users/sign_out` -- Sign out
- `/` -- Everything else

### Single Table Inheritance (STI)

For handling `Widget` behavior we are using the STI design pattern. This involved having a single table for instances of `Widgets` that uses a different subclass of `Widget` depending on the setting of the `type` column. Rails supports this pattern out of the box.

References:

- [Forum thread about someone tring it](http://railsforum.com/viewtopic.php?id=3815)
- [Stack Overflow article](http://stackoverflow.com/questions/555668/single-table-inheritance-and-where-to-use-it-in-rails)
- [Clean article about the basics](http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html)