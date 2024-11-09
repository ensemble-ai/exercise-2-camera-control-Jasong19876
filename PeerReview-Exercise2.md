# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Matthew Fulde
* *email:* mpfulde@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is position locked technically on the target. The only issue is the actual camera extends past where the camera is positioned, it goes a unit in any direction ahead of the vessel. instead of perfectly being positioned on the target. There were no fields that needed to be exported, and thus there were none. No issues with style either.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
This works just as expected. Moves at a rate specified by the export variable, and the size of the frame is customizable in the same manor. When the target hits the edge of the box, the box pushes it while moving. no issues with any logic or variables or anything. 

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory


#### Justification ##### 
for the most part this camera works as an expected lerp would. An attempt to use the lerp command was there, so mad props to the dev. The camera moves smoothly with the target when within follow_speed range, although im not sure if it moves at the correct rate considering how lerp is used. One minor flaw is the catchup speed is only used for when the target is outside the leash distance, which i don't know if this was the expected behavior, but leads to a very slow catchup when the vessel stops moving. The bigger flaw is when the vessel exits the leash distance a jittery effect can be seen. I tested this both on 60 fps and 144 fps and it persists on both so it isn't due to that. Dashing also allows the target to reach well outside the leash distance. All in all a good attempt just a little bit of error with how the leash was handled. 
___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Just a note, for me this camera was a jittery on 144 fps but not on 60 fps, but i don't feel thats a need to be outside an otherwise really well implementation. The camera moves ahead of the vessel until the leash its reached, and never exceeds it even when dashing. The catchup timer also works as expected and has a smooth catchup effect when the vessel is stationary. Changing directions works just as expected. The reason why this I am docking from perfect is becasuse the required export variables are not present, which is unfortunate do to it working just as expected.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Export variables are back! Jokes aside, I'm not sure if this implementation is working as expected. Specifically when in the x axis speed up zone (left or right), moving along the z axis pushes the box in the x direction. The same is true when moving left or right in the z speed up zone. In the corners moving any one direction moves the camera in both the x and z direction. The outer push box somewhat works as expected, the vessel can never actually reach the the push box edge before pushing the box at full speed. Another problem is when pushing in the x direction, moving in the z direction doesn't speed up in the z direction. Same when pushing the z edge and moving along the x axis.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

#### Style Guide Exemplars ####
because pretty much everything is following the style guide to my knowledge, the only exemplar I will put the segment that in my opinion did it the best.
[Framing seperation of public and export variables](https://github.com/ensemble-ai/exercise-2-camera-control-Jasong19876/blob/9e5984d1f79a30065c3c78ad759c5f3b7ad09331/Obscura/scripts/camera_controllers/framing.gd#L4), really good job at seperating and making clear the export section versus the public variable section. Not all the vars need to be public but thats besides the point. This isn't the only instance either, but this was the first part i specifically noticed.

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

#### Best Practices Exemplars ####
