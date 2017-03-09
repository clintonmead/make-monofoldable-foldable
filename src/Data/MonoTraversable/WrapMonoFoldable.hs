{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE GADTs #-}

module Data.MonoTraversable.WrapMonoFoldable (
  WrappedMonoFoldable(WrappedMonoFoldable),
  wrapMonoFoldable
  )
  where

import Data.Foldable (
  Foldable,
  fold,
  foldMap,
  foldr,
  foldl',
  foldr1,
  foldl1,
  toList,
  null,
  length,
  elem,
  maximum,
  minimum,
  sum,
  product
  )

import Data.MonoTraversable (
  MonoFoldable,
  Element
  )

import qualified Data.MonoTraversable.Unprefixed as MF

{-|
Turns any 'MonoFoldable' into a 'Foldable' type.
-}
data WrappedMonoFoldable mono element where
  WrappedMonoFoldable :: (MonoFoldable mono) => mono -> WrappedMonoFoldable mono (Element mono)

instance Foldable (WrappedMonoFoldable mono) where
  fold (WrappedMonoFoldable y) = MF.fold y
  foldMap x1 (WrappedMonoFoldable y) = MF.foldMap x1 y
  foldr x1 x2 (WrappedMonoFoldable y) = MF.foldr x1 x2 y
  foldl' x1 x2 (WrappedMonoFoldable y) = MF.foldl' x1 x2 y
  toList (WrappedMonoFoldable y) = MF.toList y
  null (WrappedMonoFoldable y) = MF.null y
  length (WrappedMonoFoldable y) = MF.length y
  elem x1 (WrappedMonoFoldable y) = MF.elem x1 y
  sum (WrappedMonoFoldable y) = MF.sum y
  product (WrappedMonoFoldable y) = MF.product y

wrapMonoFoldable :: (MonoFoldable mono) => mono -> WrappedMonoFoldable mono (Element mono)
wrapMonoFoldable = WrappedMonoFoldable