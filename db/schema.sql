-- Tabla que recibe las respuestas de la encuesta.
-- Correr una vez en el proyecto de Supabase que uses (SQL Editor o migración).
-- Pública y anónima: INSERT abierto a anon; SIN SELECT para anon (nadie puede leer
-- las respuestas de otros con la anon key). La lectura para tabular se hace desde
-- el dashboard de Supabase (service_role).

CREATE TABLE public.event_survey_responses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),

  -- P1: rol en la sala.
  role text NOT NULL CHECK (role IN ('doctor', 'center', 'both', 'other')),
  role_other text CHECK (role_other IS NULL OR length(trim(role_other)) BETWEEN 1 AND 500),

  -- P2: qué le hizo elegir la profesión (texto abierto).
  motivation text NOT NULL CHECK (length(trim(motivation)) BETWEEN 1 AND 2000),

  -- P3: horas semanales en tareas que no son atender pacientes.
  admin_hours text NOT NULL CHECK (admin_hours IN ('lt4', 'gt4', 'no_idea', 'no_paperwork')),

  -- P4: puede recordar/ubicar el diagnóstico de un paciente de hace 3 años sin buscar.
  recall_diagnosis text NOT NULL CHECK (recall_diagnosis IN ('yes', 'no')),

  -- P5: fidelización — sus pacientes se quedan o les pierde el rastro.
  patient_retention text NOT NULL CHECK (patient_retention IN ('stay', 'some', 'lost')),

  -- P6: en qué usaría 5 horas recuperadas (texto abierto).
  recovered_time text NOT NULL CHECK (length(trim(recovered_time)) BETWEEN 1 AND 2000),

  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.event_survey_responses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit an event survey response"
  ON public.event_survey_responses
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);
