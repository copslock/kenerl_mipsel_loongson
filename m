Received:  by oss.sgi.com id <S305170AbQDQX77>;
	Mon, 17 Apr 2000 16:59:59 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:65037 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbQDQX7b>; Mon, 17 Apr 2000 16:59:31 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA09888; Mon, 17 Apr 2000 17:03:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA63743
	for linux-list;
	Mon, 17 Apr 2000 16:46:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA42007
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 16:46:40 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405571AbQDQXnd>;
	Mon, 17 Apr 2000 16:43:33 -0700
Date:   Mon, 17 Apr 2000 16:43:33 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Mike Klar <mfklar@ponymail.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: Unaligned address handling, and the cause of that login problem
Message-ID: <20000417164333.B3123@uni-koblenz.de>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com>; from mfklar@ponymail.com on Sun, Apr 16, 2000 at 03:19:01PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 16, 2000 at 03:19:01PM -0700, Mike Klar wrote:

> While tracking down a random memory corruption bug, I stumbled across the
> cause of that telnet/ssh problem in recent kernels reported about a month
> ago:
> 
> The version of down_trylock() for CPUs with support LL/SC assumes that
> struct semaphore is 64-bit aligned, since it accesses count and waking as a
> single dualword (with lld/scd).  Nothing in struct semaphore guarantees this
> alignment, and in fact, struct tty_struct has a struct semaphore that is not
> 64-bit aligned.  Depending on how a tty is used (I think it's a non-blocking
> read that triggers the problem, in drivers/char/n_tty.c), the kernel will
> attempt an unaligned lld, it will cause an address error, and the handler in
> arch/mips/kernel/unaligned.c will kill current with SIGBUS (since lld/scd
> cannot be properly simulated).
> 
> The quick-and-dirty workaround is to put 32 bits of padding before the
> atomic_read member of struct tty_struct.  Of course, that doesn't fix the
> real problem, and there may well be other non-64-bit aligned struct
> semaphore's out there.  A proper fix would be to either hack up struct
> semaphore to guarantee dualword alignment, or rework the was down_trylock
> does its thing.

I'll put __attribute__ ((aligned(64))) to the structure which will fix this.
This will have to be changed again when we add support for 32-bit processors
with ll / sc instructions but for now we don't support them, so it's the
right thing.

> While I'm on the topic of unaligned handling, this behavior of sending
> SIGBUS, SIGSEGV, or SIGILL to current on unaligned accesses seems to me like
> incorrect behavior if the original fault happened in kernel mode.

> The above
> example of an unaligned lld sending SIGBUS is not too bad, since the fault
> does happen while doing something on behalf of the current process.

The assumption is that the kernel should never ever use ll, lld, sc and scd
on improperly aligned memory objects, so not checking is ok.  In other
words it's it's perfectly ok if the kernel dies or behaves silly following
such a can-not-happen case.

Note that while we don't attemt to handle missaligned ll/sc/lld/scd
instructions because that would break atomicity on SMP machines.  On the
other side again emulating them on CPUs that don't have them at all like
the R3000 is ok because those are not used on SMP systems.  That is not
counting the oddball SMP systems which we'll probably not support ever.

  Ralf
