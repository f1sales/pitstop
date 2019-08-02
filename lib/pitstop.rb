require 'pitstop/version'
require 'thor'
require 'k8s-client'

module Pitstop
  class Error < StandardError; end

  class K8SCommands < Thor

    def initialize(*args)
      super
      @client = K8s::Client.config( K8s::Config.load_file( File.expand_path '~/.kube/config'))
    end

    desc 'delete_all', 'delete all stores'
    def delete_all
      @client.api('v1').resource('pods', namespace: 'default').delete_collection(labelSelector: {app: 'f1sales-api'})
      puts "Deleted all stores"
    end

    desc 'name', 'get pod name'
    def name(store_name)
      @client.api('v1').resource('pods', namespace: 'default').list(labelSelector: {tier: store_name}).map do |pod|
        pod.metadata.name
      end.first
    end

    desc 'delete', 'delete a store (also its sidekiq)'
    def delete(store_name)
      [store_name, "sidekiq-#{store_name}"].each do |tier|
        @client.api('v1').resource('pods', namespace: 'default').delete_collection(labelSelector: {tier: tier})
        puts "Deleted: #{tier}"
      end
    end
  end
end
