Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:00:15 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:39752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbeDOPAAlhCFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ODO2/ebgf5fdBeGahC31F352EAs5Cf0Xi0RbtkiSc+E=; b=V4rMhF9KqME6V+AB9EVoerLCN
        qyfRAdLKcW9aF9CcOfnSKqP5CNmiLUzSdzi5lRUEyfqRXe3xVnkuXUWRsYQeqUhOH2MBw0aSmdcni
        WXZ27+RFSL1MOjETuw5G9W46fI+TEoxT9gBfMmemaF80t36uwAT5BOlArlmMnrJ9uDl90s+Aq9jB0
        BJr54QVbusO7OsZIWyVAOjT6SJKkYoe5Y1jbxTsXDp1rX2Tz8erU2n9puhhEcytV7W75Bs0PS1eP3
        b68lYIsMkGbynrZgODGQKqTw2ogHm7D9ItXeky2OARUw1/R4Kvo4UMAiSHN5N81Z82uKJDWrnmPkz
        P3c+9G56g==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8C-0005aL-Vz; Sun, 15 Apr 2018 14:59:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/12] iommu-common: move to arch/sparc
Date:   Sun, 15 Apr 2018 16:59:36 +0200
Message-Id: <20180415145947.1248-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

This code is only used by sparc, and all new iommu drivers should use the
drivers/iommu/ framework.  Also remove the unused exports.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 {include/linux => arch/sparc/include/asm}/iommu-common.h | 0
 arch/sparc/include/asm/iommu_64.h                        | 2 +-
 arch/sparc/kernel/Makefile                               | 2 +-
 {lib => arch/sparc/kernel}/iommu-common.c                | 5 +----
 arch/sparc/kernel/iommu.c                                | 2 +-
 arch/sparc/kernel/ldc.c                                  | 2 +-
 arch/sparc/kernel/pci_sun4v.c                            | 2 +-
 lib/Makefile                                             | 2 +-
 8 files changed, 7 insertions(+), 10 deletions(-)
 rename {include/linux => arch/sparc/include/asm}/iommu-common.h (100%)
 rename {lib => arch/sparc/kernel}/iommu-common.c (98%)

diff --git a/include/linux/iommu-common.h b/arch/sparc/include/asm/iommu-common.h
similarity index 100%
rename from include/linux/iommu-common.h
rename to arch/sparc/include/asm/iommu-common.h
diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 9ed6b54caa4b..0ef6dedf747e 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -17,7 +17,7 @@
 #define IOPTE_WRITE   0x0000000000000002UL
 
 #define IOMMU_NUM_CTXS	4096
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 struct iommu_arena {
 	unsigned long	*map;
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 76cb57750dda..a284662b0e4c 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_SPARC32)   += leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
-obj-$(CONFIG_SPARC64)   += iommu.o
+obj-$(CONFIG_SPARC64)   += iommu.o iommu-common.o
 obj-$(CONFIG_SPARC64)   += central.o
 obj-$(CONFIG_SPARC64)   += starfire.o
 obj-$(CONFIG_SPARC64)   += power.o
diff --git a/lib/iommu-common.c b/arch/sparc/kernel/iommu-common.c
similarity index 98%
rename from lib/iommu-common.c
rename to arch/sparc/kernel/iommu-common.c
index 55b00de106b5..59cb16691322 100644
--- a/lib/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -8,9 +8,9 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/iommu-helper.h>
-#include <linux/iommu-common.h>
 #include <linux/dma-mapping.h>
 #include <linux/hash.h>
+#include <asm/iommu-common.h>
 
 static unsigned long iommu_large_alloc = 15;
 
@@ -93,7 +93,6 @@ void iommu_tbl_pool_init(struct iommu_map_table *iommu,
 	p->hint = p->start;
 	p->end = num_entries;
 }
-EXPORT_SYMBOL(iommu_tbl_pool_init);
 
 unsigned long iommu_tbl_range_alloc(struct device *dev,
 				struct iommu_map_table *iommu,
@@ -224,7 +223,6 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 
 	return n;
 }
-EXPORT_SYMBOL(iommu_tbl_range_alloc);
 
 static struct iommu_pool *get_pool(struct iommu_map_table *tbl,
 				   unsigned long entry)
@@ -264,4 +262,3 @@ void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
 	bitmap_clear(iommu->map, entry, npages);
 	spin_unlock_irqrestore(&(pool->lock), flags);
 }
-EXPORT_SYMBOL(iommu_tbl_range_free);
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index b08dc3416f06..40d008b0bd3e 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -14,7 +14,7 @@
 #include <linux/errno.h>
 #include <linux/iommu-helper.h>
 #include <linux/bitmap.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 86b625f9d8dc..c0fa3ef6cf01 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -16,7 +16,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #include <asm/hypervisor.h>
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 249367228c33..565d9ac883d0 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -16,7 +16,7 @@
 #include <linux/export.h>
 #include <linux/log2.h>
 #include <linux/of_device.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
diff --git a/lib/Makefile b/lib/Makefile
index ce20696d5a92..94203b5eecd4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,7 +147,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
-obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
-- 
2.17.0
