Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 08:44:31 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:49230 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491013Ab0JMGo2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Oct 2010 08:44:28 +0200
Received: by pzk2 with SMTP id 2so3565pzk.36
        for <multiple recipients>; Tue, 12 Oct 2010 23:44:19 -0700 (PDT)
Received: by 10.142.192.17 with SMTP id p17mr7206627wff.386.1286952254284;
        Tue, 12 Oct 2010 23:44:14 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id x35sm3244125wfd.13.2010.10.12.23.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 23:44:13 -0700 (PDT)
Received: from localhost6.localdomain6 (unknown [IPv6:::1])
        by angua (Postfix) with ESMTP id E639C3C00E3;
        Wed, 13 Oct 2010 00:44:11 -0600 (MDT)
Subject: [PATCH 1/2] of/flattree: Eliminate need to provide
        early_init_dt_scan_chosen_arch
To:     benh@kernel.crashing.org, dediao@cisco.com, ralf@linux-mips.org
From:   Grant Likely <grant.likely@secretlab.ca>
Cc:     linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org, ddaney@caviumnetworks.com
Date:   Wed, 13 Oct 2010 00:44:11 -0600
Message-ID: <20101013064352.2743.80378.stgit@localhost6.localdomain6>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

This patch refactors the early init parsing of the chosen node so that
architectures aren't forced to provide an empty implementation of
early_init_dt_scan_chosen_arch.  Instead, if an architecture wants to
do something different, it can either use a wrapper function around
early_init_dt_scan_chosen(), or it can replace it altogether.

This patch was written in preparation to adding device tree support to
both x86 ad MIPS.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/microblaze/kernel/prom.c |    5 -----
 arch/powerpc/kernel/prom.c    |   12 ++++++++++--
 drivers/of/fdt.c              |    2 --
 include/linux/of_fdt.h        |    2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 427b13b..bacbd3d 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -42,11 +42,6 @@
 #include <asm/sections.h>
 #include <asm/pci-bridge.h>
 
-void __init early_init_dt_scan_chosen_arch(unsigned long node)
-{
-	/* No Microblaze specific code here */
-}
-
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	memblock_add(base, size);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fed9bf6..e296aae 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -363,10 +363,15 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-void __init early_init_dt_scan_chosen_arch(unsigned long node)
+int __init early_init_dt_scan_chosen_ppc(unsigned long node, const char *uname,
+					 int depth, void *data)
 {
 	unsigned long *lprop;
 
+	/* Use common scan routine to determine if this is the chosen node */
+	if (early_init_dt_scan_chosen(node, uname, depth, data) == 0)
+		return 0;
+
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
 	if (of_get_flat_dt_prop(node, "linux,iommu-off", NULL) != NULL)
@@ -398,6 +403,9 @@ void __init early_init_dt_scan_chosen_arch(unsigned long node)
 	if (lprop)
 		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
+
+	/* break now */
+	return 1;
 }
 
 #ifdef CONFIG_PPC_PSERIES
@@ -679,7 +687,7 @@ void __init early_init_devtree(void *params)
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
 	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
+	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, NULL);
 
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	memblock_init();
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 65da5ae..c1360e0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -533,8 +533,6 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif /* CONFIG_CMDLINE */
 
-	early_init_dt_scan_chosen_arch(node);
-
 	pr_debug("Command line is: %s\n", cmd_line);
 
 	/* break now */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 71e1a91..7bbf5b3 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -72,7 +72,7 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
-extern void early_init_dt_scan_chosen_arch(unsigned long node);
+
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern void early_init_dt_check_for_initrd(unsigned long node);
