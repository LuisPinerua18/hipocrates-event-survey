# Encuesta previa al evento — Hipócrates Salud / UNANESO

Sitio estático de una sola página: la encuesta que se envía a los asistentes antes
del evento. Una pregunta a la vez, sin librerías, guarda las respuestas en Supabase
vía la API REST (`fetch`).

## Estructura

- `index.html` — la encuesta completa (HTML + CSS + JS en un solo archivo).
- `db/schema.sql` — la tabla `event_survey_responses` para crear en Supabase.

## Configuración

Al inicio del `<script>` en `index.html` hay dos constantes:

```js
var SUPABASE_URL = "https://<tu-proyecto>.supabase.co";
var SUPABASE_ANON_KEY = "<tu-anon-key>";
```

La `anon key` es pública por diseño (va en el cliente). Apuntá al proyecto de
Supabase donde tengas creada la tabla. Para producción, cambiá estas dos líneas.

## Base de datos

Correr una sola vez `db/schema.sql` en el proyecto de Supabase (SQL Editor).
- INSERT abierto a `anon` (para que cualquier asistente pueda responder).
- Sin SELECT para `anon`: las respuestas se leen desde el dashboard de Supabase
  (Table editor / SQL con service_role), no desde la página.

### Códigos de las opciones (para tabular / graficar)

- `role`: doctor · center · both · other
- `admin_hours`: lt4 · gt4 · no_idea · no_paperwork
- `recall_diagnosis`: yes · no
- `patient_retention`: stay · some · lost
- `motivation`, `recovered_time`, `role_other`: texto libre

## Correr local

Es estático, cualquier servidor sirve:

```bash
npx serve .
```

Abrí `http://localhost:3000` (o el puerto que indique).

## Deploy

Es un sitio estático de un archivo; sirve cualquier host:

- **Vercel:** importá el repo → framework "Other" → deploy. Queda en la raíz.
- **Netlify:** arrastrá la carpeta a app.netlify.com/drop, o conectá el repo.
- **GitHub Pages:** activá Pages sobre la rama `main`.

El link para enviar a los asistentes es la raíz del sitio (`https://tudominio/`).

> Nota: el guardado funciona desde cualquier dominio (CORS de Supabase abierto),
> así que no importa dónde lo hospedes mientras la tabla exista.
