Received:  by oss.sgi.com id <S42447AbQIFVau>;
	Wed, 6 Sep 2000 14:30:50 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:65268 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42336AbQIFVai>;
	Wed, 6 Sep 2000 14:30:38 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id OAA31445;
	Wed, 6 Sep 2000 14:30:05 -0700
Message-ID: <39B6B75D.2501654E@mvista.com>
Date:   Wed, 06 Sep 2000 14:30:05 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-fbdev@vuser.vu.union.edu, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: mmap() frame buffer causes bus error on MIPS ...
References: <39B5BD14.A8D2F467@mvista.com> <39B5DABB.7FB85B09@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:
> 
> Jun Sun wrote:
> >
> > With the help from Attila, I got the latest tdfx framebuffer driver
> > working on my NEC DDB5476 board.   I have console working based on this
> > driver.
> >
> > However, when I try to mmap frame buffer into user land, the mapping is
> > succesful, but trying to read the buffer causes a bus error.
> >
> > I tried to trace the kernel using gdb.  fb_mmap() seems to do the right
> > thing :
> >
> > 1) it calls fb->fb_get_fix() to get the buffer address, size, etc.  The
> > values all look fine.  The address is physical address, pointing a
> > mapped PCI memory block.  I verified that I can access that address in
> > gdb.
> >
> > 2) for MIPS, fb_mmap() turns off CACHE bit for the page.
> >
> > I would imagine when the app tries to read the buffer, a TLB miss is
> > generated.  TLB refill routine probably sets up the right TLB entry, and
> > the app will try to read again, and get the content.  I really can't
> > think of where the Bus error might occur.
> >
> > Does anybody have a clue here?  Thanks a lot.
> >
> > Jun
> 
> Did more probing on this.  It appears the TLB entry that gets filled is
> not right, even though the original page entry is generated correctly.
> See below TLB dump.
>

This is bogus.  The TLB entry is a shifted value (right-shift for 6
bits) of the entry in the page table.  That is the reason whe I see two
different values.
 
> The original page table still has the same value (not corrupted), and
> the only explanation is that tlb_refill actually gets the entry from a
> wrong place.  I then tried to decode tlb_refill code but really got lost
> there.  (Is there an explanation about the page table setup?)
> 
> How could this be? Maybe the pte's are put in the wrong place to begin
> with?  Ralf, please help ...
> 
> Jun
> 

I found the real reason, and had a work-around to make it work for now. 
However, I am not sure about the right fix.

fb_mmap() calls get_fix() to get screen info : 

	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);

fb_mmap() then gets buffer address from fix.smem_start, which is a
physical address.  It then calls kernel's remap_page_range() with that
address, which in turn will generate pte with mk_pte_phys().

In MIPS, mk_pte_phys() is defined as follows :

extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
{
	return __pte(((physpage & PAGE_MASK) - PAGE_OFFSET) |
pgprot_val(pgprot));
}

The problematic part is " - PAGE_OFFSET" (where PAGE_OFFSET is
0x80000000).  If "physpage" is a physical address, it should not be
substracted by PAGE_OFFSET.  This is a bug.

On the other hand, I wonder why this bug is there without being caught
before (it is so fundamental).  If this is not a bug in MIPS kernel,
then the fix is in the fb_mmap(), where under __mips__ case, we should
add PAGE_OFFSET to the start of buffer address.

What is the right fix here?

Jun
