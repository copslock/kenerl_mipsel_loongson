Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:54:14 +0200 (CEST)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:63580 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009019AbaIOXvot1PsL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:44 +0200
Received: by mail-ob0-f202.google.com with SMTP id vb8so381883obc.5
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ge7/U9dJ5XcfLB52e0zcPjCV+CF6Qk3zMHbZc0WHzac=;
        b=dNkkaJxcbci0wNy9qIkm+z5z+qLo8gCAX4SXzNs8cxdzO08m0jXaSIbqNrYVJFXIBY
         cLzZh/Hhwh0ks+in1eklPM7NDixgqNNip0Bo5dgNqH+HksR8NFE/w1S6/yhf0n3gEhnz
         3rPb4a0dXTgoh5p5iaqWh8N2iISQaY8OgUYudLZzkS93s0r0G/VceISkYOGWzVqxCvfj
         8L1rbnlLTfWVuUg6DwLzOXfyAkfZFuS25b2BgZNiPsVgnfcDA106InWB0s5IhEbJfK8D
         dlqXbzAn2h/Hwa5IExp8mMcZlV/7NUURMWeHddsr8TzJF2h5lW65CN2hXkoxfJ4ocfd6
         zCkQ==
X-Gm-Message-State: ALoCoQkVR8GTsa1IeRrawzKretXGkNYtY+cGLXGb947RHDmllgNcC+FyBHQEc//9BTlAIxKP9ND3
X-Received: by 10.182.166.73 with SMTP id ze9mr17296285obb.4.1410825099023;
        Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si627501yhm.7.2014.09.15.16.51.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id pSykdCfm.3; Mon, 15 Sep 2014 16:51:38 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id E1CC9220868; Mon, 15 Sep 2014 16:51:37 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/24] MIPS: sead3: Remove sead3-serial.c
Date:   Mon, 15 Sep 2014 16:51:12 -0700
Message-Id: <1410825087-5497-10-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

It's a duplicate of sead3-platform.c and is not even compiled.
Remove it before we start fixing up IRQ assignments.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-sead3/sead3-serial.c | 45 --------------------------------------
 1 file changed, 45 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-serial.c

diff --git a/arch/mips/mti-sead3/sead3-serial.c b/arch/mips/mti-sead3/sead3-serial.c
deleted file mode 100644
index bc52705..0000000
--- a/arch/mips/mti-sead3/sead3-serial.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/serial_8250.h>
-
-#define UART(base, int)							\
-{									\
-	.mapbase	= base,						\
-	.irq		= int,						\
-	.uartclk	= 14745600,					\
-	.iotype		= UPIO_MEM32,					\
-	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP, \
-	.regshift	= 2,						\
-}
-
-static struct plat_serial8250_port uart8250_data[] = {
-	UART(0x1f000900, MIPS_CPU_IRQ_BASE + 4),   /* ttyS0 = USB   */
-	UART(0x1f000800, MIPS_CPU_IRQ_BASE + 4),   /* ttyS1 = RS232 */
-	{ },
-};
-
-static struct platform_device uart8250_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= uart8250_data,
-	},
-};
-
-static int __init uart8250_init(void)
-{
-	return platform_device_register(&uart8250_device);
-}
-
-module_init(uart8250_init);
-
-MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("8250 UART probe driver for the SEAD-3 platform");
-- 
2.1.0.rc2.206.gedb03e5
