Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 14:56:47 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:24340
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225272AbULOO4m>; Wed, 15 Dec 2004 14:56:42 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFEuRrL030051;
	Wed, 15 Dec 2004 15:56:27 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFEuH3g030050;
	Wed, 15 Dec 2004 15:56:17 +0100
Date: Wed, 15 Dec 2004 15:56:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Starzewski <mstarzewski@xes-inc.com>
Cc: linux-mips@linux-mips.org, Steve.Finney@SpirentCom.COM
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode, revisited
Message-ID: <20041215145617.GF29222@linux-mips.org>
References: <062301c4de41$5bf43cb0$0d00340a@matts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062301c4de41$5bf43cb0$0d00340a@matts>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 09, 2004 at 04:49:35PM -0600, Matthew Starzewski wrote:

> I've tried to enable HIGHMEM to access all 512MB of
> SDRAM on a BCM1125 based board as per this previous
> thread:
> 
> Using more than 256 MB of memory on SB1250 in 32-bit mode :
> http://www.spinics.net/lists/mips/msg14396.html
> BCM1125 Board: XPedite3000 PrPMC
> http://www.xes-inc.com/Products/XPedite/XPedite3000/XPedite3000.html
> 
> In MIPS32 mode, the memory map comes out to the following:
> 
> Physical Memory Map:
> 0x00000000 - 0x0FFFFFFF   256MB
> 0x80000000 - 0x8FFFFFFF   256MB
> Virtual Memory Map:
> 0x80000000 - 0x8FFFFFFF   256MB
> <<<< INACCESSIBLE >>>> 256MB
> 
> My goal in enabling HIGHMEM was to get at the upper 256MB
> much as described here.  Access to the upper 256MB through
> HIGHMEM may incur a performance hit, but it's certainly better
> going without.
> 
> http://home.earthlink.net/~jknapka/linux-mm/vminit.html#PAGING_INIT
> 
> However, what I get is a stall as per the log pasted below.  Enabling
> CONFIG_64BIT_PHYS_ADDR does not make a difference.  Results
> were cross-verified between CFE and another bootloader.

You need that if you want to address more than 1GB of memory on a BCM1250.

> When I hand the physical memory described above off to add_memory_region,
> I noticed a few odd things. One thing that looks suspicious is that the variable
> void *high_memory ends up being set to 0xa0000000, or right at KSEG1,
> in mm/init.c.
> 
> Also, num_physpages became huge, 0x90000, because the init code in
> kernel/setup.c and mm/init.c want a page for every memory location, even
> highmem.  Is this appropriate when the memory is not directly accessible
> via __va and virt_to_phys?  

You mean a struct page, not a page, I assume.  Yes, that's correct and
means that mem_map[] is a huge memory consumer in particular on systems
such as BCM1250 where RAM was scattered over the address space with a
shotgun.

The critical point would be where mem_map[] fills up the entire low-mem
which at 64 bytes per struct page and 256MB low-mem would happen at
4194304 pages or 16GB total memory at a page size at 4kB page size.
That's a suprenum, so guaranteed to not be exceeded ;-)  In reality
for reasonable performance a 1:4 ratio between lowmem and highmem should
not be exceeded.

What aggrevates the situation without CONFIG_DISCONTIG on the BCM1250 is
the large gap in it's address space from 0x10000000 - 0x8000000, that's
1.75GB which will eat 28MB of lowmem for mem_map - for nothing.  That's
not lethal but certainly deserves optimization.

> Let me know what you think of this issue.  In anticipation of the
> "Why not use MIPS64 build?" question, we'd prefer to and will, but the 
> MIPS64 build has underperformed or had bugs (SATA seek time,

Why would SATA seek times have any relation to the underlying kernel ...

> networking signals, etc) that MIPS32 doesn't.  For these issues
> or any case where the MIPS64 build isn't there yet, it makes
> sense to have the MIPS32 path open.

You could try to map some memory to CKSEG2/3 at the price of reducing the
amount of address space available, see also the current thread with
subject "HIGHMEM".  That approach will only work well upto 1GB RAM on
the BCM1250.  At that point you'll run into the limit of it's 32-bit
PCI bus, so will have to deal with bounce buffers or make use of it's
somewhat limited I/O MMU.

  Ralf
