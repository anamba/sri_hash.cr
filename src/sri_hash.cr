require "http"
require "openssl"

module SRIHash
  VERSION = "0.1.0"

  class Settings
    property algorithm : String = "sha256"
  end

  def self.settings
    @@settings ||= Settings.new
  end

  def self.from_io(io : IO, algorithm : String = settings.algorithm)
    digest = OpenSSL::Digest.new(algorithm)
    digest << io
    hash = digest.base64digest.gsub("\n", "") # remove newlines added every 60 chars by Base64 :(
    "#{algorithm}-#{hash}"
  end

  def self.from_file(file : IO, algorithm : String = settings.algorithm)
    from_io(file, algorithm)
  end

  def self.from_file(filename : String, algorithm : String = settings.algorithm)
    from_io(File.new(filename), algorithm)
  end

  def self.from_string(str : String, algorithm : String = settings.algorithm)
    from_io(IO::Memory.new(str), algorithm)
  end

  def self.script_tag(url : String, defer = true, crossorigin = "anonymous", algorithm : String = settings.algorithm)
    uri = URI.parse(url)
    client = HTTP::Client.new(uri)
    response = client.get(uri.full_path)
    client.close

    hash = from_string(response.body, algorithm)
    %(<script src="#{url}" integrity="#{hash}" crossorigin="#{crossorigin}"#{defer ? " defer" : ""}></script>)
  end
end
