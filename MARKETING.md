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
- [ ] Aprobar el **ciclo de automatización** (sección 8.6) y qué puede publicar
      el agente solo y qué pasa siempre por su revisión.

**Agente (autónomo, bajo riesgo):**
- [ ] **GA4 en las 4 subpáginas** (H-05).
- [ ] **`404.html`** propia con CTA a WhatsApp (H-06).
- [ ] **`lastmod`** en el sitemap, generado desde la fecha del commit (H-07).
- [ ] Ejecutar la **decisión A+B del hero** (B6-bis) y validar `#modalidades`.
- [ ] Al tener dominio: conectar en Netlify, 301 desde el `.netlify.app`,
      actualizar `canonical`/`og:url`/`sitemap`/JSON-LD, y **reintentar IndexNow**.
- [ ] Escribir y publicar la guía nº 5: *"el PC se enciende y se apaga solo"*
      (el servicio que falta y el caso que más se ha resuelto en la práctica).

> 🔎 Detalle de automatización con agentes y plan por etapas: **sección 8**.

---

## 8. Marketing orgánico automatizado asistido por agentes

> Investigado el **05-nov-2026**. Aquí va **cómo la malla puede producir y
> mantener su marketing orgánico con agentes** (Pi), sin depender de que el
> operador se siente a escribir. Es un mapa de diseño, no una receta mágica:
> lo que ya tenemos, lo que se puede automatizar y dónde están los límites.

### 8.1 Qué significa "orgánico automatizado" (y qué no)

| ✅ Sí se puede automatizar con agentes | ❌ No se debe (o no resulta) |
|---|---|
| Escribir y refrescar **contenido** (guías, FAQ, textos) | "Hackear" posiciones o comprar backlinks |
| **Medir** (GSC, GA4, rankings) y **reportar** lo que se movió | Publicar en masa sin revisión humana |
| **Detectar** oportunidades (búsquedas sin responder) | Spamear en Meta/TikTok (viola términos) |
| **Ejecutar** la parte técnica (metadata, JSON-LD, sitemap, `llms.txt`, 301) | Inventar reseñas, testimonios ni stock |
| **Redactar borradores** de anuncios/guiones y entregarlos listos | Decir "elimina el 100%" / prometer resultados |
| **Vigilar** que el sitio no se rompa (deploy, 404, enlaces) | Responder reseñas/comentarios con bots |

**Regla de oro del operador:** el agente **investiga y prepara**, el operador
**decide y publica**. Base legal: **Ley 19.496** (publicidad engañosa) y términos
de Meta/TikTok (ya está escrita en
`pi-dropshipping-pack/skills/dropshipping-chile/SKILL.md`).

### 8.2 Las 5 capas del sistema (de abajo hacia arriba)

**Capa 1 — Fundamentos técnicos (agente, sin riesgo).** Es lo que los buscadores
necesitan para *poder* indexar y rankear. Hoy está casi todo:

| Pieza | Estado (05-nov-2026) |
|---|---|
| `robots.txt` + `sitemap.xml` | ✅ 200 OK, 5 URLs |
| JSON-LD por tipo de página | ✅ `LocalBusiness`+`Offer`+`FAQPage` (home), `HowTo` (cachyos), `Article` (linux-vs-windows, revivir-pc), `CollectionPage` (guias) |
| Meta description / canonical / OG | ✅ en las 5 páginas |
| **`llms.txt`** (mapa del sitio para LLMs) | ❌ **404** — no existe |
| **`lastmod`** en sitemap | ❌ falta |
| **`404.html`** propia | ❌ falta |
| **GA4 en subpáginas** | ❌ 0 de 4 |
| **Search Console** | ❌ sin alta |
| **Dominio propio** | ❌ pendiente |

> **Aporte nuevo de esta investigación:** el JSON-LD por tipo de página **ya está
> hecho** (algo que `HALLAZGOS.md` no registraba) — falta *alimentarlo* con
> datos reales: `datePublished`/`dateModified` verdaderos y `author`.

**Capa 2 — Captura de señales (medición).** Sin esto no hay automatización:
el agente no puede "ver" qué funciona. **GSC + GA4** son la fuente. La
automatización real es *leer* esas exportaciones y sacar conclusiones
(palabras que traen gente, páginas con impresiones altas y CTR bajo = título
malo, consultas sin página que las responda = contenido que falta).

