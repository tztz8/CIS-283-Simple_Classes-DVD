# CIS-283-Simple_Classes-DVD
 For SCC CIS 283 class

doc -> md

**Simple Classes**

Write a program which simulates the operation of a DVD Player. This class should have methods that perform the following operations:

Insert Disk

Play Disk

Rewind Disk (number of seconds)

Fast Forward Disk (number of seconds)

Stop playing

Eject Disk

Initialize

Your class needs to handle error conditions like trying to play a disk if one is not in the machine, rewinding to the beginning of the disk, etc.

Your program should then provide a menu which allows a user to manage a disk which utilizes the Class that you created above. All of the operations should be available to the user. The menu should look exactly like this:

1. Insert Disk
2. Play Disk
3. Rewind Disk
4. Fast Forward Disk
5. Stop Disk
6. Eject Disk
7. Show Current Disk Status
8. QUIT

When a function like &quot;play&quot; or &quot;rewind&quot; or &quot;fast forward&quot; is executed, your class should retain the &quot;current position&quot; of the disk, in seconds. If a user inserts a disk, and then fast forwards the disk by 10 seconds, then the current position would be 10 seconds. If the user fast forwards again by 20 seconds, then the current position would be 30 seconds, etc.

If the user selects &quot;play&quot;, then your class should keep track of REAL TIME in seconds so that when the user selects &quot;stop&quot;, the disk has advanced by the same number of seconds that have elapsed between when the playing and stopping methods were called.

When the user selects #7 from the menu, your program should display the vital statistics about the state of your machine including : Is a disk inserted?, Current position of the disk, is the disk playing?

Your class should not do any printing of its own but return values or strings which your main program can then display for the user.
