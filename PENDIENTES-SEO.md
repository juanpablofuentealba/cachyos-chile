# Pendientes SEO — cachyos-chile.netlify.app

> Estado al 01-nov-2026. Lo que **falta** hacer para mejorar posicionamiento.
> El on-page ya está bien: title, description, canonical, robots, 1 H1,
> 11 H2, alt en imágenes, sitemap.xml, robots.txt, HTTPS+HSTS, JSON-LD
> (LocalBusiness 9 ofertas + FAQPage 13 preguntas).

## B1. Dar de alta en Google Search Console (inmediato, gratis)

**Problema:** el sitio probablemente **no está indexado** en Google todavía.
Búsqueda `site:cachyos-chile.netlify.app` no arroja resultados.

**Pasos (lo hace el operador con su cuenta Google):**
1. Entrar a https://search.google.com/search-console
2. "Agregar propiedad" → tipo **Prefijo de URL** →
   `https://cachyos-chile.netlify.app/`
3. Verificar propiedad. Opción fácil: **etiqueta HTML**. Google da un
   `<meta name="google-site-verification" ...>`. Pegarlo en el `<head>` de
   `index.html` y push (Netlify despliega solo).
   - Alternativa sin tocar código: verificación por **DNS** (si ya hay dominio
     propio) o por **Google Analytics** (el sitio ya tiene GA4
     `G-CNV88M2Q9N` → se puede verificar por ahí directamente).
4. Enviar el sitemap: `https://cachyos-chile.netlify.app/sitemap.xml`
5. Usar "Inspección de URL" → "Solicitar indexación" para las 5 páginas.

## B2. Dominio propio .cl (la palanca grande)

**Problema:** Google da **poca autoridad a subdominios gratuitos**
(`*.netlify.app`). La competencia se posiciona en `.cl` con contenido local.

**Acción:**
- Verificar disponibilidad de `serviciotecnicomacul.cl` (o similar) en NIC Chile.
- Costo: **$9.990/año** (exento de IVA). Al cliente se cobra $24.900/año.
- Una vez comprado: conectar en Netlify (Domain settings → Add custom domain),
  SSL automático. Actualizar `canonical`, `og:url`, `sitemap.xml` y JSON-LD con
  el dominio nuevo, y agregar redirect 301 del `netlify.app` al dominio.
- **Importante:** el dominio propio compite mejor y da confianza al cliente.

## B3. Cuenta Netlify propia por cliente (cuando se vendan sitios)

**Problema:** los 300 créditos/mes del plan Free son **compartidos por toda la
cuenta**. Si un proyecto de cliente se dispara, **se pausan TODOS** los sitios.

**Acción:** cuando se venda un sitio a un cliente, crear **una cuenta Netlify
por cliente** (gratis) y desplegar su proyecto ahí. Así el consumo queda aislado.
Si un cliente tiene mucho tráfico (>~11.000 visitas/mes), pasar ese proyecto a
Personal ($9/mes ≈ $9.000 CLP).

## B4. Extras opcionales (cuando haya tiempo)

- Alta en **Google Business Profile** (Macul) — refuerza búsqueda local.
- Enlazar el sitio desde redes (TikTok/Instagram) para señales externas.
- Revisar Core Web Vitals en PageSpeed Insights.
- Backlinks: repos públicos (vitrina), foros, directorios locales.

---

## Referencia de precios de mercado (investigado 01-nov-2026)

| Servicio | Mercado Chile |
|---|---|
| Landing page | $250.000 – $350.000 |
| Sitio servicios | $350.000 – $550.000 |
| Sitio corporativo pyme | $400.000 – $900.000 |
| Tienda online | $500.000 – $800.000+ |
| Mantención mensual | $30.000 – $150.000 |
| Dominio .cl | $9.990/año (NIC) |

**Nuestros precios (lanzamiento a la baja):**
Landing $149.900 · Pyme $249.900 · Dominio $24.900/año ·
Mantención $9.900 o $19.900/mes.

---

## B5. Dominio .cl — verificación de disponibilidad (01-nov-2026)

Consultado al **whois oficial de NIC Chile** (`whois.nic.cl:43`):

| Dominio | Estado |
|---|---|
| `serviciotecnicomacul.cl` | ✅ **LIBRE** |
| `soporte-macul.cl` | ✅ libre |
| `macultech.cl` | ✅ libre |
| `serviciotecnicomacul.com` | ❌ ocupado |
| `linuxchile.cl` | ❌ ocupado |

