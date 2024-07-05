
mkdir -p /workspace/web-ui
echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync --remove-source-files -rlptDu --ignore-existing /venv/ /workspace/web-ui/venv/

echo "**** syncing stable diffusion to workspace, please wait ****"
rsync --remove-source-files -rlptDu --ignore-existing /stable-diffusion-webui/ /workspace/web-ui/stable-diffusion-webui/
ln -s /cn-models/* /workspace/web-ui/stable-diffusion-webui/extensions/sd-webui-controlnet/models/

echo "**** symlinking models from ComfyUI ****"
ln -s /workspace/ComfyUI/models/Stable-diffusion /workspace/web-ui/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/Lora /workspace/web-ui/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/hypernetworks /workspace/web-ui/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/ControlNet /workspace/web-ui/stable-diffusion-webui/models/
ln -s /workspace/ComfyUI/models/vae /workspace/web-ui/stable-diffusion-webui/models/VAE
ln -s /workspace/ComfyUI/models/vae_approx /workspace/web-ui/stable-diffusion-webui/models/VAE-approx
ln -s /workspace/ComfyUI/embeddings /workspace/web-ui/stable-diffusion-webui/

if [[ $RUNPOD_STOP_AUTO ]]
then
    echo "Skipping auto-start of webui"
else
    echo "Started webui through relauncher script"
    cd /workspace/web-ui/stable-diffusion-webui
    python relauncher.py &
fi
