Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:35:55 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56980 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903710Ab2D3Led (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 04/14] MIPS: Add helper function to allow platforms to point at a DTB.
Date:   Mon, 30 Apr 2012 13:32:59 +0200
Message-Id: <1335785589-32532-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add __dt_setup_arch() that can be called to load a builtin DT.
Additionally we add a macro to allow loading a specific symbol
from the __dtb_* section.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/prom.h |   11 +++++++++++
 arch/mips/kernel/prom.c      |   14 ++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 40ed259..7206d44 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -36,6 +36,17 @@ static inline unsigned long pci_address_to_pio(phys_addr_t address)
 }
 #define pci_address_to_pio pci_address_to_pio
 
+struct boot_param_header;
+
+extern void __dt_setup_arch(struct boot_param_header *bph);
+
+#define dt_setup_arch(sym)						\
+({									\
+	extern struct boot_param_header __dtb_##sym##_begin;		\
+									\
+	__dt_setup_arch(&__dtb_##sym##_begin);				\
+})
+
 #else /* CONFIG_OF */
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 558b539..271ad98 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -95,3 +95,17 @@ void __init device_tree_init(void)
 	/* free the space reserved for the dt blob */
 	free_mem_mach(base, size);
 }
+
+void __init __dt_setup_arch(struct boot_param_header *bph)
+{
+	unsigned long size;
+
+	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
+		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
+
+		return;
+	}
+
+	initial_boot_params = bph;
+	size = be32_to_cpu(bph->totalsize);
+}
-- 
1.7.9.1