**Capa 3 — Producción de contenido (agente, con revisión).** Es donde el
agente rinde más. El patrón ya existe en `pi-dropshipping-pack`:
*encuadre → AIDA → ángulos → guion → checklist de cumplimiento*. Reutilizable
para el negocio técnico con otra voz.

**Capa 4 — Distribución y ejecución (agente).** Web es solo una parte:
Google Business Profile, WhatsApp como canal de conversión, y la vitrina pública
como backlink natural.

**Capa 5 — Ciclo de mejora (agente + cron).** Medir → escribir → publicar →
volver a medir. En **a13 ya hay `crond` (runit) corriendo** con jobs cada 15
min, así que la infraestructura para tareas programadas **ya existe**.

### 8.3 El patrón concreto: cómo se automatiza con Pi hoy

Piezas de Pi que ya están instaladas y sirven para esto:

| Pieza | Cómo se usa para marketing |
|---|---|
| **`pi --print "..."`** (modo no interactivo) | Un job de cron que produce un informe de una sola pasada, sin abrir TUI |
| **`pi --mode json`** | Registro estructurado (JSONL) de lo que hizo el agente → auditable |
| **Skills** (`skills.md`) | Encapsular el *workflow* de marketing: se cargan solo cuando la tarea lo pide |
| **Prompt templates** | `/producto`, `/anuncios`, `/tiktok`, `/banner`, `/whatsapp` ya escritos en el pack |
| **Extensiones** | Ejecutar la parte repetitiva (validar JSON-LD, actualizar sitemap) |
| **MCP** (`mcp.md`) | Conectar GA4/GSC/Dropi como herramientas del agente |
| **`codemode`** | Correr en un solo script varias comprobaciones (¿sitemap 200? ¿`llms.txt`? ¿enlaces rotos?) y devolver solo el resumen |
| **Cron de runit (a13)** | Disparar el ciclo semanal/mensual sin operador presente |

**Ciclo propuesto (semanal, en a13):**

```
1. codemode  → salud técnica: sitemap/robots/llms.txt/404/enlaces/JSON-LD válido
2. GSC+GA4   → top consultas, CTR bajo, páginas sin tráfico, consultas huérfanas
3. agente    → propone 1-3 acciones (título nuevo / sección FAQ / guía nueva)
4. agente    → redacta el borrador + el cambio técnico exacto (diff)
5. operador  → aprueba por WhatsApp/sesión (1 min)
6. agente    → rama + PR + verificación + deploy
7. registrar → qué se hizo y qué se espera medir la próxima semana
```

### 8.4 Qué NO se automatiza con agentes (límites duros)

1. **Autoridad real.** Google no premia "volumen producido por IA": premia
   contenido **útil, verificable y de una fuente real**. El sitio tiene ventaja
   única acá: **casos reales** (`rai`, `matías`) — eso no lo puede generar un
   agente, solo el operador.
2. **Cuentas.** Search Console, Business Profile, NIC Chile y Meta requieren
   **identidad del operador**. El agente guía, no suplanta.
3. **Publicar sin revisar.** Un agente que publica solo **destruye la marca** en
   un error. Siempre PR + revisión.
4. **Promesas.** Nada de "garantizado", "100%", "cura": Ley 19.496.
5. **Reseñas.** Se piden y se muestran reales; no se escriben.

### 8.5 Gaps concretos que esta investigación reveló

