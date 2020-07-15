require 'yaml'

files = Dir["#{ENV['HOME']}/Projects/temp_f1sales/f1sales-api/kube/stores/*/**.yml"].select{ |f| !f.include?('-env') }
#
# s = """
#           - name: MAILCHIMP_API_KEY
#             valueFrom:
#               secretKeyRef:
#                 name: \"mailchimp-api-key\"
#                 key: \"mailchimp-api-key\"
# """

files.each do |f|
  store_id  = File.basename(f, ".*")
  if store_id == 'audisantos' || store_id == 'blindatech' || store_id == 'lojateste'
    puts "Skipping #{store_id}"
    next
  end
  command = "kubectl exec -it `pitstop name #{store_id}` -- rake migrate:set_jobs_for_unattended"
  puts "STORE _===>>>>> #{store_id}"
  `#{command}`
  puts '======'
end


# r = files.map do |file_path|
#   env_vars = File.read(file_path)
#   service, rails_deploy, sidekiq_deploy = env_vars.split("---\n").map{ |d| YAML.load(d) }
#
#   env = sidekiq_deploy["spec"]["template"]["spec"]["containers"][0]["env"]
#   env << {
#     "name" => "MAILCHIMP_API_KEY",
#     "valueFrom"=> {
#       "secretKeyRef"=> {
#         "name"=>"mailchimp-api-key",
#         "key"=>"mailchimp-api-key"
#       }
#     }
#   }
#
#   [service, rails_deploy, sidekiq_deploy].map(&:to_yaml).join
# end
#
# File.open("ornare.yml", "w") { |file| file.write(r[0]) }
