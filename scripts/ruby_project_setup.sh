set -e # Exit on command failure

cleanup() {
  echo "Script interrupted. Do you want to clean up? (y/n)"
  echo "This will delete the directory ($PROJECT_NAME) that was just created."
  read RESPONSE
  if [[ "$RESPONSE" == "y" ]]; then
    cd .. && rm -rf "$PROJECT_NAME"
    echo "Cleaned up $PROJECT_NAME"
  fi
  exit 1
}

trap cleanup SIGINT SIGTERM

echo "=================================="
echo "|| Let's set up a Ruby project! ||"
echo "=================================="
echo "Enter project name: "
read PROJECT_NAME

# Replace spaces with underscores
PROJECT_NAME="$(echo "$PROJECT_NAME" | tr ' ' '_')"

mkdir "$PROJECT_NAME" && cd "$PROJECT_NAME"

echo "# $PROJECT_NAME" > README.md

echo "Checking for rbenv..."
if command -v rbenv &> /dev/null; then
  echo "rbenv found. Installed Ruby versions:"
  INSTALLED_VERSIONS=($(rbenv versions --bare))
  AVAILABLE_VERSIONS=($(rbenv install --list | awk '{print $1}' | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$"))

  if command -v tput &> /dev/null; then
    echo "Using ncurses for interactive selection..."

    select_ruby_version() {
      local choice=0
      local key
      while true; do
        clear
        echo "Select Ruby version using arrow keys and Enter:"
        for i in "${!INSTALLED_VERSIONS[@]}"; do
          if [[ $i -eq $choice ]]; then
            echo "> ${INSTALLED_VERSIONS[$i]}"
          else
            echo "  ${INSTALLED_VERSIONS[$i]}"
          fi
        done
        echo "  Install new version..."

        read -rsn1 key
        case "$key" in
          $'A'|k) ((choice=(choice-1+${#INSTALLED_VERSIONS[@]}+1)%(${#INSTALLED_VERSIONS[@]}+1))) ;; # Up arrow or 'k'
          $'B'|j) ((choice=(choice+1)%(${#INSTALLED_VERSIONS[@]}+1))) ;; # Down arrow or 'j'
          "")
            if [[ $choice -lt ${#INSTALLED_VERSIONS[@]} ]]; then
              RUBY_VERSION=${INSTALLED_VERSIONS[$choice]}
              break
            else
              echo "Select a version to install:"
              select NEW_VERSION in "${AVAILABLE_VERSIONS[@]}"; do
                if [[ -n "$NEW_VERSION" ]]; then
                  rbenv install "$NEW_VERSION" -s
                  RUBY_VERSION="$NEW_VERSION"
                  break
                fi
              done
              break
            fi
            ;;
        esac
      done
    }

    select_ruby_version
  else
    echo "No ncurses support found. Falling back to manual selection."
    echo "Installed versions:"
    select RUBY_VERSION in "${INSTALLED_VERSIONS[@]}" "Install new version..."; do
      if [[ "$RUBY_VERSION" == "Install new version..." ]]; then
        echo "Select a version to install:"
        select NEW_VERSION in "${AVAILABLE_VERSIONS[@]}"; do
          if [[ -n "$NEW_VERSION" ]]; then
            rbenv install "$NEW_VERSION" -s
            RUBY_VERSION="$NEW_VERSION"
            break
          fi
        done
      fi
      if [[ -n "$RUBY_VERSION" ]]; then
        break
      else
        echo "Invalid selection. Please try again."
      fi
    done
  fi

  echo "$RUBY_VERSION" > .ruby-version
else
  echo "rbenv not found. Skipping Ruby version selection."
fi

echo "" > .ruby-gemset  # Optional if using RVM

echo ".bundle/
/log/
/tmp/
*.gem
*.rbc
coverage/
vendor/bundle/" > .gitignore

git init

echo 'source "https://rubygems.org"' > Gemfile
cat <<EOL >> Gemfile
gem "rspec", group: :test
gem "rake", group: :development
gem "rubocop", require: false, group: :development
gem "bundler"
EOL

bundle install

mkdir lib spec

echo "require 'rake'" > Rakefile

echo 'require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task default: :spec' >> Rakefile

rspec --init

echo 'require "rubocop/rake_task"
RuboCop::RakeTask.new' >> Rakefile

echo "puts 'Hello, Ruby Project!'" > lib/main.rb

echo "require 'lib/main'

RSpec.describe 'Main' do
  it 'prints a greeting' do
    expect { load 'lib/main.rb' }.to output("Hello, Ruby Project!\n").to_stdout
  end
end" > spec/main_spec.rb

git add .
git commit -m "Initial project setup"
