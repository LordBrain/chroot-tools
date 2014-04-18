-- module ChrootMtab where
import Control.Monad (when,void)
import System.Environment (getArgs)
import System.Exit 

usage = putStrLn
            "Usage: chroot-mtab schrootname fstabfile schrootdir"
main = do
    args <- getArgs
    when (length args < 3) $ usage >> exitFailure 
    let [schrtname , fstabfilename , schrootdir] = args
    putStrLn "Working.."
    mtab <- openFile mtabfilename
    
    
