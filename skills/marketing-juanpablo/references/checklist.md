# Checklist antes de publicar — Juan Pablo + IA

> Pasar **todo** texto por acá antes de entregarlo al operador. Si algo falla,
> se corrige; no se entrega "con la salvedad".

## 1. Datos (lo que se puede verificar)

- [ ] **Precio correcto** y sacado de `oferta.md` (no de memoria ni inventado).
- [ ] **Nombre de marca**: "Juan Pablo + IA". Nunca el nombre del repo.
- [ ] **URL correcta**: `juanpablomasia.cl` (o `.netlify.app` mientras no haya
      dominio). **Nunca** `cachyos-chile.netlify.app` (está en 404).
- [ ] **WhatsApp** correcto: `wa.me/56931232000`.
- [ ] Si se menciona un plazo, es el real (no "en 24 horas" si no es cierto).

## 2. Voz (Chile, tuteo)

- [ ] **Tuteo**, sin voseo: no aparece *tenés, podés, querés, sabés, decime,
      fijate, andá, hacelo*.
- [ ] Frases cortas. Beneficio antes que característica.
- [ ] Suena a un técnico chileno que sabe lo que hace, no a aviso corporativo.
- [ ] Sin jerga innecesaria (*on-page, backend, deploy*) salvo que el público la use.

## 3. Cumplimiento (Ley 19.496 — publicidad engañosa)

- [ ] **Ninguna** promesa absoluta: *100%, garantizado, cura, elimina todos,
      nunca se cae, para siempre*.
- [ ] **Ningún** caso, reseña, testimonio ni cifra inventada.
- [ ] **"Solo software"** está dicho cuando se habla de PC/Android (no se abren
      equipos, no se cambian piezas).
- [ ] No se promete compatibilidad absoluta (*"corre todos los juegos"*,
      *"funciona con cualquier programa"*): Windows-only existe (SIGGES, Rayen).
- [ ] No se sugiere que se accede a datos personales del cliente.

## 4. Conversión (¿el texto lleva a alguna parte?)

- [ ] Hay **una** acción clara (normalmente escribir por WhatsApp).
- [ ] El siguiente paso es obvio y de un solo clic.
- [ ] Si es web: el precio está a la vista (es nuestra ventaja).
- [ ] Si es WhatsApp: se entiende en 3 líneas, sin párrafos.

## 5. Técnico (si el cambio va al sitio)

- [ ] JSON-LD **válido** (probar con `python3 -m json.tool`).
- [ ] `sitemap.xml` al día → `./bin/generar-sitemap.sh --check`.
- [ ] Si se tocó CSS → subir `?v=` en las 5 páginas.
- [ ] Se revisó en **pantalla chica** (o se avisa que no se probó).
- [ ] Si cambió una URL o el dominio → `./bin/cambiar-dominio.sh`.
- [ ] Un solo cambio por PR, con título claro.

## 6. Cierre

- [ ] Se entrega el **texto final** listo para copiar, no "opciones para que elijas".
- [ ] Se dice **qué medir** para saber si funcionó (clics, mensajes, visitas).
- [ ] Se avisa **qué NO se hizo** y por qué.

---

### Firma de calidad

> ¿Un cliente de Macul lo entiende en una pasada, sabe cuánto cuesta y sabe qué
> hacer después? **Si alguna de las tres es "no", no está listo.**
