Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 06:23:31 +0000 (GMT)
Received: from rth.ninka.net ([IPv6:::ffff:216.101.162.244]:3712 "EHLO
	rth.ninka.net") by linux-mips.org with ESMTP id <S8224893AbUAOGXa>;
	Thu, 15 Jan 2004 06:23:30 +0000
Received: from rth.ninka.net (localhost.localdomain [127.0.0.1])
	by rth.ninka.net (8.12.10/8.12.10) with SMTP id i0F6NGX6011727;
	Wed, 14 Jan 2004 22:23:16 -0800
Date: Wed, 14 Jan 2004 22:23:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jun Sun <jsun@mvista.com>
Cc: akpm@osdl.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, jsun@mvista.com
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program
 returns pages to kernel
Message-Id: <20040114222316.25276f12.davem@redhat.com>
In-Reply-To: <20040114174012.H13471@mvista.com>
References: <20040114163920.E13471@mvista.com>
	<20040114171252.4d873c51.akpm@osdl.org>
	<20040114172946.03e54706.akpm@osdl.org>
	<20040114174012.H13471@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <davem@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jan 2004 17:40:12 -0800
Jun Sun <jsun@mvista.com> wrote:

> Looking at my tree (which is from linux-mips.org), it appears
> arm, sparc, sparc64, and sh have tlb_start_vma() defined to call
> cache flushing.

Correct, in fact every platform where cache flushing matters
at all (ie. where flush_cache_*() routines actually need to
flush a cpu cache), they should have tlb_start_vma() do such
a flush.

> What exactly does tlb_start_vma()/tlb_end_vma() mean?  There is
> only one invocation instance, which is significant enough to infer
> the meaning.  :)

When the kernel unmaps a mmap region of a process (either for the
sake of munmap() or tearing down all mapping during exit()) tlb_start_vma()
is called, the page table mappings in the region are torn down one by
one, then a tlb_end_vma() call is made.

At the top level, ie. whoever invokes unmap_page_range(), there will
be a tlb_gather_mmu() call.

In order to properly optimize the cache flushes, most platforms do the
following:

1) The tlb->fullmm boolean keeps trap of whether this is just a munmap()
   unmapping operation (if zero) or a full address space teardown
   (if non-zero).

2) In the full address space teardown case, and thus tlb->fullmm is
   non-zero, the top level will do the explict flush_cache_mm()
   (see mm/mmap.c:exit_mmap()), therefore the tlb_start_vma()
   implementation need not do the flush, otherwise it does.

   This is why sparc64 and friends implement it like this:

#define tlb_start_vma(tlb, vma) \
do {    if (!(tlb)->fullmm)     \
                flush_cache_range(vma, vma->vm_start, vma->vm_end); \
} while (0)

Hope this clears things up.

Someone should probably take what I just wrote, expand and organize it,
then add such content to Documentation/cachetlb.txt
