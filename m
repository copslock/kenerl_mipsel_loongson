Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:22:56 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43442 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903726Ab2FEVT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:19:58 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AO-000824-3o; Tue, 05 Jun 2012 16:19:52 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 06/35] MIPS: ath79: Cleanup firmware support for the ath79 platform.
Date:   Tue,  5 Jun 2012 16:19:10 -0500
Message-Id: <1338931179-9611-7-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33520
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
 arch/mips/ath79/prom.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index e9cbd7c..adbe614 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/string.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/addrspace.h>
 
 #include "common.h"
@@ -32,23 +32,11 @@ static inline int is_valid_ram_addr(void *addr)
 	return 0;
 }
 
-static __init void ath79_prom_init_cmdline(int argc, char **argv)
-{
-	int i;
-
-	if (!is_valid_ram_addr(argv))
-		return;
-
-	for (i = 0; i < argc; i++)
-		if (is_valid_ram_addr(argv[i])) {
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, argv[i], sizeof(arcs_cmdline));
-		}
-}
-
 void __init prom_init(void)
 {
-	ath79_prom_init_cmdline(fw_arg0, (char **)fw_arg1);
+	if (!is_valid_ram_addr((int *)fw_arg1))
+		return;
+	fw_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.7.10.3
