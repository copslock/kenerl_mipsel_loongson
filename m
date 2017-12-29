Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:29:57 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:34402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbdL2IVMLenYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:21:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X9lV5gZVSFaehJusRePmbRyMMEAIYvW4yIoIjhiNNHw=; b=hVVezyvMjZqy5yY6WCSfTnWKl
        Fs78QbiFcAURc9T67vtpwdKNly09WwvkLbWMN0UNgiLJMrdp06S34pH8yRdw0qsuqzBWmeGMNzN5Y
        9Y94uCKPVQN3hAnAaxTAraYvvnSP4m6Ik6eb0ABVm1FO25Hj6wY8+DgAJQtckLCbm3nMIrAzrrC9L
        iVL19FgTh6GVpRVey9KKeWPD15H0A8tNL6oz7fMWZTLRJvUeZc1Y51jCWV++3ZWn2jrHXIdKzJOLk
        BZYjZvALd9B/zCC86R332pePEXvRTHNy/jj/7014V1zGKg7rDH1RM2VQub4fU4ZqY+FB4mOdt0CMP
        RE31nyixg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpua-0001f8-2I; Fri, 29 Dec 2017 08:21:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/67] dma-mapping: provide a generic asm/dma-mapping.h
Date:   Fri, 29 Dec 2017 09:18:28 +0100
Message-Id: <20171229081911.2802-25-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61721
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

For architectures that just use the generic dma_noop_ops we can provide
a generic version of dma-mapping.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                          |  1 +
 arch/m32r/include/asm/Kbuild         |  1 +
 arch/m32r/include/asm/dma-mapping.h  | 17 -----------------
 arch/riscv/include/asm/Kbuild        |  1 +
 arch/riscv/include/asm/dma-mapping.h | 30 ------------------------------
 arch/s390/include/asm/Kbuild         |  1 +
 arch/s390/include/asm/dma-mapping.h  | 17 -----------------
 include/asm-generic/dma-mapping.h    | 10 ++++++++++
 8 files changed, 14 insertions(+), 64 deletions(-)
 delete mode 100644 arch/m32r/include/asm/dma-mapping.h
 delete mode 100644 arch/riscv/include/asm/dma-mapping.h
 delete mode 100644 arch/s390/include/asm/dma-mapping.h
 create mode 100644 include/asm-generic/dma-mapping.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7521b063b499..a8b35d9f41b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4340,6 +4340,7 @@ F:	lib/dma-noop.c
 F:	lib/dma-virt.c
 F:	drivers/base/dma-mapping.c
 F:	drivers/base/dma-coherent.c
+F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
 
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 7e11b125c35e..ca83fda8177b 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += clkdev.h
 generic-y += current.h
+generic-y += dma-mapping.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += irq_work.h
diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
deleted file mode 100644
index 8967fb659691..000000000000
--- a/arch/m32r/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_M32R_DMA_MAPPING_H
-#define _ASM_M32R_DMA_MAPPING_H
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <linux/io.h>
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &dma_noop_ops;
-}
-
-#endif /* _ASM_M32R_DMA_MAPPING_H */
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 970460a0b492..197460ccbf21 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
deleted file mode 100644
index 73849e2cc761..000000000000
--- a/arch/riscv/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2003-2004 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- * Copyright (C) 2012 ARM Ltd.
- * Copyright (C) 2016 SiFive, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_RISCV_DMA_MAPPING_H
-#define __ASM_RISCV_DMA_MAPPING_H
-
-/* Use ops->dma_mapping_error (if it exists) or assume success */
-// #undef DMA_ERROR_CODE
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &dma_noop_ops;
-}
-
-#endif	/* __ASM_RISCV_DMA_MAPPING_H */
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 048450869328..dade72be127b 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += cacheflush.h
 generic-y += clkdev.h
 generic-y += device.h
 generic-y += dma-contiguous.h
+generic-y += dma-mapping.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += export.h
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
deleted file mode 100644
index bdc2455483f6..000000000000
--- a/arch/s390/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_S390_DMA_MAPPING_H
-#define _ASM_S390_DMA_MAPPING_H
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <linux/io.h>
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &dma_noop_ops;
-}
-
-#endif /* _ASM_S390_DMA_MAPPING_H */
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
new file mode 100644
index 000000000000..164031531d85
--- /dev/null
+++ b/include/asm-generic/dma-mapping.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_DMA_MAPPING_H
+#define _ASM_GENERIC_DMA_MAPPING_H
+
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+{
+	return &dma_noop_ops;
+}
+
+#endif /* _ASM_GENERIC_DMA_MAPPING_H */
-- 
2.14.2
