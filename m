Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 09:40:20 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:65061 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021424AbXCJJkP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 09:40:15 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.186])
	by mail1.pearl-online.net (Postfix) with ESMTP id E5AA5BA17;
	Sat, 10 Mar 2007 10:39:49 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2A9bTB3000658;
	Sat, 10 Mar 2007 10:37:30 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2A9afVF019014;
	Sat, 10 Mar 2007 10:36:41 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2A9afoQ019011;
	Sat, 10 Mar 2007 10:36:41 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 10 Mar 2007 10:36:40 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
 #2]
In-Reply-To: <116841864595-git-send-email-fbuihuu@gmail.com>
Message-ID: <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi,

i'm just trying to understand, what the "[PATCH 0,1,2/2] FLATMEM..." patchset
does.  While working through it, it appears to me that

1) Formerly min_low_pfn was never calculated, but left zero-initialized.

2) The patchset now provides proper min_low_pfn calculation from boot_mem_map
   (thanks !), and then discards this calculated value:
 a) Patch 1/2 prints an info about wasted pagetable-entries and resets
    min_low_pfn to zero, retaining the former state.
 b) (first part of) Patch 2/2 prints an info about differences between the
    the really found (boot_mem_map) and the expected (given by PHYS_OFFSET
    through ARCH_PFN_OFFSET) memory-offset, then resets min_low_pfn to
    ARCH_PFN_OFFSET.

3) Finally the (rather set than) calculated values are completely passed on
   to init_bootmem by replacing the former call (mm/bootmem.c)
       max_low_pfn = highest;
       min_low_pfn = mapstart;
       init_bootmem_core(NODE_DATA(0), mapstart, 0,           highest);
   with
       init_bootmem_core(NODE_DATA(0), mapstart, min_low_pfn, max_low_pfn);

Right ?

So far, i can't avoid the impression, that this patchset would work perfectly
without using PHYS_OFFSET at all, even better IMHO, since it would use the
*really* detected memory-offset instead of some should-be-value.  (Providing
an override-option for critical cases is another topic).


The second part of Patch 2/2 introduces PHYS_OFFSET to __pa/__va and to
virt_to_phys/phys_to_virt (writing "page_offset" shorthand for PAGE_OFFSET
and __pa_page_offset() here):

pa: address - page_offset + PHYS_OFFSET

va: address + page_offset - PHYS_OFFSET

1) Since the relation between kernel virtual address and physical address
   is fixed (we agreed about that earlier), introducing PHYS_OFFSET in this
   places is a nop at best: (page_offset - PHYS_OFFSET) is constant, whenever
   we introduce/change PHYS_OFFSET we must adjust page_offset accordingly
   (what's about CKSEG0 in __pa_page_offset() ?).

2) Because of 1) we get the same conversions, if we don't use PHYS_OFFSET
   anywhere.

3) The page_offset adjustment may force fixes in other, not yet blown up,
   places (pmd_phys() cried out lately...).

Hard to see, what we gain by introducing PHYS_OFFSET here.

What can PHYS_OFFSET achieve here - besides obfuscating ?
Are there future uses for it, that justify the contortions ?


with best regards

peter



On Wed, 10 Jan 2007, Franck Bui-Huu wrote:

> Date: Wed, 10 Jan 2007 09:44:03 +0100
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org
> Subject: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
>
> Ralf,
>
> Here's is the second attempt to make this works on your Malta board
> and all other boards that have some data reserved at the start of
> their memories. In these cases the first patchset assumed wrongly that
> the start of the memory was after this reserved area.
>
> Patch 1/2 should work alone now. the kernel should report that your
> mem config is wasting some memory for tracking reserved pages located
> at the start of the mem.
>
> Thanks for testing
>
> 		Franck
>
> ---
>
>  arch/mips/kernel/setup.c |   40 +++++++++++++++++++++++++++++++---------
>  arch/mips/mm/init.c      |   23 +++++++++++------------
>  include/asm-mips/dma.h   |    1 +
>  include/asm-mips/io.h    |    4 ++--
>  include/asm-mips/page.h  |   25 +++++++++++++++++++++----
>  5 files changed, 66 insertions(+), 27 deletions(-)
