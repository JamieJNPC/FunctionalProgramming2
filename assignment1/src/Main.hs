{-# LANGUAGE OverloadedStrings #-} 

module Main where

import Shapes
import Render (render)
import qualified Web.Scotty
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

ellipseDrawing = [(identity, 255, 0, 0, ellipse)]
rectangleDrawing = [(identity, 0, 255, 0, rectangle)]
circleDrawing =  [(scale (point 0.5 0.5), 0, 0, 0, circle), (identity, 255, 0, 0, ellipse)]
polygonDrawing = [(translate (point 50 50) <+> translate (point 0 (-50)) <+> scale (point 0.5 0.5), 255, 0, 0, polygon)]

rectangleHtml = R.renderHtml $ do
        H.head $ H.title "Rectangle"
        H.body $ do
            H.p "[(identity, 0, 255, 0, rectangle)]"
            H.img H.! src "/rectangle.png"

circleHtml = R.renderHtml $ do
        H.head $ H.title "Circle"
        H.body $ do
            H.p "[(scale (point 0.5 0.5), 0, 0, 0, circle), (identity, 255, 0, 0, ellipse)]"
            H.img H.! src "circle.png"

ellipseHtml = R.renderHtml $ do
        H.head $ H.title "Ellipse"
        H.body $ do
            H.p "[(identity, 255, 0, 0, ellipse)]"
            H.img H.! src "ellipse.png"

polygonHtml = R.renderHtml $ do
        H.head $ H.title "Polygon"
        H.body $ do
            H.p "[(translate (point 50 50) <+> translate (point 0 (-50)) <+> scale (point 0.5 0.5), 255, 0, 0, polygon)]"
            H.img H.! src "polygon.png"

main = do {
    render rectangleDrawing "rectangle.png";
    render ellipseDrawing "ellipse.png";
    render circleDrawing "circle.png";
    render polygonDrawing "polygon.png";
    Web.Scotty.scotty 3000 $ do {
        Web.Scotty.get "/rectangle" $ do {
            Web.Scotty.html rectangleHtml
        };
        Web.Scotty.get "/rectangle.png" $ do {
            Web.Scotty.file "rectangle.png"
        };
        Web.Scotty.get "/circle" $ do {
            Web.Scotty.html circleHtml
        };
        Web.Scotty.get "/circle.png" $ do {
            Web.Scotty.file "circle.png"
        };
        Web.Scotty.get "/ellipse" $ do {
            Web.Scotty.html ellipseHtml
        };
        Web.Scotty.get "/ellipse.png" $ do {
            Web.Scotty.file "ellipse.png"
        };
        Web.Scotty.get "/polygon" $ do {
            Web.Scotty.html polygonHtml
        };
        Web.Scotty.get "/polygon.png" $ do {
            Web.Scotty.file "polygon.png"
        };
    };
};