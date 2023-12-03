CREATE TABLE usuario (
  id SERIAL  NOT NULL ,
  tipo_perfil INTEGER    ,
  email VARCHAR(100)   NOT NULL ,
  senha VARCHAR(16)   NOT NULL ,
  data_nascimento DATE    ,
  img_perfil VARCHAR(256)    ,
  username VARCHAR(32)    ,
  bio VARCHAR(512)    ,
  img_capa VARCHAR(256)    ,
  nome VARCHAR(196)    ,
  imagemUrl VARCHAR(256)      ,
PRIMARY KEY(id));




CREATE TABLE neurodivergente (
  usuario_id INTEGER   NOT NULL ,
  tipo_neurodivergencia INTEGER   NOT NULL ,
  laudo_neurodivergente VARCHAR(256)      ,
PRIMARY KEY(usuario_id)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX neurodivergente_FKIndex1 ON neurodivergente (usuario_id);


CREATE INDEX IFK_Rel_22 ON neurodivergente (usuario_id);


CREATE TABLE familiar (
  usuario_id INTEGER   NOT NULL ,
  tipo_familiar INTEGER      ,
PRIMARY KEY(usuario_id)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX familiar_FKIndex1 ON familiar (usuario_id);


CREATE INDEX IFK_Rel_23 ON familiar (usuario_id);


CREATE TABLE profissional (
  usuario_id INTEGER   NOT NULL ,
  registro_profissional VARCHAR(256)    ,
  tipo_profissional INTEGER      ,
PRIMARY KEY(usuario_id)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX Table_16_FKIndex1 ON profissional (usuario_id);


CREATE INDEX IFK_Rel_21 ON profissional (usuario_id);


CREATE TABLE curriculum (
  id_curriculum SERIAL  NOT NULL ,
  neurodivergente_usuario_id INTEGER   NOT NULL ,
  tel01 VARCHAR(13)    ,
  tel02 VARCHAR(13)    ,
  area_interesse VARCHAR(64)    ,
  habilidades VARCHAR(256)    ,
  formacao VARCHAR(128)    ,
  instituicao_ensino VARCHAR(256)    ,
  experiencia_anterior BOOL    ,
  cargo VARCHAR(64)    ,
  empresa VARCHAR(128)    ,
  data_inicio DATE    ,
  data_fim DATE    ,
  resumo VARCHAR(512)      ,
PRIMARY KEY(id_curriculum)  ,
  FOREIGN KEY(neurodivergente_usuario_id)
    REFERENCES neurodivergente(usuario_id));


CREATE INDEX curriculum_FKIndex1 ON curriculum (neurodivergente_usuario_id);


CREATE INDEX IFK_TEM ON curriculum (neurodivergente_usuario_id);


CREATE TABLE curtida (
  id_curtida SERIAL  NOT NULL ,
  usuario_id INTEGER   NOT NULL   ,
PRIMARY KEY(id_curtida)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX curtida_FKIndex1 ON curtida (usuario_id);


CREATE INDEX IFK_realiza ON curtida (usuario_id);


CREATE TABLE endereco (
  id SERIAL  NOT NULL ,
  usuario_id INTEGER   NOT NULL ,
  logradouro VARCHAR(196)    ,
  complemento VARCHAR(128)    ,
  cep VARCHAR(8)    ,
  numero VARCHAR(12)    ,
  referencia VARCHAR(128)      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX endereco_FKIndex1 ON endereco (usuario_id);


CREATE INDEX IFK_tem2 ON endereco (usuario_id);


CREATE TABLE empregador (
  usuario_id INTEGER   NOT NULL ,
  cnpj VARCHAR(32)   NOT NULL   ,
PRIMARY KEY(usuario_id)  ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id));


CREATE INDEX empregador_FKIndex1 ON empregador (usuario_id);


CREATE INDEX IFK_Rel_24 ON empregador (usuario_id);


CREATE TABLE comentario (
  id SERIAL  NOT NULL ,
  curtida_id_curtida INTEGER   NOT NULL ,
  usuario_id INTEGER   NOT NULL ,
  conteudo VARCHAR(512)    ,
  data_criacao DATE      ,
PRIMARY KEY(id)    ,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id),
  FOREIGN KEY(curtida_id_curtida)
    REFERENCES curtida(id_curtida));


CREATE INDEX comentario_FKIndex3 ON comentario (usuario_id);
CREATE INDEX comentario_FKIndex4 ON comentario (curtida_id_curtida);


CREATE INDEX IFK_faz ON comentario (usuario_id);
CREATE INDEX IFK_recebe ON comentario (curtida_id_curtida);


CREATE TABLE postagem (
  id SERIAL  NOT NULL ,
  curtida_id_curtida INTEGER   NOT NULL ,
  comentario_id INTEGER   NOT NULL ,
  autor INTEGER   NOT NULL ,
  conteudo VARCHAR(512)    ,
  data_postagem DATE   NOT NULL ,
  imagem_Url INTEGER      ,
PRIMARY KEY(id, curtida_id_curtida)      ,
  FOREIGN KEY(autor)
    REFERENCES usuario(id),
  FOREIGN KEY(curtida_id_curtida)
    REFERENCES curtida(id_curtida),
  FOREIGN KEY(comentario_id)
    REFERENCES comentario(id));


CREATE INDEX postagem_FKIndex1 ON postagem (autor);
CREATE INDEX postagem_FKIndex3 ON postagem (curtida_id_curtida);
CREATE INDEX postagem_FKIndex4 ON postagem (comentario_id);


CREATE INDEX IFK_faz2 ON postagem (autor);
CREATE INDEX IFK_recebe3 ON postagem (curtida_id_curtida);
CREATE INDEX IFK_recebe2 ON postagem (comentario_id);


CREATE TABLE vaga_emprego (
  id SERIAL  NOT NULL ,
  empregador_usuario_id INTEGER   NOT NULL ,
  data_abertura DATE    ,
  data_fechamento DATE    ,
  titulo VARCHAR(50)    ,
  descricao VARCHAR(512)    ,
  requisitos VARCHAR(512)    ,
  status_vaga BOOL    ,
  empresa VARCHAR(128)      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(empregador_usuario_id)
    REFERENCES empregador(usuario_id));


CREATE INDEX vaga_emprego_FKIndex2 ON vaga_emprego (empregador_usuario_id);


CREATE INDEX IFK_cria ON vaga_emprego (empregador_usuario_id);


CREATE TABLE neurodivergente_has_vaga_emprego (
  neurodivergente_usuario_id INTEGER   NOT NULL ,
  vaga_emprego_id INTEGER   NOT NULL   ,
PRIMARY KEY(neurodivergente_usuario_id, vaga_emprego_id)    ,
  FOREIGN KEY(neurodivergente_usuario_id)
    REFERENCES neurodivergente(usuario_id),
  FOREIGN KEY(vaga_emprego_id)
    REFERENCES vaga_emprego(id));


CREATE INDEX neurodivergente_has_vaga_emprego_FKIndex1 ON neurodivergente_has_vaga_emprego (neurodivergente_usuario_id);
CREATE INDEX neurodivergente_has_vaga_emprego_FKIndex2 ON neurodivergente_has_vaga_emprego (vaga_emprego_id);


CREATE INDEX IFK_tem3 ON neurodivergente_has_vaga_emprego (neurodivergente_usuario_id);
CREATE INDEX IFK_tem4 ON neurodivergente_has_vaga_emprego (vaga_emprego_id);



