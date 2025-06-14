#!/bin/bash

# Ce script prépare un environnement Python 3.12 compatible Point2Mesh modernisé
# TensorFlow 2.16 (nightly), TensorFlow Probability, Addons, Graphics etc.
# Testé sous Ubuntu 22.04 WSL ou Linux natif

set -e

# # Mise à jour système
# sudo apt update
# sudo apt install -y python3.12 python3.12-dev python3.12-venv python3.12-distutils git wget build-essential

# # Création de l'environnement virtuel
# python3.12 -m venv point2mesh-venv
# source point2mesh-venv/bin/activate

# Mise à jour de pip
pip install --upgrade pip

# Installation des dépendances compatibles Python 3.12
echo "==> Installation TensorFlow nightly (2.16)"
pip install tf-nightly

echo "==> Installation TensorFlow Probability nightly"
pip install tfp-nightly

echo "==> Installation tensorflow-datasets pre-release"
pip install tensorflow-datasets --pre

echo "==> Installation tensorflow-addons depuis github"
pip install git+https://github.com/tensorflow/addons.git

echo "==> Installation tensorflow-graphics depuis github"
pip install git+https://github.com/tensorflow/graphics.git

# Installation des autres dépendances courantes de Point2Mesh
echo "==> Installation des dépendances générales"
pip install numpy scipy matplotlib pillow tqdm h5py trimesh opt-einsum scikit-image

echo "==> Installation terminé ✅"
