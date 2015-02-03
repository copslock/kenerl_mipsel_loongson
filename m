Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 18:44:02 +0100 (CET)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53176 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015020AbbBCRn7uCIWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 18:43:59 +0100
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJ7000SZIRTR350@mailout2.w1.samsung.com>; Tue,
 03 Feb 2015 17:47:53 +0000 (GMT)
X-AuditID: cbfec7f5-b7fc86d0000066b7-b9-54d108430a51
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 66.5E.26295.34801D45; Tue,
 03 Feb 2015 17:41:23 +0000 (GMT)
Received: from localhost.localdomain ([106.109.129.143])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0NJ700DO6IK39ZB0@eusync2.samsung.com>; Tue,
 03 Feb 2015 17:43:49 +0000 (GMT)
From:   Andrey Ryabinin <a.ryabinin@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <a.ryabinin@samsung.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konstantin Serebryany <kcc@google.com>,
        Dmitry Chernenkov <dmitryc@google.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Yuri Gribov <tetra2005@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-mm@kvack.org, Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com (supporter:S390),
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-mips@linux-mips.org (open list:MIPS),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linux-s390@vger.kernel.org (open list:S390),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPAR...)
Subject: [PATCH v11 16/19] mm: vmalloc: pass additional vm_flags to
 __vmalloc_node_range()
Date:   Tue, 03 Feb 2015 20:43:09 +0300
Message-id: <1422985392-28652-17-git-send-email-a.ryabinin@samsung.com>
X-Mailer: git-send-email 2.2.2
In-reply-to: <1422985392-28652-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1422985392-28652-1-git-send-email-a.ryabinin@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAyWRa0iTYRiGe7+zq8WHqX2NqLAECdKSfjxIlNDp1SAiJChCXTo84KZtadoJ
        U5NcHpamlkoZy9RlalvmAY1cplZiS8UsybPGPM/DEgVty383133x3D8ejnQ0UBIuXHFNplRI
        I10ZEfV1rbX7wHHuu//BLIMnvFsZZmC18QkNhZXlDDT3/GVh9mUagh/WKQTz5kEEhd+SKRiY
        70PwZ2iIBc1QCgtNvVYWWkxmCnLfbIeyB0kMDFToaKgZnyagLHWQBv1IDw1d9YUMaHKyWOgv
        X6dh+IuJAM3zJBLM1gUa+rrE0PmhiIDOhn2gbe4jYaHDdjvhcykNM+PZJBj0OTbV0kbBctUI
        7bMXlz8tRzg5KY3Bb8t+Erhp2MjgZ3UWhOvyf7N4zhKAi/QxWNtgJrBel8pg/XwWi9XT3QSe
        6ehgcdvjVQp/KntN4NHuPOKccEl0JEQWGR4rU3oeDRKFzST2stHZ3nETeTqUgOo91YjjBP6w
        YL17Xo0cbNFFMPVXMvbsyBcjIaN+sxqJbDmDENralyh7wfAewlp+zX/Jid8jGNLHabtE8nMi
        ITlTS9qLbfxloXRikrAPULybkDbpZsdi/rSQ/WgRbezuEkyWQDt2sOH3meNoYysRCVPaZFKD
        xEVokw45y2KCo1VXQuVeHiqpXBWjCPUIjpLr0cajl2pRcYu3EfEcct0idp8x+TvS0lhVvNyI
        BI50dRI3rNqQOEQaf0OmjApUxkTKVEZEcA6SBLQ1grxgGKuYK6luPbaWS9w0ryyvlGhvXXT3
        sL4a9WvK9r2zU3Zfqi1Yeuh8wjclzZjb6xnfNtnubN7xq2m3xLSYZJX4XdAYlm9X9V4XNEEJ
        HwP0ge0vFGctsZWZV2vj2NExbs5yEqffiyiYrfZTuzDpp+SKM+teQY0FQ+4+ErErpQqTHtpP
        KlXSf3l2manGAgAA
Return-Path: <a.ryabinin@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.ryabinin@samsung.com
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

For instrumenting global variables KASan will shadow memory
backing memory for modules. So on module loading we will need
to allocate memory for shadow and map it at address in shadow
that corresponds to the address allocated in module_alloc().

