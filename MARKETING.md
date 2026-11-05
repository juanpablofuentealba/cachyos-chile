# Marketing y posicionamiento orgánico — resumen consolidado

> **Qué es esto.** Todo lo que la malla sabe sobre **publicidad y marketing
> orgánico del negocio**, reunido y verificado el **05-nov-2026** desde el nodo
> `a13`. Fuentes revisadas: `cachyos-chile` (README, HALLAZGOS, PENDIENTES-SEO,
> `index.html`, `sitemap.xml`, `robots.txt`, `netlify.toml`, `avisar-buscadores.sh`,
> plugin IndexNow), `malla-memoria-comun.md` (bitácora del sitio + tabla de
> servicios), `~/contenido/` y `~/dev/pi-dropshipping-pack/` (marketing de
> dropshipping, **otra línea de negocio**), y verificación en vivo por HTTP.
>
> **Regla del repo:** acá va *qué se vende* (precios, textos, SEO, marketing).
> El método y los scripts van a `rustdesk-wlan-ssh-pi`.

---

## 1. Lo esencial en 10 líneas

- Marca del sitio: **"Juan Pablo + IA"**. URL viva:
  **https://juanpablomasia.netlify.app/** (la vieja `cachyos-chile.netlify.app`
  da **404** — confirmado en vivo).
- El sitio **está publicado y sano** (HTTP 200, Brotli, HTTPS+HSTS, ~0,4 s de
  carga, 5 páginas estáticas).
- El **on-page está bien resuelto**: 1 H1, meta description de 161 caracteres,
  canonical, JSON-LD `LocalBusiness` (9 ofertas) + `FAQPage` (13 preguntas),
  `sitemap.xml` y `robots.txt` correctos.
- **El problema no es la web, es la distribución:** el negocio depende de
  **Google orgánico + WhatsApp**. Sin **Search Console** ni **dominio propio**,
  el sitio compite con las manos atadas.
- **Las dos palancas grandes siguen pendientes:** (1) alta en **Google Search
  Console**, (2) **dominio `.cl` propio** (`serviciotecnicomacul.cl` estaba
  **libre** al 01-nov).
- **IndexNow** (Bing/Yandex) está armado y **falla con 403** por ser subdominio
  `.netlify.app`: se activa solo cuando haya dominio propio.
- **Todo el tráfico orgánico de las guías es invisible:** GA4 está **solo en la
  home**; las 4 subpáginas no tienen Analytics.
- **Falta `404.html`** propia y **`lastmod`** en el sitemap (dos arreglos de
  bajo riesgo y bajo costo que aún no se hicieron).
- **Nada comprobado en móvil real**: el menú hamburguesa (H-01) se arregló, pero
  la revisión en pantalla chica del rediseño de nov-2026 sigue pendiente.
- **No hay estrategia orgánica fuera de Google**: sin Google Business Profile,
  sin redes activas enlazando, sin backlinks planificados.

---

## 2. La oferta que se publicita (los 4 servicios, en orden de valor)

| # | Servicio | Precio | Modalidad |
|---|---|---|---|
| 1 | **Páginas web** + mantención | desde **$149.900** (landing) · **$249.900** (hasta 5 pág.) | 100% remoto |
| 2 | **PC presencial en Macul** (formateo + CachyOS + optimización) | **$44.900** (visita incluida) · **+$19.900** fuera de Macul | Presencial |
| 3 | **Android** (optimización / formateo con respaldo) | **$24.900** · **$29.900** | En Macul, solo software |
| 4 | **Soporte remoto** (RustDesk + Tailscale, Windows/Linux) | **$18.000/hora** | Remoto, todo Chile |

- Mantención mensual: **Plan Cuidado $9.900/mes** · **Plan Activo $19.900/mes**.
- Dominio propio: **$24.900/año** (+ configuración); `.cl` en NIC = **$9.990/año**.
- Marca de posicionamiento declarada: **100% software** (no abre equipos, no
  cambia piezas) · **Presencial en Macul, remoto en todo Chile**.
