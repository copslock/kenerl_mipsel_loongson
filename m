Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Dec 2003 01:41:41 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:42148 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225446AbTLNBlk>;
	Sun, 14 Dec 2003 01:41:40 +0000
Received: from localhost (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id hBE1fHZ29076;
	Sat, 13 Dec 2003 17:41:19 -0800
Date: Sat, 13 Dec 2003 17:41:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
In-Reply-To: <20031213222626.GA20153@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <torvalds@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@osdl.org
Precedence: bulk
X-list: linux-mips



On Sat, 13 Dec 2003, Jamie Lokier wrote:
>
> Peter Horton wrote:
> > A quick look at sparc and sparc64 seem to show the same problem.
>
> D-cache incoherence with unsuitably aligned multiple MAP_FIXED
> mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
> have the same behaviour on those platforms: allowing a mapping that
> should not be allowed.

Why?

If the user asks for it, it's the users own damn fault. Nobody guarantees
cache coherency to users who require fixed addresses.

Just document it as a bug in the user program if this causes problems.
Don't blame the kernel - the kernel is only doing what the user asked it
to do.

		Linus
