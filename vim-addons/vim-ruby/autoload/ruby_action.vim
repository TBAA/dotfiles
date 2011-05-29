" maintainer (this file) : Marc Weber <marco-oweber@gmx.de>

" prog: either ruby or spec
fun! ruby_action#CompileRHS(prog)
  let ef= 
        \  '%*\\tfrom\\\ %f:%l:%m,'
        \ .'%*\\tfrom\\\ %f:%l,'
        \ .'%f:%l:%m,'
        \ .'%f:%l:'


  let args = [a:prog, expand('%')]
  let args = eval(input(a:prog." prog:", string(args)))
  return "call bg#RunQF(".string(args).", 'c', ".string(ef).")"
endfun
