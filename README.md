# sprite-demo-castle-engine
First steps to work with sprites through Castle Game Engine. Built with Lazarus.

I worked on this code for personal purposes and I share it for those approaching CGE.
Of course it's all to be improved but it can give you a basic idea.

Demo is divided into two parts:
<ul>
<li>Goniometer</li>
<li>Road demo</li>
</ul> 

The first shows with extreme precision the direction of the sprite in degrees. Using mouse click coordinates and Player position I apply the arctangent formula and I convert the value obtained in degrees. This way I get the requested direction.
The second one is a demo with a road background where you can move the sprite that is sized according to the distance from the observation point.
One click to walk, double click to run.
Run animation is divided into three actions, short initial walk, run, short final walk but it is not perfect.

A personal observation: you can try to improve sprite animations as much as possible but in general the result will never be satisfactory (unless you use small sprites with a high frame number or you want to create a retro game). It would be better to prepare and export animations from Spine, Dragon Bones or such or eventually Player 3d on 2d background.

The code is commented on in the most significant parts.

Any changes that improve the code would be appreciated.
Still to do would be:
1) Turn the sprite in the required direction before starting the animation (I have attached individual idle images)
2) Insert an action to pick up an object
3) Define a walking area
4) and much more ...
