" maintainer (this file) : Marc Weber <marco-oweber@gmx.de>
call actions#AddAction('run ruby interpreter', {'action': funcref#Function('ruby_action#CompileRHS', {'args': ["ruby"]})})
call actions#AddAction('run spec interpreter', {'action': funcref#Function('ruby_action#CompileRHS', {'args': ["spec"]})})
