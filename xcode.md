func didMove(to view: SKView)
Parameters - The view that is presenting the scene.
This method is intended to be overridden in a subclass. You can use this method to implement any custom behavior for your scene when it is about to be presented by a view. For example, you might use this method to create the scene’s contents.

Physics
categoryBitMask - number defining the type of object this is for considering collisions
collisionBitMask - number defining what categories of object this node should collide with
contactTestBitMask - number defining which collisions we want to be notified about




https://medium.com/@enzosan/how-to-create-a-continuous-rain-of-nodes-in-spritekit-4bf563d9ca7d

Function to create 

func spawnRain(){
    let rainFall = RainFall()
    rainNode = rainFall
    rainFall.name = "rain"
    self.addChild(rainFall)
}


override func update(_ currentTime: TimeInterval) {
spawnRain()
}



override func sceneDidLoad() {
    //        set the game scene ad the physixs protocol delegate
    self.physicsWorld.contactDelegate = self
    
}

//    handle contact events
func didBegin(_ contact: SKPhysicsContact) {
     if (contact.bodyA.categoryBitMask == floorCategory) && (contact.bodyB.categoryBitMask == RainFallCategory) {
        contact.bodyB.node?.removeFromParent()
    }



import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
    //create the scene contents before switching to the view
    //e.g. create 15 balloons
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //check if there's 15 balloons, if not, create 1
    }
    
    override func sceneDidLoad() {
    //        set the game scene ad the physixs protocol delegate
    self.physicsWorld.contactDelegate = self
}
    
    func didBegin(_ contact: SKPhysicsContact) {
     if (contact.bodyA.categoryBitMask == floorCategory) && (contact.bodyB.categoryBitMask == RainFallCategory) {
        contact.bodyB.node?.removeFromParent()
    }

}
