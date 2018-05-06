This supports loading a build pack from a private git repository.

It hooks in only to the release and compile api.

To use:-

1. Add this to heroku as a buildpack

    heroku buildpacks:set heroku/ruby
    
2. Add a file in the project root   .heroku-private-build.yml with the following shape:-


    {
        buildpacks: [ {
            uri: 'git@github.com:user/private-repor'
        }]
    }

3. Add the base64 enocded deploy key to the BUILDPACK_SSH_KEY env variable
    
    heroku config:set BUILDPACK_SSH_KEY=<build key>
    
    
Then push to heroku.
   
# heroku-private-buildpack
