Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA26774; Thu, 16 May 1996 07:22:31 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA14020 for linux-list; Thu, 16 May 1996 14:21:06 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA14015 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 07:21:04 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA26731 for <linux@neteng.engr.sgi.com>; Thu, 16 May 1996 07:21:04 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA14001; Thu, 16 May 1996 07:21:01 -0700
Received: from arvidsjaur.anu.edu.au by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id HAA08955; Thu, 16 May 1996 07:20:58 -0700
Received: (from tridge@localhost) by arvidsjaur.anu.edu.au (8.7.3/8.6.9) id AAA24100; Fri, 17 May 1996 00:20:34 +1000
Date: Fri, 17 May 1996 00:20:34 +1000
Message-Id: <199605161420.AAA24100@arvidsjaur.anu.edu.au>
From: Andrew Tridgell <tridge@cs.anu.edu.au>
To: lm@gate1-neteng.engr.sgi.com
CC: linux-mc@arvidsjaur.anu.edu.au, Linus.Torvalds@cs.Helsinki.FI,
        linux@neteng.engr.sgi.com, alan@cymru.net
In-reply-to: <199605152243.PAA19394@neteng.engr.sgi.com>
	(lm@gate1-neteng.engr.sgi.com)
Subject: Re: mpp kernel interface
Reply-to: Andrew.Tridgell@anu.edu.au
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Larry,

I think what you describe is really a blueprint for a "throughput"
machine, a machine that gets its parallelism mostly from the fact that
you will be running lots of independent jobs on it at once. The
alternative is a "parallel" machine, which aims to get optimal
performance even when just running one or two programs.

For example, a throughput machine is an ideal departmental
server. Lots of people doing edits/compiles with some heavy computation
thrown in now and then. Its the sort of thing that clusters of
workstations normally do.

A "parallel" machine is what supercomputer centres often have. They
run just one or two jobs at once, but they are big jobs, like climate
modelling or fluid dynamics simulations. They use huge amounts of ram
(many GB) for the one process and require very tight communications
using specialised parallel libraries.

Our research group is really centered around parallel systems, with
algorithms that scale to thousands of cpus. Unfortunately our budget
only stretches to 16 cpus on the AP+ at the moment, but we can also
run on much larger systems like we did this week by connecting to the
"Parallel Computing Research Facility" at Fujitsu in Japan.

This approach has a number of implications:

- we're not as worried about the ability to dynamically enter/leave a
"cluster". This makes algorithms simpler and faster as they can use
data structures that assume that the number of cpus and their layout
stays static.

- we're not as worried about recovering/continuing if a cpu
crashes. If all user jobs are running on all cpus then it doesn't make
much sense to try to recover when one goes down, as it kills all user
jobs anyway, so you might as well shutdown (crash), replace the part
and startup again. Its not as though this is a common experience for
us anyway. I don't think we've had a hardware fault on our 128 cpu
ap1000 yet, after several years of operation.

- we're worried about getting the very best bandwidth/latency out of
the communications network, while still providing all the lovely
operating system services that Linux provides.

- we're worried about providing efficient parallel filesystem, memory
and networking abstractions, scalable to lots of processors.

> Processes have two major chunks of work, the PID name space and how you
> do remote processes.  For the PID name space, make pid_t a 32 bit int,
> make the top 16 bits the host part, and the bottom 16 bits the pid part.
> (We need to come back to the host part when we discuss process migration.)
> A host part of "0" means "this host".  So a "kill -HUP 1" will always
> restart init.

ok, this makes sense with what we've done so far, which is really just
a tightly integrated network of workstations. I'm not at all sure its
what we want in the long term however. It assumes that things like
init will be running on every cpu, so that you have to distinguish
which copy of init you mean when you send it a signal.

I'm hoping that we will eventually have a really "single system image"
machine, where only one copy of init is actually running. Most cpus
would not be running any system daemons at all, just the necessary
kernel threads. 

Right now we do in fact have one copy of init on each cpu, along with
lots of other daemons. We can get away with them all having the same
pid because the system isn't really parallel yet, there is no notion
of a remote syscall. (we have in fact done a remote signal send
operation for parallel programs, but its not as general as a remote
kill)

> Devices I sort of punt on.  For device access, I would just use the 
> remote mag tape protocol (or something very, very similar) so that all
> of the locking, etc., still works - since you ship all the requests to
> the system w/ the device, that kernel can implement the locks.  Any
> issues here?

