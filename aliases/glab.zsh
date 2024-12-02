# brew install glab

# export GITLAB_HOST=

# Login
# glab auth login

# Clone all repos
# glab repo clone -g <group> -a=false -p --paginate

clone_all_pjt_repos() {
  mkdir -p ~/pjt
  cd ~/pjt
  echo "List of groups:"
  glab api --paginate 'groups?top_level_only=true' | jq -r ".[].full_path"
  echo "\nCloning all repos...\n"
  for group in $(glab api --paginate 'groups?top_level_only=true' | jq -r ".[].full_path"); do
    glab repo clone -g $group -a=false -p --paginate
  done
}