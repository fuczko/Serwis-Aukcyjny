# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Projekt_session',
  :secret      => 'd319c2ab20b19a4636cd537c08aad4c162073b25b4f51a890a480bee60a18dd5b7a20124e4a95eacd93c74f4a2b8d56238bc9928ecf564bc545aab061415fbe5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
