@auto[]
$hQUEUES[
	$.links[test_amqp_links]
	$.metrics[test_amqp_metrics]
]

@log[file;comment][locals]
$v[$status:rusage]
$now[^date::unix-timestamp($v.tv_sec)]
$usec($v.tv_usec)
$line[[^now.sql-string[].^usec.format[%06.0f]] $comment^#0A]
^line.save[append;logs/$file]
$result[]

@instanceId[]
^if(def $request:argv.1){$request:argv.1}{pid-$status:pid}

@connectAmqp[]
$result[^amqp::create[ $.auto_reconnect(5) ]]

@declareQueue[oAmqp;sLogicalName]
^oAmqp.declare[
	$.queue[$hQUEUES.[$sLogicalName]]
	$.passive(false)
	$.durable(true)
	$.auto_delete(false)
]
