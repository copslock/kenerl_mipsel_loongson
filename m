Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 18:03:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17658 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225464AbUAOSDi>;
	Thu, 15 Jan 2004 18:03:38 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0FI3Uo18508;
	Thu, 15 Jan 2004 10:03:30 -0800
Date: Thu, 15 Jan 2004 10:03:30 -0800
From: Jun Sun <jsun@mvista.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program returns pages to kernel
Message-ID: <20040115100330.C18368@mvista.com>
References: <20040114163920.E13471@mvista.com> <20040114171252.4d873c51.akpm@osdl.org> <20040114172946.03e54706.akpm@osdl.org> <20040114174012.H13471@mvista.com> <20040114222316.25276f12.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040114222316.25276f12.davem@redhat.com>; from davem@redhat.com on Wed, Jan 14, 2004 at 10:23:16PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Looks the right fix is to add cache flush to tlb_start_vma().
See the patch attached.  Unless someone objects, I will check it
later.

BTW, I really don't like the function naming of tlb_start_vma()
and tbl_end_vma(). :)

Jun

On Wed, Jan 14, 2004 at 10:23:16PM -0800, David S. Miller wrote:
> On Wed, 14 Jan 2004 17:40:12 -0800
> Jun Sun <jsun@mvista.com> wrote:
> 
> > Looking at my tree (which is from linux-mips.org), it appears
> > arm, sparc, sparc64, and sh have tlb_start_vma() defined to call
> > cache flushing.
> 
> Correct, in fact every platform where cache flushing matters
> at all (ie. where flush_cache_*() routines actually need to
> flush a cpu cache), they should have tlb_start_vma() do such
> a flush.
> 
> > What exactly does tlb_start_vma()/tlb_end_vma() mean?  There is
> > only one invocation instance, which is significant enough to infer
> > the meaning.  :)
> 
> When the kernel unmaps a mmap region of a process (either for the
> sake of munmap() or tearing down all mapping during exit()) tlb_start_vma()
> is called, the page table mappings in the region are torn down one by
> one, then a tlb_end_vma() call is made.
> 
> At the top level, ie. whoever invokes unmap_page_range(), there will
> be a tlb_gather_mmu() call.
> 
> In order to properly optimize the cache flushes, most platforms do the
> following:
> 
> 1) The tlb->fullmm boolean keeps trap of whether this is just a munmap()
>    unmapping operation (if zero) or a full address space teardown
>    (if non-zero).
> 
> 2) In the full address space teardown case, and thus tlb->fullmm is
>    non-zero, the top level will do the explict flush_cache_mm()
>    (see mm/mmap.c:exit_mmap()), therefore the tlb_start_vma()
>    implementation need not do the flush, otherwise it does.
> 
>    This is why sparc64 and friends implement it like this:
> 
> #define tlb_start_vma(tlb, vma) \
> do {    if (!(tlb)->fullmm)     \
>                 flush_cache_range(vma, vma->vm_start, vma->vm_end); \
> } while (0)
> 
> Hope this clears things up.
> 
> Someone should probably take what I just wrote, expand and organize it,
> then add such content to Documentation/cachetlb.txt
> 

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="real-fix.patch"

diff -Nru linux/include/asm-mips/tlb.h.orig linux/include/asm-mips/tlb.h
--- linux/include/asm-mips/tlb.h.orig	Thu Oct 31 08:35:52 2002
+++ linux/include/asm-mips/tlb.h	Thu Jan 15 10:02:14 2004
@@ -2,9 +2,14 @@
 #define __ASM_TLB_H
 
 /*
- * MIPS doesn't need any special per-pte or per-vma handling..
+ * MIPS doesn't need any special per-pte or per-vma handling, except
+ * we need to flush cache for area to be unmapped.
  */
-#define tlb_start_vma(tlb, vma) do { } while (0)
+#define tlb_start_vma(tlb, vma) 				\
+	do {							\
+		if (!tlb->fullmm)				\
+			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
+	}  while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 

--HlL+5n6rz5pIUxbD--