mostly speed issues. Could using something like rmt really scale to
lots of processors with reasonable performance?
 
> Files.  I have also punted on this.  I have never gotten that excited about
> a cache coherent distributed file system, though others certainly do.  It's
> not because I don't think it is useful.  I believe it can be done and that
> we have the talent right here on this list to do it.  So I'll bow out of
> commenting on it, other than to say make sure mmap works right.

The big problems are indeed cache coherency and things like mmap(). We
implemented a parallel filesystem called HiDIOS on the 128 node ap1000
which worked by putting the buffer cache for a block on the cell that
owns the block. We didn't support mmap() as the machine had no mmu,
and the only cache local to each cpu is an optional one controlled by
the user in much the same way as stdio, but applied to file
descriptors in the C library.

We were able to get away with this because the remote memory access
bandwidth was very high (slightly higher in fact than local memory),
and latencies were low. We also used a really simple meta data
structure that completely elimated indirect blocks to find data on the
disk. We got 60MB/sec through the filesystem (the hardware limit is
64MB/sec).

We've seen attempts to put standard unix filesystem structures on
parallel machines and they are just not efficient enough. The cost of
manipulating all that meta data is huge when the disks (in parallel)
are capable of higher thoughputs than a local memory copy.

We are planning on doing a similar parallel filesystem for
Linux/AP+. We'll use a more sophisticated meta data scheme than was
used in the AP1000 HiDIOS, but still much simpler than that used in
ext2. It will be tuned for big io tasks, like loading 2GB of data
before the start of a heavy computing task. It will probably be
pathetic for loading your .cshrc, but we aren't going to be
encouraging people to use this system to run shell scripts on :-)

I still don't know how we are going to handle mmap. We think mmap is
very important in a parallel filesystem, but we just don't know how to
implement it in a really fast and coherent way yet.
 
> Sockets.  This is a hard problem.  Some people think that a socket
> should stick around after the CPU that created the socket has crashed.

yep, sockets are probably hard. We've already met problems with
them and we haven't even tried to make them parallel yet :-)

We use sockets to implement the stdin/stdout/stderr of parallel
processes. The paralleld that launches parallel programs on each cell
first creates 3 sockets back to the launching program, setting them up
as file desciptors 0, 1 and 2. When it then does a fork()/exec() the
parallel program inherits them.

The problem is that on a 64 cell machine we end up having 192 sockets
connected to the one process on the front end that launched the
parallel program. This is madness! It also won't work well if we have
1024 cpus :-)

I'm hoping this problem will go away when we revamp the way we launch
parallel programs. If we had a remote fork() and/or remote exec()
and also had a way for the file descriptors of remote forked processes
to feed back into the parent cpu then it would be much better. 

We'd probably also need to use a tree structure to feed the file
descriptors (and paging for that matter) back up into the parent
process. 1000 children all writing to one parent would not be pretty. 

> Cluster {join,leave}  This turns out to be a thorny area.  You gotta get it
> right, too.  You want the cluster to keep working in the face of a crashed
> node.  You also want nodes to be taken out and added back into the cluster
> for whatever reasons.  There's a whole set of protocol issues here that I'm 
> too sick to describe, trust me that we have a lot of work in this area.

This is a really interesting area to work on, but its probably not
something our group will be looking at soon, for the reasons described
earlier. We've got to focus our attentions a bit :-)
 
> Finally - when doing all of this stuff, please do a 100Mbit ethernet based
> version as well as the AP version.  If you come at it from a network point
> of view, a whole bunch of problems will _not_ happen in the AP version.
> When you have all that nice hardware, you tend to use it and it can
> screw up the architecture such that a network based cluster won't work.
> On the other hand, if you do a network based cluster, you are guarenteed
> that you have a partioned solution.  As you try and make all of those
> kernels work on that one big shared memory, you'll find that partitioning
> is a big performance win.  Coming from a network cluster, you'll get that
> without having to work for it - the other way frequently is harder.

We probably won't do a 100Mbit version ourselves, we just don't have
the time. We'd love to cooperate with people that are doing it,
however, and I hope that a lot of what we do will be relevant for
systems like that.

The problem is really latency. Ethernet type systems have latencies
which aren't much lower than the system clock tick interval. This
means it often makes sense to do things is quite different ways to
what we have to do.

Cheers, Andrew
