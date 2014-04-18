#!/usr/bin/env runghc
{-# LANGUAGE ViewPatterns #-}

import System.Process
import System.IO
import Control.Monad
import Data.List

filterInteresting = filter (\x -> "Mount Location" `isPrefixOf` f x || "setup.fstab" `isPrefixOf` f x)
    where f = dropSpace

dropSpace = dropWhile (==' ')

mkPairs (x:y:xs) = (x,y): mkPairs xs
mkPairs _ = []

both f (x,y) = (f x,f y)

getCpyPairs :: IO [(String,String)]
getCpyPairs = do
    (i,o,e,p) <- createProcess (shell "schroot -i --all-sessions") { std_out=CreatePipe, std_err = Inherit}
    case o of
        Nothing -> putStrLn "Error reading pipe." >> return []
        (Just h) -> fmap (map (both (dropSpace . drop 16)) . mkPairs . filterInteresting . lines) (hGetContents h)

updateChrootMtab fstabfilename mtabfile = do
    fstab <- fmap (filter ("/" `isPrefixOf`) . lines) $ readFile fstabfilename
    mounts <-  fmap lines $ readFile "/proc/mounts"
    let new_mtab = map (take 1 . drop 1 . words) fstab >>= \word -> filter ((== word) . take 1 . drop 1 . words) mounts
    writeFile mtabfile  (unlines new_mtab)

copy ((++"/etc/mtab")->y,("/etc/schroot/" ++)-> x) = updateChrootMtab x y

main = do
    p <- getCpyPairs
    mapM_ copy p
