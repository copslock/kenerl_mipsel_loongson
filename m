Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Dec 2003 18:05:10 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:32706 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225451AbTLNSFK>;
	Sun, 14 Dec 2003 18:05:10 +0000
Received: from localhost (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id hBEI53Z32492;
	Sun, 14 Dec 2003 10:05:03 -0800
Date: Sun, 14 Dec 2003 10:05:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Horton <pdh@colonel-panic.org>
cc: Jamie Lokier <jamie@shareable.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
In-Reply-To: <20031214103803.GA916@skeleton-jack>
Message-ID: <Pine.LNX.4.58.0312141001090.14336@home.osdl.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org>
 <Pine.LNX.4.58.0312131740120.14336@home.osdl.org> <20031214103803.GA916@skeleton-jack>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <torvalds@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@osdl.org
Precedence: bulk
X-list: linux-mips



On Sun, 14 Dec 2003, Peter Horton wrote:
> >
> > Just document it as a bug in the user program if this causes problems.
> > Don't blame the kernel - the kernel is only doing what the user asked it
> > to do.
>
> I've seen code written for X86 use MAP_FIXED to create self wrapping
> ring buffers. Surely it's better to fail the mmap() on other archs
> rather than for the code to fail in unexpected ways?

Yes and no.

In _that_ case it would clearly be polite to just fail the mmap(). No
question about that - it's always nice if the kernel can find problems
early rather than late.

However, there are other ways you can screw yourself in user space, and
I'm not convinced it is always wrong to create a unaligned shared mapping.
For example, I can see that being useful exactly because you want to write
some CPU test in user space, for example.

So I'm generally opposed to the kernel saying "you can't do that" if there
isn't some really fundamental reason (security or stability) for it to be
really a no-no. It's often better to give the user rope to hang himself:
that rope might be used for interesting things too.

> It's a bug either way ... either the test should be fixed up or it
> should be removed from arch_get_unmapped_area() to save confusion.

I agree that we might as well remove it, but it's not 2.6.x material.

		Linus
