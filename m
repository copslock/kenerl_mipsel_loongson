Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64DreRw007277
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 06:53:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64DreTu007276
	for linux-mips-outgoing; Thu, 4 Jul 2002 06:53:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.28.100] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64DrURw007267
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 06:53:32 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64DvQc28363;
	Thu, 4 Jul 2002 15:57:26 +0200
Date: Thu, 4 Jul 2002 15:57:26 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020704155726.A28268@dea.linux-mips.net>
References: <20020702114045.A16197@lucon.org> <20020702220651.B9566@dea.linux-mips.net> <00d401c22337$7e731580$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00d401c22337$7e731580$10eca8c0@grendel>; from kevink@mips.com on Thu, Jul 04, 2002 at 10:47:41AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-1.8 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED,PORN_12,PORN_3,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 10:47:41AM +0200, Kevin D. Kissell wrote:

> The R5900 kernel for the Playstation 2 does not use system
> calls.  It uses a memory-mapped pseudo-device hack that
> the guys at Sony came up with, which is much faster.  We
> at MIPS came up with an even faster hack which uses 
> the destruction of a "k" register value, but which requires 
> the branch-likely instruction and thus only workson 
> MIPS II CPUs and above (R39xxx, R4xxx, R5xxx,
> but not the classic R3K).  See my message
> "Re: patches for test-and-set without ll/sc" of January 22.
> 
> I consider it to be very important for MIPS/Linux
> that the embedded/workstation kernel and libraries
> merge with the Playstation 2 "consumer" Linux, and
> I don't think that will happen if we try to push the
> PS2 people to use something far less efficient than
> what they already have. "Entia non sunt multiplicanda 
> praeter necessitatem", as a wise old guy once said,
> but could we not consider a MIPS/Linux universe
> where R3000 binaries use system calls, non-LL/SC
> MIPSII+ binaries use k-register destruction, real,
> manly, MIPS binaries use LL/SC instructions, and
> where the MIPS/Linux kernel (a) supports an appropriate
> system call, (b) makes a contract with userland to 
> destroy k-regs predictably, and (c) contains the
> emulation logic for LL/SC?  That should give us
> full cross-platform binary compatibility, with optimal
> performance on each platform when an appropriately
> configured set of libraries and tools is installed.

No, Sony's ABI isn't MP proof and will break silently on MP systems.  As
such I can't consider it anything else but a hack.  sysmips(MIPS_ATOMIC_SET,
...) and ll/sc however are MP proof.

  Ralf
