Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 08:39:00 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47812 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820514Ab3DKGi6w1lvY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Apr 2013 08:38:58 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: move mips_{set,get}_machine_name() to a more generic place
Date:   Thu, 11 Apr 2013 08:34:59 +0200
Message-Id: <1365662099-3981-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Previously this functionality was only available to users of the mips_machine
api. Moving the code to prom.c allows us to also add a OF wrapper.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mips_machine.h |    4 ----
 arch/mips/include/asm/prom.h         |    3 +++
 arch/mips/kernel/mips_machine.c      |   20 --------------------
 arch/mips/kernel/proc.c              |    1 +
 arch/mips/kernel/prom.c              |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/mips_machine.h b/arch/mips/include/asm/mips_machine.h
index 363bb35..9d00aeb 100644
--- a/arch/mips/include/asm/mips_machine.h
+++ b/arch/mips/include/asm/mips_machine.h
@@ -42,13 +42,9 @@ extern long __mips_machines_end;
 #ifdef CONFIG_MIPS_MACHINE
 int  mips_machtype_setup(char *id) __init;
 void mips_machine_setup(void) __init;
-void mips_set_machine_name(const char *name) __init;
-char *mips_get_machine_name(void);
 #else
 static inline int mips_machtype_setup(char *id) { return 1; }
 static inline void mips_machine_setup(void) { }
-static inline void mips_set_machine_name(const char *name) { }
-static inline char *mips_get_machine_name(void) { return NULL; }
 #endif /* CONFIG_MIPS_MACHINE */
 
 #endif /* __ASM_MIPS_MACHINE_H */
diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 8808bf5..1e7e096 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -48,4 +48,7 @@ extern void __dt_setup_arch(struct boot_param_header *bph);
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
 
+extern char *mips_get_machine_name(void);
+extern void mips_set_machine_name(const char *name);
+
 #endif /* __ASM_PROM_H */
diff --git a/arch/mips/kernel/mips_machine.c b/arch/mips/kernel/mips_machine.c
index 411a058..8b4af4b 100644
--- a/arch/mips/kernel/mips_machine.c
+++ b/arch/mips/kernel/mips_machine.c
@@ -13,7 +13,6 @@
 #include <asm/mips_machine.h>
 
 static struct mips_machine *mips_machine __initdata;
-static char *mips_machine_name = "Unknown";
 
 #define for_each_machine(mach) \
 	for ((mach) = (struct mips_machine *)&__mips_machines_start; \
@@ -21,25 +20,6 @@ static char *mips_machine_name = "Unknown";
 	     (unsigned long)(mach) < (unsigned long)&__mips_machines_end; \
 	     (mach)++)
 
-__init void mips_set_machine_name(const char *name)
-{
-	char *p;
-
-	if (name == NULL)
-		return;
-
-	p = kstrdup(name, GFP_KERNEL);
-	if (!p)
-		pr_err("MIPS: no memory for machine_name\n");
-
-	mips_machine_name = p;
-}
-
-char *mips_get_machine_name(void)
-{
-	return mips_machine_name;
-}
-
 __init int mips_machtype_setup(char *id)
 {
 	struct mips_machine *mach;
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 7a54f74..fcdedfb 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -12,6 +12,7 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
+#include <asm/prom.h>
 #include <asm/mips_machine.h>
 
 unsigned int vced_count, vcei_count;
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 028f6f8..9d653e1 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -23,6 +23,21 @@
 #include <asm/page.h>
 #include <asm/prom.h>
 
+static char mips_machine_name[64] = "Unknown";
+
+__init void mips_set_machine_name(const char *name)
+{
+	if (name == NULL)
+		return;
+
+	snprintf(mips_machine_name, sizeof(mips_machine_name), name);
+}
+
+char *mips_get_machine_name(void)
+{
+	return mips_machine_name;
+}
+
 int __init early_init_dt_scan_memory_arch(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -50,6 +65,21 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
+int __init early_init_dt_scan_model(unsigned long node,
+	const char *uname, int depth,
+	void *data)
+{
+	if (!depth) {
+		char *model = of_get_flat_dt_prop(node, "model", NULL);
+		if (model) {
+			mips_set_machine_name(model);
+			pr_info("MIPS: machine is %s\n",
+					mips_get_machine_name());
+		}
+	}
+	return 0;
+}
+
 void __init early_init_devtree(void *params)
 {
 	/* Setup flat device-tree pointer */
@@ -65,6 +95,9 @@ void __init early_init_devtree(void *params)
 	/* Scan memory nodes */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
+
+	/* try to load the mips machine name */
+	of_scan_flat_dt(early_init_dt_scan_model, NULL);
 }
 
 void __init __dt_setup_arch(struct boot_param_header *bph)
-- 
1.7.10.4