- CTA único del sitio: **WhatsApp** (`wa.me/56931232000`, mensajes precargados
  distintos por servicio) + botón **Mercado Pago** (`link.mercadopago.cl/tuemprendimiento`).
- **Hueco de catálogo detectado:** falta como 5º servicio *"el PC se cae / se
  apaga → diagnóstico + informe"*, que es justamente el producto **más probado**
  en la práctica (caso `rai`) y 100% remoto.

> El detalle de la oferta y su relación con la malla vive en
> `rustdesk-clientes/malla-memoria-comun.md` → *"🌐 El negocio en línea"*.

---

## 3. Estado del sitio y del SEO (medido, no supuesto)

### 3.1 Lo que ya está bien

| Aspecto | Estado |
|---|---|
| Publicación | ✅ `https://juanpablomasia.netlify.app/` **200 OK** |
| On-page | ✅ 1 H1 (`Web y soporte técnico sin vueltas`), H2 por servicio, alt en imágenes |
| Meta description | ✅ 161 caracteres (antes 340 = muro) |
| Datos estructurados | ✅ `LocalBusiness` + 9 `Offer` + `FAQPage` (13 Q&A) |
| Canonical / `og:url` | ✅ apuntan a la URL nueva |
| `robots.txt` + `sitemap.xml` | ✅ 5 URLs correctas, dominio actualizado |
| Seguridad | ✅ HTTPS forzado, HSTS preload, `nosniff`, `SAMEORIGIN`, `referrer-policy` |
| Rendimiento | ✅ HTML 42 KB · sitio 1,6 MB · Brotli · TTFB ~0,31 s · carga ~0,44 s |
| Cache | ✅ HTML `max-age=0` · `assets/*` y `og-image` 1 año `immutable` |
| Rutas limpias | ✅ pretty URLs + 301 automáticos, sin redirects manuales |
| Móvil | ✅ menú hamburguesa CSS-only (H-01, antes el menú era **invisible** en ≤820px) |
| Analytics | ✅ GA4 `G-CNV88M2Q9N` en la **home** |

### 3.2 Lo que falta o está roto (por orden de impacto)

| # | Problema | Impacto | Riesgo de arreglarlo |
|---|---|---|---|
| **B1** | **Sin Google Search Console** → el sitio probablemente **no está indexado** | 🔴 Máximo: sin indexar, el orgánico es 0 | — (requiere clic del operador) |
| **B2** | **Sin dominio propio** (`.netlify.app` = poca autoridad y 403 en IndexNow) | 🔴 Alto | — (compra + ~30 min de config) |
| **H-05** | **GA4 solo en la home**; las 4 guías no miden nada | 🟠 Alto: ciegos justo en el contenido que más atrae orgánico | 🟢 Bajo (copiar el bloque) |
| **B6** | Hero sigue mezclando dos públicos (**negocio/web** vs **mi PC personal**) | 🟠 Medio: diluye el mensaje y el CTA | 🟢 Bajo (decisión A+B ya tomada, falta ejecutar) |
| — | **Sin revisión en móvil real** del rediseño de nov-2026 | 🟠 Medio: el grueso del tráfico web es móvil | 🟢 Nulo |
| **H-06** | **404 genérica de Netlify** (con marca Netlify) | 🟡 Bajo-medio: imagen poco profesional, se pierde el CTA | 🟢 Bajo (`404.html`) |
| **H-07** | **`sitemap.xml` sin `lastmod`** | 🟡 Bajo-medio: se pierde una señal de re-rastreo | 🟢 Bajo (ideal automatizar con fecha del commit) |
| **B4** | **Sin Google Business Profile** (búsqueda local "servicio técnico Macul") | 🟠 Medio: es gratis y refuerza lo local | 🟢 Bajo |
| **B4** | Sin backlinks ni redes enlazando | 🟡 Bajo-medio | 🟢 Bajo |
| **H-04** | El *ping* de sitemap a Google/Bing **ya no existe** (404/410) | — (informativo: no perder tiempo en eso) | — |

