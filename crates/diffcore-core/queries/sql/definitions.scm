; SQL (Postgres) definition patterns
;
; Dollar-quoted bodies are blanked before parsing (see `mask_sql_bodies`), so
; the grammar only sees DDL headers. Names are the last identifier of the
; object reference: `wms.do_x` → `do_x`.

; CREATE [OR REPLACE] FUNCTION wms.do_x(...) — PROCEDURE is rewritten to FUNCTION
(create_function
  (keyword_function) .
  (object_reference (identifier) @func_name .)) @func_node

; Headers the grammar rejects (e.g. procedures without RETURNS) still keep
; `CREATE ... FUNCTION <name> (<args>)` inside the ERROR node.
(ERROR
  (keyword_function) .
  (object_reference (identifier) @func_name .) .
  (function_arguments)) @func_node

; CREATE TRIGGER trg ... EXECUTE FUNCTION fn()
(create_trigger
  (keyword_trigger) .
  (object_reference (identifier) @trigger_name .)) @trigger_node

; CREATE TABLE wms.t (...)
(create_table
  (object_reference (identifier) @table_name .)) @table_node

; CREATE [MATERIALIZED] VIEW wms.v AS ...
(create_view
  (object_reference (identifier) @view_name .)) @view_node
(create_materialized_view
  (object_reference (identifier) @view_name .)) @view_node
