Received:  by oss.sgi.com id <S305165AbQDPWg6>;
	Sun, 16 Apr 2000 15:36:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:58987 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQDPWgf>;
	Sun, 16 Apr 2000 15:36:35 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA10178; Sun, 16 Apr 2000 15:31:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA89222
	for linux-list;
	Sun, 16 Apr 2000 15:17:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA93829
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 16 Apr 2000 15:17:27 -0700 (PDT)
	mail_from (mfklar@ponymail.com)
Received: from short.adgrafix.com (short.adgrafix.com [63.79.128.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07833
	for <linux@cthulhu.engr.sgi.com>; Sun, 16 Apr 2000 15:17:26 -0700 (PDT)
	mail_from (mfklar@ponymail.com)
Received: from ppan2 (oak-ts1-h1-48-98.ispmodems.net [209.162.48.98])
	by short.adgrafix.com (8.9.3/8.9.3) with SMTP id SAA23063;
	Sun, 16 Apr 2000 18:13:51 -0400 (EDT)
From:   "Mike Klar" <mfklar@ponymail.com>
To:     <linux@cthulhu.engr.sgi.com>
Cc:     <linux-mips@fnet.fr>
Subject: Unaligned address handling, and the cause of that login problem
Date:   Sun, 16 Apr 2000 15:19:01 -0700
Message-ID: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

While tracking down a random memory corruption bug, I stumbled across the
cause of that telnet/ssh problem in recent kernels reported about a month
ago:

The version of down_trylock() for CPUs with support LL/SC assumes that
struct semaphore is 64-bit aligned, since it accesses count and waking as a
single dualword (with lld/scd).  Nothing in struct semaphore guarantees this
alignment, and in fact, struct tty_struct has a struct semaphore that is not
64-bit aligned.  Depending on how a tty is used (I think it's a non-blocking
read that triggers the problem, in drivers/char/n_tty.c), the kernel will
attempt an unaligned lld, it will cause an address error, and the handler in
arch/mips/kernel/unaligned.c will kill current with SIGBUS (since lld/scd
cannot be properly simulated).

The quick-and-dirty workaround is to put 32 bits of padding before the
atomic_read member of struct tty_struct.  Of course, that doesn't fix the
real problem, and there may well be other non-64-bit aligned struct
semaphore's out there.  A proper fix would be to either hack up struct
semaphore to guarantee dualword alignment, or rework the was down_trylock
does its thing.

While I'm on the topic of unaligned handling, this behavior of sending
SIGBUS, SIGSEGV, or SIGILL to current on unaligned accesses seems to me like
incorrect behavior if the original fault happened in kernel mode.  The above
example of an unaligned lld sending SIGBUS is not too bad, since the fault
does happen while doing something on behalf of the current process.
Consider this example, though:  If kernel code attempts an unaligned word
read to virtual address 0x00000001 (for example), the unaligned handler will
attempt to simulate with 2 aligned reads, which will fault, and since the
unaligned handler catches those faults, it will wind up sending SIGSEGV to
current.  I would think that condition should cause an oops, since that's
what an equivalent aligned access would do, and especially since the access
may have had nothing to do with current (it may happen from an interrupt,
for example).

Comments?

Mike Klar
Wyldfier Technology
