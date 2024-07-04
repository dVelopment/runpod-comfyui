#!/bin/bash

export PYTHONUNBUFFERED=1

# comfyui
source /venv/bin/activate
rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/

cd /workspace/ComfyUI
python main.py --listen --port 3000 &

# automatic1111
echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync --remove-source-files -rlptDu --ignore-existing /web-ui/venv/ /workspace/venv/

echo "**** syncing stable diffusion to workspace, please wait ****"
rsync --remove-source-files -rlptDu --ignore-existing /web-ui/stable-diffusion-webui/ /workspace/stable-diffusion-webui/
ln -s /web-ui/cn-models/* /workspace/stable-diffusion-webui/extensions/sd-webui-controlnet/models/

echo "**** symlinking models from ComfyUI ****"
ln -s /workspace/ComfyUI/models/Stable-diffusion /workspace/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/Lora /workspace/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/hypernetworks /workspace/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/ControlNet /workspace/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/vae /workspace/stable-diffusion-webui/models/VAE
ln -s /workspace/ComfyUI/embeddings /workspace/stable-diffusion-webui/


if [[ $RUNPOD_STOP_AUTO ]]
then
    echo "Skipping auto-start of webui"
else
    echo "Started webui through relauncher script"
    cd /workspace/stable-diffusion-webui
    python relauncher.py &
fi
