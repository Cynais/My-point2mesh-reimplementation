import os
import uuid
import trimesh
import numpy as np

MANIFOLD_SOFTWARE_DIR = "Manifold/build"

def remesh(vertices: np.ndarray, faces: np.ndarray, num_faces=2000):
    # Write the original mesh as OBJ.
    original_file = random_file_name("obj")
    mesh = trimesh.Trimesh(vertices=vertices, faces=faces)
    mesh.export(original_file)

    # Create a manifold of the original file.
    manifold_file = random_file_name("obj")
    manifold_script_path = os.path.join(MANIFOLD_SOFTWARE_DIR, "manifold")
    cmd = f"{manifold_script_path} {original_file} {manifold_file}"
    os.system(cmd)

    # Simplify the manifold.
    simplified_file = random_file_name("obj")
    simplify_script_path = os.path.join(MANIFOLD_SOFTWARE_DIR, "simplify")
    cmd = (
        f"{simplify_script_path} -i {manifold_file} -o {simplified_file} -f {num_faces}"
    )
    os.system(cmd)

    # Load the simplified manifold robustement
    loaded_mesh = trimesh.load(simplified_file, force='mesh')
    
    if not isinstance(loaded_mesh, trimesh.Trimesh):
        raise ValueError("Failed to load simplified mesh")

    # Prevent file spam.
    os.remove(original_file)
    os.remove(manifold_file)
    os.remove(simplified_file)

    return loaded_mesh.vertices, loaded_mesh.faces


def random_file_name(ext, prefix="tmp_"):
    return f"{prefix}{uuid.uuid4()}.{ext}"
