{-# LANGUAGE OverloadedStrings #-} 

module Main where

import Shapes
import Render (render)
import qualified Web.Scotty
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

ellipseDrawing = [ (identity, ellipse) ]
rectangleDrawing = [ (identity, rectangle) ]
circleDrawing = [ (identity, circle) ]

rectangleHtml = R.renderHtml $ do
        H.head $ H.title "Rectangle"
        H.body $ do
            H.img H.! src "/rectangle.png" H.! alt "this sucks"

circleHtml = R.renderHtml $ do
        H.head $ H.title "Circle"
        H.body $ do
            H.img H.! src "circle.png" H.! alt "this sucks"

ellipseHtml = R.renderHtml $ do
        H.head $ H.title "Ellipse"
        H.body $ do
            H.img H.! src "ellipse.png" H.! alt "this sucks"

main = do {
    render rectangleDrawing "rectangle.png";
    render ellipseDrawing "ellipse.png";
    render circleDrawing "circle.png";
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
    };
};