### 3.3 Riesgos de operación del hosting (afectan la publicidad)

- **Plan Free = 300 créditos/mes compartidos por TODA la cuenta.** Con ~42 KB
  por página, 1.000 visitas ≈ 1,7 créditos → aguanta decenas de miles de visitas.
  Pero **si un sitio de cliente se dispara, se pausan TODOS** (los visitantes ven
  "Site not available"). **Mitigación: una cuenta Netlify por cliente.**
- Un proyecto de cliente con **>~11.000 visitas/mes** conviene pasarlo a
  **Personal ($9/mes ≈ $9.000 CLP)**.
- **Cache del `og-image` a 1 año**: si algún día se cambia la imagen hay que
  **renombrarla o subir el `?v=`**, o WhatsApp/Facebook seguirán mostrando la vieja.

---

## 4. Las 4 cosas que realmente mueven la aguja

Ordenadas por relación **impacto / esfuerzo**:

1. **Dominio `.cl` propio** — `serviciotecnicomacul.cl` **verificada LIBRE** en
   el whois de NIC Chile (01-nov-2026). $9.990/año, se inscribe a nombre del
   operador con RUT (el agente **no puede** comprarlo: pago con tarjeta +
   identidad + NIC no tiene API).
   *Al tenerlo se desbloquea:* autoridad ante Google, **IndexNow deja de dar
   403**, redirect 301 desde el `.netlify.app`, `canonical`/`og:url`/`sitemap`/
   JSON-LD al dominio nuevo → todo eso **sí lo puede hacer el agente**.
2. **Google Search Console** — 5 minutos con la cuenta Google del operador.
   Verificación fácil por **GA4** (ya está instalado) o etiqueta HTML. Después:
   enviar el sitemap + "Solicitar indexación" en las 5 páginas.
3. **Instrumentar las 4 guías con GA4** — hoy el contenido que más puede atraer
   búsquedas orgánicas (*cómo instalar CachyOS*, *Linux vs Windows*, *revivir un
   PC viejo*) es **invisible** en Analytics.
4. **Contenido local + prueba social** — Google Business Profile (Macul) con
   fotos y horario; enlazar el sitio desde redes; mostrar el **ejemplo real**
   (`matias-electricista.netlify.app`) que ya está publicado y funcionando como
   credencial.

---

## 5. Activos de marketing que ya existen (y cómo se conectan)

| Activo | Dónde | Uso |
|---|---|---|
| **Sitio comercial** "Juan Pablo + IA" | `cachyos-chile` → Netlify | Escaparate principal, precios a la vista |
| **4 guías orgánicas** (CachyOS, Linux vs Windows, revivir PC viejo, índice) | `/guias/`, `/como-instalar-cachyos/`, `/linux-vs-windows/`, `/revivir-pc-viejo-con-linux/` | Imán de tráfico: responden búsquedas reales de gente que **ya** busca soluciones Linux |
| **Ejemplo real publicado** | `matias-electricista.netlify.app` (cliente `matías`, electricista) | Prueba social en la sección "¿Quién está detrás?" (`#quien-soy`) |
| **Kit público (vitrina)** | `rustdesk-wlan-ssh-pi-vitrina` | Marketing del *método*, sin datos de clientes |
| **Repos públicos técnicos** | `zte-blade-a54-debloat`, `android-debloat-log`, `pi-android-pack`, `antiacaros-uv`, `commitpilot` | Backlinks naturales y autoridad técnica del autor |
| **Pack de contenido dropshipping** | `~/dev/pi-dropshipping-pack/`, `~/contenido/` | **Otra línea de negocio** (TikTok/UGC, ads, WhatsApp). Plantillas de ganchos, ángulos y cumplimiento Ley 19.496 **reutilizables** para promocionar los servicios técnicos. |
| **WhatsApp** (`wa.me/56931232000`) | Todos los CTA | Canal de conversión real: el sitio no vende, **agenda** |

