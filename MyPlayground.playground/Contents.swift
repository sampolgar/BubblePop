import SpriteKit

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

func random() -> CGFloat {
  return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
  return random() * (max - min) + min
}



let startingX = random(min: -45, max: 45)
let startingY = random(min: 0, max: 1)
let angle = atan2(startingX, startingY)

print("staringX: \(startingX)")
print("staringY: \(startingY)")


print("printing the angle: \(angle)")
print("printing the angle minus 90: \(angle - 90)")
print("printing the radian: \(angle - 90 * degreesToRadians)")


//print(" tester:  \(atan2(90, 15))")
