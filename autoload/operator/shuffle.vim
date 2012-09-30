" operator-shuffle - Operator for shuffle chars,lines
" Version: 0.0.1
" Copyright (C) 2012 pekepeke <pekepekesamurai@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Interface  "{{{1
function! operator#shuffle#exec(motion_wiseness)  "{{{2

  let reg_0 = [@0, getregtype('0')]

  normal! `[v`]"0y
  if a:motion_wiseness == 'char'
    let s = split(@0, '\zs\ze')
    let delim = ""
  else
    let s = split(@0, "\n")
    let delim = "\n"
  endif

  let last_l = len(s) - 1
  for i in range(0, last_l)
    let n = s:rand(last_l)
    let tmp_s = s[i]
    let s[i] = s[n]
    let s[n] = tmp_s
  endfor

  let @0 = join(s, delim)
  normal! `[v`]"0P`[

  call setreg('0', reg_0[0], reg_0[1])
endfunction




" Misc.  "{{{1
let s:rand_seed = localtime()
function! s:rand(...) "{{{2
  " let s:rand_seed = abs(s:rand_seed * s:rand_seed)
  let s:rand_seed = and(s:rand_seed * 1103515245 + 12345, 2147483647)
  if a:0 > 0
    return s:rand_seed % (a:1 + 1)
  endif
endfunction

" __END__  "{{{1
" vim: foldmethod=marker
