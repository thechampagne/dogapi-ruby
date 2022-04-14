require_relative "dogceo/version"
require 'net/http'
require 'json'

class DogAPIException < StandardError
  def initialize(message)
    super(message)
  end
end

module DogAPI
  class << self
    ##
    # DISPLAY SINGLE RANDOM IMAGE FROM ALL DOGS COLLECTION
    #
    # return a random dog image
    #
    # Raises DogAPIException
    def random_image
      begin
        response = get_request('breeds/image/random')
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # DISPLAY MULTIPLE RANDOM IMAGES FROM ALL DOGS COLLECTION
    #
    # * `images_number` number of images
    #
    # *NOTE* ~ Max number returned is 50
    #
    # Return multiple random dog image
    # Raises DogAPIException
    def multiple_random_images(images_number)
      begin
        response = get_request("breeds/image/random/#{images_number}")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # RANDOM IMAGE FROM A BREED COLLECTION
    #
    # * `breed` breed name
    #
    # Returns a random dog image from a breed, e.g. hound
    # Raises DogAPIException
    def random_image_by_breed(breed)
      begin
        response = get_request("breed/#{breed.strip}/images/random")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # MULTIPLE IMAGES FROM A BREED COLLECTION
    #
    # * `breed` breed name
    # * `images_number` number of images
    #
    # Return multiple random dog image from a breed, e.g. hound
    # Raises DogAPIException
    def multiple_random_images_by_breed(breed, images_number)
      begin
        response = get_request("breed/#{breed.strip}/images/random/#{images_number}")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # ALL IMAGES FROM A BREED COLLECTION
    #
    # * `breed` breed name
    #
    # Returns array of all the images from a breed, e.g. hound
    # Raises DogAPIException
    def images_by_breed(breed)
      begin
        response = get_request("breed/#{breed.strip}/images")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # SINGLE RANDOM IMAGE FROM A SUB BREED COLLECTION
    #
    # * `breed` breed name
    # * `sub_breed` sub_breed name
    #
    # Returns a random dog image from a sub-breed, e.g. Afghan Ho
    # Raises DogAPIException
    def random_image_by_sub_breed(breed, sub_breed)
      begin
        response = get_request("breed/#{breed.strip}/#{sub_breed.strip}/images/random")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # MULTIPLE IMAGES FROM A SUB-BREED COLLECTION
    #
    # * `breed` breed name
    # * `sub_breed` sub_breed name
    # * `images_number` number of images
    #
    # Return multiple random dog images from a sub-breed, e.g. Afghan Hound
    # Raises DogAPIException
    def multiple_random_images_by_sub_breed(breed, sub_breed, images_number)
      begin
        response = get_request("breed/#{breed.strip}/#{sub_breed.strip}/images/random/#{images_number}")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # LIST ALL SUB-BREED IMAGES
    #
    # * `breed` breed name
    # * `sub_breed` sub_breed name
    #
    # Returns array of all the images from the sub-breed
    # Raises DogAPIException
    def images_by_sub_breed(breed, sub_breed)
      begin
        response = get_request("breed/#{breed.strip}/#{sub_breed.strip}/images")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # LIST ALL BREEDS
    #
    # Returns hash of all the breeds as keys and sub-breeds as values if it has
    # Raises DogAPIException
    def breeds_list
      begin
        response = get_request('breeds/list/all')
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    ##
    # LIST ALL SUB-BREEDS
    #
    # * `breed` breed name
    #
    # Returns array of all the sub-breeds from a breed if it has sub-breeds
    # Raises DogAPIException
    def sub_breeds_list(breed)
      begin
        response = get_request("breed/#{breed.strip}/list")
        json = JSON.parse(response)
        if json['status'] != 'success'
          raise DogAPIException.new(json['message'])
        end
        if json['message'].length == 0
          raise DogAPIException.new('the breed does not have sub-breeds')
        end
        return json['message']
      rescue => ex
        raise DogAPIException.new(ex.message)
      end
    end

    private def get_request(endpoint)
      uri = URI("https://dog.ceo/api/#{endpoint}")
      res = Net::HTTP.get_response(uri)
      res.body
    end

  end
end