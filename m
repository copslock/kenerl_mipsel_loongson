Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 22:13:15 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:49670 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225240AbTBGWNP>;
	Fri, 7 Feb 2003 22:13:15 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id 9BBA440F0C; Fri,  7 Feb 2003 23:13:12 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18hGkI-0005PJ-00; Fri, 07 Feb 2003 23:13:18 +0100
Date: Fri, 7 Feb 2003 23:13:16 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] clear USEDFPU in copy_thread
In-Reply-To: <20030207104621.L13258@mvista.com>
Message-ID: <Pine.LNX.4.21.0302072257520.18717-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

> On Thu, Feb 06, 2003 at 04:43:42PM -0800, Jun Sun wrote:
> > I am still curious whether this is a bug in i386 as well or they do
> > clear the flag in some non-obvious way.  Note that the unlazy_fpu()
> > in copy_thread won't do it.  It only clears the current process's
> > USEDFPU flag, while the child process's flag is set way back in
> > copy_flags() calls inside do_fork().
> >

Well, I'm not an expert of linux/x86 at all, and this is a bit off
topic :), but look at the comment in arch/i386/process.c:408:
 * We fsave/fwait so that an exception goes off at the right time
 * (as a call from the fsave or fwait in effect) rather than to
 * the wrong process. Lazy FP saving no longer makes any sense
 * with modern CPU's, and this simplifies a lot of things (SMP
 * and UP become the same).

It seems they're just calling unlazy_fpu to do a fsave/fwait to
synchronize the FPU so that if an exception happens in the FPU code of a
process, the current process is signalled and not some newly scheduled
process instead. I think they do the same thing when cloning; put a
barrier to current process FPU operations so that it gets the signal, not
its child, if something is wrong in the previously executed FPU
instructions. Whether TIF_USEDFPU is set or cleared in the child isn't
really relevant in fact, it is maybe slightly inefficient because on
the first context switch of the child, an unnecessary fsave/fwait will be
done, but it doesn't hurt.

Vivien.
