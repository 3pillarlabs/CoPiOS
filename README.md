# Memory management tips & tricks

## Overview

Sometimes we just want better interfaces and easier to work data structures. We know them as convenient types. Are easy to use and we want to share them with others.

### Weak observables

Sometimes we need more than 1 delegate and we call those observers. In iOS we often used notifications for sending events for multiple observers. 

The issue always appears is that if one needs to send any data associated with the event, it's required to create keys for each object and wrap into a dictionary. Once the event is sent, get the data out of dictionary and the used.

Wouldn't be better if:

- we could just have the observers conform to a protocol which has a well defined interface with no need of wrapping and unwrapping data around?
- we could just add ourselves as observers for events and then 'forget' to remove ourselves, yet our application to continue working without worrying about retain cycles?


### Lazy properties

Swift has lazy properties and we can intialize them on demand, but it was those times when we wanted to initialize with a closure and within that closure to call a small function on the `self`. 

Sceptical eye should be on duty whenever a small function on the `self`, it may not be needed.