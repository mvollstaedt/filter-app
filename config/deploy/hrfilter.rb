set :stage, :production
set :application, 'hrfilter.de'
set :deploy_to, '/var/www/hrfilter.de'

server 'localhost',
  user: 'stefan',
  roles: %w{web app db},
  ssh_options: {
    user: 'stefan', # overrides user setting above
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey password)
  }