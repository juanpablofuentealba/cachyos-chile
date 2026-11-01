# Hallazgos técnicos — sitio cachyos-chile (Netlify)

> Registro de todo lo auditado y verificado el **01-nov-2026** sobre
> https://cachyos-chile.netlify.app/ mientras trabaja sin dominio propio.
> Cada hallazgo trae el dato real medido (no supuestos).
>
> Documento hermano: `PENDIENTES-SEO.md` (lo que falta hacer + dominio .cl).

---

## H-01 · Menú invisible en móvil (RESUELTO)

**Hallazgo.** En `<=820px` el CSS tenía:

```css
.nav-links a:not(.btn) { display: none; }
```

Ocultaba **todo** el menú (Modalidades, PC, Android, Remoto, Precios,
Páginas web, Guías, Preguntas) y **no había menú hamburguesa**. Desde el
celular solo quedaba el botón de WhatsApp → las secciones nuevas (`#web`)
eran inalcanzables. El grueso del tráfico web es móvil.

**Solución.** Menú hamburguesa **CSS-only** (checkbox + label, sin JS),
aplicado a las 5 páginas (index, /guias/ y las 3 guías de Linux).
`aria-label` + `.sr-only` para accesibilidad.

**Verificado.** `menu-toggle` presente en HTML y regla `:checked` en el CSS,
en producción.

---

## H-02 · Deploy roto por plugin local sin manifest (RESUELTO)

**Hallazgo.** Al agregar el plugin de IndexNow, el deploy falló dos veces:

```
Failed during stage 'building site': Build script returned non-zero exit code: 2
The plugin "./netlify/plugins/indexnow" is missing a "manifest.yml".
```

**Causa.** Un plugin local de Netlify necesita **3 cosas**: `index.js`,
`manifest.yml` y un `package.json` en la **raíz del repo**.
Faltaban el `manifest.yml` y el `package.json` raíz.

**Solución.** Se agregaron ambos. El deploy volvió a `ready`.

**Cómo se diagnostica.** `netlify build` en local replica el error exacto de
Netlify sin gastar un deploy. **Siempre correr `netlify build` antes de push.**

**Nota.** `constants.CONTEXT` viene `undefined` en build local; el plugin se
hizo tolerante (avisa igual en local, se salta previews en Netlify).

---

## H-03 · IndexNow rechaza subdominios `.netlify.app`

**Hallazgo.** El aviso a IndexNow (Bing/Yandex) responde siempre:

```json
{"errorCode":"UserForbiddedToAccessSite",
 "message":"User is unauthorized to access the site. Please verify the site using the key and try again"}
HTTP 403
```

**Descartado (todo estaba bien):** la key responde `200`, `text/plain`,
32 bytes sin salto de línea, HTTPS, sin redirects, `keyLocation` correcto.
Se probó GET y POST, con y sin `keyLocation`: **siempre 403**.

**Causa real.** IndexNow no acepta subdominios gratuitos compartidos
(`*.netlify.app`). Es la misma barrera que enfrenta Google.

**Estado.** Todo dejado armado (script + plugin en cada deploy + key
publicada). **Funcionará solo cuando haya dominio propio.**

**Dato curioso.** Con la key aún sin publicar devolvió `202` (aceptado);
con la key real publicada devuelve `403`. El `202` inicial era falso positivo.

---

## H-04 · Google/Bing eliminaron el ping de sitemap

**Hallazgo.**

| Endpoint | Respuesta |
|---|---|
| `google.com/ping?sitemap=…` | **404** (eliminado) |
| `bing.com/ping?sitemap=…` | **410** (eliminado) |

**Implicancia.** Ya no sirve "avisar" a Google por ping. El único camino es
**Search Console** (requiere clic del operador) y, para Bing/Yandex, IndexNow.

---

## H-05 · Las subpáginas no tienen Analytics

**Hallazgo.** GA4 (`G-CNV88M2Q9N`) está **solo en la home**. Medido:

| Página | Scripts GTM |
|---|---|
| `/` | 3 ✅ |
| `/guias/` | 0 ❌ |
| `/como-instalar-cachyos/` | 0 ❌ |
| `/linux-vs-windows/` | 0 ❌ |
| `/revivir-pc-viejo-con-linux/` | 0 ❌ |

**Implicancia.** No se ven en GA4 las visitas a las guías (que son las que
más tráfico orgánico pueden generar).

**Arreglo pendiente.** Copiar el mismo bloque de GA4 a las 4 subpáginas.
No se hizo porque no estaba pedido. Bajo riesgo.

---

## H-06 · La página 404 es la genérica de Netlify

**Hallazgo.** Cualquier URL inexistente muestra la 404 por defecto de Netlify
(con branding de Netlify), no una del negocio.

**Implicancia.** Feo y poco profesional si alguien llega por un enlace viejo.
Además pierde la oportunidad de ofrecer el servicio / WhatsApp.

**Arreglo pendiente.** Crear `404.html` en la raíz: Netlify la usa
automáticamente como 404 personalizada, sin configuración.

---

## H-07 · El sitemap no tiene `lastmod`

**Hallazgo.** `sitemap.xml` tiene `changefreq` y `priority`, pero **cero**
`lastmod` (fechas de modificación).

**Implicancia.** Los buscadores usan `lastmod` para saber si vale la pena
re-rasterizar. Sin fechas, pierden una señal útil.

**Arreglo pendiente.** Agregar `<lastmod>YYYY-MM-DD</lastmod>` a cada URL.
Idealmente automatizarlo con la fecha del último commit.

---

## H-08 · Rendimiento medido (sano)

**Datos reales** (01-nov-2026, desde a16):

