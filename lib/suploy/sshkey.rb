module Suploy
  module SshKey
    def create(key_file)
      key_file ||= '~/.ssh/id_rsa.pub'
      key_file = File.expand_path(key_file)
      if File.file? key_file
        print "Adding key-file '#{key_file}' ... "
        file = File.open(key_file, 'rb')
        key_content = file.read
        key_name = key_content.split.last
        Suploy::Api::SshKey.create key_name, key_content
        file.close
        puts "Done"
      else
        raise KeyFileDoesNotExist.new "Key-file '#{key_file}' does not exist."
      end
    end

    def index
      ssh_keys = Suploy::Api::SshKey.index
      if ssh_keys.size > 0
        table = Terminal::Table.new do |t|
          t << ['Name', 'Fingerprint']
          t.add_separator
          ssh_keys.each do |k|
            t << [k.info["title"], k.info["fingerprint"]]
          end
        end
        puts table
      else
        puts "You have not added an SSH Key yet, why don't you do so..?"
      end
    end

    def remove(key_name)
      if key_name.nil?
        raise ArgumentError.new "You must provide a SSH Key name to delete."
      end
      print "Remove key '#{key_name}' ... "
      ssh_key = Suploy::Api::SshKey.get key_name
      ssh_key.remove
      puts "Done"
    end

    module_function :create, :index, :remove
  end
end
