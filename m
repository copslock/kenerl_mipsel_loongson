Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 23:37:00 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:56263 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225446AbUANXg7>;
	Wed, 14 Jan 2004 23:36:59 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0ENatkp019865;
	Wed, 14 Jan 2004 15:36:55 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0ENas9u007219;
	Wed, 14 Jan 2004 15:36:54 -0800 (PST)
Date: Wed, 14 Jan 2004 15:36:54 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@linux-mips.org
Subject: Re: ptrace induced instruction cache bug?
In-Reply-To: <20040113205858.GA17260@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0401141441370.1969-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

> On Tue, Jan 13, 2004 at 10:35:04AM -0800, Nathan Field wrote:
> > > It sounds reasonable.  I've encountered this problem in the past also,
> > > but never with the Pro 2.1 / MIPS release which is what you're using.  
> > > I don't see anything obviously wrong with your test code, either.
> > 	So... is there a fix for this?
> 
> Usually a missing cache flush, as you surmised :)  But I don't know of
> any that were missing in that version.
	So I looked into this and found that in ptrace.c:access_process_vm 
if I added a (obviously inefficient) flush_cache_all() into:

		if (write) {
			memcpy(maddr + offset, buf, bytes);
#ifdef CONFIG_SUPERH
			flush_dcache_page(page);
#endif
			flush_page_to_ram(page);
			flush_icache_page(vma, page);
			/* [ndf] I know this is not efficient, but it 
			 * makes it work. */
+++			flush_cache_all();
		} else {
			memcpy(buf, maddr + offset, bytes);
			flush_page_to_ram(page);
		}

then my ptrace test suite works. Looking at the status of the cache with 
my debugger while I step over various lines I see the entry for my address 
in the data cache in set 8, way 2. I step over flush_page_to_ram and it's 
still there. When I step over my call to flush_cache_all I see that the 
entry has moved to set 8, way 3. Unfortunatly there doesn't seem to be a 
"dirty" bit in the cache status bits, so I can't prove what's going wrong 
by looking at the contents of the data cache as I step over the various 
cache flushing functions. I'd guess that the address that I want flushed 
moving around when I call flush_cache_all indicates that it really is 
being flushed (and then filled again by a later memory access), but I 
don't know the details of how the data cache is supposed to operate.

	Anyway, I'd guess that flush_page_to_ram ->
mips32_flush_page_to_ram_pc -> blast_dcache_page doesn't work on the MIPS
Malta board. Given how frequently it seems to be used that seems unlikely. 
At this point the board does what I want it to for my testing purposes, 
but something isn't quite right.

	nathan

> 
> > > Yes, you will need a newer toolchain.  Honestly, I'm baffled as to why a
> > > Pro 2.1 toolchain was available from our web site at all, unless you got
> > > it via an old product subscription... it should have been Pro 3.0, which
> > > uses GCC 3.2 and a more recent binutils.  But I don't have any control
> > > over these things :)
> > 	I downloaded it about 5 days ago from:
> > http://www.mvista.com/previewkit/index.html
> > 
> > Could I get a preview kit of your 3.0 release for a Malta 4Kc board?
> 
> Let me inquire as to why we're distributing old ones.
> 
> 

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
