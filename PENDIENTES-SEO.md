# Pendientes SEO — juanpablomasia.netlify.app

> Estado al 01-nov-2026. Lo que **falta** hacer para mejorar posicionamiento.
> El on-page ya está bien: title, description, canonical, robots, 1 H1,
> 11 H2, alt en imágenes, sitemap.xml, robots.txt, HTTPS+HSTS, JSON-LD
> (LocalBusiness 9 ofertas + FAQPage 13 preguntas).

## B1. Dar de alta en Google Search Console (inmediato, gratis)

**Problema:** el sitio probablemente **no está indexado** en Google todavía.
Búsqueda `site:juanpablomasia.netlify.app` no arroja resultados.

**Pasos (lo hace el operador con su cuenta Google):**
1. Entrar a https://search.google.com/search-console
2. "Agregar propiedad" → tipo **Prefijo de URL** →
   `https://juanpablomasia.netlify.app/`
3. Verificar propiedad. Opción fácil: **etiqueta HTML**. Google da un
   `<meta name="google-site-verification" ...>`. Pegarlo en el `<head>` de
   `index.html` y push (Netlify despliega solo).
   - Alternativa sin tocar código: verificación por **DNS** (si ya hay dominio
     propio) o por **Google Analytics** (el sitio ya tiene GA4
     `G-CNV88M2Q9N` → se puede verificar por ahí directamente).
4. Enviar el sitemap: `https://juanpablomasia.netlify.app/sitemap.xml`
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
- Agregar redirect 301 de `juanpablomasia.netlify.app` → dominio nuevo.
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

---

### B6-bis. Decisión tomada (01-nov-2026, noche) — pendiente de EJECUTAR

El operador confirmó **A + B juntas** para el hero ("1 toda la razón, 2 toda la
razón"). No hay que volver a decidir: mañana es solo **ejecutar y validar**.

**Motivo:** A (arreglar) y B (mover) son el mismo arreglo. El hero no es lugar
para 4 precios; el detalle ya vive en `#modalidades`. Hacer solo una deja
problema (hero sin mensaje fuerte, o info duplicada).

**Hero propuesto (resultado final):**

> ⚡ *(badge actual, sin cambios)*
>
> # Arreglo tu PC remoto en todo Chile
> Soporte remoto para **Linux y Windows** por **$18.000/h**. Presencial en Macul
> y Android en mi domicilio. También armamos tu **página web**.
>
> [💬 Arreglar mi PC remoto] [Ver los 4 servicios]

**Problemas del hero actual que esto resuelve:**
1. El subtítulo suelta **4 servicios y 4 precios** de golpe (mucha info).
2. "Arreglo tu PC" / "arreglo tu Android" repetitivo.

**Lo que NO se toca:** H1 (mensaje fuerte), botones y badge.

**Checklist para mañana:**
- [ ] Verificar que `#modalidades` tenga los 4 servicios con precios
      (web $149.900 · PC presencial $44.900 +$19.900 fuera de Macul ·
      Android desde $19.900 · remoto $18.000/h).
- [ ] Acortar el subtítulo del hero (quitar listado de precios).
- [ ] Validar (HTML/anclas) y actualizar `style.css?v=` si se toca CSS.
- [ ] Rama + PR + revisar deploy preview. Trabajar en el MSI (encender por WoL).

---

## C. Publicidad de marca en el pie de página (idea del operador, 3-nov-2026)

**Idea:** que **todas** las páginas web que generemos (nuestra y de clientes)
lleven al final un **crédito/publicidad de marca** del operador — algo del tipo
*"Página web creada por Juan Pablo + IA"* / nombre de empresa. Así cada sitio que
entregamos **trabaja como publicidad nuestra** (efecto "powered by").

**Orden acordado: probar primero en nuestra propia página** (`cachyos-chile`).

### Estado actual del footer en `index.html` (línea ~473)

```html
<footer>
  <div class="wrap foot">
    <div>© 2026 Tu emprendimiento · Presencial en Macul · Remoto en todo Chile</div>
    <div><a href="https://cachyos.org" target="_blank">cachyos.org</a></div>
  </div>
</footer>
```

### Tareas

- [ ] Definir el **texto/ marca exacta**: nombre comercial + "· IA" (ej.
      *"Sitio creado por <Marca> · desarrollo web con IA"*). Ojo: el footer aún
      dice "Tu emprendimiento" → aprovechar para poner el nombre real.
- [ ] Agregar el crédito en el footer de **las 5 páginas** (`index.html`,
      `guias/`, `como-instalar-cachyos/`, `linux-vs-windows/`,
      `revivir-pc-viejo-con-linux/`).
- [ ] ¿Vincular el crédito a una **página propia** (portafolio/servicios de
      desarrollo web) para captar leads? Definir destino.
- [ ] Mantener consistencia visual (`style.css`) y actualizar `?v=` si se toca CSS.
- [ ] **Exportar el componente** (snippet HTML/CSS) reutilizable para pegar en
      los sitios de **clientes** — ahí es donde rinde como publicidad.

### Enlazado con el negocio

- Encaja con el servicio **#1 (Páginas web + mantención)** de cachyos-chile.
- Los sitios de clientes pasan a ser **vitrina** del servicio de desarrollo web.
- **No** poner datos de clientes en el crédito (privacidad, regla dura nº 5/6).

### Nota de flujo (cliente nuevo)

Hay un cliente que **mandará sus bocetos escritos + imágenes** para su sitio.
Cuando lleguen: armarlo en el repo público `cachyos-chile` (si es de marketing/
web) y aplicar el crédito de marca al pie desde el primer despliegue.
