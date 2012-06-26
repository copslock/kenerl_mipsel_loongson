Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:51:47 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54995 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903766Ab2FZEuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:50:02 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbO-0002zj-EM; Mon, 25 Jun 2012 23:42:10 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 13/33] MIPS: lantiq: Cleanup firmware support for the lantiq platform.
Date:   Mon, 25 Jun 2012 23:41:28 -0500
Message-Id: <1340685708-14408-14-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lantiq/prom.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index d185e84..aa9da9e 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -9,9 +9,9 @@
 #include <linux/export.h>
 #include <linux/clk.h>
 #include <linux/of_platform.h>
-#include <asm/bootinfo.h>
 #include <asm/time.h>
 
+#include <asm/fw/fw.h>
 #include <lantiq.h>
 
 #include "prom.h"
@@ -36,24 +36,6 @@ void prom_free_prom_memory(void)
 {
 }
 
-static void __init prom_init_cmdline(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) KSEG1ADDR(fw_arg1);
-	int i;
-
-	arcs_cmdline[0] = '\0';
-
-	for (i = 0; i < argc; i++) {
-		char *p = (char *) KSEG1ADDR(argv[i]);
-
-		if (CPHYSADDR(p) && *p) {
-			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
-		}
-	}
-}
-
 void __init plat_mem_setup(void)
 {
 	ioport_resource.start = IOPORT_RESOURCE_START;
@@ -78,7 +60,7 @@ void __init prom_init(void)
 		soc_info.name, soc_info.rev_type);
 	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
 	pr_info("SoC: %s\n", soc_info.sys_type);
-	prom_init_cmdline();
+	fw_init_cmdline();
 
 #if defined(CONFIG_MIPS_MT_SMP)
 	if (register_vsmp_smp_ops())
-- 
1.7.10.3
