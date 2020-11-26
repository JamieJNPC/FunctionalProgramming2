module Render(render) where
import Shapes
import Codec.Picture

pixelRenderer :: Drawing -> Int -> Int -> PixelRGB8
pixelRenderer (a:as) x y = if (point (fromIntegral x-125) (fromIntegral y-125)) `inside` a then pixelRenderer' a else pixelRenderer as x y
pixelRenderer [] x y = PixelRGB8 255 255 255

pixelRenderer' :: (Transform, Integer, Integer, Integer, Shape) -> PixelRGB8
pixelRenderer' (_, c1, c2, c3, _) = PixelRGB8 (fromIntegral c1) (fromIntegral c2) (fromIntegral c3)

render a name = writePng name $ generateImage (pixelRenderer a) 250 250