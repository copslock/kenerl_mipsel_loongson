Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:46:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993920AbdHMEoJqIfxd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:44:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1682C69B6296C;
        Sun, 13 Aug 2017 05:44:00 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:44:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 22/38] MIPS: VDSO: Drop gic_get_usm_range() usage
Date:   Sat, 12 Aug 2017 21:36:30 -0700
Message-ID: <20170813043646.25821-23-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We don't really need gic_get_usm_range() to abstract discovery of the
address of the GIC user-visible section now that we have access to its
base address globally.

Switch to calculating it ourselves, which will allow us to stop
requiring the irqchip driver to care about a counter exposed to userland
for use via the VDSO.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/vdso.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 093517e85a6c..019035d7225c 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -13,13 +13,13 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/mips-cps.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -99,9 +99,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
+	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
 	struct vm_area_struct *vma;
-	struct resource gic_res;
 	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
@@ -125,7 +124,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * only map a page even though the total area is 64K, as we only need
 	 * the counter registers at the start.
 	 */
-	gic_size = gic_present ? PAGE_SIZE : 0;
+	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
@@ -148,13 +147,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/* Map GIC user page. */
 	if (gic_size) {
-		ret = gic_get_usm_range(&gic_res);
-		if (ret)
-			goto out;
+		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
 
-		ret = io_remap_pfn_range(vma, base,
-					 gic_res.start >> PAGE_SHIFT,
-					 gic_size,
+		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(PAGE_READONLY));
 		if (ret)
 			goto out;
-- 
2.14.0
