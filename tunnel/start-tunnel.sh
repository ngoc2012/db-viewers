#!/bin/sh

chmod 600 /root/.ssh/id_rsa

# Example: forward local port 3307 to db.example.com:3306 via ssh.example.com
ssh -i "$SSH_IDFILE" \
    -o StrictHostKeyChecking=yes -N \
    -L 0.0.0.0:5433:"$SSH_DOMAIN":5433 \
    -L 0.0.0.0:3308:"$SSH_DOMAIN":3308 \
    "$SSH_USER"@"$SSH_DOMAIN"
