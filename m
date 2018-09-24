Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 13:58:14 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeIXL6J4trNU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 13:58:09 +0200
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21B3DD64;
        Mon, 24 Sep 2018 11:58:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rene Nielsen <rene.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 69/70] MIPS: VDSO: Match data page cache colouring when D$ aliases
Date:   Mon, 24 Sep 2018 13:53:08 +0200
Message-Id: <20180924113107.984774618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66529
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

commit 0f02cfbc3d9e413d450d8d0fd660077c23f67eff upstream.

When a system suffers from dcache aliasing a user program may observe
stale VDSO data from an aliased cache line. Notably this can break the
expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
suggests, monotonic.

In order to ensure that users observe updates to the VDSO data page as
intended, align the user mappings of the VDSO data page such that their
cache colouring matches that of the virtual address range which the
kernel will use to update the data page - typically its unmapped address
within kseg0.

This ensures that we don't introduce aliasing cache lines for the VDSO
data page, and therefore that userland will observe updates without
requiring cache invalidation.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Patchwork: https://patchwork.linux-mips.org/patch/20344/
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/mips/kernel/vdso.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,12 +14,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/page.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -118,12 +120,30 @@ int arch_setup_additional_pages(struct l
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
+	/*
+	 * Find a region that's large enough for us to perform the
+	 * colour-matching alignment below.
+	 */
+	if (cpu_has_dc_aliases)
+		size += shm_align_mask + 1;
+
 	base = get_unmapped_area(NULL, 0, size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
 	}
 
+	/*
+	 * If we suffer from dcache aliasing, ensure that the VDSO data page
+	 * mapping is coloured the same as the kernel's mapping of that memory.
+	 * This ensures that when the kernel updates the VDSO data userland
+	 * will observe it without requiring cache invalidations.
+	 */
+	if (cpu_has_dc_aliases) {
+		base = __ALIGN_MASK(base, shm_align_mask);
+		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+	}
+
 	data_addr = base + gic_size;
 	vdso_addr = data_addr + PAGE_SIZE;
 
