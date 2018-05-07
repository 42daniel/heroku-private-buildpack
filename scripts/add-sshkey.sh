
set -x          # enable debugging

env_dir=${1:-}
ssh_key_file=${env_dir}/BUILDPACK_SSH_KEY
GIT_SSH_KEY=$(cat ${ssh_key_file})

if [ "$GIT_SSH_KEY" != "" ]; then
      echo "Detected SSH key for git. Adding SSH config" >&1
      echo "" >&1

      # Ensure we have an ssh folder
      if [ ! -d ~/.ssh ]; then
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
      fi

      # Load the private key into a file.
      echo $GIT_SSH_KEY | base64 --decode > ~/.ssh/deploy_key

      # Change the permissions on the file to
      # be read-only for this user.
      chmod 400 ~/.ssh/deploy_key

      # Setup the ssh config file.
      echo -e "Host github.com\n"\
              " IdentityFile ~/.ssh/deploy_key\n"\
              " IdentitiesOnly yes\n"\
              " UserKnownHostsFile=/dev/null\n"\
              " StrictHostKeyChecking no"\
              > ~/.ssh/config
fi