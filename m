Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 00:07:40 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33524 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225272AbUAOAHk>;
	Thu, 15 Jan 2004 00:07:40 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0F07Tx16030;
	Wed, 14 Jan 2004 16:07:29 -0800
Date: Wed, 14 Jan 2004 16:07:29 -0800
From: Jun Sun <jsun@mvista.com>
To: Nathan Field <ndf@ghs.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: ptrace induced instruction cache bug?
Message-ID: <20040114160729.D13471@mvista.com>
References: <20040113205858.GA17260@nevyn.them.org> <Pine.LNX.4.44.0401141441370.1969-100000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0401141441370.1969-100000@zcar.ghs.com>; from ndf@ghs.com on Wed, Jan 14, 2004 at 03:36:54PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 14, 2004 at 03:36:54PM -0800, Nathan Field wrote:
> > On Tue, Jan 13, 2004 at 10:35:04AM -0800, Nathan Field wrote:
> > > > It sounds reasonable.  I've encountered this problem in the past also,
> > > > but never with the Pro 2.1 / MIPS release which is what you're using.  
> > > > I don't see anything obviously wrong with your test code, either.
> > > 	So... is there a fix for this?
> > 
> > Usually a missing cache flush, as you surmised :)  But I don't know of
> > any that were missing in that version.
> 	So I looked into this and found that in ptrace.c:access_process_vm 
> if I added a (obviously inefficient) flush_cache_all() into:
> 
> 		if (write) {
> 			memcpy(maddr + offset, buf, bytes);
> #ifdef CONFIG_SUPERH
> 			flush_dcache_page(page);
> #endif
> 			flush_page_to_ram(page);
> 			flush_icache_page(vma, page);
> 			/* [ndf] I know this is not efficient, but it 
> 			 * makes it work. */
> +++			flush_cache_all();
> 		} else {
> 			memcpy(buf, maddr + offset, bytes);
> 			flush_page_to_ram(page);
> 		}
> 
> then my ptrace test suite works. Looking at the status of the cache with 
> my debugger while I step over various lines I see the entry for my address 
> in the data cache in set 8, way 2. I step over flush_page_to_ram and it's 
> still there. When I step over my call to flush_cache_all I see that the 
> entry has moved to set 8, way 3. Unfortunatly there doesn't seem to be a 
> "dirty" bit in the cache status bits, so I can't prove what's going wrong 
> by looking at the contents of the data cache as I step over the various 
> cache flushing functions. I'd guess that the address that I want flushed 
> moving around when I call flush_cache_all indicates that it really is 
> being flushed (and then filled again by a later memory access), but I 
> don't know the details of how the data cache is supposed to operate.
> 
> 	Anyway, I'd guess that flush_page_to_ram ->
> mips32_flush_page_to_ram_pc -> blast_dcache_page doesn't work on the MIPS
> Malta board. Given how frequently it seems to be used that seems unlikely. 
> At this point the board does what I want it to for my testing purposes, 
> but something isn't quite right.
> 

There are too many things related to cache are wrong in 2.4.17.  For example,

. flush_page_indexed() is not right for multi-way cache
. when you map user pages into kernel, you are sufferring potential cache
  aliasing problem (BTW, we still suffer from this right now to a less degree)
. flush_page_to_ram() has a broken semantic, because it is not clear whether
  the area mapped into user virt spaces should be flushed or not
...

In short, it is not worth your time to fix old bugs.  Last time I checked
malta was working fine around 2.4.21.  It shouldn't be too hard to get
it working again in the latest 2.4 branch.

Jun
