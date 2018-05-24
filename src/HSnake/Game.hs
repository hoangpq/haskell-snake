module HSnake.Game where

import HSnake.Basic
import HSnake.Board
import HSnake.Player
import HSnake.Snake

import Control.Lens
import Data.Word

data GameState = GameState {
     _players            :: [Player],
     _applePosition      :: HSnake.Basic.Point,
     _board              :: Board,
     _level              :: Int,
     _lastTick           :: Word32
}
makeLenses ''GameState

initialGameState :: GameState
initialGameState = GameState
                 [initialPlayer, initialComputer]
                 (HSnake.Basic.Point 0 0)
                 initialBoard
                 1
                 0

speedFromLevel :: Integer -> Integer
speedFromLevel l = toInteger $ floor $ (380 * (0.5**(0.1 * (fromIntegral l))) + 20)

-- if snake's length is greater than 10, then increase level
shouldIncreaseLevel :: [Player] -> Bool
shouldIncreaseLevel ps = length (filter (>=10) (map (\pl -> pl^.snake^.len) ps)) > 0
