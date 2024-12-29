# Objective-C KVO Crash with Asynchronous Setter

This repository demonstrates a subtle bug in Objective-C related to Key-Value Observing (KVO) and asynchronous operations within custom setter methods.  When an asynchronous operation in a setter completes *after* the observer is removed, it can lead to a crash due to accessing deallocated memory.

The `bug.m` file contains the problematic code. The `bugSolution.m` file shows how to mitigate this issue using techniques like checking for observer validity before updating.

## Bug Description

The bug occurs because the KVO observer's `dealloc` method might have been called before the asynchronous operation in the setter finishes. Attempting to update the observed object after deallocation results in a crash.