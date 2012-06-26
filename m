Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:53:28 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55007 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903770Ab2FZEub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:50:31 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbX-0002zj-Nl; Mon, 25 Jun 2012 23:42:19 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 29/33] MIPS: RB532: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:44 -0500
Message-Id: <1340685708-14408-30-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33827
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
 arch/mips/rb532/prom.c |   38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 54f5399..c2c08c0 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -1,37 +1,19 @@
 /*
- *  RouterBoard 500 specific prom routines
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright (C) 2003, Peter Sadik <peter.sadik@idt.com>
- *  Copyright (C) 2005-2006, P.Christeas <p_christ@hol.gr>
- *  Copyright (C) 2007, Gabor Juhos <juhosg@openwrt.org>
- *			Felix Fietkau <nbd@openwrt.org>
- *			Florian Fainelli <florian@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the
- *  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
- *  Boston, MA  02110-1301, USA.
+ * RouterBoard 500 specific prom routines
  *
+ * Copyright (C) 2003, Peter Sadik <peter.sadik@idt.com>
+ * Copyright (C) 2005-2006, P.Christeas <p_christ@hol.gr>
+ * Copyright (C) 2007, Gabor Juhos <juhosg@openwrt.org>
+ *                     Felix Fietkau <nbd@openwrt.org>
+ *                     Florian Fainelli <florian@openwrt.org>
  */
-
 #include <linux/init.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/console.h>
-#include <linux/bootmem.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
 
 #include <asm/fw/fw.h>
 #include <asm/mach-rc32434/ddr.h>
@@ -129,7 +111,7 @@ void __init prom_init(void)
 			ddr_reg[0].end - ddr_reg[0].start);
 
 	if (!ddr) {
-		printk(KERN_ERR "Unable to remap DDR register\n");
+		pr_err("Unable to remap DDR register\n");
 		return;
 	}
 
-- 
1.7.10.3
