Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA210158 for <linux-archive@neteng.engr.sgi.com>; Sat, 18 Oct 1997 05:21:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA16406 for linux-list; Sat, 18 Oct 1997 05:21:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA16401 for <linux@engr.sgi.com>; Sat, 18 Oct 1997 05:21:16 -0700
Received: from tbird.cobaltmicro.com ([209.19.61.36]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA03480
	for <linux@engr.sgi.com>; Sat, 18 Oct 1997 05:21:14 -0700
	env-from (ralf@tbird.cobaltmicro.com)
Received: (from ralf@localhost)
	by tbird.cobaltmicro.com (8.8.5/8.8.5) id FAA03930;
	Sat, 18 Oct 1997 05:18:39 -0700
Message-ID: <19971018051839.32034@tbird.cobaltmicro.com>
Date: Sat, 18 Oct 1997 05:18:39 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
To: Mark Hemment <markhe@nextd.demon.co.uk>
Cc: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: Page Colouring
References: <Pine.LNX.3.95.971017224546.1223A-101000@nextd.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.81e
In-Reply-To: <Pine.LNX.3.95.971017224546.1223A-101000@nextd.demon.co.uk>; from Mark Hemment on Sat, Oct 18, 1997 at 12:10:19AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Oct 18, 1997 at 12:10:19AM +0100, Mark Hemment wrote:

>   I've tried a few other colouring strategies, but none have worked very
> well.  Perhaps I have a bug in mm/page_alloc.c, or page colouring is
> not worth the effort on systems with fast memory and a (large) pipeburst
> cache.  More likely, I hope, the colouring strategy is wrong.
> 
>   So, if anyone has an ideas I'd love to hear them.  Better still, try
> them out yourself.

There is something else that I'd like the page colouring stuff to do
for MIPS, I'm just not really shure how to handle this.

The primary cache on all 64bit MIPS CPUs is virtually indexed and physically
tagged.  As the CPU only uses the lower 12 bits of the virtual address to
index the 2 << n bytes sized primary cache (where n is bigger than 12) it is
possible by accessing a page mapped to two virtual addresses which have
different bits 12 ... n to create multiple entries in the cache for the
same physical address.  This is the effect known as "virtual aliasing".
Some MIPS CPUs are smart and handle this in hardware, others throw an
exception and yet others again will have to take care of avoiding virtual
aliases in software by cache flushing.

Given that cache flushing is a very expensive operation it is highly
desireable to try to avoid it trying to allocate pages of the right colour.
One place to particularly benefit about this is do_wp_page() in mm/memory.c,
but there should be others:

[...]
        new_page = __get_free_page(GFP_KERNEL);
[...]
        /*
         * Do we need to copy?
         */
        if (atomic_read(&mem_map[MAP_NR(old_page)].count) != 1) {
                if (new_page) {
                        if (PageReserved(mem_map + MAP_NR(old_page)))
                                ++vma->vm_mm->rss;
                        copy_cow_page(old_page,new_page);
                        flush_page_to_ram(old_page);
                        flush_page_to_ram(new_page);
                        flush_cache_page(vma, address);
                        set_pte(page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_p                        free_page(old_page);
                        flush_tlb_page(vma, address);
                        return;
                }
[...]

Using the virtual address it is possible to choose a prefereable colour
for the page allocation.  So it's possible to accelerate things about
as follows:

[...]
        new_page = __get_free_page(GFP_KERNEL, pgcolour(address));
[...]
        /*
         * Do we need to copy?
         */
        if (atomic_read(&mem_map[MAP_NR(old_page)].count) != 1) {
                if (new_page) {
                        if (PageReserved(mem_map + MAP_NR(old_page)))
                                ++vma->vm_mm->rss;
                        copy_cow_page(old_page,new_page);
                        flush_page_to_ram(old_page);		/* XXX */
                        change_page_colour(new_page, address);
                        flush_cache_page(vma, address);
                        set_pte(page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_p                        free_page(old_page);
                        flush_tlb_page(vma, address);
                        return;
                }
[...]

where change_page_colour() would only flush the L1 caches when hazzard of
creating virtual aliases actually exists.  For a 16kb primary cache (assuming
we can always allocate a page of the right colour) this would reduce the
cacheflushing overhead by 75% (for MIPS flushing a page is a four digit cycle
operation) as well as giving the guarantee that at least the d-cache is hot
after return from the pagefault handler.  Other CPUs with virtual indexed
caches (PPC, Sparc ???) should profit from this application of page colouring
as well.

(XXX: Maybe it's too late for my brain, but why are we doing a writeback
on the old_page page?  As things are the cache shouldn't have any dirty
lines for that page?)

  Ralf
