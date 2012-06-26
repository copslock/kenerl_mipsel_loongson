Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:56:56 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55025 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903787Ab2FZEvW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:22 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbQ-0002zj-5M; Mon, 25 Jun 2012 23:42:12 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 16/33] MIPS: Lasat: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:31 -0500
Message-Id: <1340685708-14408-17-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33835
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

Make changes based on running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lasat/prom.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 8bd3994..a2dbb04 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -9,12 +9,13 @@
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
@@ -84,11 +85,11 @@ void __init prom_init(void)
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
