module Suploy
  module SshKey
    def create(key_file)
      key_file ||= '~/.ssh/id_rsa.pub'
      key_file = File.expand_path(key_file)
      if !(File.file? key_file)
        raise Suploy::Error::KeyFileDoesNotExist.new "Key-file '#{key_file}' does not exist."
      end
      puts "Adding key-file '#{key_file}' ... "
      file = File.open(key_file, 'rb')
      key_content = file.read
      key_name = key_content.split.last
      Suploy::Api::SshKey.create key_name, key_content
      file.close
      puts "Done"
    end

    def index
      ssh_keys = Suploy::Api::SshKey.index
      if ssh_keys.empty?
        raise Suploy::Error::NoSshKeysFound.new "You have not added an SSH Key yet, why don't you do so..?"
      end
      table = Terminal::Table.new
      table.title = "SSH Keys: #{ssh_keys.size}"
      table.headings = ['Name', 'Fingerprint']
      table.rows = ssh_keys.map do |k|
        [k.info["title"], k.info["fingerprint"]]
      end
      puts table
    end

    def remove(key_name)
      if key_name.nil?
        raise ArgumentError.new "You must provide a SSH Key name to delete."
      end
      puts "Remove key '#{key_name}' ... "
      ssh_key = Suploy::Api::SshKey.get key_name
      ssh_key.remove
      puts "Done"
    end

    module_function :create, :index, :remove
  end
end
