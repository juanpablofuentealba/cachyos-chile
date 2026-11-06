# Cómo se entrega un sitio al cliente (hosting y dominio)

> Documentado 05-nov-2026. Surgió de una duda real: *"¿después de 5 o 10
> clientes tengo que decirle a los clientes que se creen su Netlify?"*
>
> **Respuesta corta: no.** El trabajo lo haces tú; las cuentas quedan a nombre
> del cliente. Al cliente no se le pide nada.

---

## 1. La regla

| Pieza | A nombre de | Quién la crea | Quién la paga |
|---|---|---|---|
| **Dominio** (`.cl`) | **Cliente** | Tú (con RUT y tarjeta del cliente) | Cliente → $24.900/año |
| **Hosting Netlify** | **Cliente** | Tú (con el correo del cliente) | Incluido en el servicio |
| **El sitio (código)** | **Cliente** | Tú | Incluido |

**El cliente no crea cuentas ni llena formularios.** Tú haces todo el trabajo
técnico. Solo entregas las credenciales al final.

---

## 2. Por qué el hosting va en cuenta del cliente

**No es por los 300 minutos de build.** Ese límite casi no molesta: los sitios
son estáticos y no compilan nada.

**Es por los créditos compartidos del plan Free.** En el plan Free de Netlify,
el ancho de banda y los créditos son **de toda la cuenta**, no por sitio.

| Escenario | Qué pasa |
|---|---|
| 10 clientes en **tu** cuenta Free | Si **uno** recibe mucho tráfico, consume los créditos de todos → **se caen los 10** |
| Cada cliente en **su** cuenta | Un cliente con mucho tráfico solo se afecta a sí mismo |

**El riesgo real:** un cliente viral te derriba el sitio a los otros nueve,
incluidos los tuyos.

### Números concretos (medidos)

- Plan Free = **300 créditos/mes** compartidos por toda la cuenta.
- Con páginas de ~42 KB, **1.000 visitas ≈ 1,7 créditos**.
- Aguanta **decenas de miles de visitas**... si es un solo sitio.

### Ventajas de que la cuenta sea del cliente

| Ventaja | Para quién |
|---|---|
| Un cliente con mucho tráfico no afecta a los demás | Tú |
| Si termina la relación, el sitio sigue siendo suyo | Cliente (evita reclamos) |
| No cargas con mantener 20 cuentas ajenas | Tú |
| Puedes ofrecer mantención mensual sin riesgo | Ambos |

---

## 3. Cómo se lo dices al cliente

**No se le dice "créate un Netlify".** Se le presenta como un beneficio,
porque lo es.

### Texto para usar (WhatsApp o correo)

```
Tu página queda publicada con hosting incluido. Yo dejo todo funcionando.

Lo único: el hosting y el dominio quedan a tu nombre, en una cuenta que
armo con tu correo. Así el sitio es 100% tuyo y no depende de mí.
```

### Variante más corta

```
Tu sitio queda publicado y funcionando. El hosting y el dominio quedan a
tu nombre —yo armo las cuentas con tu correo—, así el sitio es tuyo y no
depende de que yo siga trabajando contigo.
```

### Si el cliente pregunta "¿y eso cuánto cuesta?"

```
El hosting va incluido en lo que te cobré. El dominio propio es aparte:
$24.900 al año, e incluye dejarlo configurado y apuntando a tu página.
```

### Si el cliente pregunta "¿tengo que hacer algo yo?"

```
No, nada. Yo creo las cuentas con tu correo, publico el sitio y te entrego
los accesos. Si algún día quieres cambiarte de proveedor, el sitio es tuyo.
```

---

## 4. Qué NO decir

| ❌ No decir | Por qué |
|---|---|
| "Créate una cuenta en Netlify" | Le pasas una tarea técnica que él no pidió ni entiende |
| "Hosting gratis" a secas | Genera expectativa de que nunca habrá costo (el dominio es aparte) |
| "Queda en mi cuenta y yo te lo administro" | Lo hace dependiente de ti y te carga el riesgo de los créditos |
| "Si se cae, es culpa de Netlify" | Suena a que no te haces cargo |

---

## 5. Procedimiento interno (para el agente o el operador)

Cuando se entrega un sitio nuevo:

1. **Dominio:** registrar en NIC Chile a nombre del cliente (RUT + tarjeta
   del cliente). Configurar DNS hacia Netlify.
2. **Netlify:** crear cuenta con el **correo del cliente** (no el tuyo).
   Publicar el sitio ahí.
3. **Verificar:** HTTPS activo, dominio resolviendo, WhatsApp funcionando.
4. **Entregar:** pasarle las credenciales de Netlify y el acceso al dominio.
5. **Registrar:** anotar en la ficha del cliente el dominio, la cuenta y la
   fecha de renovación anual.

> ⚠️ **Nunca dejar el sitio de un cliente en la cuenta propia.** Ni el dominio.
> Es riesgo compartido y complica la entrega si la relación termina.

---

## 6. Sobre el dominio (aclaración aparte)

El dominio **nunca fue problema**: cada cliente tiene el suyo, no hay límite.

| Concepto | Precio |
|---|---|
| Dominio propio (al cliente) | **$24.900/año** |
| Costo real en NIC Chile (`.cl`) | $9.990/año |
| Margen | $14.910/año |

NIC Chile cobra **exento de IVA**. Verificado en
`nic.cl/dominios/tarifas.html` el 05-nov-2026.

**NIC Chile solo vende `.cl`.** Los `.spa`, `.com` o `.net` se compran en
registradores internacionales (Namecheap, Cloudflare), en dólares, y salen
más caros. Para Chile, **`.cl` es lo que corresponde**.

---

## Fuentes

- `oferta.md` — precios y condiciones de los 4 servicios.
- `MARKETING.md`, línea 126 — cálculo de créditos del plan Free.
- Medición directa: API de Netlify (plan Free, `usages_exceeded: []`).
- `nic.cl/dominios/tarifas.html` — tarifas vigentes de `.cl`.
