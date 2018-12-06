class Link < ActiveRecord::Base
    validates :long_url, presence: true, on: :create
    validates_format_of :long_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
    before_create :generate_random_slug

    def generate_random_slug
        chars_in_slug = 6
        alphabet_str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        slug = []

        i = 0
        while i < chars_in_slug
            random_index = rand(0..61)
            slug[i] = alphabet_str[random_index]
            i += 1
        end
        
        self.short_url = slug.join()
        # self.save
    end
end