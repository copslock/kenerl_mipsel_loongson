Received:  by oss.sgi.com id <S42213AbQHJRvt>;
	Thu, 10 Aug 2000 10:51:49 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:64503 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42202AbQHJRvc>;
	Thu, 10 Aug 2000 10:51:32 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id KAA04609;
	Thu, 10 Aug 2000 10:50:28 -0700
Message-ID: <3992EB64.8F2587A6@mvista.com>
Date:   Thu, 10 Aug 2000 10:50:28 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@uni-koblenz.de>
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: bug in the latest cache code?
References: <3992007C.49050FC@mvista.com> <20000810193858.A1478@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Wed, Aug 09, 2000 at 06:08:12PM -0700, Jun Sun wrote:
> 
> > I spent the last a few days to track down a problem where /sbin/init
> > hangs forever.  It turns out, I believe, to be a bug introduced in the
> > recent cache code change.
> >
> > A new function, r4k_flush_icache_page_i32(), was added recently.  It
> > calls blast_icache32_page(), which uses Hit cache operations to flush
> > cache.  Unfortunately, that will generate TLB fault if virtual address
> > is not present in TLB.  Under certain conditions,
> > r4k_flush_icache_page_i32() will be called in the middle of handling a
> > page fault, and it will then generate the same page fault again with
> > cache hit operation.  This causes a deadlock (on current->mm->mmap_sem).
> >
> > I read the previous version of code.  The fix seems to be using the
> > indexed cache operation.  Here is the fix, and apparently it fixes the
> > problem on my board.
> 
> I can see how this may happen and will take care of fixing this one.
> 

Thanks.

Below is the stack trace and some of my notes on this problem.  Hope
this helps.

I agree we should not use index operation abusively, but this is pretty
serious problem.  I don't think we can fix it easily without changing
the arch-independent part of kernel.

Jun

-------------------------

more traces :
the page fault is caused r4k_flush_icache_page_i32(), the first cache
(Hit_....) operation.

call stack when current->mm->sem has already been taken but
        r4k_flush_icache_page_i32() is still called.

#0  jsun_bug () at r4xx0.c:1971
#1  0x8009aa60 in r4k_flush_icache_page_i32 (vma=0x811401e0,
page=0x810476c0,
    address=263607008) at r4xx0.c:1986
#2  0x800b0320 in do_no_page (mm=0x81142080, vma=0x811401e0,
address=263607008,
    write_access=0, page_table=0x811fed94) at memory.c:1162
#3  0x800b0508 in handle_mm_fault (mm=0x81142080, vma=0x811401e0,
    address=263607008, write_access=0) at memory.c:1202
#4  0x80094118 in do_page_fault (regs=0x81127f30, write=0,
address=263607008)
    at fault.c:93
#5  0x8008ce98 in handle_tlbl () at r4k_misc.S:154

(263607008 = 0xfb652e0)

The epc for #5 tlbl fault is 0xfb652e0, which means it is a page fault
for
the next instruction.

****

annotated calling trace :

handle_tlbl (in asm) - arch/mips/kernel/r4k_misc.S
    do_page_fault - arch/mips/mm/fault.c
        after check it is a good area
        swtich (handle_mm_fault(....) )  - line 93
            [not visiable to gdb
            handle_mm_fault(...)  - mm/memory.c ]
                alloc pte
                handle_pte_fault(...)
                    check about the page and
                    do_no_page(...)  - mm/memory.c
                        /* do a bunch of stuff but TLB entry
			   for the new page is not built yet */
                        flush_page_to_ram(new_page);
                        flush_icache_page(...)
                          ( = r4k_flush_icache_page_i32) ;
                                ==> jsun_bug()