---

## 6. Contexto competitivo y de precios (01-nov-2026)

| Servicio | Mercado Chile | Nuestro precio |
|---|---|---|
| Landing page | $250.000 – $350.000 | **$149.900** |
| Sitio de servicios | $350.000 – $550.000 | **$249.900** |
| Sitio corporativo pyme | $400.000 – $900.000 | — |
| Tienda online | $500.000 – $800.000+ | — |
| Mantención web mensual | $30.000 – $150.000 | **$9.900 / $19.900** |
| Dominio `.cl` | $9.990/año (NIC) | $24.900/año al cliente |

**Lectura:** estamos **muy por debajo** del mercado en web y mantención
(estamos al 40–60% del piso). Eso sirve para entrar, pero **deja margen para
subir** cuando haya 2–3 casos publicados y el dominio propio. El dominio a
$24.900 es sano (2,5× el costo).

**Nicho local (salud, Macul):** CESFAM Dr. Félix de Amesti + COSAM Macul
(Corporación Municipal de Desarrollo Social de Macul, `corpomunimacul.cl`),
puerta técnica probable **DITEC**. Windows 10/11 en dominio (SIGGES lo exige).
**Oferta honesta: diagnóstico + arreglo con informe**, no "mantener arriba".
Contactos en `rustdesk-clientes/investigacion/macul-contactos-salud.md`.

---

## 7. Pendientes de marketing (checklist accionable)

**Operador (no delegable):**
- [ ] Comprar `serviciotecnicomacul.cl` en NIC Chile (RUT + tarjeta, $9.990).
- [ ] Alta en **Google Search Console** (verificación por GA4) + enviar sitemap
      + solicitar indexación de las 5 URLs.
- [ ] **Google Business Profile** (Macul): categoría, horario, fotos, WhatsApp.
- [ ] Revisar el sitio en **su celular** y decir qué se ve mal.

**Agente (autónomo, bajo riesgo):**
- [ ] **GA4 en las 4 subpáginas** (H-05).
- [ ] **`404.html`** propia con CTA a WhatsApp (H-06).
- [ ] **`lastmod`** en el sitemap, generado desde la fecha del commit (H-07).
- [ ] Ejecutar la **decisión A+B del hero** (B6-bis) y validar `#modalidades`.
- [ ] Al tener dominio: conectar en Netlify, 301 desde el `.netlify.app`,
      actualizar `canonical`/`og:url`/`sitemap`/JSON-LD, y **reintentar IndexNow**.
- [ ] Escribir y publicar la guía nº 5: *"el PC se enciende y se apaga solo"*
      (el servicio que falta y el caso que más se ha resuelto en la práctica).

---

## 8. Datos duros para citar (verificados el 05-nov-2026)

```
https://juanpablomasia.netlify.app/          -> 200  (URL viva)
https://cachyos-chile.netlify.app/           -> 404  (vieja, muerta)
https://matias-electricista.netlify.app/     -> 200  (ejemplo real)
sitemap.xml  -> 5 URLs, dominio actualizado, 0 lastmod
robots.txt   -> Allow: / + sitemap
subpáginas con GA4 -> 0 de 4
404.html     -> no existe
IndexNow     -> 403 UserForbiddedToAccessSite (subdominio .netlify.app)
dominio .cl  -> serviciotecnicomacul.cl LIBRE (whois.nic.cl, 01-nov-2026)
```

---

*Consolidado por Pi (nodo `a13`) el 05-nov-2026. Si cambia un precio, un texto
de venta o el estado SEO, **actualizar este archivo** — es la referencia que
debe leer cualquier nodo antes de proponer ideas de marketing.*
