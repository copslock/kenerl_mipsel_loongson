Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 18:00:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30954 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026793AbbEVQAIzpvze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 18:00:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 40F07FD0140CB;
        Fri, 22 May 2015 17:00:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:54:57 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:54:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Michal Marek <mmarek@suse.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 11/15] MIPS: malta: probe pflash via DT
Date:   Fri, 22 May 2015 16:51:10 +0100
Message-ID: <1432309875-9712-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47568
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

Add the DT nodes required to probe the CFI compatible parallel monitor
flash found on the Malta development board, and remove the platform
code that was previously doing it. Delete the now-empty malta-platform.c
file. Adjust the Malta defconfigs that enable MTD & the pflash/CFI
driver to enable CONFIG_MTD_PHYSMAP_OF rather than CONFIG_MTD_PHYSMAP in
order to preserve their behaviour.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/malta.dts            | 25 ++++++++
 arch/mips/configs/malta_defconfig           |  2 +-
 arch/mips/configs/malta_kvm_defconfig       |  2 +-
 arch/mips/configs/malta_kvm_guest_defconfig |  2 +-
 arch/mips/configs/maltaup_xpa_defconfig     |  2 +-
 arch/mips/mti-malta/Makefile                |  2 +-
 arch/mips/mti-malta/malta-platform.c        | 90 -----------------------------
 7 files changed, 30 insertions(+), 95 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-platform.c

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 66df923..9720c66 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -117,5 +117,30 @@
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pflash@1e000000 {
+			compatible = "intel,dt28f160", "cfi-flash";
+			reg = <0x1e000000 0x400000>;
+			bank-width = <4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			yamon@0 {
+				label = "YAMON";
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			user-fs@100000 {
+				label = "User FS";
+				reg = <0x100000 0x2e0000>;
+			};
+
+			board-config@3e0000 {
+				label = "Board Config";
+				reg = <0x3e0000 0x20000>;
+				read-only;
+			};
+		};
 	};
 };
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 4f0528c..52b00ab 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -230,7 +230,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 815595d..7199654 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -235,7 +235,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index 2a0d7b0..9ba7149 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -234,7 +234,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 7d7714c..245bf14 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -231,7 +231,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 1d633fe..357fde1 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -6,7 +6,7 @@
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
 obj-y				:= malta-display.o malta-dt.o malta-dtshim.o malta-init.o \
-				   malta-int.o malta-memory.o malta-platform.o \
+				   malta-int.o malta-memory.o \
 				   malta-reset.o malta-setup.o malta-time.o
 
 obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
deleted file mode 100644
index c41b0e0..0000000
--- a/arch/mips/mti-malta/malta-platform.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006, 07 MIPS Technologies, Inc.
- *   written by Ralf Baechle (ralf@linux-mips.org)
- *     written by Ralf Baechle <ralf@linux-mips.org>
- *
- * Copyright (C) 2008 Wind River Systems, Inc.
- *   updated by Tiejun Chen <tiejun.chen@windriver.com>
- *
- * 1. Probe driver for the Malta's UART ports:
- *
- *   o 2 ports in the SMC SuperIO
- *   o 1 port in the CBUS UART, a discrete 16550 which normally is only used
- *     for bringups.
- *
- * We don't use 8250_platform.c on Malta as it would result in the CBUS
- * UART becoming ttyS0.
- *
- * 2. Register RTC-CMOS platform device on Malta.
- */
-#include <linux/init.h>
-#include <linux/serial_8250.h>
-#include <linux/mc146818rtc.h>
-#include <linux/module.h>
-#include <linux/irq.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/platform_device.h>
-#include <asm/mips-boards/maltaint.h>
-#include <mtd/mtd-abi.h>
-
-static struct mtd_partition malta_mtd_partitions[] = {
-	{
-		.name =		"YAMON",
-		.offset =	0x0,
-		.size =		0x100000,
-		.mask_flags =	MTD_WRITEABLE
-	}, {
-		.name =		"User FS",
-		.offset =	0x100000,
-		.size =		0x2e0000
-	}, {
-		.name =		"Board Config",
-		.offset =	0x3e0000,
-		.size =		0x020000,
-		.mask_flags =	MTD_WRITEABLE
-	}
-};
-
-static struct physmap_flash_data malta_flash_data = {
-	.width		= 4,
-	.nr_parts	= ARRAY_SIZE(malta_mtd_partitions),
-	.parts		= malta_mtd_partitions
-};
-
-static struct resource malta_flash_resource = {
-	.start		= 0x1e000000,
-	.end		= 0x1e3fffff,
-	.flags		= IORESOURCE_MEM
-};
-
-static struct platform_device malta_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &malta_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &malta_flash_resource,
-};
-
-static struct platform_device *malta_devices[] __initdata = {
-	&malta_flash_device,
-};
-
-static int __init malta_add_devices(void)
-{
-	int err;
-
-	err = platform_add_devices(malta_devices, ARRAY_SIZE(malta_devices));
-	if (err)
-		return err;
-
-	return 0;
-}
-
-device_initcall(malta_add_devices);
-- 
2.4.1
