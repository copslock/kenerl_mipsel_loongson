Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA814592 for <linux-archive@neteng.engr.sgi.com>; Tue, 24 Mar 1998 11:03:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA3216735
	for linux-list;
	Tue, 24 Mar 1998 11:02:14 -0800 (PST)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA3236060
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 24 Mar 1998 11:02:13 -0800 (PST)
Received: (from ariel@localhost) by oz.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA108910 for linux@engr.sgi.com; Tue, 24 Mar 1998 11:02:12 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199803241902.LAA108910@oz.engr.sgi.com>
Subject: Digest of last week's bounces
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Tue, 24 Mar 1998 11:02:12 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

A digest of recent bounces from earliest to latest [22-24 March].

Overview:
	Subject: Re: MIPS 2.1.89 now in CVS
	Subject: Re: Lmbench results for Linux/MIPS 2.1.90
	Subject: Another 7kb
	Subject: The current trick
	Subject: Re: English
	Subject: Bus errors on the Indy
	Subject: Re: More fixes

Summary of the important points:
Ralf improved the performance of SGI/Linux significantly
merged some latest Linux 2.1.90 sources and fixed several bugs.



From: ralf@uni-koblenz.de
Message-ID: <19980322202140.44155@uni-koblenz.de>
Date: Sun, 22 Mar 1998 20:21:40 +0100
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@fnet.fr,
        linux@engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: MIPS 2.1.89 now in CVS
References: <19980322172150.64018@alpha.franken.de>
Mime-Version: 1.0
In-Reply-To: <19980322172150.64018@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Mar 22, 1998 at 05:21:50PM +0100

> irgendwie mag fnet.fr die zugegeben durch unser Mailsystem verunstaltete
> (aber IHMO gueltige) From Adresse nicht. Da Anwort/Frage primaer dich
> betreffen, schick ich sie nur an dich.

I don't have the holy RFC at hand but if I remember it right unbalanced
violate the spec.  Anyway, if you want to very if your mail is RFC down
to the letter, try mailing Ralph Babel.  If you mail bounces, it isn't  ;-)

> On Tue, Mar 17, 1998 at 11:48:43PM +0100, ralf@uni-koblenz.de wrote:
> > I've upgraded the MIPS port to 2.1.89.  Aside of the still unresolved
> > problem in exit_mm() which I've reported some hours ago is seems to be
> > working on Indys.  Haven't yet tested the rest of my hardware collection.
> 
> Is the exit_mm() problem still unresolved ?

I solved it.  There is a couple of superfluous fput calls in fs/binfmt_elf.c
Will commit the fix later today along with other bug fixes and performance
improvments.  Still haven't verified if this is a bug in our private
version or in Linus' version as well.

The bad new is that I still haven't been able to track down the case of
memory corruption that is plaguing the Indy.

> > I'm particularly interested in reports about the NCR53C9x driver on
> > Olivetti M700 / Magnum 4000.
> 
> works so far. But I can't say much, because fsck bombs out due to the
> exit_mm() problem. But detection of the scsi devices and mounting the root
> filesystem works.

Ok.  The Indy driver also survived the switch to the new SCSI midlevel
code, so everything went alot smother than initially reading the SCSI
code made me believe.

  Ralf

Date: Sun, 22 Mar 1998 21:30:05 -0800
Message-Id: <199803230530.VAA12819@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com, lm@who.net
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
In-Reply-To: <19980322075452.09681@uni-koblenz.de>
References: <19980322075452.09681@uni-koblenz.de>

ralf@uni-koblenz.de writes:
 > Hi all,
 > 
 > here is another round of lmbench results.  Most notably all benchmarks
 > that depend on the overhead of syscall entry have improved remarkably.
 > For comparison I've included some more machines in the table.
 > 
 > The machines:
 > 
 >  indy:     Indy R5000SC 180MHz, 512mb l2 cache, 96mb memory.
 >  sv002076: Sun Ultra Enterprise E450, 2 x 296MHz Ultra2 CPUs,
 >            1gb memory (two interleaved).
 >  dull:     Dell Pentium 200 MMX, 32mb, running Redhat's 2.0.27.
 >  tbird:    SNI RM200, R4600 133MHz, no second level cache, 32mb memory.
 > 
 > I'm thinking about not saving the temporary registers on syscall entry;
 > I'm just not shure if this would break the semantics of ptrace(2).
...

      UMIPS-BSD (4.3 BSD on the MIPS M/1000) did not save the temporary
