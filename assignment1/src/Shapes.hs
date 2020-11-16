module Shapes(
  Shape, Point, Vector, Transform, Drawing,
  point, getX, getY,
  empty, circle, rectangle, square, ellipse,
  identity, translate, rotate, scale, (<+>),
  inside)  where


-- Utilities

data Vector = Vector Double Double
              deriving Show
vector = Vector

cross :: Vector -> Vector -> Double
cross (Vector a b) (Vector a' b') = a * a' + b * b'

mult :: Matrix -> Vector -> Vector
mult (Matrix r0 r1) v = Vector (cross r0 v) (cross r1 v)

invert :: Matrix -> Matrix
invert (Matrix (Vector a b) (Vector c d)) = matrix (d / k) (-b / k) (-c / k) (a / k)
  where k = a * d - b * c
        
-- 2x2 square matrices are all we need.
data Matrix = Matrix Vector Vector
              deriving Show

matrix :: Double -> Double -> Double -> Double -> Matrix
matrix a b c d = Matrix (Vector a b) (Vector c d)

getX (Vector x y) = x
getY (Vector x y) = y

-- Shapes

type Point = Vector

point :: Double -> Double -> Point
point = vector


data Shape = Empty 
           | Circle 
           | Rectangle
           | Square
           | Ellipse
             deriving Show

empty, circle, rectangle :: Shape

empty = Empty
circle = Circle
rectangle = Rectangle
square = Square
ellipse = Ellipse

-- Transformations

data Transform = Identity
           | Translate Vector
           | Scale Vector
           | Compose Transform Transform
           | Rotate Matrix
             deriving Show

identity = Identity
translate = Translate
scale = Scale
rotate angle = Rotate $ matrix (cos angle) (-sin angle) (sin angle) (cos angle)
t0 <+> t1 = Compose t0 t1

transform :: Transform -> Point -> Point
transform Identity                   x = id x
transform (Translate (Vector tx ty)) (Vector px py)  = Vector (px - tx) (py - ty)
transform (Scale (Vector tx ty))     (Vector px py)  = Vector (px / tx)  (py / ty)
transform (Rotate m)                 p = (invert m) `mult` p
transform (Compose t1 t2)            p = transform t2 $ transform t1 p

-- Drawings

type Drawing = [(Transform,Shape)]

-- interpretation function for drawings

inside :: Point -> Drawing -> Bool
inside p d = or $ map (inside1 p) d

inside1 :: Point -> (Transform, Shape) -> Bool
inside1 p (t,s) = insides (transform t p) s

insides :: Point -> Shape -> Bool
p `insides` Empty = False
p `insides` Circle = distance p <= 100
p `insides` Rectangle = maxnormRect p <= 100
p `insides` Square = maxnorm p <= 100
p `insides` Ellipse = distanceEllipse p <= 100

distance :: Point -> Double
distance (Vector x y ) = sqrt ( x**2 + y**2 )

distanceEllipse :: Point -> Double
distanceEllipse (Vector x y) = sqrt (x**2 + ((y**2)*2))

maxnorm :: Point -> Double
maxnorm (Vector x y ) = max (abs x) (abs y)

maxnormRect :: Point -> Double
maxnormRect (Vector x y ) = max (abs x) (abs y*2)

testShape = (scale (point 10 10), circle)
