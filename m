Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA88581 for <linux-archive@neteng.engr.sgi.com>; Thu, 5 Mar 1998 12:54:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA653718 for linux-list; Thu, 5 Mar 1998 12:52:49 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA883736 for <linux@engr.sgi.com>; Thu, 5 Mar 1998 12:52:44 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA26372
	for <linux@engr.sgi.com>; Thu, 5 Mar 1998 12:52:42 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA13360
	for <linux@engr.sgi.com>; Thu, 5 Mar 1998 21:52:38 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA18354;
	Thu, 5 Mar 1998 21:31:44 +0100
Message-ID: <19980305213144.33306@uni-koblenz.de>
Date: Thu, 5 Mar 1998 21:31:44 +0100
To: Harald Koerfgen <harald.koerfgen@netcologne.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: R3000 glibc
References: <19980305003010.18771@uni-koblenz.de> <XFMail.980305202951.harald.koerfgen@netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <XFMail.980305202951.harald.koerfgen@netcologne.de>; from Harald Koerfgen on Thu, Mar 05, 1998 at 08:29:51PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thought this might as well be interesting to other as well, so I copy this
to the usual lists.

On Thu, Mar 05, 1998 at 08:29:51PM +0100, Harald Koerfgen wrote:

> BTW Eine Sache, die ich schon immer wissen wollte, aber nie zu fragen wagte:
> 
> Wie sieht das eigentlich mit der CPU-Abhaengigkeit der glibc aus?
> 
> Ich habe gerade damit anfgefangen, mich mit dem Ramdisk-Support fuer linux/MIPS zu
> beschaeftigen und moechte spaeter einmal ein Ramdisk-Image zum Kernel-Image
> dazulinken, welches als root gemountet werden soll. Auf diesem moechte ich eine
> statisch gelinkte bash unterbringen. Meine eigentliche Frage ist nun, wuerde das mit
> der existierenden glibc funktionieren, oder muesste ich eine R3000-spezifische glibc
> bauen?

All the published userland binaries have been compiled using MIPS ISA 1.  The
sole exception is glibc.  As it is usual for Linux, the MIPS binaries of
glibc have been built using the three add-ons crypt, localedata and
linuxthreads.  In order to be threadsafe LinuxThreads has to use some kind of
semaphores etc..  Since it is the natural way of doing things for R6000 and
better, I choose to implement this using the ll and sc instructions.

For the members of the MIPS CPU family which are lacking these two
instructions I suggest to simulate them in the reserved instruction handler.
This will work for all uniprocessor systems and using the special hardware
which is part of old R2000/R3000 systems it would even be SMP proof - if
we ever do R3000 SMP ...  It wouldn't be interrupt safe as well.

The implementation could roughly look like:

unsigned long ll_bit, lladdr;

void simulate_ll(struct pt_regs *regs)
{
	unsigned long addr;

	/*
	 * analyse the ll instruction that just caused a ri exception
	 * and put the referenced address to addr.
	 */
	[...]
	
	lladdr = addr;
	ll_bit = 1;
	regs[reg_to_be_loaded] = *addr;
}

void simulate_sc(struct pt_regs *regs)
{
	/*
	 * analyse the ll instruction that just caused a ri exception
	 * and put the referenced address to addr.
	 */
	[...]

	lladdr = addr;

	if (ll_bit = 0) {
		regs[reg_to_be_stored] = 0;
		return;
	}

	*addr = regs[reg_to_be_loaded];
	regs[reg_to_be_loaded] = 1;
}

The scheduler would have to clear ll_bit on every context switch in order
to take care of shared memory and threads sharing their mm_struct.

There are for shure better ways of doing this, but this implementation would
keep the 100% binary compatibility.  The way not to do it is to use
sysmips(MIPS_ATOMIC_SET, ...) syscall which would result in the full
syscall overhead.  Even though Linux's is way less than RISC/OS's ...

  Ralf
