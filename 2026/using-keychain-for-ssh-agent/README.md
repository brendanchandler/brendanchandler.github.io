# Passwordless ssh logins

To avoid entering your ssh password repeatedly, you can use the
ssh-agent command, which runs in the background and stores your
unencrypted ssh key for any future ssh clients that want to use it.
However, you have to remember to start ssh-agent once every time you
reboot your machine.

To make starting ssh-agent easier and more automatic, you can use the
`keychain` utility, which you can run on each shell startup and it
will check if an ssh-agent is already running, and if not, start one
for you.

Just add this to your shell startup (.bashrc in my case):

``` shell
# Start keychain with your private key (id_rsa in my case).  This starts
# ssh-agent if needed.
keychain $HOME/.ssh/id_rsa

# Set up environment variables like SSH_AGENT_PID that are needed to use 
# ssh-agent in this shell.
source $HOME/.keychain/$HOSTNAME-sh
```

