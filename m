Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 08:58:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55372 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903417Ab2GVG43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 08:56:29 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/5] MIPS: lantiq: adds device_tree_init function
Date:   Sun, 22 Jul 2012 08:56:00 +0200
Message-Id: <1342940161-1421-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33952
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add a lantiq specific version of device_tree_init. The generic MIPS version
was removed by.

commit 594e966bc412d64eec9282d28ce511bdd62fea39
Author: David Daney <david.daney@cavium.com>
Date:   Thu Jul 5 18:12:38 2012 +0200

MIPS: Prune some target specific code out of prom.c

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 05a3364..e537099 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -8,7 +8,10 @@
 
 #include <linux/export.h>
 #include <linux/clk.h>
+#include <linux/bootmem.h>
 #include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 
@@ -74,6 +77,25 @@ void __init plat_mem_setup(void)
 	__dt_setup_arch(bph);
 }
 
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
+
+	if (!initial_boot_params)
+		return;
+
+	base = virt_to_phys((void *)initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
+
+	/* Before we do anything, lets reserve the dt blob */
+	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
+
+	unflatten_device_tree();
+
+	/* free the space reserved for the dt blob */
+	free_bootmem(base, size);
+}
+
 void __init prom_init(void)
 {
 	/* call the soc specific detetcion code and get it to fill soc_info */
-- 
1.7.9.1
