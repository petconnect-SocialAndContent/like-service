FROM ruby:3.2

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install

EXPOSE 3020

CMD ["ruby", "app/app.rb"]
