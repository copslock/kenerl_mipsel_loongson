Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 23:05:59 +0100 (BST)
Received: from ux1.dataflo.net ([IPv6:::ffff:207.252.248.16]:24325 "EHLO
	ux1.dataflo.net") by linux-mips.org with ESMTP id <S8225978AbUEMWF5> convert rfc822-to-8bit;
	Thu, 13 May 2004 23:05:57 +0100
Received: from server1.RightHand.righthandtech.com ([207.252.250.187])
	by ux1.dataflo.net (8.12.11/8.12.11) with ESMTP id i4DM5r5K079575
	for <linux-mips@linux-mips.org>; Thu, 13 May 2004 17:05:55 -0500 (CDT)
content-class: urn:content-classes:message
Subject: RE: problems on D-cache alias in 2.4.22
Date: Thu, 13 May 2004 17:05:52 -0500
Message-ID: <B482D8AA59BF244F99AFE7520D74BF9609D4B1@server1.RightHand.righthandtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems on D-cache alias in 2.4.22
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Index: AcQ5NnTrK9jtHiAwTiu//MgHM8HyDA==
From: "Bob Breuer" <bbreuer@righthandtech.com>
To: <linux-mips@linux-mips.org>
Return-Path: <bbreuer@righthandtech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbreuer@righthandtech.com
Precedence: bulk
X-list: linux-mips


> -----Original Message-----
> Date: Thu, 13 May 2004 14:52:53 +0800
> From: wuming <wuming@ict.ac.cn>
> Subject: problems on D-cache alias in 2.4.22
> 
>  I am developing in linux-2.4.22 on the machine with virtual address
> indexed and physical
> address tagged. But when I compile some application programs, 
> I met the
> following error:
> 
> cc1: internal compiler error: Segmentation fault
> 
> I have searched about this error from internet, it's due to some
> hardware fault or
> a wrong pte fault handler. Because my machine have D-cache 
> aliasing, so
> I think
> this error should be due to a wrong pte fault handler. After 
> my painful
> kernel hacking,
> I found some strange problems and it's in function __update_cache( ):
> 
> void __update_cache(struct vm_area_struct *vma, unsigned long address,
> pte_t pte)
> {
> unsigned long addr;
> struct page *page;
> 
> if (!cpu_has_dc_aliases)
> return;
> 
> page = pte_page(pte);
> 
> /*This printk is added by myself*/
> printk("<1>valid page:%d\tpage mapping:0x%p\tpage flags:%d\n",\
> VALID_PAGE(page), page->mapping, (page->flags & (1UL << 
> PG_dcache_dirty)));
> 
> if (VALID_PAGE(page) && page->mapping &&
> (page->flags & (1UL << PG_dcache_dirty))) {
> if (pages_do_alias((unsigned long) page_address(page), address &
> PAGE_MASK)) {
> addr = (unsigned long) page_address(page);
> flush_data_cache_page(addr);
> }
> ClearPageDcacheDirty(page);
> }
> }
> 
> When my kernel is running, I found the condition "page->mapping" and
> "(page->flags & (1UL << PG_dcache_dirty))"
> will never be true at the same time. so the function
> flush_data_cache_page( ) will never be called.
> Then I commented the two condition, the compiler error disappeared.
> I do not understand the phenomenon very clearly, so I need some help.
> 
> 

I am having a similar problem with 2.4.26 on an NEC VR5500 with a 32k
2-way cache.  This is with a 32 bit little-endian kernel, and an ext2
filesystem on an ide hard drive in pio mode.

Removing just the check for PG_dcache_dirty fixes the problem for me.

Along the way, I found a bogus check for cache aliases in c-r4k.c.  In
the ld_mmu_r4xx0 function, it has the check:
    if (c->dcache.sets * c->dcache.ways > PAGE_SIZE)
which will never work for a 32k cache.

Bob Breuer
