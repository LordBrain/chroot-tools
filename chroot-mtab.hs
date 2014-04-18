--{-# LANGUAGE ViewPatterns #-}
-- module ChrootMtab where
import Control.Monad (when,void)
import System.Environment (getArgs)
import System.Exit 
import Data.Function
import Data.List

usage = putStrLn $
            "Usage: ./chroot-mtab schrootname fstabfile schrootdir" ++
            "\n   schrootname - name of schroot" ++
            "\n   fstabfile - name of schroot fstab file (in it's profile dir)" ++
            "\n   schrootdir - where to copy the mtab too"
safeSecond = (!!1)

data Mounts a = MOUNTS [a] deriving Show
data FSTAB a = FSTAB [a] deriving Show
main = do
    args <- getArgs
    when (length args < 3) $ usage >> exitFailure 
    let [schrtname , fstabfilename , schrootdir] = args
    putStrLn "Working.."
    fstab <- fmap (filter ("/" `isPrefixOf`)) $ fmap lines $ readFile fstabfilename
    mapM print $ map (FSTAB . words) fstab
    --mounts <- --fmap (filter ("/" `isPrefixOf`). map (unwords . drop 1 . words)) $ fmap lines $ readFile "/proc/mounts"
    mounts <-  fmap lines $ readFile "/proc/mounts"
    mapM print $ map (MOUNTS . words) mounts
    let new_mtab = nub [ x | x <- mounts, y <- fstab, ((==) `on` take 1 ) x y]
    print new_mtab
--flip concatMap fstab (\(words -> (head) -> dirname) -> filter (not . null . dropWhile (/= dirname) . words) mounts)
    writeFile (schrootdir ++ "/mtab") (unlines new_mtab)
    
    
