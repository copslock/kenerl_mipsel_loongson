Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 22:56:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:58492 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835281Ab3FMUzVB0ex2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 22:55:21 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UnEY6-0005JR-QY; Thu, 13 Jun 2013 15:55:14 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 3/3] MIPS: malta: Remove software reset defines from generic header.
Date:   Thu, 13 Jun 2013 15:55:06 -0500
Message-Id: <1371156906-31563-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
References: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Remove the software reset register and reset value definitions
from the 'include/asm/mips-boards/generic.h' header file. Also
clean up header and whitespace in platform file.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mips-boards/generic.h |    6 -----
 arch/mips/mti-malta/malta-reset.c           |   29 ++++----------------------
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index bd9746f..4861681 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -24,12 +24,6 @@
 #define ASCII_DISPLAY_POS_BASE	   0x1f000418
 
 /*
- * Reset register.
- */
-#define SOFTRES_REG	  0x1f000500
-#define GORESET		  0x42
-
-/*
  * Revision register.
  */
 #define MIPS_REVISION_REG		   0x1fc00010
diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 7911012..d627d4b 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -1,31 +1,14 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Reset the MIPS boards.
- *
  */
-#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/pm.h>
 
-#include <asm/io.h>
 #include <asm/reboot.h>
 
 #define SOFTRES_REG	0x1f000500
@@ -47,7 +30,6 @@ static void mips_machine_halt(void)
 	__raw_writel(GORESET, softres_reg);
 }
 
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
@@ -56,5 +38,4 @@ static int __init mips_reboot_setup(void)
 
 	return 0;
 }
-
 arch_initcall(mips_reboot_setup);
-- 
1.7.2.5
