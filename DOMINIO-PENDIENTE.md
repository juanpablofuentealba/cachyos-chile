# Dominio `juanpablomasia.cl` — todo listo, falta tu mano

> **Estado al 05-nov-2026.** El dominio elegido es **`juanpablomasia.cl`**.
> Verificado **LIBRE** en el whois oficial de NIC Chile (`whois.nic.cl`:
> `juanpablomasia.cl: no entries found`).
>
> **El trabajo técnico ya está hecho.** Lo único que no puede hacer un agente
> es **comprar** el dominio (requiere RUT + tarjeta + sesión autenticada;
> NIC Chile no tiene API de registro). Son ~5 minutos tuyos + los pasos de abajo.

---

## 1. Lo que ya está preparado (hecho por el agente)

| Pieza | Estado |
|---|---|
| `bin/cambiar-dominio.sh` | ✅ listo — cambia las **66** apariciones del host de una vez (canonical, `og:url`, `og:image`, Twitter, JSON-LD, sitemap, robots, `llms.txt`, plugin IndexNow, generador de sitemap) |
| Redirección 301 en `netlify.toml` | ✅ escrita y **comentada** — se activa con el dominio |
| `bin/generar-sitemap.sh` | ✅ regenera el sitemap con el host nuevo |
| Plugin IndexNow | ✅ dejará de dar **403** en cuanto el host sea `.cl` (acepta dominios propios, no `.netlify.app`) |
| `http→https` + HSTS | ✅ ya configurado en Netlify (SSL automático) |
| Prueba del script | ✅ `--check` cuenta las 66 coincidencias sin escribir nada |

---

## 2. TUS PASOS (en orden, ~15 minutos)

### Paso 1 — Comprar el dominio (5 min)

1. Entrar a **https://www.nic.cl** → "Inscribe tu dominio".
2. Buscar **`juanpablomasia.cl`** (libre) y agregarlo al carro.
3. Pagar **$9.990/año** (exento de IVA) con débito o crédito.
4. Inscribirlo **a tu nombre** (RUT). Es a 1 año, renovable.

> 💡 Puedes pagar más de un año de una vez (más barato a largo plazo).
> Al cliente le cobras $24.900/año, así que el margen cubre renovación + gestión.

### Paso 2 — Decime "listo" (1 min)

Con el dominio comprado, **respóndeme "dominio comprado"**. Yo hago:

- Corro `./bin/cambiar-dominio.sh juanpablomasia.cl` (las 66 URLs).
- Activo la redirección 301 en `netlify.toml`.
- Regenero `sitemap.xml` y `llms.txt`.
- Abro PR, verifico en el deploy preview y mergeo.

> ⚠️ **Importante:** el cambio de URLs **no hace daño antes de tiempo** —
> `juanpablomasia.cl` da error de DNS hasta que esté conectado. Por eso lo
> hacemos **después** de conectar el dominio, no antes.

### Paso 3 — Conectar el dominio en Netlify (5 min, requiere tu login)

1. Entrar a **https://app.netlify.com** → proyecto **`juanpablomasia`**.
2. **Domain settings** → **Add a domain** → escribir `juanpablomasia.cl`.
3. Netlify te muestra **2 caminos**:
   - **Opción A (recomendada, más simple):** cambiar los **nameservers** en NIC
     Chile por los de Netlify (`dns1.pXX.nsone.net` y compañía). Netlify
     configura todo solo (SSL incluido).
   - **Opción B:** dejar los nameservers de NIC y agregar los registros que
     Netlify indique (A / CNAME). Más manual, más fácil equivocarse.
4. Marcar `juanpablomasia.cl` como **Primary domain** (el `.netlify.app` queda
   redirigiendo solo).
5. Esperar propagación DNS (de minutos a un par de horas).

> El SSL (HTTPS) lo emite Netlify solo, gratis, cuando el DNS ya apunta bien.

### Paso 4 — Volver a Search Console (5 min)

Cuando `https://juanpablomasia.cl` ya responda:

1. En **Search Console**: agregar propiedad **`https://juanpablomasia.cl/`**
   (verificación por GA4, que ya está en las 5 páginas).
2. Enviar el sitemap: `https://juanpablomasia.cl/sitemap.xml`.
3. "Inspección de URL" → "Solicitar indexación" en las 5 páginas.
4. Si ya tenías la propiedad del `.netlify.app`: en **Configuración → Cambio de
   dirección** puedes declarar el cambio de dominio (señal fuerte para Google).

---

## 3. Qué gana el negocio con esto (por qué vale los $9.990)

| Antes (`.netlify.app`) | Después (`.cl`) |
|---|---|
| Google **desconfía** de subdominios gratuitos | Dominio país = señal de legitimidad |
| **IndexNow 403** (Bing/Yandex nunca se enteran) | IndexNow **funciona** en cada deploy |
| Compite contra negocios con `.cl` | Compite en igualdad |
| Cliente dice "¿es tuyo esto?" | Marca propia: `juanpablomasia.cl` |
| URL larga para dictar por teléfono | Dirección que se dicta de una |

---

## 4. Cuando intentes comprarlo, ojo con esto

- **NIC Chile no tiene API** ni registro automático: es formulario web con
  sesión. No hay forma de que un agente lo compre.
- **Titularidad:** inscribirlo a **tu nombre** (persona). Si algún día quieres
  facturar como empresa, se puede transferir el dominio después.
- **Renovación:** NIC avisa por correo. Si se vence, el dominio entra en
  "período de gracia" y luego se **libera al público**. Mantener el correo al día.
- **Alternativa si se te ocurre otro nombre:** `serviciotecnicomacul.cl` y
  `macultech.cl` también estaban libres al 01-nov-2026. Pero `juanpablomasia.cl`
  es **mejor a largo plazo**: la marca personal sirve para todos los servicios
  (web, PC, Android, remoto), no solo para Macul.
