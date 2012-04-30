Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:35:30 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56979 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903709Ab2D3Led (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [PATCH 03/14] MIPS: Provide pci_address_to_pio.
Date:   Mon, 30 Apr 2012 13:32:58 +0200
Message-Id: <1335785589-32532-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ralf Baechle <ralf@linux-mips.org>

Without I/O ports won't work.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/prom.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 7a6e82e..40ed259 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -12,6 +12,9 @@
 #define __ASM_PROM_H
 
 #ifdef CONFIG_OF
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/types.h>
 #include <asm/bootinfo.h>
 
 extern int early_init_dt_scan_memory_arch(unsigned long node,
@@ -21,6 +24,18 @@ extern int reserve_mem_mach(unsigned long addr, unsigned long size);
 extern void free_mem_mach(unsigned long addr, unsigned long size);
 
 extern void device_tree_init(void);
+
+static inline unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	/*
+	 * The ioport address can be directly used by inX() / outX()
+	 */
+	BUG_ON(address > IO_SPACE_LIMIT);
+
+	return (unsigned long) address;
+}
+#define pci_address_to_pio pci_address_to_pio
+
 #else /* CONFIG_OF */
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
-- 
1.7.9.1
