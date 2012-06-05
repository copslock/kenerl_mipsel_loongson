Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:23:46 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43446 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903728Ab2FEVT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:19:59 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AP-000824-5U; Tue, 05 Jun 2012 16:19:53 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 08/35] MIPS: Cobalt: Cleanup firmware support for the Cobalt platform.
Date:   Tue,  5 Jun 2012 16:19:12 -0500
Message-Id: <1338931179-9611-9-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33522
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
 arch/mips/cobalt/setup.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index ec3b2c4..3fdd449 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -15,9 +15,9 @@
 #include <linux/ioport.h>
 #include <linux/pm.h>
 
-#include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/gt64120.h>
+#include <asm/fw/fw.h>
 
 #include <cobalt.h>
 
@@ -97,21 +97,9 @@ void __init plat_mem_setup(void)
 
 void __init prom_init(void)
 {
-	unsigned long memsz;
-	int argc, i;
-	char **argv;
+	fw_init_cmdline();
 
-	memsz = fw_arg0 & 0x7fff0000;
-	argc = fw_arg0 & 0x0000ffff;
-	argv = (char **)fw_arg1;
-
-	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
-		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
-
-	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
+	add_memory_region(0x0, (fw_arg0 & 0x7fff0000), BOOT_MEM_RAM);
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.7.10.3
