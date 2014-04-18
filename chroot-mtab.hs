--{-# LANGUAGE ViewPatterns #-}
-- module ChrootMtab where
import Control.Monad (when,void)
import System.Environment (getArgs)
import System.Exit 
import Data.Function
import Data.List

usage = putStrLn $
--            "Usage: ./chroot-mtab schrootname [fstabfile] [mtabfile]" ++
--            "\n   schrootname - name of schroot (assume debian locations)" ++
--            "\n                 Presently, this is ignored if 3 parameters are given." ++
            "Usage: ./chroot-mtab fstabfile mtabfile" ++
            "\n" ++
            "\n   copies /proc/mounts to the specified mtabfile, but filters out" ++
            "\n   directories that are not listed in the specified fstabfile." ++
            "\n" ++
            "\n Command-line Arguments: " ++
            "\n   fstabfile - name of schroot fstab file (in it's profile dir)" ++
            "\n   mtabfile - where to copy the mtab too"

main = do
    args <- getArgs
    when (length args /= 2) $ usage >> exitFailure 
    let [fstabfilename , mtabfile] = args
    fstab <- fmap (filter ("/" `isPrefixOf`) . lines) $ readFile fstabfilename
    mounts <-  fmap lines $ readFile "/proc/mounts"
    let new_mtab = map (take 1 . drop 1 . words) fstab >>= \word -> filter ((== word) . take 1 . drop 1 . words) mounts
--nub [ x | x <- mounts, y <- fstab, ((==) `on` (take 1 . drop 1) ) x y]
    writeFile mtabfile  (unlines new_mtab)
    
    
