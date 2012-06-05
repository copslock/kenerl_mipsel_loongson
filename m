Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:51:40 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43556 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903722Ab2FEVuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:50:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AR-000824-Hb; Tue, 05 Jun 2012 16:19:55 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 13/35] MIPS: jz4740: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:17 -0500
Message-Id: <1338931179-9611-14-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33529
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
 arch/mips/jz4740/prom.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index c5071ab..ea86605 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -1,23 +1,14 @@
 /*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC prom code
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *  JZ4740 SoC prom code
  *
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-
 #include <linux/serial_reg.h>
 
 #include <asm/fw/fw.h>
@@ -33,7 +24,9 @@ void __init prom_free_prom_memory(void)
 {
 }
 
-#define UART_REG(_reg) ((void __iomem *)CKSEG1ADDR(JZ4740_UART0_BASE_ADDR + (_reg << 2)))
+#define UART_REG(_reg)							\
+	((volatile void __iomem *)CKSEG1ADDR(JZ4740_UART0_BASE_ADDR +	\
+	(_reg << 2)))
 
 void prom_putchar(char c)
 {
-- 
1.7.10.3
