Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 14:29:31 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48064 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903754Ab2EBM3Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2012 14:29:24 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 04/14] MIPS: Add helper function to allow platforms to point at a DTB.
Date:   Wed,  2 May 2012 14:27:34 +0200
Message-Id: <1335961659-21358-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
References: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33115
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
Changes in V2
* remove unused size variable

 arch/mips/include/asm/prom.h |   11 +++++++++++
 arch/mips/kernel/prom.c      |   11 +++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

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
index 558b539..4c788d2 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -95,3 +95,14 @@ void __init device_tree_init(void)
 	/* free the space reserved for the dt blob */
 	free_mem_mach(base, size);
 }
+
+void __init __dt_setup_arch(struct boot_param_header *bph)
+{
+	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
+		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
+
+		return;
+	}
+
+	initial_boot_params = bph;
+}
-- 
1.7.9.1
