Received:  by oss.sgi.com id <S42285AbQHJBNH>;
	Wed, 9 Aug 2000 18:13:07 -0700
Received: from [204.94.214.10] ([204.94.214.10]:24145 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42283AbQHJBMp>;
	Wed, 9 Aug 2000 18:12:45 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA17147
	for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 18:02:59 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id SAA53981 for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 18:10:02 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA35592
	for <linux@engr.sgi.com>;
	Wed, 9 Aug 2000 18:08:25 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07442
	for <linux@engr.sgi.com>; Wed, 9 Aug 2000 18:08:16 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id SAA17369;
	Wed, 9 Aug 2000 18:08:14 -0700
Message-ID: <3992007C.49050FC@mvista.com>
Date:   Wed, 09 Aug 2000 18:08:12 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: bug in the latest cache code?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

I spent the last a few days to track down a problem where /sbin/init
hangs forever.  It turns out, I believe, to be a bug introduced in the
recent cache code change.

A new function, r4k_flush_icache_page_i32(), was added recently.  It
calls blast_icache32_page(), which uses Hit cache operations to flush
cache.  Unfortunately, that will generate TLB fault if virtual address
is not present in TLB.  Under certain conditions,
r4k_flush_icache_page_i32() will be called in the middle of handling a
page fault, and it will then generate the same page fault again with
cache hit operation.  This causes a deadlock (on current->mm->mmap_sem).

I read the previous version of code.  The fix seems to be using the
indexed cache operation.  Here is the fix, and apparently it fixes the
problem on my board.

Jun

-----------

static void
r4k_flush_icache_page_i32(struct vm_area_struct *vma, struct page *page,
                      unsigned long address)
{
        if (!(vma->vm_flags & VM_EXEC))
                return;

-        blast_icache32_page(address);
+        address = KSEG0 + (address & PAGE_MASK & (dcache_size - 1));
+        blast_icache32_page_indexed(address);
}
