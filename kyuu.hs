
{-

Copyright 2011 Mate J Kovacs

This file (Kyuu.hs) is part of Kyuu.

Kyuu is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Kyuu is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Kyuu. If not, see <http://www.gnu.org/licenses/>.

-}

module Kyuu ( readsRD, showsRD, readRD, showRD ) where

import Ratio ( Ratio, Rational, (%), numerator, denominator )
import Data.List
import Data.Char

readsRD :: ReadS Rational
readsRD s =
  if si == "" && sm == "" && sr == ""
  then []
  else [ (fromRational $ qi + (qm + qr) / 10^length sm, v) ]
    where
      qi = nullzero si $ read si % 1
      qm = nullzero sm $ read sm % 1
      qr = nullzero sr $ read sr % (10^length sr - 1)
      
      (si, t) = span isDigit s
      (sm, u) = span isDigit (expect '.' t)
      (sr, v) = span isDigit (expect '#' u)
      
      expect f (h:t) = if h == f then t else h:t
      expect _ [] = []
      
      nullzero x n = if x=="" then 0 else n

showsRD :: Rational -> ShowS
showsRD q s =
  put di ('.' : put dm ('#' : put dr s) )
    where
      put = flip (foldr shows)
      
      di = map fst li
      dm = map fst lm
      dr = map fst lr
      
      it0 = tail $ iterate next (0, q)
      denr = denominator $ snd (head it0) / 10
      midl = max (factor 2 denr) (factor 5 denr)
      (li, it1) = splitAt 1 it0
      (lm, it2) = splitAt midl it1
      start = snd $ head it2
      lr = head it2 : takeWhile (\p -> snd p /= start) (tail it2)
      
      next (_, x) = let (i, f) = properFraction x in (i, 10 * f)
      
      factor f n = if n `rem` f == 0 then 1 + factor f (n `div` f) else 0

readRD :: String -> Rational
readRD s =
  case [x | (x, t) <- readsRD s, ("", "") <- lex t] of
    [x] -> x
    _   -> error "readRD: no parse"

showRD :: Rational -> String
showRD q = showsRD q ""
