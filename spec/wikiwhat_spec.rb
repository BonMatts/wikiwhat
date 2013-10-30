require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'vcr'
require_relative '../lib/wikiwhat'

describe Wikiwhat::Page do
  VCR.use_cassette('wikiwhat')do

  let(:pigeon) { Wikiwhat::Page.new("Columba livia", :header => "Description") }
  let(:hawk) { Wikiwhat::Page.new("Cathartes aura", :header => "Description") }
    describe "#run" do
      it "sets instance varaibles" do

        expect(pigeon.head).to eq("Description")
        expect(hawk.head).to eq("Description")
        expect(hawk.header).to eq("\n<p>A large bird, it has a wingspan of 160–183 cm (63–72 in), a length of 62–81 cm (24–32 in), and weight of 0.8 to 2.3 kg (1.8 to 5.1 lb). While birds in the Northern limit of the species' range average around 2 kg (4.4 lb), vulture from the neotropics are generally smaller, averaging around 1.45 kg (3.2 lb). It displays minimal sexual dimorphism; sexes are identical in plumage and in coloration, although the female is slightly larger. The body feathers are mostly brownish-black, but the flight feathers on the wings appear to be silvery-gray beneath, contrasting with the darker wing linings. The adult's head is small in proportion to its body and is red in color with few to no feathers. It also has a relatively short, hooked, ivory-colored beak. The irises of the eyes are gray-brown; legs and feet are pink-skinned, although typically stained white. The eye has a single incomplete row of eyelashes on the upper lid and two rows on the lower lid.</p>\n<p>The two front toes of the foot are long and have small webs at their bases. Tracks are large, between 9.5 and 14 cm (3.7 and 5.5 in) in length and 8.2 and 10.2 cm (3.2 and 4.0 in) in width, both measurements including claw marks. Toes are arranged in the classic, anisodactyl pattern. The feet are flat, relatively weak, and poorly adapted to grasping; the talons are also not designed for grasping, as they are relatively blunt. In flight, the tail is long and slim. The Black Vulture is relatively shorter-tailed and shorter-winged, which makes it appear rather smaller in flight than the Turkey vulture, although the body masses of the two species are roughly the same. The nostrils are not divided by a septum, but rather are perforate; from the side one can see through the beak. It undergoes a molt in late winter to early spring. It is a gradual molt, which lasts until early autumn. The immature bird has a gray head with a black beak tip; the colors change to those of the adult as the bird matures. How long turkey vultures can live in captivity is not well known. While 21 years is generally given as a maximum age, the Gabbert Raptor Center on the University of Minnesota campus is home to a turkey vulture named Nero with a confirmed age of 37.<sup class=\"noprint Inline-Template\" style=\"white-space:nowrap;\">[<i>clarification needed</i>]</sup> There is another female bird, named Richard, living at the Lindsay Wildlife Museum in Walnut Creek, CA that hatched in 1974 and arrived at the museum later that year. The oldest wild captured banded bird was 16 years old.</p>\n<p>Leucistic (sometimes mistakenly called \"albino\") Turkey Vultures are sometimes seen. The well-documented records come from the United States of America, but this probably reflects the fact that such birds are more commonly reported by birders there, rather than a geographical variation. Even in the United States, white Turkey Vultures (although they presumably always turned up every now and then) were only discussed in birder and raptor conservation circles and are not scientifically studied.</p>\n<p>The Turkey Vulture, like most other vultures, has very few vocalization capabilities. Because it lacks a syrinx, it can only utter hisses and grunts. It usually hisses when it feels threatened. Grunts are commonly heard from hungry young and from adults in their courtship display.</p>\n")
        expect(hawk.title).to eq("Cathartes aura")
      end

      it "runs requested method"
    end

    describe "#find_paragraphs"

    describe "#find_image_list"

    describe "#find_header"

    describe "#find_refs"

    describe "#find_sidebar_image"
  end
end