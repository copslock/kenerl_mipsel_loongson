Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J7F8nC009197
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 00:15:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J7F87P009196
	for linux-mips-outgoing; Wed, 19 Jun 2002 00:15:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J7ExnC009189
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 00:14:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA19440
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 00:17:47 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA21644
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 00:17:48 -0700 (PDT)
Received: (from hartvige@localhost)
	by copfs01.mips.com (8.11.4/8.9.0) id g5J7Hnc27328
	for linux-mips@oss.sgi.com; Wed, 19 Jun 2002 09:17:49 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200206190717.g5J7Hnc27328@copfs01.mips.com>
Subject: Re: Linux and the Sony Playstation
To: linux-mips@oss.sgi.com (user alias)
Date: Wed, 19 Jun 2002 09:17:49 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Forwarded message:
> From: "Kevin D. Kissell" <kevink@mips.com>
> To: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
> Subject: Linux and the Sony Playstation 2
> Date: Tue, 18 Jun 2002 15:59:57 +0200
> 
> The Sony PS2 Linux kit has been shipping for nearly
> a month now, and I'm frankly astonished at how little
> I've seen on this mailing list about it.  For better or
> for worse, this changes everything for MIPS/Linux.
> The number of MIPS/Linux users worldwide has
> just gone up by at least an order of magnitude,
> and they are on a platform running a 2.2.1-derived
> kernel and using gcc 2.95.2.
> 
> It's a perfectly usable platform out of the box, but
> Carsten has thrown "crashme" at it, and it goes down
> relatively quickly.  People trying to port kaffe and
> other programs that do double-precision float are
> blocked because there's no double precision on the
> R5900, and the Sony kernel lacks the Algorithmics
> emulator.

The few simple double-precision programs (ala hello world) I ran worked,
and the compiler substitutes integer code (softfloat) for any double
precision operation. What are the things known not to work?

> It's not clear what Sony is going to put into further
> development, and what they are going to expect the
> user community to take over from here.  There is a 
> group of people trying to take the kernel up to
> 2.2.20, but I'm not yet sure whether they know
> what they are doing, and anyway, that box needs
> to get to 2.4.x ASAP.

It would be great to get 2.4.x on PS/2, and if one doesn't run into 
glibc/kernel dependencies in the upgrade, it should be a reasonable amount
of work. The biggest benefit I see is that a 2.4.x upgrade with the emulator
would allow binary portability of userland using double prec floats.

But one thing which I really admire on the Sony release is the thoroughness
and completeness of their offering. The kernel has full support for the
additional T5900 SIMD state, all new instructions and state is supported
fully in toolchain: binutils, gdb, you name it. Everything in the kit works
(at least what I have tested).

Getting the kernel upgraded would be nice, but there is probably even
more work getting the toolchain, glibc and userland up to speed. There
are about  600 binary userland RPMs provided, which is also a ton of
work to keep updated.

One needs to be very careful that the individual "upgrade" pieces people
do doesn't break the overall nice picture of "everything works out of
the box". What is really needed is that somebody puts together a
productized PS/2 Linux kit version 2.0, which has the
kernel/glibc/toolchain/userland RPMs upgraded to recent versions. 

If somebody else volunteers for the rest, I'll do the kernel :-)
(One of us here here might do it anyway).

/Hartvig


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
