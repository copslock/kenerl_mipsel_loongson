Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA22737; Fri, 20 Jun 1997 02:24:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA20395 for linux-list; Fri, 20 Jun 1997 02:23:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA20388; Fri, 20 Jun 1997 02:23:37 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.37.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA04491; Fri, 20 Jun 1997 02:23:36 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id FAA08805;
	Fri, 20 Jun 1997 05:19:49 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id FAA07966; Fri, 20 Jun 1997 05:17:42 -0400
Date: Fri, 20 Jun 1997 05:17:42 -0400
Message-Id: <199706200917.FAA07966@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: fisher@sgi.com
CC: lm@neteng.engr.sgi.com, sca@refugee.engr.sgi.com,
        carlson@heaven.newport.sgi.com, linux@cthulhu.engr.sgi.com,
        fisher@hollywood.engr.sgi.com
In-reply-to: <199706200855.BAA14655@hollywood.engr.sgi.com>
	(fisher@hollywood.engr.sgi.com)
Subject: Re: Getting X on Linux/SGI
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: fisher@hollywood.engr.sgi.com (William Fisher)
   Date: Fri, 20 Jun 1997 01:55:31 -0800 (PDT)

I'm glad someone stepped in this.

	   Nearly all of those systems were nearly bare metal software
	   environments since we had numerous talks with Chet at MIPS
	   about software features that would propell the business.
	   NONE of those customers wanted anything to do with any
	   flavor of Unix, Linux, BSD, System V, etc.

	   In fact Hunter-Ready and the other real-time kernels
	   weren't that popular with the hard core real-time/embedded
	   folks.

	   Hence I would like to here more about larry's definition of
	   "embedded systems" because they sure don't sound like any
	   that our semiconductor partners sell to.

Allow me...

Let me relay a story a co-Sparc developer of mine told (and showed!)
me when I saw him in person in Germany the other week.

His name is Eddie C. Dost and he works for a software/hardware house
there where they do nothing but embedded work.  About two weeks ago he
was asked to tackle two projects.  One involved an i386SX based board
which controlled lighting systems for skyscrapers, the other was a
m68k based board which was meant to be deployed by the hundreds to
control campus wide key card entry systems for a bunch of corporations
and universities in the German speaking countries.

He was given QNX to write his drivers and get the box going.  Since it
is a micro-kernel, you have to perform a task switch to handle even an
interrupt, and you have to compile your interrupt handlers with a
special compiler and compiler options using QNX compilers just to cope
with this bullshit.  This was on both systems.

Interrupt response was so slow, that even when he coded the drivers in
raw optimized assembly he could not keep up and would drop characters
easily on his serial ports, the ISDN performance sucked balls as well.

So eddie got so frustrated one night that he took both the m68k and
Intel ports of Linux, in about an hour added kernel build time
configuration options such as "CONFIG_NO_MEMORY_MANAGEMENT",
"CONFIG_NO_FANCY_SYSCALLS", "CONFIG_NO_USELESS_FEATURES" and the like
to the point where he was able to get a 120k sized Linux kernel with
his drivers and the specialized code to run the control systems he
needed to deploy, and he got full over the serial line KGDB source
level debugging of his kernel as well.

The next night he got it completely working and debugged, needless to
say this thing didn't have the interrupt performance problems QNX
did.  The next evening he blew the first revisions of the PROM's the
boxes would eventually use in production when these things got sent
to the customers.

Now here comes the interesting part...

He had to then approach his boss, he explained the issues and how he
had solved the problem.  The boss went "what, use Linux, why the fuck
would we even want to do such a thing?"

His response was: "Firstly, QNX doesn't even fucking work, at best the
product would be delayed if I could get it to work with QNX at all,
and thus you might even lose these sales.  Secondly, I just saved you
a shitload of money and future engineering costs.  Not only did I just
save you the QNX license on all the hundreds of these fuckers you are
going to sell to people (you can sell it at the same prive, the
customer won't know the difference), I have a usable mini-Linux kernel
that we can use (and thus save the licensing fee's + the engineering
all over again) as a base for a lot of our future embedded products."

His boss was blown away, the rest is history...

So you see, the real issue is that people don't know they want it...

Oh btw, Eddie will in fact be working on some MIPS based embedded
boards in the near future, and I can tell you he sure as hell isn't
gonna be putting QNX or any other "embedded OS" in those things.

Later,
David "Sparc" Miller
davem@caip.rutgers.edu
