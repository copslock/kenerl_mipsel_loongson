Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5P4ix619425
	for linux-mips-outgoing; Sun, 24 Jun 2001 21:44:59 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5P4iwV19422
	for <linux-mips@oss.sgi.com>; Sun, 24 Jun 2001 21:44:59 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id VAA18399;
	Sun, 24 Jun 2001 21:42:32 -0700
Date: Sun, 24 Jun 2001 21:42:32 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
Message-ID: <20010624214232.A18389@mvista.com>
References: <3B34BE3B.B72D40F1@mvista.com> <01ee01c0fc08$66e81e80$0deca8c0@Ulysses> <3B34D6AC.9EACA819@mvista.com> <020c01c0fc21$51256760$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <020c01c0fc21$51256760$0deca8c0@Ulysses>; from kevink@mips.com on Sat, Jun 23, 2001 at 10:15:49PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 23, 2001 at 10:15:49PM +0200, Kevin D. Kissell wrote:
> > > Since the kernel cache attribute is never initialized before
> > > ld_mmu_{whatever} is invoked, and since that Config field
> > > does not have a well-defined reset state on many MIPS
> > > CPUs, it would appear that we are in effect trusting the
> > > bootloader to have done something reasonable like
> > > set kseg0 to be non-cachable or write-through, either
> > > of which would be safe for the current code.
> >
> > I think you just proposed a fix: check current config register when we
> turn
> > off cache.  Thanks. :-)
> 
> That's a heuristic at best.  If the config register comes up random,
> it can appear to be sane even though the cache is in fact uninitialized.
> 

For any practical reasons, we can assume there is a loader for Linux,
and we can assume loader does not run with a random config register.

Jun
