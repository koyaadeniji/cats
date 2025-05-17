FROM ruby:3.0-alpine

# Set timezone & install packages
RUN apk add --no-cache build-base git tzdata && \
    cp /usr/share/zoneinfo/Africa/Lagos /etc/localtime && \
    echo "Africa/Lagos" > /etc/timezone

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler -v 2.2.4

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && bundle install

# Copy the entire app
COPY . .

# Expose the port
EXPOSE 8000

# Use puma to run rack app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

