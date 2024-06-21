ScriptName VAoNOblivionFavor Extends ActiveMagicEffect

import actor 
import objectreference
import spell
import Debug


Function OblivionFavorController(int functionDescision)
    ; code

    if functionDescision == 1
        addFavor()
    elseif functionDescision == 2
        removeFavor()
    elseif functionDescision == 3
        effectActive()
    elseif functionDescision == 4
        getCurrentFavor()
    else
        ;something to handle incorrect input
        Debug.Notification("A script is calling the OblivionFavorController Incorrectly.")
    endif
EndFunction

Function addFavor()
    
EndFunction

Function removeFavor()
    ; code
EndFunction

Function effectActive()
    ; code
EndFunction

Function getCurrentFavor()
    ; code
EndFunction