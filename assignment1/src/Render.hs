module Render(render) where
import Shapes
import Codec.Picture

pixelRenderer a x y = if (point (fromIntegral x-125) (fromIntegral y-125)) `inside` a then PixelRGB8 0 0 0 else PixelRGB8 255 255 255

render a name = writePng name $ generateImage (pixelRenderer a) 250 250