"""
Run this once to generate P-TC_Logo_blue.png in the same folder.
Requires: pip install Pillow
"""
from PIL import Image, ImageFilter
import numpy as np, os

script_dir = os.path.dirname(os.path.abspath(__file__))
src  = os.path.join(script_dir, "P-TC_Logo_v2.png")
dest = os.path.join(script_dir, "P-TC_Logo_blue.png")

img = Image.open(src).convert("RGBA")
w, h = img.size
data = np.array(img)
r, g, b = data[:,:,0].astype(float), data[:,:,1].astype(float), data[:,:,2].astype(float)
gray = 0.299*r + 0.587*g + 0.114*b
logo_mask = gray < 128

# Diagonal gradient: royal blue #1D4ED8 → cyan #06B6D4
c1 = np.array([29,  78, 216], dtype=float)
c2 = np.array([6,  182, 212], dtype=float)
xs = np.arange(w).reshape(1, w) / float(w)
ys = np.arange(h).reshape(h, 1) / float(h)
diag = np.clip((xs + ys) / 2.0, 0, 1)
grad = np.zeros((h, w, 3), dtype=float)
for c in range(3):
    grad[:,:,c] = c1[c] + (c2[c] - c1[c]) * diag

result = np.zeros((h, w, 4), dtype=np.uint8)
result[logo_mask, 0] = grad[logo_mask, 0].astype(np.uint8)
result[logo_mask, 1] = grad[logo_mask, 1].astype(np.uint8)
result[logo_mask, 2] = grad[logo_mask, 2].astype(np.uint8)
result[logo_mask, 3] = 255
out = Image.fromarray(result, "RGBA")

shadow_arr = np.zeros((h, w, 4), dtype=np.uint8)
shadow_arr[logo_mask] = [10, 30, 70, 150]
shadow = Image.fromarray(shadow_arr, "RGBA").filter(ImageFilter.GaussianBlur(7))
canvas = Image.new("RGBA", (w, h), (0,0,0,0))
sh = Image.new("RGBA", (w, h), (0,0,0,0)); sh.paste(shadow, (4,5))
canvas = Image.alpha_composite(canvas, sh)
canvas = Image.alpha_composite(canvas, out)

canvas.save(dest)
print("Saved:", dest)