**Recomendado:** `serviciotecnicomacul.cl` (libre).

### Por qué el agente NO puede comprarlo
1. **Pago:** NIC exige tarjeta del operador.
2. **Identidad legal:** el .cl se inscribe a nombre de persona/empresa con RUT.
3. **Sin API:** NIC Chile no tiene API de registro (verificado; el registro es
   por formulario web con sesión autenticada).

### Pasos manuales (5 min, una vez) — operador
1. Entrar a https://www.nic.cl → "Inscribe tu dominio".
2. Buscar `serviciotecnicomacul.cl`, registrar.
3. Pagar **$9.990/año** (exento de IVA) con débito/crédito.
4. A nombre del operador (RUT).

### Lo que queda automatizado cuando haya dominio (agente)
- Conectar dominio en Netlify (DNS + SSL automático).
- Actualizar `canonical`, `og:url`, `sitemap.xml` y JSON-LD al dominio nuevo.
- Agregar redirect 301 de `cachyos-chile.netlify.app` → dominio nuevo.
- Actualizar host/keyLocation en `netlify/plugins/indexnow/index.js` y
  `avisar-buscadores.sh` → **IndexNow empieza a funcionar** (hoy da 403 por ser
  subdominio `.netlify.app`; con dominio propio debería aceptar).
- Guiar el alta en Search Console (requiere clic del operador).

### Estado de IndexNow (dejado listo, pendiente dominio)
- ✅ `avisar-buscadores.sh` creado y funcionando.
- ✅ Plugin Netlify `netlify/plugins/indexnow/` con `manifest.yml` y
  `package.json` raíz → corre en cada deploy (`plugin_state: success`).
- ✅ Key publicada: `4ac291d7c370106abaa06b0edf277790.txt`.
- ⚠️ Aviso rechazado hoy con `UserForbiddedToAccessSite` (403): IndexNow no
  acepta subdominios `.netlify.app`. Se resolverá con el dominio propio.

---

## B6. Revisar el hero: mezcla dos servicios y puede confundir (PENDIENTE)

**Origen:** observación del operador (01-nov-2026): *"hay que arreglar la
info del hero para más claridad de los clientes; se confunden cosas desde mi
punto de vista, pero en principio está bueno."* Estado: **aceptable por ahora**,
pero anotado para mejorar.

**Hero actual:**

> **Tu negocio con página web — y tu PC como nuevo**
> *Te armo tu página web profesional (rápida, con WhatsApp y hosting incluido)
> y también dejo tu PC, notebook o Android funcionando como nuevo: formateo,
> instalación de Linux (CachyOS) y optimización. Presencial en Macul o remoto
> en todo Chile.*
> CTA: "Quiero mi página web" · "Ver los 4 servicios"

**Qué puede confundir (a revisar):**

1. **Dos mensajes en un mismo titular.** Web (digital, para negocios) y
   reparación de PC (equipo físico) son públicos distintos. Juntarlos en el
   H1 puede diluir qué ofrece realmente.
2. **"Tu PC como nuevo"** — el sitio NO toca hardware (solo software). "Como
   nuevo" podría hacer pensar en arreglo físico (piezas, pantalla), y luego
   el cliente se decepciona al leer "solo software".
3. **"Tu negocio con página web"** — asume que el visitante *tiene* un
   negocio; el que entra buscando arreglar su PC personal no se siente aludido.
4. **"Presencial en Macul o remoto en todo Chile"** aparece junto a la web,
   pero la web no es presencial. Mezcla geografía de servicios que no aplica
   igual a todos.
5. **CTA principal = web**, cuando quizá la mayoría del tráfico que llega busca
   algo técnico (o al revés). Conviene decidir el público objetivo principal.

**Ideas para cuando se retome (elegir una):**

- **A. Hero de servicio único:** dejar solo el servicio más rentable (web) y
  mover el técnico a su sección. Más claro, pero abandona al visitante técnico.
- **B. Hero con dos columnas/botones separados:** "¿Quieres una web?" vs
  "¿Tu PC está lento?", cada uno con su CTA. Segmenta sin mezclar.
- **C. Hero por público:** "Para tu negocio" / "Para tu equipo", con
  sub-opciones. Más ordenado si el tráfico es mixto.
- **D. Dejar el hero como está** y solo pulir redacción (quitar "como nuevo",
  aclarar "solo software").

**Nota:** el operador considera el estado actual **aceptable**, no urgente.
