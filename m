Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:52:38 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55002 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903767Ab2FZEuT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:50:19 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbZ-0002zj-Jn; Mon, 25 Jun 2012 23:42:21 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 32/33] MIPS: vr41xx: Cleanup firmware support for vr41xx platforms.
Date:   Mon, 25 Jun 2012 23:41:47 -0500
Message-Id: <1340685708-14408-33-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33825
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
 arch/mips/vr41xx/common/init.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 2391632..a4c1f02 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -19,11 +19,9 @@
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/string.h>
 
-#include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/fw/fw.h>
 #include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 
@@ -59,17 +57,7 @@ void __init plat_mem_setup(void)
 
 void __init prom_init(void)
 {
-	int argc, i;
-	char **argv;
-
-	argc = fw_arg0;
-	argv = (char **)fw_arg1;
-
-	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
-		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
+	fw_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.7.10.3
