Received:  by oss.sgi.com id <S305166AbPLFT1z>;
	Mon, 6 Dec 1999 11:27:55 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29531 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLFT1u>; Mon, 6 Dec 1999 11:27:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA03370; Mon, 6 Dec 1999 11:36:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA71434
	for linux-list;
	Mon, 6 Dec 1999 11:25:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA71214
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 11:24:59 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08484
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 11:18:50 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFTIc>;
	Mon, 6 Dec 1999 17:08:32 -0200
Date:   Mon, 6 Dec 1999 17:08:32 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Kernel Semaphores
Message-ID: <19991206170831.A15350@uni-koblenz.de>
References: <00b901bf4003$3f583c50$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <00b901bf4003$3f583c50$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 05:02:06PM +0100, Kevin D. Kissell wrote:

> Some time ago, I fixed the assembler macros
> for waking_non_zero_interruptable and down_trylock
> to be correct(ish) for MIPSEL and MIPSEB, but
> there remained the issue of their requiring the use
> of 64-bit instructions to work - they "cheat" by using
> the same ll/sc pair to update both the count and the
> waking field of the semaphore.

Btw, we have two variants for all the semaphore code as you know.  We
can eleminate the little endian variant by just swapping the order of
the two atomic_t members in struct semaphore which will eleminate the
maintenance problems.

> To make it work on 32-bit CPUs, I looked at using
> the x386 model, but that one uses interrupt disables
> and is intrinsically SMP-unsafe.

semaphore-helper.h uses spin_lock_irqsave which is smp-safe.  The way
we do things for 64-bit MIPS is just more performant.

  Ralf
