Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA18865; Thu, 1 Aug 1996 18:14:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA29537 for linux-list; Fri, 2 Aug 1996 01:14:37 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA29527 for <linux@cthulhu.engr.sgi.com>; Thu, 1 Aug 1996 18:14:35 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA11931 for <linux@yon.engr.sgi.com>; Thu, 1 Aug 1996 18:13:01 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA18859; Thu, 1 Aug 1996 18:14:34 -0700
Date: Thu, 1 Aug 1996 18:14:34 -0700
Message-Id: <199608020114.SAA18859@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: ariel@cthulhu.engr.sgi.com
CC: linux@yon.engr.sgi.com
In-reply-to: <199608012046.NAA11583@yon.engr.sgi.com> (ariel@yon)
Subject: Re: Those FreeBSD guys...
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ariel@yon (Ariel Faigon)
   Date: Thu, 1 Aug 1996 13:46:21 -0700 (PDT)

I can't help, I have to comment on some of this ;-)  My comments
probably look like flame fare, but statements like the following make
my stomach turn.  Enter this mail at your own risk. ;)

   Yesterday, I went to the MindSource monthly meeting (Michael's
   at Shoreline) where three FreeBSD people gave a talk.
   Jordan Hubbard (he is on a visit from Ireland), Sameer Parekh (sp?),
   and Matt Dillon.

My pinhead radar was on high lately, this must have been what set it
off ;)

   "Our impression of the Linux community is that they are
   a bunch of Cowboys, "

Yee haw!

   "they don't even use a source-control system
   to coordinate and split the work. We have these great development
   control tools: cvsup and sup ... we work really well together.
   all the core team has write permission to the source tree"
   There are 47 people doing major contributions. 14 of them
   are core.

Mostly untrue.

Fact: Linus is the only person who can get at the master
      tree, of what use are source control tools when this
      is the case is beyond me.

Fact: The entire world has write permission to the Linux sources,
      because of the GPL.  The FreeBSD tree can be encorporated
      into things where the sources aren't publicly available.

Fact: Those subprojects (mostly the ports) do use source control
      systems (the same ones the FreeBSD people use, sans sup which
      is truly braindamaged and useless, cvs does everything sup
      claims to be doing) when multiple people are working on tree,
      because it makes _sense_ here.

Fact: FreeBSD people are jealous that we have allowed one person
      to drive the firetruck "by himslef" and provide free QA for all
      kernel development.  In Linus we trust.

   "Linux might give you the "feeling" it is faster, but it is because
   we gave a lot of thought in the design to scalability and SMP,
   when you load Linux the great performance suddenly drops down
   sharply while BSD scales nicely."

Fact: FreeBSD has been talking/toying with an SMP implementation
      for many years now, currently the best it can do is run user
      processes on one cpu and service interrupts on another on
      one particular dual-pentium system.  Linux has SMP working
      on all Intel platforms which at least closely adhere to the
      Intel SMP specification.  We also have SMP fully working on
      Sparc machines, MIPS should be next.

Fact: It not only feels faster, it is faster, and on all supported
      platforms.  We have shown this with benchmarks, and real
      life examples.  On my 4 processor SparcStation I got Sparc/
      Linux smp working on, I had a load of 600 for 3 hours going
      on that machine.  The jobs were a mixture of lat_tcp's, bw_tcp's
      parallel kernel makes on both local disk and over NFS, 300
      invocations of crashme, and my X session locally on the machine.
      The machine had filled up %92 of it's swap space (the machine
      had 168mb of ram if I recall), typing commands in my xterms
      were still spiffy.  Next.

   "If you want a single user Unix to play at home, Linux is fine
   but if you are a commercial entity or ISP and you count on reliability
   and solid network performance, complex routing etc. use FreeBSD"

Fact: Linux survives crashme and other stress tests longer than
      any commercial or free operating system out there.

Fact: FreeBSD is faster over loopback when compared to Linux over
      the wire. ;-)

   "Linux is just a kernel, when you go to a full distribution
   things are much more complex, there are too many Linux distributions
   there's only one FreeBSD source base and it is complete with all
   utilities"

Fact: Entities like RedHat and others provide prepackaged, plug in
      and go, click your mouse button on this and it works, Linux
      installations and full support.

Fact: More distributions give Linux more flavor.  If I don't like the
      way the distribution scheme is layed out in the FreeBSD "one true"
      distribution, I'm out of luck because "I have no choice."

   "They try to run on too many architectures and the code is not clean
   We (FreeBSD as opposed to NetBSD) focus on Intel only, do it cleanly
   and make sure it works well"

I don't think I even need to say how bolixed this statement is.

   "They have the momentum and we don't underestimate this... we learned
   that we need to be nicer towards newbie questions to establish
   a larger user base"

I am happy that they do not understand the real reason we have so much
momentum.

   The future of FreeBSD is really promising: Clustering & Log filesystems
   are coming. SMP is already here (although it is not exactly symmetrical)"

Linux has real symmetrical SMP today, we have MPP support and
work on multicomputers, we are X/Open and POSIX branded.  Fine grained
SMP, IPV6, and more + faster support on more architectures in in the
works.  People are working on clustering and logging filesystems for
Linux as well.

   Sounds like these guys haven't seen linux since 0.99...
   Interesting nevertheless.

I agree.

dm@engr.sgi.com

'Ooohh.. "FreeBSD is faster over loopback, when compared to
Linux over the wire". Film at 11.' -Linus
