Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA21025; Wed, 15 May 1996 15:44:47 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA26316 for linux-list; Wed, 15 May 1996 22:43:22 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA26301 for <linux@cthulhu.engr.sgi.com>; Wed, 15 May 1996 15:43:21 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id PAA19394; Wed, 15 May 1996 15:43:19 -0700
Message-Id: <199605152243.PAA19394@neteng.engr.sgi.com>
To: tridge@cs.anu.edu.au
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: linux-mc@arvidsjaur.anu.edu.au, Linus.Torvalds@cs.Helsinki.FI,
        linux@neteng.engr.sgi.com, alan@cymru.net
Subject: Re: mpp kernel interface 
Date: Wed, 15 May 1996 15:43:19 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: With 30 people now on this list there must be someone else who wants
: to say something ...

I'm going to try.  I'm probably going to do a half assed job, as I am 
feeling a bit sick today.  But I'll give it a go.

: It really depends on how we end up using this stuff. Does anyone out
: there have any experience with implementing things like remote fork,
: remote paging, remote files/sockets etc? What sorts of interfaces are
: useful for doing stuff like that?

I have a few ideas.  Lots of them are stolen from the UCAL Locus project, 
Jim Bob says check it out.

First, this is mostly a naming problem.  Wrap your brain around that.  We
need to have clear in our heads exactly how everything is named. Once
you can draw that picture, the implementation becomes straight forward.
After you read through this, you may or may not be in basic agreement.
If we ever converge, I will volunteer to write "man pages" for each of
the chunks of work so that we have a well documented TODO list.  It is
as close as I've ever gotten to a spec.

Things we need to name

	hosts
	cluster
	processes
	devices
	files
	sockets

other things

	cluster {join,leave}
	SMP vs cluster?

The hard one is sockets.  I've never seen a good solution to that.
I'll come back to that.  First, I want to go through the other ones and
offer suggestions.

Hosts are just hosts, nothing changes there.

Clusters are a mapping of "cluster_name" -> "list of hosts".  Think
of getclustbyname().  I did this for SparcClusters, it worked pretty
well.  The cluster is the name that you use to get to your cluster.
This implies that you wack rlogin/telnet and/or you wack DNS to 
to translate from the cluster name to the hostname to the IP address
of that host.  DNS is the easiest place.

Processes have two major chunks of work, the PID name space and how you
do remote processes.  For the PID name space, make pid_t a 32 bit int,
make the top 16 bits the host part, and the bottom 16 bits the pid part.
(We need to come back to the host part when we discuss process migration.)
A host part of "0" means "this host".  So a "kill -HUP 1" will always
restart init.

Remote processes.  This part gets fun, fun, fun.  Think of how we have
files as objects in the kernel, in C++ terms, an inode is a class with all
virtual methods - each instance of the class implments its own methods.
We need to do that for processes.  For every operation we currently
do on a process, we need to make that a function call.  You want this
layer to be very thin, it can't be a performance hit for local processes
or we blew it.  The intances of the process class I imagine are at
least "local", "remote", "local debugged", "remote debugged".  I can
also image using this to implement "local or remote, gang scheduled".
See how that works?  I'm hand waving like crazy here.  I'm not positive
the debugging stuff works in this layer, but I would love it if all the
System V /proc crap was buried in an optional instance of the process
class.  I believe that you can make the non debugged instance faster.

Devices I sort of punt on.  For device access, I would just use the 
remote mag tape protocol (or something very, very similar) so that all
of the locking, etc., still works - since you ship all the requests to
the system w/ the device, that kernel can implement the locks.  Any
issues here?

Files.  I have also punted on this.  I have never gotten that excited about
a cache coherent distributed file system, though others certainly do.  It's
not because I don't think it is useful.  I believe it can be done and that
we have the talent right here on this list to do it.  So I'll bow out of
commenting on it, other than to say make sure mmap works right.

Sockets.  This is a hard problem.  Some people think that a socket
should stick around after the CPU that created the socket has crashed.
I don't know how to do that efficiently, so I punt.  The only thing I
would suggest in the socket domain is (a) make gethostbyname("cluster")
be translated into a getclustbyname("cluster") so that you can think of
the cluster as one host (DNS or someone is round robining the host you
actually get), and (b) manage the routing tables within the cluster far
more dynamically that routing tables are corrently managed.  The latter
means that you notice immediately when a CPU leaves the cluster and
update your routing tables to route around that dead CPU.

Cluster {join,leave}  This turns out to be a thorny area.  You gotta get it
right, too.  You want the cluster to keep working in the face of a crashed
node.  You also want nodes to be taken out and added back into the cluster
for whatever reasons.  There's a whole set of protocol issues here that I'm 
too sick to describe, trust me that we have a lot of work in this area.

SMP vs cluster.  Lots of people wonder about this - do you do one, both, 
neither?  The smartest people I know, have all concluded the same thing:
you do 4 way SMP nodes, and cluster those to scale beyond the 4 CPUs.
The reasoning is as follows: when you are creating processes, you 
are striping them across the cluster (if you have a coherent distributed
mmap, rfork() is not that hard, seems worse than it is, but as a first
pass, just do rexec(), that will scale parallel make which is a great
test case).  It turns out from cache affinity studies that you really
want to avoid moving processes from one CPU/cache/memory to another.
It screws up your performance.  On the other hand, if you get unlucky
with your striping alg and land a couple of long running processes on
the same node, it is nice to have more than one CPU there to handle the
load.  Another way to state this: you need to balance your load.  If
you try and statically balance it at fork and/or exec time, you will
make mistakes because you don't have enough info at that point to do 
perfect scheduling job.  If you are sending jobs to SMPs instead of
uniprocessers, the SMPs can do a reasonable job of dynamically scheduling
the load.  And a 4 way SMP is a good first order approximation of an
infinitely large SMP, it is rare that you'll screw up so badly that 
you need more than 4 processors to smooth out the load.

So why am I beating on this issue so hard?  Because I don't want a 
fine grained threaded SMP kernel.  Threading the kernel that much introduces
way too much of a performance penalty for the simple case of "run this
one job".  Also consider that the SMP kernel may well form the basis for
a fully preemptable uniprocessor kernel.  I do not want to sacrafice more
than 1% performance on the uniprocessor to get preemption.  Solaris and
IRIX both suck at this - you pay big time for that checklist item.  

If you walk into the SMP arena with the model that you "fork" your system
every 4 processors, then you don't have to work so hard to get scaling.
Coarse grained, non intrusive locking will work just fine for 4 processors
and you leave the rest to the cluster.  Cool?

Finally - when doing all of this stuff, please do a 100Mbit ethernet based
version as well as the AP version.  If you come at it from a network point
of view, a whole bunch of problems will _not_ happen in the AP version.
When you have all that nice hardware, you tend to use it and it can
screw up the architecture such that a network based cluster won't work.
On the other hand, if you do a network based cluster, you are guarenteed
that you have a partioned solution.  As you try and make all of those
kernels work on that one big shared memory, you'll find that partitioning
is a big performance win.  Coming from a network cluster, you'll get that
without having to work for it - the other way frequently is harder.

That's enough for now, how about some comments?

--lm