| Gap | Por qué importa | Quién |
|---|---|---|
| **Sin `llms.txt`** (404) | Los asistentes IA (ChatGPT, Perplexity, Copilot) son hoy una **fuente real de tráfico orgánico**. Un `llms.txt` le dice a esos asistentes qué hay en el sitio y cómo citarlo. Es texto plano, riesgo cero. | Agente |
| **`dateModified` falso/genérico** | Los buscadores y los LLMs premian *frescura real*. Hay "2026" en todas las páginas: sin fecha exacta no se distingue lo actual. | Agente |
| **Sin `author`/`publisher` real** en el JSON-LD de las guías | Es la señal de **E-E-A-T** (experiencia real). El operador *sí* tiene experiencia: hay que declararla. | Agente |
| **Sin medición de subpáginas** | Sin GA4 en las guías, el ciclo completo no tiene entrada. | Agente |
| **Sin `Marketing` en el flujo de Pi** | El pack de dropshipping tiene skill; el negocio técnico **no tiene su propia skill de marketing**. Hoy el conocimiento vive en `MARKETING.md`, que es pasivo. | Agente |
| **Cron sin job de marketing** | Hay 3 jobs (watchdog, relé WoL, sync HP) pero **ninguno** mide ni reporta la web. | Agente |

### 8.6 Plan por etapas (lo que se puede empezar ya)

**Etapa 0 — Cimientos (agente, 1 sesión, reversible):**
- [ ] `llms.txt` en la raíz (mapa del sitio en texto plano para asistentes IA).
- [ ] `lastmod` real en `sitemap.xml`, generado desde la fecha del commit.
- [ ] `404.html` propia con CTA a WhatsApp.
- [ ] GA4 en las 4 subpáginas (cierra H-05).
- [ ] `author`/`publisher` + `dateModified` reales en el JSON-LD.

**Etapa 1 — Ojos (operador + agente):**
- [ ] Search Console (verificación por GA4) + enviar sitemap.
- [ ] Exportar/consultar GSC y GA4; primer informe de "qué trae gente".

**Etapa 2 — Skill de marketing del negocio:**
- [ ] Crear `marketing-servicio-tecnico` (skill de Pi) con la voz del negocio:
      tuteo chileno, precios a la vista, prueba real, sin promesas.
      **Este repo (`cachyos-chile`) es su fuente de verdad.**

**Etapa 3 — Ciclo automático (cron de a13):**
- [ ] Job semanal `pi --print` que produce el informe + borradores y **solo**
      escribe en `~/informes/marketing/AAAA-MM-DD.md` (nada de push automático).
- [ ] El operador revisa; lo aprobado se convierte en PR.

**Etapa 4 — Cuando haya dominio propio:**
- [ ] IndexNow empieza a funcionar (Bing/Yandex) en cada deploy.
- [ ] 301 del `.netlify.app`, `canonical`/`og:url`/`sitemap`/JSON-LD al dominio.

### 8.7 La advertencia importante

El marketing orgánico automatizado **multiplica lo que ya hay**, no crea
resultados de la nada. Si el sitio no está indexado (hoy **probablemente no lo
está**: sin Search Console), automatizar contenido es **llenar un balde sin
fondo**. **Orden correcto: primero cimientos y medición (Etapas 0 y 1), después
producción.**

Además: el contenido generado por IA **sin experiencia real encima** se detecta
y no posiciona. El activo que ningún competidor puede copiar es el archivo de
**casos reales resueltos** (rai, matías, los hallazgos H-01..H-86 del kit). La
tarea del agente es **empaquetar** ese conocimiento, no inventarlo.

---

## 9. Datos duros para citar (verificados el 05-nov-2026)

```
https://juanpablomasia.netlify.app/          -> 200  (URL viva)
https://cachyos-chile.netlify.app/           -> 404  (vieja, muerta)
https://matias-electricista.netlify.app/     -> 200  (ejemplo real)
sitemap.xml  -> 5 URLs, dominio actualizado, 0 lastmod
robots.txt   -> Allow: / + sitemap
llms.txt     -> 404  (no existe)
subpáginas con GA4 -> 0 de 4
404.html     -> no existe
JSON-LD por página  -> LocalBusiness/Offer/FAQPage · HowTo · Article · CollectionPage
IndexNow     -> 403 UserForbiddedToAccessSite (subdominio .netlify.app)
dominio .cl  -> serviciotecnicomacul.cl LIBRE (whois.nic.cl, 01-nov-2026)
a13          -> crond (runit) activo; pi --print / --mode json disponibles
```

---

*Consolidado por Pi (nodo `a13`) el 05-nov-2026. Si cambia un precio, un texto
de venta o el estado SEO, **actualizar este archivo** — es la referencia que
debe leer cualquier nodo antes de proponer ideas de marketing.*
