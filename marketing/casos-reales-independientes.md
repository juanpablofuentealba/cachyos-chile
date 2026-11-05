# Casos reales: personas que trabajan solas con agentes de IA

> Investigado 05-nov-2026 desde el MSI. Fuentes: Hacker News (API Algolia),
> artículos públicos de los propios autores.
> **Objetivo:** sacar ideas replicables para "Juan Pablo + IA".

---

## El caso más completo: Blake La Pierre

**Quién:** ingeniero en ciencias de la computación (redes y sistemas
distribuidos), consultor por años. **Empresa unipersonal**, sin empleados.

**Qué hace:** publica libros de puzzles en Amazon KDP, corre bots de
market-making en cripto, y hace consultoría.

**Cómo lo hace:** ~17 agentes de IA, cada uno con **un trabajo angosto**, su
propia memoria y su propio contexto. Todos comparten **un solo Linux**.

> *"Traté el problema como un problema de sistemas distribuidos. En vez de un
> chat gigante donde pregunto todo, dividí el trabajo en agentes separados,
> cada uno con un trabajo angosto, su propia memoria y su propio contexto.
> Un agente sabe todo sobre mis libros de puzzles y nada sobre mis impuestos."*

### Su equipo (agrupado por función)

| Área | Agentes |
|---|---|
| **Publicación** | Libros (construye y mantiene los libros KDP; el repo git tiene fuente, archivos de impresión y borradores de listado) |
| **Trading** | Estrategia · Vigilancia de bots en vivo (diagnostica pérdidas y escribe el arreglo) · Escáner de prop trading · Escáner de opciones |
| **Caza de dinero** | Bonos de banco, promociones de broker, programas de referidos (rastrea 36 programas, marca vencimientos urgentes) |
| **Administración** | Odoo (ERP: hojas de tiempo, reportes) · Código tributario de EE.UU. · Capital para pymes |
| **Proyectos paralelos** | Stream de audio 24/7 en YouTube · Radio web |
| **Generalistas** | Uno que mantiene la visión global · uno que responde lo que no encaja en ningún lado |

### Las 5 lecciones que él mismo sacó

1. **Agentes angostos le ganan a un chat gigante.**
   Un agente enfocado acumula contexto en su área: conoce el estilo de la casa,
   las convenciones de carpetas y **todas las ideas que ya rechazaste** (lleva
   un registro de ideas). Un generalista tendría que reaprender eso cada vez.

2. **Hazles mostrar el trabajo.**
   Sus mejores agentes **etiquetan la confianza**: el agente de capital marca
   cada afirmación como *verificado*, *de terceros*, *no verificado* o
   *estimación*. El de trading separa la pérdida en categorías para poder
   revisar la aritmética.
   > *"Cuando un agente te dice cómo sabe algo, puedes confiarle más."*

3. **Solo alertas, humano en el loop para el dinero.**
   El escáner de Kraken **no puede operar**: solo imprime entrada, stop y
   tamaño. Los bots parten en *dry-run* y pasan a vivo con pocos dólares antes
   de subir capital por etapas.
   > *"Perder $1,14 por un bug es matrícula. Perder $1.140 es un problema."*

4. **Artefactos reales, no respuestas de chat.**
   Todo lo que vale la pena guardar termina como **archivo**: un repo, un CSV,
   un reporte markdown con la fecha en el nombre. Así el trabajo es revisable,
   comparable y reutilizable por otros agentes.

5. **Construir es fácil. Publicar es el cuello de botella.**
   Tenía 14 libros construidos y **solo 2 publicados**. Los agentes producen
   más rápido de lo que él puede revisar, subir y vender.
   > *"La restricción se movió de hacer cosas a decidir y terminar."*

### Su rutina semanal

> *"Reviso los chats de los bots, leo lo que hicieron y les mando ideas nuevas.
> Eso es todo. Toma exactamente lo que me toma leer y escribir."*

Algunas cosas corren por **cron** (el escáner de dinero cada hora, y solo
reporta lo nuevo o lo que cambió materialmente, para no ahogarlo en repetidos).

**Lo irreversible lo hace él:** operar, abrir cuentas, publicar, gastar plata.

---

## Patrones que se repiten en otros casos

### 1. Un producto, un nicho, un dueño

| Caso | Qué es | Dato |
|---|---|---|
| **Lunch Money** | App de presupuesto personal | **Una sola persona**, nómada digital |
| **Checkbot** | Extensión Chrome que audita SEO/velocidad/seguridad de sitios | Un desarrollador |
| **Pageflows** | Biblioteca de flujos de UX | *"Paga mis cuentas hace un par de años; un día o dos de trabajo a la semana"* |
| **nicbou** | Contenido para inmigrantes en Alemania | **Comisión por referir** a servicios que el lector necesita |
| **masa331** | Addon pago para una plataforma de e-commerce (25k tiendas) | Empezó como empleado, luego partnership 80/20 |

**Patrón:** no venden "horas". Venden **un producto o un servicio repetible**
que ya está construido.

### 2. El contenido trae al cliente, no la publicidad

- **nicbou** escribe guías gratis y cobra **comisión** cuando el lector contrata
  el servicio que necesita.
- **Pageflows** vive de tráfico orgánico a una biblioteca de ejemplos.

**Traducción a tu caso:** las guías que ya publicaste (`/pc-se-apaga-solo/`,
`/revivir-pc-viejo-con-linux/`, `/linux-vs-windows/`) son exactamente esto.
Son el activo, no el relleno.

