#!/bin/bash

export PYTHONUNBUFFERED=1

# comfyui
echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync -au --remove-source-files /comfy-ui/ /workspace/comfy-ui/

cd /workspace/comfy-ui
source /workspace/comfy-ui/venv/bin/activate

comfy launch -- --listen --port 3000 &
