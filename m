Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:57:57 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55030 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903776Ab2FZEvf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:35 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbN-0002zj-9F; Mon, 25 Jun 2012 23:42:09 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 11/33] MIPS: jz4740: Cleanup firmware support for the JZ4740 platform.
Date:   Mon, 25 Jun 2012 23:41:26 -0500
Message-Id: <1340685708-14408-12-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33837
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
 arch/mips/jz4740/prom.c |   25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 4a70407..c5071ab 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -20,33 +20,12 @@
 
 #include <linux/serial_reg.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-jz4740/base.h>
 
-static __init void jz4740_init_cmdline(int argc, char *argv[])
-{
-	unsigned int count = COMMAND_LINE_SIZE - 1;
-	int i;
-	char *dst = &(arcs_cmdline[0]);
-	char *src;
-
-	for (i = 1; i < argc && count; ++i) {
-		src = argv[i];
-		while (*src && count) {
-			*dst++ = *src++;
-			--count;
-		}
-		*dst++ = ' ';
-	}
-	if (i > 1)
-		--dst;
-
-	*dst = 0;
-}
-
 void __init prom_init(void)
 {
-	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+	fw_init_cmdline();
 	mips_machtype = MACH_INGENIC_JZ4740;
 }
 
-- 
1.7.10.3