registers on syscall().  It did, of course, save them on interrupts,
so preemption left the registers valid.  I don't see why saving the
registers on syscall should affect ptrace(), since the ptrace()
caller is acting on another process, which will have saved all its
registers if preempted.  That change ought to let the R5000 beat
the Pentium, despite the Indy's miserable memory latency.

>From owner-linux@cthulhu  Sun Mar 22 21:55:31 1998
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by oz.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA36672 for <ariel@oz.engr.sgi.com>; Sun, 22 Mar 1998 21:55:31 -0800 (PST)
From: owner-linux@cthulhu
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id VAA2562878;
	Sun, 22 Mar 1998 21:55:30 -0800 (PST)
Date: Sun, 22 Mar 1998 21:55:30 -0800 (PST)
Message-Id: <199803230555.VAA2562878@cthulhu.engr.sgi.com>
To: owner-linux@cthulhu
Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from [ralf@uni-koblenz.de]   
Status: RO

From: ralf@uni-koblenz.de
Message-ID: <19980323065516.23188@uni-koblenz.de>
Date: Mon, 23 Mar 1998 06:55:16 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com, lm@who.net
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
References: <19980322075452.09681@uni-koblenz.de> <199803230530.VAA12819@fir.engr.sgi.com>
Mime-Version: 1.0
X-Mailer: Mutt 0.85e
In-Reply-To: <199803230530.VAA12819@fir.engr.sgi.com>; from William J. Earl on Sun, Mar 22, 1998 at 09:30:05PM -0800

On Sun, Mar 22, 1998 at 09:30:05PM -0800, William J. Earl wrote:

>  > I'm thinking about not saving the temporary registers on syscall entry;
>  > I'm just not shure if this would break the semantics of ptrace(2).
> ...
> 
>       UMIPS-BSD (4.3 BSD on the MIPS M/1000) did not save the temporary
> registers on syscall().  It did, of course, save them on interrupts,
> so preemption left the registers valid.  I don't see why saving the
> registers on syscall should affect ptrace(), since the ptrace()
> caller is acting on another process, which will have saved all its
> registers if preempted.  That change ought to let the R5000 beat
> the Pentium, despite the Indy's miserable memory latency.

Yeah, let's make some nice benchmarks that are going to fry the borg :-)
Given that we have that many registers I think we might reach the magic
1.0 microseconds.  It's just 56 cycles we need to get from somewhere ...

I was thinking about ptrace(2) because on Linux it has an option
(PF_TRACESYS) where the tracee is only stopped on syscalls.  Anyway, the
lost registers are just temporary registers, so away with 'em ...

  Ralf

>From owner-linux  Sun Mar 22 22:04:15 1998
From: ralf@uni-koblenz.de
Message-ID: <19980323070406.41524@uni-koblenz.de>
Date: Mon, 23 Mar 1998 07:04:06 +0100
To: linux@engr.sgi.com
Subject: Another 7kb
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e

Just shrunk the kernel by another 7kb.  Instead of the already nice trick
for computing current from the stack pointer, I'm now using the global
pointer $28 to store it.  Since we don't do global pointer optimization
we get a register to store current for free.  Saves another over 7kb and
some cycles on context switch and syscalls.  En passer I fixed a couple
of bugs in the R3000 code.

Explanation for IRIX people: current is the pointer to the current task,
the most accessed variable in the entire kernel.  Linux stores the process
structure at the lower end of a 8kb pages, the stack at the upper end so
current can be computed from $sp without doing loads as $sp & ~0x1fff.

  Ralf

>From owner-linux  Sun Mar 22 22:41:17 1998
From: ralf@uni-koblenz.de
Message-ID: <19980323074108.36199@uni-koblenz.de>
Date: Mon, 23 Mar 1998 07:41:08 +0100
To: linux@engr.sgi.com
Subject: The current trick
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e

The last 2.1.90 kernel:

  Simple syscall: 1.2611 microseconds
  Simple read: 2.1703 microseconds
  Simple write: 1.9885 microseconds
  Simple stat: 23.7789 microseconds
  Simple fstat: 3.6228 microseconds

With the current trick:

  Simple syscall: 1.1700 microseconds
  Simple read: 1.9605 microseconds
  Simple write: 1.8097 microseconds
  Simple stat: 15.6738 microseconds
  Simple fstat: 3.9914 microseconds

We're getting closer, 31 cycles to fry.

  Ralf


