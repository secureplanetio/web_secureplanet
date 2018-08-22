cron: sh -c "env | sed 's/^/export /' > /root/.bash_profile; /usr/sbin/cron -f"
 
puma: bundle exec puma -C config/puma.rb
