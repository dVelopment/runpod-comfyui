
mkdir -p /workspace/web-ui
echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync --remove-source-files -rlptDu --ignore-existing /venv/ /workspace/web-ui/venv/

echo "**** syncing stable diffusion to workspace, please wait ****"
rsync --remove-source-files -rlptDu --ignore-existing /stable-diffusion-webui/ /workspace/web-ui/stable-diffusion-webui/

if [[ -f /requirements.txt ]]; then
    echo "moving /requirements.txt to /workspace/web-ui/stable-diffusion-webui/requirements.txt"
    mv -f /requirements.txt /workspace/web-ui/stable-diffusion-webui/requirements.txt
fi

ln -s /cn-models/* /workspace/web-ui/stable-diffusion-webui/extensions/sd-webui-controlnet/models/

echo "**** symlinking models from ComfyUI ****"
ln -sf /workspace/models/vae_approx /workspace/web-ui/stable-diffusion-webui/models/VAE-approx

if [[ $RUNPOD_STOP_AUTO ]]
then
    echo "Skipping auto-start of webui"
else
    echo "Started webui through relauncher script"
    source /workspace/web-ui/venv/bin/activate
    cd /workspace/web-ui/stable-diffusion-webui
    python relauncher.py &
fi
