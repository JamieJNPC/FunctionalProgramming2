{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_assignment1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/bin"
libdir     = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/lib/x86_64-linux-ghc-8.8.4/assignment1-0.1.0.0-7wI2esY8W7iDPExp4LKKNQ-assignment1"
dynlibdir  = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/share/x86_64-linux-ghc-8.8.4/assignment1-0.1.0.0"
libexecdir = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/libexec/x86_64-linux-ghc-8.8.4/assignment1-0.1.0.0"
sysconfdir = "/mnt/c/Users/Jamie/Documents/Functional Programming/assignment1/.stack-work/install/x86_64-linux-tinfo6/59721e69a7e8def7d87f933be2ba161b5c86c18b4f6f694db3f23b3148c2af68/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "assignment1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "assignment1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "assignment1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "assignment1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "assignment1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "assignment1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
