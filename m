Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0RNR9r01271
	for linux-mips-outgoing; Sun, 27 Jan 2002 15:27:09 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0RNR0P01253
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 15:27:00 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0RMQvG18102;
	Sun, 27 Jan 2002 14:26:57 -0800
Date: Sun, 27 Jan 2002 14:26:57 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Jason Gunthorpe <jgg@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Help with OOPSes, anyone?
Message-ID: <20020127142657.C18041@momenco.com>
References: <20020127002242.A11373@momenco.com> <Pine.LNX.3.96.1020127032353.6344B-100000@wakko.deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020127032353.6344B-100000@wakko.deltatee.com>; from jgg@debian.org on Sun, Jan 27, 2002 at 03:53:34AM -0700
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Interesting... did you try the 2.4.17 that's in the SGI CVS?  That's what
I'm using....

Our PROM does configure the cache for us, but I'd like to see the code
anyway.  Might be insightful.

We're pretty sure our GT-64120 is setup properly, as we use the same
parameters under vxWorks and OpenBSD without problem.

The particular board I'm using has no L3 on it.  But I will try the
NONCACHED option to see what happens.

Matt

On Sun, Jan 27, 2002 at 03:53:34AM -0700, Jason Gunthorpe wrote:
> 
> On Sun, 27 Jan 2002, Matthew Dharm wrote:
> 
> > My instincts are telling me that these are all being caused by the same
> > problem, but I'll be damned if I can figure out what that is.  Caching is a
> > good suspect, but that's just because it's always a good suspect.
> 
> I can tell you that I have managed to get 2.4.17 (patched up from the
> 2.4.15 in the linux_2_4 branch of SGI CVS) running very solidly on a
> RM7000 platform. I have carefully inspected the cache code, and I
> think that what is in the CVS tree is correct, though a little
> over-zealous :> I had to make some tweaks to the cache init on the RM7k,
> the existing code is wrong - but this is only important if your PROM does
> not do it for you. I can send you this code if you like.
> 
> I'm using the Debian user land, 8M of L3 and a custom system controller.
> The machine works will enough to build complicated programs, run X stuff,
> etc. My board also has 512M of ram, (mapped from 0-512M, so no problems
> with highmem..). The box is nfs root'd and I've currently got a 8139
> ethernet chip on it. 
> 
> > In these OOPSes, one is caused by some code in unaligned.c -- I've seen
> > several (many) like this, tho I only captured and decoded one.  The code in
> 
> Many of the oops's I've seen (while gettings this working) come from
> unaligned.c - haven't investigated why yet - they might actually be kernel
> unaligned memory references.
> 
> While working on the SR7100, I noticed that various sorts of problems that
> result in a subtly broken system bus caused random faults in unaligned.c
> 
> > -- I FTPed the SRPM for wget and built it without any problems.  Heck, it
> > even works!  But when I try to build something bigger (say, ncftp or
> > glibc), it dies an ugly death.  Heck, I could FTP, build, and use ksymoops
> 
> Just tried for you:
> 
> mips:/tmp/ram# apt-get source -b ncftp
> [..]
> dpkg-deb: building package `ncftp' in `../ncftp_3.1.1-3_mipsel.deb'.
> mips:/tmp/ram# uname -a
> Linux mips 2.4.15-greased-turkey #407 Thu Jan 17 19:20:18 MST 2002 mips unknown
> mips:/tmp/ram# cat /proc/cpuinfo    
> processor               : 0
> cpu model               : RM7000 V3.2  FPU V2.0
> BogoMIPS                : 346.20
> [..]
> mips:/tmp/ram# free
>              total       used       free     shared    buffers     cached
> Mem:        514100     124996     389104          0         16      98604
> 
> > hopes that will fix the problem.  I'm thinking about trying
> > CONFIG_MIPS_UNCACHED, but I don't know if that works on an RM7000 processor
> 
> It does.
> 
> > -- the L1 and L2 are built-in to the processor, and I don't think the L1
> > can be deactivated.  Then again, I don't know how CONFIG_MIPS_UNCACHED
> 
> They can.. It is worth trying without the L3 cache at the very least.
> 
> I see your boards have the GT system controllers. You may want to validate
> they are configured correctly, you can get all sorts of really screwy
> results if they are not - there are lots of errata for those chips, and 
> some models have a very intolerant (electricaly) sdram controller.
> 
> Jason
> 
> 
> 

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
