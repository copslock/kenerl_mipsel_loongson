Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:46:06 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54961 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903761Ab2FZEmO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:42:14 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbM-0002zj-4z; Mon, 25 Jun 2012 23:42:08 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 09/33] MIPS: Emma: Cleanup firmware support for the Emma platform.
Date:   Mon, 25 Jun 2012 23:41:24 -0500
Message-Id: <1340685708-14408-10-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33817
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
 arch/mips/emma/common/prom.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/mips/emma/common/prom.c b/arch/mips/emma/common/prom.c
index cae4225..5228584 100644
--- a/arch/mips/emma/common/prom.c
+++ b/arch/mips/emma/common/prom.c
@@ -25,7 +25,7 @@
 #include <linux/bootmem.h>
 
 #include <asm/addrspace.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/emma/emma2rh.h>
 
 const char *get_system_type(void)
@@ -40,22 +40,7 @@ const char *get_system_type(void)
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	char **arg = (char **)fw_arg1;
-	int i;
-
-	/* if user passes kernel args, ignore the default one */
-	if (argc > 1)
-		arcs_cmdline[0] = '\0';
-
-	/* arg[0] is "g", the rest is boot parameters */
-	for (i = 1; i < argc; i++) {
-		if (strlen(arcs_cmdline) + strlen(arg[i]) + 1
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, arg[i]);
-		strcat(arcs_cmdline, " ");
-	}
+	fw_init_cmdline();
 
 #ifdef CONFIG_NEC_MARKEINS
 	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
-- 
1.7.10.3
