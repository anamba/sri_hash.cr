require "./spec_helper"

describe SRIHash do
  it "generates an SRI hash given a String" do
    SRIHash.from_string("Example text").should eq "sha256-ljgfRyA+rQLdERYr90sJ9dRLkTYUnUIAHmR1dX6cvmQ="
  end

  it "allows any algorithm supported by openssl" do
    # one time change via arguments
    SRIHash.from_string("Example text", "sha384").should eq "sha384-ccLtG4S0txUiu3s0kEOUSiKfr3poGC+i1midiPHzO/aDkeHwlXnP4ozRKWqOREqn"
    SRIHash.from_string("Example text").should eq "sha256-ljgfRyA+rQLdERYr90sJ9dRLkTYUnUIAHmR1dX6cvmQ="

    # settings change
    SRIHash.settings.algorithm = "sha384"
    SRIHash.from_string("Example text").should eq "sha384-ccLtG4S0txUiu3s0kEOUSiKfr3poGC+i1midiPHzO/aDkeHwlXnP4ozRKWqOREqn"

    # change back to default for remaining specs
    SRIHash.settings.algorithm = "sha256"
  end

  it "generates an SRI hash given a filename as String" do
    SRIHash.from_file("test.js").should eq "sha256-ljgfRyA+rQLdERYr90sJ9dRLkTYUnUIAHmR1dX6cvmQ="
  end
  it "generates an SRI hash given an IO (e.g. File)" do
    SRIHash.from_file(File.new("test.js")).should eq "sha256-ljgfRyA+rQLdERYr90sJ9dRLkTYUnUIAHmR1dX6cvmQ="
  end
  it "generates a complete script tag given a url" do
    SRIHash.script_tag("https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js").should eq %(<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js" integrity="sha256-ZaXnYkHGqIhqTbJ6MB4l9Frs/r7U4jlx7ir8PJYBqbI=" crossorigin="anonymous" defer></script>)
    SRIHash.script_tag("https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js", defer: false).should eq %(<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js" integrity="sha256-ZaXnYkHGqIhqTbJ6MB4l9Frs/r7U4jlx7ir8PJYBqbI=" crossorigin="anonymous"></script>)
    SRIHash.script_tag("https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js", algorithm: "sha384").should eq %(<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js" integrity="sha384-7WBfQYubrFpye+dGHEeA3fHaTy/wpTFhxdjxqvK04e4orV3z+X4XC4qOX3qnkVC6" crossorigin="anonymous" defer></script>)
  end
end
