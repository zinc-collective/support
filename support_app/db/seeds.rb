# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


cohere_inbox = Inbox.find_or_create_by(name: "Cohere")
cohere_inbox.update(confirmation_message: "Thanks! We'll get back with you!")