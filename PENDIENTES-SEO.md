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
