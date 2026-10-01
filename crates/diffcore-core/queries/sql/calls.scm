; SQL call patterns (outside dollar-quoted bodies; bodies are scanned
; textually by `sql_body_calls`)

; SELECT wms.fn(x) / views / defaults
(invocation
  (object_reference) @callee) @node

; CREATE TRIGGER ... EXECUTE FUNCTION|PROCEDURE wms.fn()
(create_trigger
  (keyword_execute)
  .
  (_)
  .
  (object_reference) @callee) @node
