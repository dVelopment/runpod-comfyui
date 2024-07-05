# #!/bin/bash
#########################################################
# Uncomment and change the variables below to your need:#
#########################################################

# Install directory without trailing slash
install_dir="/workspace/web-ui"

# Name of the subdirectory
#clone_dir="stable-diffusion-webui"

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="--port 4000 --xformers --skip-install --listen --enable-insecure-extension-access"
#export XFORMERS_PACKAGE="xformers==0.0.17.dev447"

# add custom models directories to COMMANDLINE_ARGS
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --cpkt-dir /workspace/models/Stable-diffusion"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --embeddings-dir /workspace/embeddings"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --hypernetwork-dir /workspace/models/hypernetworks"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --vae-dir /workspace/models/vae"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --lora-dir /workspace/models/Lora"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS} --controlnet-dir /workspace/models/ControlNet"

# python3 executable
#python_cmd="python3"

# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
venv_dir="/workspace/web-ui/venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

# install command for torch
# export TORCH_COMMAND="pip install torch"

# Requirements file to use for stable-diffusion-webui
#export REQS_FILE="./extensions/sd_dreambooth_extension/requirements.txt"

# Fixed git repos
#export K_DIFFUSION_PACKAGE=""
#export GFPGAN_PACKAGE=""

# Fixed git commits
#export STABLE_DIFFUSION_COMMIT_HASH=""
#export TAMING_TRANSFORMERS_COMMIT_HASH=""
#export CODEFORMER_COMMIT_HASH=""
#export BLIP_COMMIT_HASH=""

# Uncomment to enable accelerated launch
# export ACCELERATE="True"

###########################################