### 3. La advertencia honesta

Un comentario de HN que vale la pena tener presente:

> *"Solía tener un negocio unipersonal rentable. Y me sentía miserable cada vez
> que tenía que levantarme de noche a arreglar el servidor, o dar soporte desde
> el laptop cuando se supone que estaba de vacaciones. Ahora que somos equipo,
> me siento mucho mejor, aunque el margen sea un poco menor."*

**Lección:** el negocio unipersonal tiene un techo que no es técnico, es
**de atención**. Los agentes ayudan a producir, pero **no responden el
teléfono a las 2 de la mañana**.

### 4. El cliente no quiere hacer tu trabajo

> *"Los clientes no quieren hacer el trabajo de sus proveedores. Yo no quiero
> escanear mis propias compras en el supermercado."*

**Lección:** aunque la IA esté disponible, el cliente **paga por no tener que
usarla**. Eso protege tu negocio: no te reemplaza un ChatGPT, te reemplaza
alguien que **se haga cargo**.

### 5. La rendición de cuentas es el foso

> *"Los agentes no tienen concepto de responsabilidad. Aunque sean capaces de
> reemplazar al coordinador, no vamos a dejarles hacer cosas importantes:
> siempre queremos la última palabra."*

**Lección:** tu ventaja no es "uso IA". Es que **respondes tú**. Eso es lo que
el cliente compra.

---

## Qué replicar en "Juan Pablo + IA" (concreto)

### A. Agentes angostos, no un chat gigante

Hoy tienes un solo Pi que hace todo. La lección de La Pierre es separar:

| Agente | Trabajo | Dónde vive |
|---|---|---|
| **Ventas** | Correos a colegios/iglesias, seguimiento, registro de respuestas | `marketing/` |
| **Sitio** | Contenido, SEO, guías, deploy | repo `juanpablomasia` |
| **Clientes** | Fichas, historial, respaldos | `rustdesk-clientes` |
| **Técnico** | Hallazgos, scripts, diagnóstico | `rustdesk-wlan-ssh-pi` |

**No hace falta instalar nada nuevo:** ya tienes la separación por repos y por
skills. Lo que falta es **tratarlos como agentes distintos** (cada uno con su
contexto y su registro), no mezclar todo en una sesión.

### B. Etiquetar la confianza

Copiar la idea del agente de capital: cuando investigues algo (un precio de
mercado, un contacto, una licitación), marcar cada dato como:

- **verificado** (lo vi en la fuente oficial)
- **de terceros** (lo dice un directorio, no la fuente)
- **no verificado** (lo supongo)
- **estimación** (lo calculé)

**Aplicación inmediata:** los correos de colegios e iglesias ya lo hacen
implícitamente (dije "MX verificado", "correo de ejemplo descartado"). Conviene
hacerlo explícito siempre.

### C. Artefactos, no conversaciones

Todo lo que produjiste hoy ya cumple: `correos-listos-colegios.md`,
`correo-iglesias-macul.md`, este documento. **Archivos con fecha, en el repo.**

**Regla a adoptar:** si una conversación produjo algo útil y no quedó en un
archivo del repo, se perdió.

### D. Solo alertas para lo irreversible

Igual que el escáner de Kraken: **el agente prepara, el humano ejecuta.**
Ya lo aplicamos con los correos (no envié nada). Conviene extenderlo a:
- Publicar en el sitio (hoy sí lo hago, pero es reversible)
- Enviar correos (nunca)
- Tocar clientes (nunca sin autorización)

### E. El cuello de botella es publicar, no construir

La Pierre tenía 14 libros hechos y 2 publicados. **Tu caso es igual:** tienes
10 correos listos y 0 enviados, 4 correos de iglesias listos y 0 enviados.

> **La lección más incómoda y la más útil:** producir más no sirve si no se
> termina. El trabajo pendiente no es "hacer más correos", es **enviarlos**.

---

## Fuentes

| Fuente | Qué aporta |
|---|---|
| `blakelapierre.substack.com/p/i-run-my-one-person-business-with` | El caso completo de los 17 agentes |
| HN `item?id=25614966` | Hilo "Successful one-person online businesses" (270 comentarios) |
| HN `item?id=43947659` | "If 1 person can control 10 AI agents, why would we still need that person?" |
| HN `item?id=21332072` | Hilo grande (1474 pts) de negocios unipersonales |
| `lunchmoney.app` · `checkbot.io` · `pageflows.com` | Casos de producto de una sola persona |

---

## Lo que NO encontré (y conviene saber)

- **No hay casos públicos de alguien usando `pi` (el arnés que usamos) para
  un negocio de servicios técnicos.** Pi es un arnés nuevo y de nicho; los
  casos documentados son de Claude Code, Cursor y agentes propios.
- **No hay casos de "servicio técnico de PC con IA" documentados.** Eso puede
  ser bueno (nadie lo está contando) o malo (nadie lo está haciendo).
- **Los casos exitosos son de producto digital** (apps, libros, contenido), no
  de servicio presencial. Tu negocio mezcla las dos cosas: web (digital,
  escalable) y PC presencial (servicio, no escalable).

**Conclusión honesta:** lo replicable es el **método** (agentes angostos,
artefactos, confianza etiquetada, humano en lo irreversible), no el modelo de
negocio. El modelo de negocio de ellos no se copia; el método sí.
