"""
Prepara as fotos de fundo do Monasterium.

Como usar (na raiz do projeto, onde fica o pubspec.yaml):
  1. Crie a pasta  originais  e coloque nela as fotos baixadas (jpg, png, webp).
  2. Rode:  python preparar_fundos.py
  3. As fotos redimensionadas e renomeadas vão para  assets/fundos/
     (paisagem01.jpg, paisagem02.jpg ...). As originais não são alteradas.

Se aparecer erro de módulo, instale uma vez:  pip install pillow
"""
import os
import sys

try:
    from PIL import Image, ImageOps
except ImportError:
    print("Falta o Pillow. Instale com:  pip install pillow")
    sys.exit(1)

ORIGINAIS = "originais"
DESTINO = os.path.join("assets", "fundos")
LARGURA_MAX = 1600
QUALIDADE = 80
EXTENSOES = (".jpg", ".jpeg", ".png", ".webp")

if not os.path.isdir(ORIGINAIS):
    print(f"Crie a pasta '{ORIGINAIS}' e coloque as fotos nela.")
    sys.exit(1)

os.makedirs(DESTINO, exist_ok=True)

# Continua a numeração de onde parou, sem sobrescrever fotos já prontas.
existentes = [f for f in os.listdir(DESTINO) if f.lower().startswith("paisagem")]
proximo = len(existentes) + 1

arquivos = sorted(f for f in os.listdir(ORIGINAIS) if f.lower().endswith(EXTENSOES))
if not arquivos:
    print(f"Nenhuma foto encontrada em '{ORIGINAIS}'.")
    sys.exit(1)

for nome in arquivos:
    try:
        with Image.open(os.path.join(ORIGINAIS, nome)) as img:
            img = ImageOps.exif_transpose(img).convert("RGB")
            if img.width > LARGURA_MAX:
                altura = round(img.height * LARGURA_MAX / img.width)
                img = img.resize((LARGURA_MAX, altura), Image.LANCZOS)
            saida = os.path.join(DESTINO, f"paisagem{proximo:02d}.jpg")
            img.save(saida, "JPEG", quality=QUALIDADE, optimize=True)
            kb = os.path.getsize(saida) // 1024
            print(f"{nome} -> {os.path.basename(saida)} ({kb} KB)")
            proximo += 1
    except Exception as e:
        print(f"Pulei {nome}: {e}")

print(f"\nPronto. {proximo - 1} fotos em {DESTINO}")
