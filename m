Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jun 2004 00:31:37 +0100 (BST)
Received: from p508B6ABC.dip.t-dialin.net ([IPv6:::ffff:80.139.106.188]:2633
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225796AbUFXXbc>; Fri, 25 Jun 2004 00:31:32 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5ONVV8d016199;
	Fri, 25 Jun 2004 01:31:31 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5ONVUYh016198;
	Fri, 25 Jun 2004 01:31:30 +0200
Date: Fri, 25 Jun 2004 01:31:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yaron Presente <ypresente@mrv.com>
Cc: linux-mips@linux-mips.org
Subject: Re: non-contiguous physical memory
Message-ID: <20040624233130.GA15158@linux-mips.org>
References: <40DACD33.60801@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DACD33.60801@mrv.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 24, 2004 at 03:46:43PM +0300, Yaron Presente wrote:

> I'm running montavista linux (2.4.18_mvl30-malta-mips_fp_le) on a board 
> that has 2 memory banks of physical memory.
> 1. 32MB from physical address 0x00000000
> 2. 16MB from physical address 0x20000000
> 
> Currently I can only access the first bank (by add_memory_region(0, 32 
> << 20, BOOT_MEM_RAM) in prom_init() ).
> I tried the obvious solution of adding another region at 0x20000000 
> (add_memory_region(0x20000000, 16 << 20, BOOT_MEM_RAM))
> but that didn't seem to work. I've also tried to add a BOOT_MEM_RESERVED 
> region in between the regions in order to create a seemingly contiguous 
> memory, with no success.
> My questions are:
> Is it possible to access the second bank as well under MIPS ?
> Is there a way to define a "hole" in the physical memory?
> Do I have to use CONFIG_DISCONTIGMEM ? is it fully supported ?
> Thanks for your help,

Your initial approach was nearly right - you can solve the problem of
holes in the memory map as long as they're small enough by only adding
the available regions with add_memory_region().  Typically uses for
this are small holes due to memory in use by firmware, for example.

Now, in your case the whole isn't small.  In fact, with 480MB it's big ;-)
What Linux will try to do is to allocate the mem_map array for the
entire memory range from 0x0 - 0x21000000, that's 528MB.  mem_map contains
one page per 4k page; each entry is 64 bytes in size for 32-bit kernels
so that makes a total size for mem_map[] of 8.25MB of which just 768kB are
actually being used.

Just to make life a little bit more misserable memory 32-bit kernels can
only use memory above the 512MB boundary as highmem.

CONFIG_DISCONTIGMEM can solve this problem - but Linux/MIPS really doesn't
much an attempt to make that easy to use.  Right now only a single MIPS
system is using CONFIG_DISCONTIGMEM and that system is using it in
combination with CONFIG_NUMA which is quite an additional complication.

With CONFIG_DISCONTIGMEM there will be no more mem_map[] array. Instead
there will be one such array for each memory region which means you'll
loose a bit of performance due to additional complexity but you'll save
all the wasted memory.

  Ralf
