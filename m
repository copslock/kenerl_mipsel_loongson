Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5NHptR32428
	for linux-mips-outgoing; Sat, 23 Jun 2001 10:51:55 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5NHpsV32424
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 10:51:54 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5NHpl025549;
	Sat, 23 Jun 2001 10:51:47 -0700
Message-ID: <3B34D6AC.9EACA819@mvista.com>
Date: Sat, 23 Jun 2001 10:49:32 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3B34BE3B.B72D40F1@mvista.com> <01ee01c0fc08$66e81e80$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > I looked at the code and it appears this config may not work properly.
> >
> > My understanding is that if CPU has been running with cache enabled, and,
> > presummably, have many dirty cache entries, and if you suddenly change
> config
> > register to run kernel uncached, you *don't* get all the dirty cache lines
> > flushed into memory.  Therefore, you will be accessing stale data in
> memory.
> >
> > Is this right?  If so, we need a better way to run CPU uncached.
> >
> > In the past, I have been a private patch to do so.  It seems pretty
> difficult
> > to come up a generic, because we want to figure out the CPU type and
> disable
> > cache *before* kernel starts to modify any memory content.
> 
> Since the kernel cache attribute is never initialized before
> ld_mmu_{whatever} is invoked, and since that Config field
> does not have a well-defined reset state on many MIPS
> CPUs, it would appear that we are in effect trusting the
> bootloader to have done something reasonable like
> set kseg0 to be non-cachable or write-through, either
> of which would be safe for the current code. 

I think you just proposed a fix: check current config register when we turn
off cache.  Thanks. :-)

Jun
