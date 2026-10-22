# Configuración de los 4 dispositivos — cachyos-chile

Guía para sincronizar tus dispositivos con el repositorio de GitHub y el sitio de Netlify.

- **Repositorio:** https://github.com/juanpablofuentealba/cachyos-chile
- **Sitio en vivo:** https://cachyos-chile.netlify.app/
- **Usuario GitHub:** juanpablofuentealba
- **Correo:** jpfuentealbabizama@gmail.com

---

## Resumen de dispositivos

| # | Dispositivo | Sistema | Estado |
|---|---|---|---|
| 1 | Notebook | CachyOS + pi | ✅ Ya sincronizado |
| 2 | PC | CachyOS + pi | ⏳ Pendiente |
| 3 | Android | Termux + pi | ⏳ Pendiente |
| 4 | Android | Termux + pi | ⏳ Pendiente |

---

## Dispositivo 2 — PC con CachyOS (fish)

Copia y pega esto en una terminal **fish** de ese PC:

```fish
# ===== SETUP cachyos-chile en CachyOS =====
sudo pacman -S --needed git github-cli

git config --global user.name "juanpablofuentealba"
git config --global user.email "jpfuentealbabizama@gmail.com"
git config --global init.defaultBranch main

# Autenticación GitHub (elige: GitHub.com -> HTTPS -> Login with a web browser)
gh auth login

mkdir -p ~/Projects
cd ~/Projects
git clone https://github.com/juanpablofuentealba/cachyos-chile.git
cd cachyos-chile

echo "=== listo ==="
git log --oneline -1
git status -sb
```

---

## Dispositivos 3 y 4 — Android con Termux

Copia y pega esto en **Termux** de cada Android (shell bash):

```bash
# ===== SETUP cachyos-chile en Termux =====
pkg update && pkg upgrade -y
pkg install -y git gh

git config --global user.name "juanpablofuentealba"
git config --global user.email "jpfuentealbabizama@gmail.com"
git config --global init.defaultBranch main

# Autenticación (elige: GitHub.com -> HTTPS -> Login with a web browser)
gh auth login

mkdir -p ~/Projects
cd ~/Projects
git clone https://github.com/juanpablofuentealba/cachyos-chile.git
cd cachyos-chile

echo "=== listo ==="
git log --oneline -1
git status -sb
```

---

## Sobre `gh auth login`

En ambos casos, cuando lo ejecutes:

1. Elige **GitHub.com**
2. Protocolo: **HTTPS**
3. Autenticar Git: **Yes**
4. Cómo autenticar: **Login with a web browser**
5. Copia el **código de 8 dígitos** que aparece
6. Abre `https://github.com/login/device`, pega el código y autoriza

---

## Flujo de trabajo (una vez configurados)

En cualquier dispositivo:

```bash
cd ~/Projects/cachyos-chile
git pull                    # traer cambios de otros dispositivos
# ... editar archivos ...
git add -A
git commit -m "descripción"
git push                    # sube a GitHub -> Netlify despliega solo
```

**Regla de oro:** haz `git pull` ANTES de empezar a editar, para evitar
conflictos entre dispositivos.

---

## Cómo funciona la sincronización

```
Dispositivo  ->  GitHub (main)  ->  Netlify (auto-deploy)  ->  cachyos-chile.netlify.app
```

- **GitHub:** cada dispositivo clona el repo y hace push con `gh auth login`.
- **Netlify:** NO se conecta a cada dispositivo. Se conecta al repo de GitHub.
  Cuando haces `git push`, Netlify detecta el cambio y despliega solo.
- Los dispositivos NO necesitan Netlify CLI para nada.

---

## Notas

- **Termux** usa bash, no fish. Los comandos de arriba funcionan en bash.
  Si quieres fish en Termux: `pkg install fish` y `chsh -s fish`.
- **pi** (el agente IA) es una instalación aparte en cada dispositivo.
  No se sincroniza automáticamente. Para trabajar el repo basta con git + gh.
- **Seguridad:** si usas tokens en vez de `gh auth login`, no compartas el mismo
  token en todos los dispositivos y revócalos cuando ya no los uses
  (https://github.com/settings/tokens).
