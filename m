Received:  by oss.sgi.com id <S305166AbPLFP66>;
	Mon, 6 Dec 1999 07:58:58 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15424 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLFP6m>; Mon, 6 Dec 1999 07:58:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA09239; Mon, 6 Dec 1999 08:07:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA00751
	for linux-list;
	Mon, 6 Dec 1999 07:52:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA46668
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 07:52:21 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08011
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 07:52:16 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA08825
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 07:52:14 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA02360
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 07:52:13 -0800 (PST)
Message-ID: <00b901bf4003$3f583c50$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Kernel Semaphores
Date:   Mon, 6 Dec 1999 17:02:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This is for Ralf and any other MIPS/Linux kernel
hackers who may be on the list.

Some time ago, I fixed the assembler macros
for waking_non_zero_interruptable and down_trylock
to be correct(ish) for MIPSEL and MIPSEB, but
there remained the issue of their requiring the use
of 64-bit instructions to work - they "cheat" by using
the same ll/sc pair to update both the count and the
waking field of the semaphore.

To make it work on 32-bit CPUs, I looked at using
the x386 model, but that one uses interrupt disables
and is intrinsically SMP-unsafe.  Now, looking at 
the comments and studying the code a bit,
it *seems* that the issue is not so much a race
condition between updates of the waking and
count fields, but a race with other functions that
may be updating the waking field.   CAN ANYONE
CONFIRM OR DENY THAT?

If it's true, it looks to me that by inventing one
new primitive in atomic.h, atomic_sub_and_return_if_gtz(),
one can:

    a) Eliminate the need for an assembly macro dedicated
        to waking_non_zero, which maps directly to the new macro.
    b) Make it possible to do waking_non_zero_interruptible in
        C, as all the examinations/updates of sem->waking can
        be made atomic
    c) Likewise simplify down_trylock() and
    d) Make waking_non_zero_trylock() SMP safe.

I've coded this up for experimentation, and will provide
the sources (at least relative to 2.2.12) to any interested
parties, but I'd really like someone who has worked
intimately with the kernel semaphores to tell me if
there really are races between updates of sem->waking
and sem->count, and if they exist, what they are!
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
