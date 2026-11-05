# Google Search Console — hacerlo paso a paso

> Estado: **el sitio ya está listo del lado técnico.** Solo falta que el operador
> haga los clics. Todo lo de acá es la cuenta Google del operador (nadie más
> puede hacerlo).
>
> Verificado desde a13 el 05-nov-2026:
> - El archivo de verificación responde **200** y Googlebot puede leerlo.
> - `robots.txt` lo permite (`Allow: /`).
> - `sitemap.xml` con **6 URLs** bien formado.

---

## Paso 0 — Verificar la propiedad

1. Entrar a **https://search.google.com/search-console**
2. Arriba a la izquierda, menú de propiedades → **«Añadir propiedad»**
3. Elegir **«Prefijo de la URL»** (NO «Dominio»; ese pide DNS y todavía no
   tenemos el `.cl`).
4. Escribir exactamente:
   ```
   https://juanpablomasia.netlify.app/
   ```
   ⚠️ Con `https://` adelante **y** barra al final.
5. Apretar **«Continuar»**.
6. En la pantalla de verificación, buscar la opción **«Archivo HTML»**.
   Debe decir algo como *«Descarga el archivo… y súbelo a tu sitio»*.
   - El archivo ya está publicado en:
     `https://juanpablomasia.netlify.app/google394ddc95e10794bf.html`
   - **No hay que descargar ni subir nada más**: ya está en el sitio.
7. Apretar **«Verificar»**.

✅ Si dice *«Se ha verificado la propiedad»* → listo, pasá al paso 1.

> Si falla, esperar 1 minuto y «Verificar» de nuevo (Netlify a veces tarda en
> propagar). El archivo ya da 200, así que no hay razón para que falle.

---

## Paso 1 — Enviar el sitemap (una vez)

1. En el menú izquierdo → **«Sitemaps»**
2. En el campo «Añadir un sitemap nuevo», escribir solo:
   ```
   sitemap.xml
   ```
   ⚠️ Solo eso. No escribir la URL completa (Search Console la completa sola).
3. Apretar **«Enviar»**.
4. Debe quedar con estado **«Correcto»**. Las 6 URLs aparecerán en «Páginas».

---

## Paso 2 — Solicitar indexación de las 6 páginas (una vez)

1. Arriba, en la **barra de búsqueda** de Search Console (la de «Inspeccionar
   cualquier URL»).
2. Pegar la primera URL de la lista, apretar **Enter**, esperar que cargue.
3. Apretar **«Solicitar indexación»**.
4. Repetir con las 6. La lista exacta:

```
https://juanpablomasia.netlify.app/
https://juanpablomasia.netlify.app/guias/
https://juanpablomasia.netlify.app/como-instalar-cachyos/
https://juanpablomasia.netlify.app/linux-vs-windows/
https://juanpablomasia.netlify.app/revivir-pc-viejo-con-linux/
https://juanpablomasia.netlify.app/pc-se-apaga-solo/
```

> «Solicitar indexación» no garantiza que aparezca mañana, pero le avisa a Google
> que mire. Sin esto, puede tardar semanas.

---

## Paso 3 — Esperar y volver a mirar (en 3-7 días)

- **«Páginas»** (menú izquierdo) → cuántas están indexadas. Empezará bajo.
- **«Rendimiento»** → recién ahí empezarán a aparecer consultas reales de gente.
  Esos son los datos que necesitábamos para decidir qué contenido escribir.

---

## Qué NO hay que hacer

- ❌ No borrar `google394ddc95e10794bf.html` del sitio: Google revisa la
  verificación cada cierto tiempo y, si desaparece, pierdes la propiedad.
- ❌ No usar «Añadir propiedad → Dominio» todavía: eso pide el DNS del `.cl`.
  Cuando compres el dominio, se agrega **como propiedad nueva**.
- ❌ No obsesionarse con «Solicitar indexación» todos los días: una vez por URL
  basta.
