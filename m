Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:41:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60755 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992912AbcHIMj1pvih4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:39:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 324E54FB65570;
        Tue,  9 Aug 2016 13:39:08 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:39:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/20] MIPS: SEAD3: Use generic restart-poweroff driver
Date:   Tue, 9 Aug 2016 13:35:38 +0100
Message-ID: <20160809123546.10190-14-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54449
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

Remove the custom platform code to restart when instructed to power off,
instead relying upon the generic restart-poweroff driver probed via DT
to do the same thing.

Remove also the halt implementation, which is incorrect. The generic
MIPS version will hang the system as halt should.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/sead3.dts  |  4 ++++
 arch/mips/configs/sead3_defconfig |  1 +
 arch/mips/mti-sead3/Makefile      |  1 -
 arch/mips/mti-sead3/sead3-reset.c | 31 -------------------------------
 4 files changed, 5 insertions(+), 32 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-reset.c

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index d661012..ae2e3ab 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -94,6 +94,10 @@
 			offset = <0x50>;
 			mask = <0x4d>;
 		};
+
+		poweroff {
+			compatible = "restart-poweroff";
+		};
 	};
 
 	system-controller@1f000200 {
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index 055af30..ab4c465 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -81,6 +81,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_SPI=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_RESTART=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SENSORS_ADT7475=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 04ea002..ad722c8 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -13,6 +13,5 @@ obj-y += sead3-display.o
 obj-y += sead3-dtshim.o
 obj-y += sead3-init.o
 obj-y += sead3-int.o
-obj-y += sead3-reset.o
 obj-y += sead3-setup.o
 obj-y += sead3-time.o
diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
deleted file mode 100644
index 8f548f0..0000000
--- a/arch/mips/mti-sead3/sead3-reset.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/io.h>
-#include <linux/pm.h>
-
-#include <asm/reboot.h>
-
-#define SOFTRES_REG	0x1f000050
-#define GORESET		0x4d
-
-static void mips_machine_halt(void)
-{
-	unsigned int __iomem *softres_reg =
-		ioremap(SOFTRES_REG, sizeof(unsigned int));
-
-	__raw_writel(GORESET, softres_reg);
-}
-
-static int __init mips_reboot_setup(void)
-{
-	_machine_halt = mips_machine_halt;
-	pm_power_off = mips_machine_halt;
-
-	return 0;
-}
-arch_initcall(mips_reboot_setup);
-- 
2.9.2
