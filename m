Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:15:38 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60372 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823707Ab2LGFPPTkVtE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:15:15 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqHF-0007PC-B4; Thu, 06 Dec 2012 23:15:09 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Clean-ups for MIPS Technologies Inc. generic header file.
Date:   Thu,  6 Dec 2012 23:15:03 -0600
Message-Id: <1354857303-28905-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35227
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

Clean up standard header text and remove unused #define.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mips-boards/generic.h |   28 +++++++--------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 6e23ceb..fa188ff 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -1,21 +1,14 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * This program is free software; you can distribute it and/or modify it
- * under the terms of the GNU General Public License (Version 2) as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
  * Defines of the MIPS boards specific address-MAP, registers, etc.
+ *
+ * Copyright (C) 2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
 #ifndef __ASM_MIPS_BOARDS_GENERIC_H
 #define __ASM_MIPS_BOARDS_GENERIC_H
@@ -30,13 +23,6 @@
 #define ASCII_DISPLAY_WORD_BASE    0x1f000410
 #define ASCII_DISPLAY_POS_BASE     0x1f000418
 
-
-/*
- * Yamon Prom print address.
- */
-#define YAMON_PROM_PRINT_ADDR      0x1fc00504
-
-
 /*
  * Reset register.
  */
-- 
1.7.9.5
