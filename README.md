# Servicio Técnico Macul — cachyos-chile

Sitio estático (HTML + CSS) para el servicio técnico de software a domicilio en Macul.
Publicado en Netlify: https://cachyos-chile.netlify.app/

## Estructura

```
.
├── index.html                      # Landing principal
├── guias/index.html                # Índice de guías
├── como-instalar-cachyos/index.html
├── linux-vs-windows/index.html
├── revivir-pc-viejo-con-linux/index.html
├── og-image-macul.jpg              # Imagen de vista previa (WhatsApp/redes)
├── assets/
│   ├── style.css
│   ├── como-instalar-cachyos.jpg
│   ├── linux-vs-windows.jpg
│   └── revivir-pc-viejo.jpg
├── robots.txt
├── sitemap.xml
└── netlify.toml
```

## Vista previa local

```bash
python3 -m http.server 8080
# abrir http://localhost:8080
```

## Vista previa del enlace (WhatsApp)

WhatsApp/Meta cachea la preview de cada URL. Si la imagen no aparece o no se
actualiza:

1. Revisa en https://developers.facebook.com/tools/debug/ pegando la URL y
   pulsando **"Scrape Again"**.
2. Como WhatsApp comparte la caché de Meta, tras re-scrapear suele aparecer.
3. Para forzar una preview nueva en un chat, comparte la URL con un parámetro
   distinto, p. ej. `https://cachyos-chile.netlify.app/?v=3`.

Metas relevantes en `index.html`:

- `og:image` → `https://cachyos-chile.netlify.app/og-image-macul.jpg` (1200x630)
- `og:image:width` / `og:image:height` → `1200` / `630`
- `twitter:card` → `summary_large_image`

> Nota: se quitó el `?v=2` de las URLs de imagen para máxima compatibilidad con
> crawlers que ignoran query strings.

## `fb:app_id` (opcional)

El Sharing Debugger puede advertir *"Missing Properties: fb:app_id"*. Es solo
una advertencia de atribución, **no** impide que la imagen se muestre. Si quieres
eliminarla, crea una app en https://developers.facebook.com/apps/ y añade en el
`<head>` de `index.html`:

```html
<meta property="fb:app_id" content="TU_APP_ID">
```

## Despliegue

Conectado a Netlify. Para desplegar manualmente:

```bash
# opción Netlify CLI
npx netlify deploy --prod --dir=.
```

O arrastra la carpeta a https://app.netlify.com/drop.
