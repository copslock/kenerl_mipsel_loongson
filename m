Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 14:12:24 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992375AbeIXMMMeqTLU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 14:12:12 +0200
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C074D1088;
        Mon, 24 Sep 2018 12:12:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
Date:   Mon, 24 Sep 2018 13:53:18 +0200
Message-Id: <20180924113116.349047480@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66536
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.

We don't really need gic_get_usm_range() to abstract discovery of the
address of the GIC user-visible section now that we have access to its
base address globally.

Switch to calculating it ourselves, which will allow us to stop
requiring the irqchip driver to care about a counter exposed to userland
for use via the VDSO.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17040/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/vdso.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
@@ -21,6 +20,7 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 
@@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
+	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
 	struct vm_area_struct *vma;
-	struct resource gic_res;
 	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
@@ -127,7 +126,7 @@ int arch_setup_additional_pages(struct l
 	 * only map a page even though the total area is 64K, as we only need
 	 * the counter registers at the start.
 	 */
-	gic_size = gic_present ? PAGE_SIZE : 0;
+	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
@@ -168,13 +167,9 @@ int arch_setup_additional_pages(struct l
 
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
