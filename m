Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 18:38:39 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:8576 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225439AbTLMSii>; Sat, 13 Dec 2003 18:38:38 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AVEeu-0003Er-00; Sat, 13 Dec 2003 18:38:32 +0000
Date: Sat, 13 Dec 2003 18:38:32 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <phorton@bitbox.co.uk>, linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2 - area of problem
Message-ID: <20031213183832.GA12439@skeleton-jack>
References: <3FD99C34.9090001@bitbox.co.uk> <20031213170751.GB13271@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213170751.GB13271@linux-mips.org>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 13, 2003 at 06:07:51PM +0100, Ralf Baechle wrote:
> On Fri, Dec 12, 2003 at 10:45:08AM +0000, Peter Horton wrote:
> 
> > More info on the random segmentation faults and data corruption on my Qube2.
> > 
> > 2.4.21 from CVS is the first kernel to exhibit the problem. I tracked it 
> > down to the cache handling changes that went in between 2.4.20 and 2.4.21.
> > 
> > By (not very scientifically) removing flush_dcache_page() and 
> > re-instating flush_page_to_ram() I managed to get the 2.4.21 kernel 
> > stable (see attached patch). Applying a similiar patch to 2.4.23 (CVS 
> > HEAD) allows me to run 2.4.23 too.
> > 
> > I don't know how to track the problem any further - the kernel's cache 
> > handling is a bit out of my league.
> > 
> > Anyone got a clue stick they can point me in the right direction with ?
> 
> Can you put a printk into c-r4k.c and print the value of the
> shm_align_mask variable?  I want to make sure it's got a sane value on
> your box.  Also the first few lines of your bootup messages with the
> processor and cache stuff would be useful.
> 

I've just tried changing pages_do_alias() to always return non-zero. The
resulting kernel is still unstable - segmentation faults when loading
shared libraries, signal 11 when compiling etc.

P.
