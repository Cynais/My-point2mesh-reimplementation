
#!/bin/bash
set -e

echo "=== Compilation de Manifold et Simplify ==="

# # Dépendances build
# sudo apt update
sudo apt install -y cmake gcc-10 g++-10 build-essential git

# Récupération du projet
cd ~/My-point2mesh-reimplementation

# --- Compilation de Manifold ---
git clone --recursive https://github.com/hjwdzh/Manifold || echo "Manifold déjà cloné"
cd Manifold
mkdir -p build
cd build
cmake .. -DCMAKE_C_COMPILER=gcc-10 -DCMAKE_CXX_COMPILER=g++-10 -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
cd ../..

# # --- Compilation de Simplify ---
# git clone https://github.com/Hjwdzh/QuadricMeshSimplification.git || echo "Simplify déjà cloné"
# cd QuadricMeshSimplification
# mkdir -p build
# cd build
# cmake ..
# make -j$(nproc)
# cd ../..

# --- Placement des binaires ---
mkdir -p Manifold/build
cp Manifold/build/manifold Manifold/build/
cp QuadricMeshSimplification/build/simplify Manifold/build/

echo "✅ Compilation de Manifold et Simplify terminée"