From: ralf@uni-koblenz.de
Message-ID: <19980323085804.58255@uni-koblenz.de>
Date: Mon, 23 Mar 1998 08:58:04 +0100
To: Dave Wreski <dave@nic.com>
Cc: linux@engr.sgi.com
Subject: Re: English
References: <19980322200046.50788@uni-koblenz.de> <XFMail.980323011130.dave@nic.com>
Mime-Version: 1.0
X-Mailer: Mutt 0.85e
In-Reply-To: <XFMail.980323011130.dave@nic.com>; from Dave Wreski on Mon, Mar 23, 1998 at 01:11:30AM -0500

(Some of SGI's people may want to comment this, so I cc this to SGI's
Linux mailing list.)

On Mon, Mar 23, 1998 at 01:11:30AM -0500, Dave Wreski wrote:

> Ralf, you were very kind in answering a few questions I had in the past about
> Linux and SGI, and I hoped I could ask one more, now that I understand there
> is a web site at SGI for Linux.

Yeah, check out http://www.linux.sgi.com.

> I understand that Sun feels Linux is a threat to its software division, and
> according to David Miller at last year's Atlanta show, it could cause serious
> financial problems for their software division.

I admit that Linux has heavy impact into some companies markets.  The Sparc
people have been doing a pretty nice job for the more modern Sparcs.  In
fact it's just the pricetag on the bigger machines that so far prevented
Linux to be ported to Sun's biggest hardware.

One of the problems Sun has is that their hardware is considered to be
very reliable but Solaris unlike Linux isn't.  I know of significant Sun
installations which have been converted to Sun hardware running Linux.
The number of of people which intend to do the same with their SGI's is
lower, partially caused by the fact that Linux/SGI is not yet ready for
prime time, partially due to technical attributes like XFS.

> I was really just wondering why SGI would go so far as to even donate hardware
> to some of the developers, and even sponsor David Miller to port Linux to
> their platform.

SGI's market is different than Sun's.  SGI's products are far more being
marketed by technical attributes than Sun's which gives them a far bigger
``safety distance'' towards Linux than Sun has.  SGI's engineers are very
openminded to Linux and now and then manage to convice their managment to
make steps towards Linux and Free Software in general.  Finally SGI
recognices that Linux has properties that IRIX doesn't have and probably
won't every have.

On the opposite side the way the Sun employees I talked to are talking
about Linux.  They're talking about Linux like the devil himself about holy
water.  It almost seems like Sun is spreading an almost irrational fear
of Linux under their employees.

>                  Do you think they feel the way Netscape now does?  Maybe
> something like having their engineers produce really high-end hardware, and
> let the Linux engineers produce really high end software for it?

The concept fails in areas where the demand is low, therefore the
probability to find the highly skilled volunteers.  Web browsers are popular
and every computer system needs an OS, most of them a web browser, that's
why Linux is a success and why I think Netscape's ``going public'' will be
a success as well.

Free Software finds it's limits where the number of people that could
push the development is low and the cost for them invest is high.  Guess
why there are no Linux port to top of the line iron like Sun E1000 or
Origin 2000.

  Ralf

From: ralf@uni-koblenz.de
Message-ID: <19980323222727.52929@uni-koblenz.de>
Date: Mon, 23 Mar 1998 22:27:27 +0100
To: linux@engr.sgi.com
Subject: Bus errors on the Indy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e

The bus error messages that people have been posting to the list were
quite useless as a debugging aid.  The problem is that the kernel
reenables interrupts in the bus error handler.  The Indy however seems
to post the buserror both as dbe/ibe exception and via the interrupt
mechanism.  I wonder what the rationale behind this behaviour is.

Anyway, as result we catch the bus error interrupt at the point where
the dbe/ibe handler reenable interupts.  Means results of c0_epc
printed to the screen are pretty bogus.  I fixed that and therefore
hope we'll rsn be able to get rid of the problem.

  Ralf


>From owner-linux  Tue Mar 24 07:07:27 1998
Date: Tue, 24 Mar 1998 16:09:37 +0100 (CET)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: More fixes
In-Reply-To: <19980323225125.14671@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980324160922.650B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 23 Mar 1998 ralf@uni-koblenz.de wrote:

> I fixed the old reboot problem.  The cause were three lines of code
> that should have been removed ages ago.  Now the second level cache
> is being disabled on reboot as it is supposed to.

Any fixes for the R4000SC yet?

- Ulf


-- 
Peace, Ariel
