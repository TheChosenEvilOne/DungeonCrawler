/proc/print_ac_list(list)
    for(var/key in list)
        // if(isnull(list[key]))
        //     usr << "key"
        //     continue
        usr << "[key] = [list[key]?.type]"