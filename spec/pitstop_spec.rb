RSpec.describe Pitstop do
  it "has a version number" do
    expect(Pitstop::VERSION).not_to be nil
  end

 
end

# client.api('v1').resource('pods', namespace: 'default').list.each do |pod|
#   puts "pod: #{pod}"
# end
#
# client.api('v1').resource('pods', namespace: 'default').list(labelSelector: {'tier' => 'lojateste'}).each do |pod|
#   puts "namespace=#{pod.metadata.namespace} pod: #{pod.metadata.name} node=#{pod.spec.nodeName}"
# end
