# tab name changer
function tabname() { 
    echo -ne "\033]0;$@\007" 
}

# bundle install, db:migrate, db:test prepare
function bimp {
    echo '####################################'
    echo '  bundle install'
    echo '####################################'
    bundle install
    echo '####################################'
    echo '  bundle exec rake db:migrate'
    echo '####################################'
    bundle exec rake db:migrate
    echo '####################################'
    echo '  bundle exec rake db:test:prepare'
    echo '####################################'
    bundle exec rake db:test:prepare
}

# current git branch
function current-branch {
    git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1 /'
}

# git easy push
function geps {
    git push $* origin $(current-branch)
}

# git easy pull
function gepl {
    git pull --rebase $* origin $(current-branch)
}

# git checkout fuzzy
function gcf {
    branch="$(git branch | cut -b3- | grep "$1")"
    if [[ -n "$branch" ]]; then
        git checkout "$branch"
    else
        echo "Couldn't find branch matching $1." >&2
    fi
}

