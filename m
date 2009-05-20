Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 15:26:38 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44405 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022587AbZETO0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 15:26:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4KEQ5UV022211;
	Wed, 20 May 2009 15:26:06 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4KEQ5Ce022210;
	Wed, 20 May 2009 15:26:05 +0100
Date:	Wed, 20 May 2009 15:26:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Ungerer <gerg@snapgear.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
Message-ID: <20090520142604.GA29677@linux-mips.org>
References: <4A139F50.7050409@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A139F50.7050409@snapgear.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 04:12:32PM +1000, Greg Ungerer wrote:

> I have a system lockup problem that I have been looking at on a custom
> Cavium/Octeon 5010 based design. I am running on linux-2.6.29 with
> David Daney's latest round of PCI and ethernet patches (posted here
> on this list).
>
> I have tracked the problem back to local_flush_tlb_kernel_range() in
> arch/mips/mm/tlb-r4k.c. At the top of this function is:
>
>     void local_flush_tlb_kernel_range(unsigned long start, unsigned long 
> end)
>     {
>         unsigned long flags;
>         int size;
>
>         ENTER_CRITICAL(flags);
>         size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
>         size = (size + 1) >> 1;
>         if (size <= current_cpu_data.tlbsize / 2) {
>
> The problem is that typical example values I see passed in for start
> and end are:
>
>     start = c000000000006000
>     end   = ffffffffc01d8000
>
> Now the vmalloc area starts at 0xc000000000000000 and the kernel code
> and data is all at 0xffffffff80000000 and above. I don't know if the
> start and end are reasonable values, but I can see some logic as to
> where they come from. The code path that leads to this is via
> __vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
> to see how we end up with values like this.

Either start or end address is sensible but not the combination - both
addresses should be in the same segment.  Start is in XKSEG, end in CKSEG2
and in between there are vast wastelands of unused address space exabytes
in size.

> But the size calculation above with these types of values will result
> in still a large number. Larger than the 32bit "int" that is "size".
> I see large negative values fall out as size, and so the following
> tlbsize check becomes true, and the code spins inside the loop inside
> that if statement for a _very_ long time trying to flush tlb entries.
>
> This is of course easily fixed, by making that size "unsigned long".
> The patch below trivially does this.
>
> But is this analysis correct?

Yes - but I think we have two issues here.  The one is the calculation
overflowing int for the arguments you're seeing.  The other being that
the arguments simply are looking wrong.

There are a few more instances of the same overflow issue which the patch
below is fixing.

  Ralf


 arch/mips/mm/tlb-r3k.c |    6 ++----
 arch/mips/mm/tlb-r4k.c |    6 ++----
 arch/mips/mm/tlb-r8k.c |    3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index f0cf46a..1c0048a 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -82,8 +82,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-		int size;
+		unsigned long size, flags;
 
 #ifdef DEBUG_TLB
 		printk("[tlbrange<%lu,0x%08lx,0x%08lx>]",
@@ -121,8 +120,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	unsigned long flags;
-	int size;
+	unsigned long size, flags;
 
 #ifdef DEBUG_TLB
 	printk("[tlbrange<%lu,0x%08lx,0x%08lx>]", start, end);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 9619f66..892be42 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -117,8 +117,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-		int size;
+		unsigned long size, flags;
 
 		ENTER_CRITICAL(flags);
 		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
@@ -160,8 +159,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	unsigned long flags;
-	int size;
+	unsigned long size, flags;
 
 	ENTER_CRITICAL(flags);
 	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index 4f01a3b..4ec95cc 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -111,8 +111,7 @@ out_restore:
 /* Usable for KV1 addresses only! */
 void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	unsigned long flags;
-	int size;
+	unsigned long size, flags;
 
 	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 	size = (size + 1) >> 1;
