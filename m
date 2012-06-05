Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:59:30 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43600 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903722Ab2FEVws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:52:48 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AT-000824-Fl; Tue, 05 Jun 2012 16:19:57 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 17/35] MIPS: Lasat: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:21 -0500
Message-Id: <1338931179-9611-18-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33548
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

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lasat/prom.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 8bd3994..0091351 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -2,19 +2,18 @@
  * PROM interface routines.
  */
 #include <linux/types.h>
-#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
-#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/ioport.h>
+#include <linux/cpu.h>
+
 #include <asm/fw/fw.h>
 #include <asm/lasat/lasat.h>
-#include <asm/cpu.h>
+#include <asm/lasat/eeprom.h>
 
 #include "at93c.h"
-#include <asm/lasat/eeprom.h>
 #include "prom.h"
 
 #define RESET_VECTOR	0xbfc00000
@@ -58,7 +57,7 @@ static void setup_prom_vectors(void)
 		__prom_putc = (void *)PROM_PUTC_ADDR;
 		prom_monitor = (void *)PROM_MONITOR_ADDR;
 	}
-	printk(KERN_DEBUG "prom vectors set up\n");
+	pr_debug("prom vectors set up\n");
 }
 
 static struct at93c_defs at93c_defs[N_MACHTYPES] = {
@@ -84,11 +83,11 @@ void __init prom_init(void)
 	setup_prom_vectors();
 
 	if (IS_LASAT_200()) {
-		printk(KERN_INFO "LASAT 200 board\n");
+		pr_info("LASAT 200 board\n");
 		lasat_ndelay_divider = LASAT_200_DIVIDER;
 		at93c = &at93c_defs[1];
 	} else {
-		printk(KERN_INFO "LASAT 100 board\n");
+		pr_info("LASAT 100 board\n");
 		lasat_ndelay_divider = LASAT_100_DIVIDER;
 		at93c = &at93c_defs[0];
 	}
-- 
1.7.10.3
