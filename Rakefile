namespace :cookbook do
  desc 'run all tests'
  task :ci do
    [:rubocop, :foodcritic, :chefspec, :kitchen].each do |t|
      Rake::Task["cookbook:#{t}"].execute
    end
  end

  desc 'run lint/style test suite'
  task :lint do
    [:rubocop, :foodcritic].each do |t|
      Rake::Task["cookbook:#{t}"].execute
    end
  end

  desc 'run spec test suite'
  task :spec do
    [:chefspec, :kitchen].each do |t|
      Rake::Task["cookbook:#{t}"].execute
    end
  end

  desc 'run rubocop'
  task :rubocop do
    exit 1 unless system('chef exec rubocop')
  end

  desc 'run foodcritic'
  task :foodcritic do
    exit 1 unless system('chef exec foodcritic -f any .')
  end

  desc 'run chefspec'
  task :chefspec do
    exit 1 unless system('chef exec rspec')
  end

  desc 'run test-kitchen'
  task :kitchen do
    exit 1 unless system('chef exec kitchen test')
  end

  desc 'generate encrypted databag secret'
  task :generate_secret do
    secret_file = ::File.join(::File.dirname(__FILE__), 'test', 'integration', 'default', 'encrypted_data_bag_secret')

    if ::File.exists?(secret_file)
      puts 'Secret file already exists!'
    else
      `openssl rand -base64 512 > #{secret_file}`
    end
  end

  desc 'manipulate a local data bag'
  task :data_bag, [:bag, :item] do
    data_bag_path = ::File.join(::File.dirname(__FILE__), 'test', 'integration', 'default', 'data_bags')
    ::FileUtils.mkdir_p(data_bag_path) unless ::Dir.exists?(data_bag_path)

    if ::File.exists?(::File.join(data_bag_path, args[:bag], "#{args[:item]}.json"))
      system "knife solo data bag edit #{args[:bag]} #{args[:item]} --data-bag-path #{data_bag_path}"
    else
      system "knife solo data bag create #{args[:bag]} #{args[:item]} --data-bag-path #{data_bag_path}"
    end
  end

  desc 'manipulate a local encrypted data bag'
  task :encrypted_data_bag, [:bag, :item] do |t, args|
    data_bag_path = ::File.join(::File.dirname(__FILE__), 'test', 'integration', 'default', 'data_bags')
    ::FileUtils.mkdir_p(data_bag_path) unless ::Dir.exists?(data_bag_path)

    secret_file = ::File.join(::File.dirname(__FILE__), 'test', 'integration', 'default', 'encrypted_data_bag_secret')
    Rake::Task["cookbook:#{t}"].execute unless ::File.exists?(secret_file)

    if ::File.exists?(::File.join(data_bag_path, args[:bag], "#{args[:item]}.json"))
      system "knife solo data bag edit #{args[:bag]} #{args[:item]} --data-bag-path #{data_bag_path} --secret-file #{secret_file}"
    else
      system "knife solo data bag create #{args[:bag]} #{args[:item]} --data-bag-path #{data_bag_path} --secret-file #{secret_file}"
    end
  end
end
