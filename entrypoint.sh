#!/bin/bash
# Wait for the container to fully initialize
sleep 1

# Switch to the container's working directory
cd /home/container || exit 1

MODIFIED_STARTUP="eval $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')"
echo ":/home/container$ ${MODIFIED_STARTUP}"

${MODIFIED_STARTUP}