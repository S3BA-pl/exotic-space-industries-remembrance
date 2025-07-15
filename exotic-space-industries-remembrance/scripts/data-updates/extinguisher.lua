--====================================================================================================
--CHECK FOR MOD
--====================================================================================================

--fire extinguisher
if not mods["extinguisher"] then
    return
end

ei_lib = require("lib/lib")

ei_lib.set_prerequisites("extinguisher", {"sulfur-processing"})