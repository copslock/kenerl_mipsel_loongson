Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA300540 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 14:45:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA07862 for linux-list; Thu, 4 Dec 1997 14:45:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA07855; Thu, 4 Dec 1997 14:44:58 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA18761; Thu, 4 Dec 1997 14:44:55 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA01496;
	Thu, 4 Dec 1997 23:44:45 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA30220;
	Thu, 4 Dec 1997 23:01:22 +0100
Message-ID: <19971204230122.18229@uni-koblenz.de>
Date: Thu, 4 Dec 1997 23:01:22 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Greg Chesson <greg@xtp.engr.sgi.com>,
        David Chatterton <chatz@omen.melbourne.sgi.com>,
        Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda> <9712041708.ZM8190@omen.melbourne.sgi.com> <chatz@omen.melbourne.sgi.com> <9712040903.ZM8161@xtp.engr.sgi.com> <199712041722.JAA26372@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <199712041722.JAA26372@fir.engr.sgi.com>; from William J. Earl on Thu, Dec 04, 1997 at 09:22:12AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 04, 1997 at 09:22:12AM -0800, William J. Earl wrote:

> Greg Chesson writes:
>  > I've been reading the O2 thread with great interest.
>  > 
>  > It seems to me that a "vanilla" port of Linux on the O2 is quite feasible.
>  > Several writers have agreed.
>  > 
>  > But full support in Linux for extremem platform-dependent multimedia
>  > hardware is problematic.  This has also been mentioned by several writers,
>  > some of whom developed the OS code.  The problems are twofold: it would
>  > be a non-trivial task even with full documentation to provide complete
>  > support for O2 hardware since the job would require as much new invention
>  > as it would require porting, and second- full disclosure
>  > of the inner workings is viewed as too much of a giveaway to present
>  > and future competitors.
>  > 
>  > Makes me wonder whether the Indy port of Linux could be ratcheted into
>  > a vanilla port for the O2, and then perhaps SGI could produce binary
>  > loadable drivers for the missing bits.
> 
>       For IRIX, most of the O2 work was really in areas which, in
> linux, would be reasonably general purpose.  In particular, being able
> to allocate large pages (64 KB tiles on O2) at any time, no matter how
> long the system has been running, was a major change, and would be
> useful for performance reasons on any system with variable page size,
> since it helps ordinary programs with large address spaces on
> large-memory systems, as well as supporting the O2 graphics and
> digital media.  Similarly, having solid time-scheduled realtime
> support is broadly useful.  For digital media, one needs a reasonably
> portable API, and applications on top of it, which supports high
> performance.  With those facilities in hand, doing the drivers is not
> all that difficult.  Providing those facilities, however, is a substantial
> project, and not especially tied to SGI hardware.

Indeed - and you're pointing to what I consider _the_ problem with
current Linux kernels.  Linux uses the ``buddy system'' described by
Donald Knuth's ``Algorithems And Data Structures'' to maintain it's
free pages.  This algorithem results in massive fragmentation even
after a short uptime.

On a Linux box you can press <shift> + <scroll-lock> and the kernel will
print some memory statistics to the console or syslog.  For the
purpose of illustrating things I've appended those numbers from a
couple of systems.  As it is easy to see Linux doesn't do a good job
at all.

As a result certain kernel subsystems that need large buffers may fail
on a loaded machine.  Typical example is the floppy driver allocating
a track sized buffer.  Much worse - the networking code sometimes does
atomic allocations.  Atomic means it cannot sleep for swapping etc.
On machines that have sufficiently fragment memory as a result network
services like NFS using >=4kb blocks (results in allocation of 8kb
blocks) are stalling.

For my 8mb PC this may mean it will sometime stop NFS serving when
nothing else is running at the same time just because the compile I
was running before resulted in completly fragmented memory leaving
no chunks bigger than a single 4kb page.  Unfortunately there is nothing
that 100% prevents this to happen under all circumstances on machines
with more memory.  I've seen reports of machines with >128mb of memory
having 2mb of free memory left all in 4kb chunks.

>      In graphics, if linux winds up with an IRIX-compatible kernel
> graphics driver on some SGI boxes, the IRIX Xsgi, libgl.so, and
> libGL.so platform-specific binaries could run on linux.  Note that
> each of our systems comes with a license for the then-current version
> of these components, so loading linux does not preclude using the IRIX
> components, although, at present, they may not be shipped in a linux
> distribution.  Since they are only useful on SGI hardware, perhaps SGI
> could make arrangements to permit "stable" binaries to be included in
> linux distributions for selected platforms.

This sounds like a possible way to go.  From the technical point of view
I'd prefer to rebuild those binaries - if possible - as native Linux
binaries.  It'd reduce memory usage significantly.

As far as technical documentation about the O2 goes - does a model like

 - full disclosure of documentation under a NDA to some Linux developers
 - the NDA would contain an expiration date, maybe one or two years, after
   which the covered information can be disclosed because SGI does no
   longer consider nondisclosure a vital for it's bussines.
 - disclosure as binaries:
   Parts that are considered to be based on information that SGI thinks
   should not be disclosed could be made available as binaries.
 - disclosure as source code:
   This would be drivers for disk/network (as I understand SGI doesn't
   consider this part of the O2 to be too valuable) and a part of the
   technical details about GFX that allow to implement a reasonable ASCII
   console, maybe a simple X server and to spread these components as
   source.

sound acceptable?  While I believe we should currently not try to go for
an O2 port because we still have same homework to do, I also think it's
important that we find a solution that allows Linux to be used on SGI
boxes before they can be considered old iron like the Indy.

Another important thing to consider is that porting Linux to the O2 takes
time.  So until we Linux developers have produced an acceptable O2
implementation an NDA wouldn't even hurt the idea of Free Software very
much.  It's also time during which the value of the non-disclosed
information for SGI decreases, so why shouldn't we - unlike for the
Indy port - try to overlap time of non-disclosure of technical information
with working on the port?

Another argument for or port to current SGI hardware - many people
want to prototype their embedded applications on a desktop using the same
operating system and CPU type.  For many embedded applications Linux is
one of the operating system of choice, after all Linux has many points
where it beats IRIX.  Most important the price per license.  For many
embedded applications MIPS is the CPU of choice.  So for developers of
such appliances running Linux, not IRIX, on an O2 could well be the OS of
choice even at the price of loosing IRIX's advantages.

One of the people interested in Linux for such an MIPS based appliance
being prototyped on a UNIX system was Kevin Kissel (kevink@neu.sgi.com).
So I guess even for SGI having a Linux desktop should be interesting.

  Ralf
