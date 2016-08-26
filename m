Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:24:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15995 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992612AbcHZOWQ2Fg7n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:22:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 47BFE27FA617E;
        Fri, 26 Aug 2016 15:21:56 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:21:59 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/19] MIPS: SEAD3: Drop use of cobalt fbdev driver
Date:   Fri, 26 Aug 2016 15:17:46 +0100
Message-ID: <20160826141751.13121-15-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The 2 line * 16 character LCD display on the SEAD3 board has no real use
as a framebuffer device. It's far too small to produce any meaningful
output if used as the kernel console, SEAD3 is a development board that
will essentially always have a far more useful UART connection & the
code in sead3-display.c will overwrite whatever's on the display every
second anyway. Remove this unused code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/mti-sead3/Makefile    |  3 +--
 arch/mips/mti-sead3/sead3-lcd.c | 43 -----------------------------------------
 2 files changed, 1 insertion(+), 45 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-lcd.c

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index ad722c8..cb6d620 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -8,8 +8,7 @@
 # Copyright (C) 2012 MIPS Technoligies, Inc.  All rights reserved.
 # Steven J. Hill <sjhill@mips.com>
 #
-obj-y := sead3-lcd.o
-obj-y += sead3-display.o
+obj-y := sead3-display.o
 obj-y += sead3-dtshim.o
 obj-y += sead3-init.o
 obj-y += sead3-int.o
diff --git a/arch/mips/mti-sead3/sead3-lcd.c b/arch/mips/mti-sead3/sead3-lcd.c
deleted file mode 100644
index 10b10ed2..0000000
--- a/arch/mips/mti-sead3/sead3-lcd.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/platform_device.h>
-
-static struct resource __initdata sead3_lcd_resource = {
-		.start	= 0x1f000400,
-		.end	= 0x1f00041f,
-		.flags	= IORESOURCE_MEM,
-};
-
-static __init int sead3_lcd_add(void)
-{
-	struct platform_device *pdev;
-	int retval;
-
-	/* SEAD-3 and Cobalt platforms use same display type. */
-	pdev = platform_device_alloc("cobalt-lcd", -1);
-	if (!pdev)
-		return -ENOMEM;
-
-	retval = platform_device_add_resources(pdev, &sead3_lcd_resource, 1);
-	if (retval)
-		goto err_free_device;
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto err_free_device;
-
-	return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-	return retval;
-}
-
-device_initcall(sead3_lcd_add);
-- 
2.9.3
