Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PGecT02143
	for linux-mips-outgoing; Mon, 25 Jun 2001 09:40:38 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PGebV02140
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 09:40:37 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5PGeV021424;
	Mon, 25 Jun 2001 09:40:31 -0700
Message-ID: <3B3768F0.19D7A773@mvista.com>
Date: Mon, 25 Jun 2001 09:38:08 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3B34BE3B.B72D40F1@mvista.com> <01ee01c0fc08$66e81e80$0deca8c0@Ulysses> <3B34D6AC.9EACA819@mvista.com> <020c01c0fc21$51256760$0deca8c0@Ulysses> <20010624214232.A18389@mvista.com> <001f01c0fd43$3865b680$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > > > > Since the kernel cache attribute is never initialized before
> > > > > ld_mmu_{whatever} is invoked, and since that Config field
> > > > > does not have a well-defined reset state on many MIPS
> > > > > CPUs, it would appear that we are in effect trusting the
> > > > > bootloader to have done something reasonable like
> > > > > set kseg0 to be non-cachable or write-through, either
> > > > > of which would be safe for the current code.
> > > >
> > > > I think you just proposed a fix: check current config register
> > > > when we turn off cache.  Thanks. :-)
> > >
> > > That's a heuristic at best.  If the config register comes up random,
> > > it can appear to be sane even though the cache is in fact uninitialized.
> > >
> >
> > For any practical reasons, we can assume there is a loader for Linux,
> > and we can assume loader does not run with a random config register.
> 
> That's a position that would sound reasonable to someone working
> on Linux for legacy DEC/SGI systems, but not one that I would
> expect to satisfy someone working on embedded Linux.  It would
> need to be governed by a config option, but I would think
> that ultimately we need to have a Linux that can be ROMed
> and branched to directly from the reset vector.  Why force
> everyone doing an embedded MIPS/Linux widget to re-invent
> the wheel?
> 

The currenct common practice in embedded world is:

1. during development stage, using a loader to download kernel to target.

2. during productization stage, use a separate rom loader to cold-start the
board and load the kernel from flash to RAM, assuming the kernel is on flash.

There are a couple of other vairants, but generally you do have a first stage
loader that will set up the environment right for Linux kernel.

Cold-starting a board and loading a kernel is highly board and system
specific.  Does not seem to make sense to get included in the kernel
structure.

Jun
