#!/bin/sh

chmod 600 /root/.ssh/id_rsa.pub

# Example: forward local port 3307 to db.example.com:3306 via ssh.example.com
    # -o StrictHostKeyChecking=yes -N \

# echo "$SSH_IDFILE" "$SSH_DOMAIN" "$SSH_USER" "$SSH_DOMAIN"
ssh -i "$SSH_IDFILE" \
    -o StrictHostKeyChecking=no -N \
    -L 0.0.0.0:5433:"$SSH_DOMAIN":5433 \
    -L 0.0.0.0:3308:"$SSH_DOMAIN":3308 \
    "$SSH_USER"@"$SSH_DOMAIN"
