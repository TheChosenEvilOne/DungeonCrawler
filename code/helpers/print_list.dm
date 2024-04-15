/proc/print_ac_list(list)
    for(var/key in list)
        usr << "[key] = [list[key]?.type]"