| Métrica | Valor |
|---|---|
| HTML home | 42 KB (sin comprimir) |
| Assets totales | **1,6 MB** el sitio completo |
| CSS | 11 KB |
| Compresión | **Brotli** activa (`content-encoding: br`) ✅ |
| TTFB | ~0,31 s |
| Carga total home | ~0,44 s |

**Consumo de créditos (plan Free).** Con ~42 KB por página:
1.000 visitas ≈ **1,7 créditos** de bandwidth. Con 300 créditos/mes aguanta
**decenas de miles de visitas**. Sobrado para un negocio local.

---

## H-09 · Cache de assets

**Estado tras la optimización (PR #13):**

| Ruta | Cache-Control |
|---|---|
| `/` (HTML) | `max-age=0, must-revalidate` ✅ correcto (siempre fresco) |
| `/assets/*.css` | `max-age=31536000, immutable` ✅ |
| `/assets/*.jpg` | `max-age=31536000, immutable` ✅ |
| `/og-image-macul.jpg` | `max-age=31536000, immutable` ✅ (antes 1 h) |

**Ojo.** Al cachear el og-image 1 año, si algún día se cambia esa imagen hay
que **renombrarla o subir el `?v=`** del meta, si no seguirá la vieja en
WhatsApp/Facebook.

---

## H-10 · Rutas limpias y redirects (correcto)

**Verificado.** Netlify resuelve las pretty URLs solo:

```
/guias                    -> 301 -> /guias/    -> 200
/como-instalar-cachyos    -> 301 -> /…/        -> 200
```

No hacen falta redirects manuales en `netlify.toml` (y de hecho antes hubo
redirects redundantes que se quitaron).

---

## H-11 · HTTPS y seguridad (impecable)

| Header | Valor |
|---|---|
| HTTPS | ✅ forzado (http → 301) |
| HSTS | `max-age=31536000; includeSubDomains; preload` |
| `x-content-type-options` | `nosniff` |
| `x-frame-options` | `SAMEORIGIN` |
| `referrer-policy` | `strict-origin-when-cross-origin` |
| SSL | automático (Let's Encrypt, gestionado por Netlify) |

Nada que hacer aquí.

---

## H-12 · Preconnect a Analytics

**Cambio aplicado (PR #13).** Se agregó al `<head>` de la home:

```html
<link rel="preconnect" href="https://www.googletagmanager.com" crossorigin>
<link rel="dns-prefetch" href="https://www.googletagmanager.com">
<link rel="preconnect" href="https://www.google-analytics.com" crossorigin>
```

**Efecto.** El navegador abre la conexión a Google antes de pedir el script
de GA4 → carga menos bloqueante.

**Nota.** No se puso en las subpáginas porque no tienen Analytics (ver H-05).

---

## H-13 · Límites reales del plan Free de Netlify

**Plan Free = 300 créditos/mes**, compartidos por **todos** los proyectos de
la cuenta. Tarifas (oficiales de Netlify):

| Recurso | Créditos |
|---|---|
| Deploy de producción | 15 c/u |
| Bandwidth | 20 por GB |
| Web requests | 2 por 10.000 |
| Compute | 10 por GB-hora |

**Equivalencias de los 300 créditos (usando todo en una cosa):**
- ~15 GB de tráfico, o
- ~1,5 millones de requests, o
- ~20 deploys de producción, o
- ~11.000-12.000 visitas reales de 1 MB (mezcla típica).

**Límites de cuenta:** hasta **500 proyectos** por cuenta (Free, Personal, Pro).

**⚠️ Riesgo clave.** Los créditos son **compartidos**. Si un sitio de un
cliente se dispara, **se pausan TODOS** los sitios de la cuenta y los
visitantes ven "Site not available".

**Mitigación.** Al vender sitios a clientes, crear **una cuenta Netlify por
cliente** (gratis). Si un cliente crece mucho (>~11.000 visitas/mes), pasar
ese proyecto a **Personal ($9/mes ≈ $9.000 CLP)**.

---

## H-14 · La cuenta sigue en Free

**Verificado vía API de Netlify:** `type_name: Free`, sin método de pago,
`custom_domain: None`, `domain_aliases: []`.

Suficiente para el sitio actual. Revisar si se venden sitios (ver H-13).

---

## H-15 · Precios de mercado (para vender páginas web)

Investigado el 01-nov-2026 en fuentes chilenas:

| Servicio | Rango mercado |
|---|---|
| Landing page | $250.000 – $350.000 |
| Sitio servicios | $350.000 – $550.000 |
| Sitio corporativo pyme | $400.000 – $900.000 |
| Freelancer, sitio corporativo | $400.000 – $1.200.000 |
| Tienda online | $500.000 – $800.000+ |
| Catálogo/reservas/login | $1.200.000 – $3.000.000 |
| Mantención web mensual | $30.000 – $150.000 |
| Dominio `.cl` (NIC) | $9.990/año |
| Dominio `.com` (registrador) | ~$11.000/año |

**Nuestros precios (lanzamiento a la baja):**
Landing **$149.900** · Pyme **$249.900** · Dominio **$24.900/año** ·
Mantención **$9.900 / $19.900/mes**.

---

## Resumen de acciones sugeridas (no urgentes)

| # | Acción | Riesgo | Impacto |
|---|---|---|---|
| H-05 | GA4 en las 4 subpáginas | bajo | medir guías |
| H-06 | `404.html` propia | bajo | imagen profesional |
| H-07 | `lastmod` en el sitemap | bajo | SEO |
| B1 | Search Console (clic operador) | — | indexación |
| B2 | Dominio `.cl` (ver `PENDIENTES-SEO.md`) | — | **el grande** |