__vmalloc_node_range() could be used for this purpose,
except it puts a guard hole after allocated area. Guard hole
in shadow memory should be a problem because at some future
point we might need to have a shadow memory at address
occupied by guard hole. So we could fail to allocate shadow
for module_alloc().

Now we have VM_NO_GUARD flag disabling guard page, so we need to
pass into __vmalloc_node_range(). Add new parameter 'vm_flags'
to __vmalloc_node_range() function.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/kernel/module.c       |  2 +-
 arch/arm64/kernel/module.c     |  4 ++--
 arch/mips/kernel/module.c      |  2 +-
 arch/parisc/kernel/module.c    |  2 +-
 arch/s390/kernel/module.c      |  2 +-
 arch/sparc/kernel/module.c     |  2 +-
 arch/unicore32/kernel/module.c |  2 +-
 arch/x86/kernel/module.c       |  2 +-
 include/linux/vmalloc.h        |  4 +++-
 mm/vmalloc.c                   | 10 ++++++----
 10 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index bea7db9..2e11961 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -41,7 +41,7 @@
 void *module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
+				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 9b6f71d..67bf410 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -35,8 +35,8 @@
 void *module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				    GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				    GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
+				    NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 enum aarch64_reloc_op {
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 2a52568..1833f51 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -47,7 +47,7 @@ static DEFINE_SPINLOCK(dbe_lock);
 void *module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
-				GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
+				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 5822e8e..3c63a82 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -219,7 +219,7 @@ void *module_alloc(unsigned long size)
 	 * init_data correctly */
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
 				    GFP_KERNEL | __GFP_HIGHMEM,
-				    PAGE_KERNEL_RWX, NUMA_NO_NODE,
+				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 409d152..36154a2 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -50,7 +50,7 @@ void *module_alloc(unsigned long size)
 	if (PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				    GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
+				    GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 #endif
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 97655e0..192a617 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -29,7 +29,7 @@ static void *module_map(unsigned long size)
 	if (PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
+				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 #else
diff --git a/arch/unicore32/kernel/module.c b/arch/unicore32/kernel/module.c
index dc41f6d..e191b34 100644
--- a/arch/unicore32/kernel/module.c
+++ b/arch/unicore32/kernel/module.c
@@ -25,7 +25,7 @@
 void *module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
+				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index e69f988..e830e61 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -88,7 +88,7 @@ void *module_alloc(unsigned long size)
 	return __vmalloc_node_range(size, 1,
 				    MODULES_VADDR + get_module_load_offset(),
 				    MODULES_END, GFP_KERNEL | __GFP_HIGHMEM,
-				    PAGE_KERNEL_EXEC, NUMA_NO_NODE,
+				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1526fe7..7d7acb3 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -76,7 +76,9 @@ extern void *vmalloc_32_user(unsigned long size);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
 extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
-			pgprot_t prot, int node, const void *caller);
+			pgprot_t prot, unsigned long vm_flags, int node,
+			const void *caller);
+
 extern void vfree(const void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2e74e99..35b25e1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1619,6 +1619,7 @@ fail:
  *	@end:		vm area range end
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
+ *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
  *	@node:		node to use for allocation or NUMA_NO_NODE
  *	@caller:	caller's return address
  *
@@ -1628,7 +1629,8 @@ fail:
  */
 void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
-			pgprot_t prot, int node, const void *caller)
+			pgprot_t prot, unsigned long vm_flags, int node,
+			const void *caller)
 {
 	struct vm_struct *area;
 	void *addr;
@@ -1638,8 +1640,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
 		goto fail;
 
-	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED,
-				  start, end, node, gfp_mask, caller);
+	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
+				vm_flags, start, end, node, gfp_mask, caller);
 	if (!area)
 		goto fail;
 
@@ -1688,7 +1690,7 @@ static void *__vmalloc_node(unsigned long size, unsigned long align,
 			    int node, const void *caller)
 {
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
-				gfp_mask, prot, node, caller);
+				gfp_mask, prot, 0, node, caller);
 }
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
-- 
2.2.2
