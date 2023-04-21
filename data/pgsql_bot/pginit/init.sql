CREATE TABLE IF NOT EXISTS public.bot
(
    id bigserial NOT NULL,
    user_id bigint,
    token character varying(50),
    title character varying(50),
    status integer,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.bot
    OWNER to bc_bot_user;