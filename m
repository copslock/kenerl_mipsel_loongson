Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 09:44:12 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994573AbeGPHoDOA9Rt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 09:44:03 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6FBF3C03;
        Mon, 16 Jul 2018 07:43:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 01/43] MIPS: Fix ioremap() RAM check
Date:   Mon, 16 Jul 2018 09:36:06 +0200
Message-Id: <20180716073511.923793671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 523402fa9101090c91d2033b7ebdfdcf65880488 upstream.

We currently attempt to check whether a physical address range provided
to __ioremap() may be in use by the page allocator by examining the
value of PageReserved for each page in the region - lowmem pages not
marked reserved are presumed to be in use by the page allocator, and
requests to ioremap them fail.

The way we check this has been broken since commit 92923ca3aace ("mm:
meminit: only set page reserved in the memblock region"), because
memblock will typically not have any knowledge of non-RAM pages and
therefore those pages will not have the PageReserved flag set. Thus when
we attempt to ioremap a region outside of RAM we incorrectly fail
believing that the region is RAM that may be in use.

In most cases ioremap() on MIPS will take a fast-path to use the
unmapped kseg1 or xkphys virtual address spaces and never hit this path,
so the only way to hit it is for a MIPS32 system to attempt to ioremap()
an address range in lowmem with flags other than _CACHE_UNCACHED.
Perhaps the most straightforward way to do this is using
ioremap_uncached_accelerated(), which is how the problem was discovered.

Fix this by making use of walk_system_ram_range() to test the address
range provided to __ioremap() against only RAM pages, rather than all
lowmem pages. This means that if we have a lowmem I/O region, which is
very common for MIPS systems, we're free to ioremap() address ranges
within it. A nice bonus is that the test is no longer limited to lowmem.

The approach here matches the way x86 performed the same test after
commit c81c8a1eeede ("x86, ioremap: Speed up check for RAM pages") until
x86 moved towards a slightly more complicated check using walk_mem_res()
for unrelated reasons with commit 0e4c12b45aa8 ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Fixes: 92923ca3aace ("mm: meminit: only set page reserved in the memblock region")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.2+
Patchwork: https://patchwork.linux-mips.org/patch/19786/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/ioremap.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
+#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -97,6 +98,20 @@ static int remap_area_pages(unsigned lon
 	return error;
 }
 
+static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
+			       void *arg)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (pfn_valid(start_pfn + i) &&
+		    !PageReserved(pfn_to_page(start_pfn + i)))
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Generic mapping function (not visible outside):
  */
@@ -115,8 +130,8 @@ static int remap_area_pages(unsigned lon
 
 void __iomem * __ioremap(phys_addr_t phys_addr, phys_addr_t size, unsigned long flags)
 {
+	unsigned long offset, pfn, last_pfn;
 	struct vm_struct * area;
-	unsigned long offset;
 	phys_addr_t last_addr;
 	void * addr;
 
@@ -136,18 +151,16 @@ void __iomem * __ioremap(phys_addr_t phy
 		return (void __iomem *) CKSEG1ADDR(phys_addr);
 
 	/*
-	 * Don't allow anybody to remap normal RAM that we're using..
+	 * Don't allow anybody to remap RAM that may be allocated by the page
+	 * allocator, since that could lead to races & data clobbering.
 	 */
-	if (phys_addr < virt_to_phys(high_memory)) {
-		char *t_addr, *t_end;
-		struct page *page;
-
-		t_addr = __va(phys_addr);
-		t_end = t_addr + (size - 1);
-
-		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
-			if(!PageReserved(page))
-				return NULL;
+	pfn = PFN_DOWN(phys_addr);
+	last_pfn = PFN_DOWN(last_addr);
+	if (walk_system_ram_range(pfn, last_pfn - pfn + 1, NULL,
+				  __ioremap_check_ram) == 1) {
+		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
+			  &phys_addr, &last_addr);
+		return NULL;
 	}
 
 	/*
