Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2004 20:59:14 +0100 (BST)
Received: from p508B778C.dip.t-dialin.net ([IPv6:::ffff:80.139.119.140]:40978
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225254AbUI3T7J>; Thu, 30 Sep 2004 20:59:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8UJx5MC013148;
	Thu, 30 Sep 2004 21:59:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8UJx32g013147;
	Thu, 30 Sep 2004 21:59:03 +0200
Date: Thu, 30 Sep 2004 21:59:03 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	mentre@tcl.ite.mee.com
Subject: Re: How to handle a specific DMA configuration ?
Message-ID: <20040930195903.GB4368@linux-mips.org>
References: <20040928100831.GI27756@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928100831.GI27756@enix.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 28, 2004 at 12:08:31PM +0200, Thomas Petazzoni wrote:

> My physical memory mapping is a bit special : I have 384 MB of
> memory. The first 256MB are directly connected to the RM9000, while
> the last 128MB are connected to the Marvell controller. _Only_ the
> last 128MB are usable for DMA (especially for network traffic). For
> the moment, Linux only takes care of the first 256MB, but I can change
> it to take care of the complete physical memory space (384 MB).
> 
> My problem is the allocation of skbuff. They are allocated using
> alloc_skb() in net/core/skbuff.c, and uses the "normal" kmalloc()
> allocator. kmalloc() will allocate memory somewhere in the physical
> memory space : even if a I allow Linux to allocate memory between
> 256MB and 384MB, I cannot be sure that it will use memory in this
> space to allocate skbuff. If skbuff are not allocated in this space,
> then I can't use DMA to transfer the buffers.
> 
> As I understand the ZONE_DMA thing, it allows to tell Linux that a
> physical memory region located between 0 and some value (16 MB on PCs
> for old ISA cards compatibility) is the only area usable for DMA. How
> could I declare my 256MB-384MB physical memory reagion to be the only
> area usable for DMA ? How can I tell the skbuff functions to allocate
> _only_ DMA-able memory ?

ZONE_DMA has a system specific meaning.  On a PCI system ISA could always
be exist through a PCI-to-ISA bridge, so you can't just go and give it
a system specific meaning.  It's also needed for PCI devices with a
less than 32-bit DMA limit; those exist in a rich variety.

> Moreover, can I make assumptions on the
> alignement of final data at the bottom of the network stack (my DMA
> controller doesn't like the 2 byte-aligned things).

Well, if you put packets on an aligned address you'll later take a bunch
of missalignment exceptions which are going to severly impact networking
performance ...

> At the moment, I see only three solutions. The two first aren't not
> very satisfying, the third might be a solution, but not perfect
> neither (and not sure it would work).

Change the configuration of the board to put the MV memory at the bottom.
Leave ZONE_DMA what it used to be, < 16MB.  Set the ZONE_NORMAL limit to
128MB.  Anything above that is non-dmable will go into ZONE_HIGHMEM.
See also CONFIG_LIMITED_DMA in 2.6.  It works, it has little compatibility
problems but it's a solution for platform that simply doesn't reflect the
Linux hw architecture very much ...

  Ralf
