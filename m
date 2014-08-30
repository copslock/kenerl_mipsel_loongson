Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:06:45 +0200 (CEST)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:62221 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007493AbaH3CFfgx7eB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:35 +0200
Received: by mail-lb0-f181.google.com with SMTP id n15so3378737lbi.26
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7sZN9jQ8w/XeccZgKOLjidtjlX2AHt8cFTJtshSZyI=;
        b=yZF9DES0OG9QtdbJ/WmOUmuSIKUNNtuNT0/bmiD6XygvZL3CUH6jiflfbsdjV2MDlS
         HNKtqxl13fWiWazCuNv/6UGWKtLxWF8tnC8/mV08G/UTCL+RO8EB82IBrkt42RhGEBvV
         xNIiBVhgZNkVgkdiwW4HSmmDLz3gLwtK+t/Tvtl5DMgpX5tq5v9FIPQZ8WqJkjNO5xCz
         stYUMAXhQ2l+GA+4+S6uis/d1T1x44Zn6DznTBQoQKWD2ILlivGhBE17R4Z2Hqzc3pMs
         Nb7mtpvjg/IYxHvUzAqVLw9r0DhEo4V+zw58iEDK9b+MZ3UvA1A+KeShPvmlsTLnmU5M
         RdDQ==
X-Received: by 10.112.205.200 with SMTP id li8mr13808093lbc.70.1409364330118;
        Fri, 29 Aug 2014 19:05:30 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:29 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 5/5] MIPS: make PCI_DMA_BUS_IS_PHYS=1 constant
Date:   Sat, 30 Aug 2014 06:06:28 +0400
Message-Id: <1409364388-7108-6-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

No one of supported MIPS machines has an IOMMU unit, so we can safely define
PCI_DMA_BUS_IS_PHYS = 1. Also remove iommu flag from the pci controller
structure, since it is useless.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
---
 arch/mips/include/asm/pci.h      | 10 ++++------
 arch/mips/kernel/setup.c         |  7 -------
 arch/mips/pci/pci-ip32.c         |  1 -
 arch/mips/pci/pci.c              |  3 ---
 arch/mips/pnx833x/common/setup.c |  3 ---
 5 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 974b0e3..eae11b5 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -41,8 +41,6 @@ struct pci_controller {
 	   and XFree86. Eventually will be removed. */
 	unsigned int need_domain_info;
 
-	int iommu;
-
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
 	int (*get_busno)(void);
@@ -105,11 +103,11 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
 struct pci_dev;
 
 /*
- * The PCI address space does equal the physical memory address space.	The
- * networking and block device layers use this boolean for bounce buffer
- * decisions.  This is set if any hose does not have an IOMMU.
+ * The PCI address space does equal the physical memory address space.
+ * The networking and block device layers use this boolean for bounce
+ * buffer decisions.
  */
-extern unsigned int PCI_DMA_BUS_IS_PHYS;
+#define PCI_DMA_BUS_IS_PHYS     (1)
 
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7c1fe2b..0af4275 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -44,13 +44,6 @@ struct screen_info screen_info;
 #endif
 
 /*
- * Despite it's name this variable is even if we don't have PCI
- */
-unsigned int PCI_DMA_BUS_IS_PHYS;
-
-EXPORT_SYMBOL(PCI_DMA_BUS_IS_PHYS);
-
-/*
  * Setup information
  *
  * These are initialized so they are in the .data section
diff --git a/arch/mips/pci/pci-ip32.c b/arch/mips/pci/pci-ip32.c
index b1e061f..7ae89d0 100644
--- a/arch/mips/pci/pci-ip32.c
+++ b/arch/mips/pci/pci-ip32.c
@@ -116,7 +116,6 @@ static struct pci_controller mace_pci_controller = {
 	.pci_ops	= &mace_pci_ops,
 	.mem_resource	= &mace_pci_mem_resource,
 	.io_resource	= &mace_pci_io_resource,
-	.iommu		= 0,
 	.mem_offset	= MACE_PCI_MEM_OFFSET,
 	.io_offset	= 0,
 	.io_map_base	= CKSEG1ADDR(MACEPCI_LOW_IO),
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 1bf60b1..81d49a5 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -83,9 +83,6 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	LIST_HEAD(resources);
 	struct pci_bus *bus;
 
-	if (!hose->iommu)
-		PCI_DMA_BUS_IS_PHYS = 1;
-
 	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
 		next_busno = (*hose->get_busno)();
 
diff --git a/arch/mips/pnx833x/common/setup.c b/arch/mips/pnx833x/common/setup.c
index 99b4d94..8a7443b 100644
--- a/arch/mips/pnx833x/common/setup.c
+++ b/arch/mips/pnx833x/common/setup.c
@@ -38,9 +38,6 @@ extern void pnx833x_machine_power_off(void);
 
 int __init plat_mem_setup(void)
 {
-	/* fake pci bus to avoid bounce buffers */
-	PCI_DMA_BUS_IS_PHYS = 1;
-
 	/* set mips clock to 320MHz */
 #if defined(CONFIG_SOC_PNX8335)
 	PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
-- 
1.8.1.5
