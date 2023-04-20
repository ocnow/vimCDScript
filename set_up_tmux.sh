#!/bin/bash

#function to list folders in ls and ask choice to switch
chose_dir () {
    echo "Chose Project:"
    directories=($(ls -d */ 2>/dev/null))
    directories=("New Project" "$directories[@]")
    select dir in $directories; do
    # Check if the user has made a selection
        if [[ $REPLY -eq 1 ]];then
            echo "Happy coding..go ahead and create project"
            return 0
        elif [ -n "$dir" ]; then
            echo "You select project $dir Happy coding"
            cd $dir
            set_up_tmux .
            break
        else
            echo "Invalid choice. Please try again."
         fi
    done
    return 0
}

set_up_tmux () {
    tmux new-session -d -s $arg1 cargo-session;
    tmux rename-window -t 0 'Main'
    tmux send-keys -t 'Main' 'tmux split-window -h' C-m 'swap-pane' C-m 'clear' C-m 'nvim .' C-m
    tmux attach-session -t cargo-session:0
}

cd /Users/omkarkulkarni/Coding

echo "Enter which path:"
echo "1.Leetcode"
echo "2.Reactapps"
echo "3.Next"
echo "4.Rust"
echo "5.JSPrac"

read pathchoice

case $pathchoice in
    1)
        #echo "chosen 1"
        cd LeetCode
        ;;
    2)
        #echo "chose 2"
        cd React/reactpps/
        ;;
    3)
        #echo "chosen 3"
        cd React/nextapps/
        ;;
    4)
        cd Rust/
        ;;
    5)
        cd LearnJS/
        ;;
    *)
        #echo "default choice"
        return 0
        ;;
esac

chose_dir

