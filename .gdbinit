#set auto-load safe-path /
#add-auto-load-safe-path ...
set disassembly-flavor intel
define hook-quit
    set confirm off
end
set history save on
set history size 10000
set history filename ~/.gdb_history
