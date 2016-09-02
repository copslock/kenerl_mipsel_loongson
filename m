Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:53:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992160AbcIBPwDgFUiA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:52:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8C210F264AED;
        Fri,  2 Sep 2016 16:51:41 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:51:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/12] MIPS: Malta: Probe pflash via DT
Date:   Fri, 2 Sep 2016 16:48:54 +0100
Message-ID: <20160902154859.24269-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55012
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

 arch/mips/boot/dts/mti/malta.dts            | 25 ++++++++++++++++
 arch/mips/configs/malta_defconfig           |  2 +-
 arch/mips/configs/malta_kvm_defconfig       |  2 +-
 arch/mips/configs/malta_kvm_guest_defconfig |  2 +-
 arch/mips/configs/maltaup_xpa_defconfig     |  2 +-
 arch/mips/mti-malta/Makefile                |  1 -
 arch/mips/mti-malta/malta-platform.c        | 44 -----------------------------
 7 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index ee43296..2e594ec 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -50,6 +50,31 @@
 		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pflash@1e000000 {
+		compatible = "intel,dt28f160", "cfi-flash";
+		reg = <0x1e000000 0x400000>;
+		bank-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		yamon@0 {
+			label = "YAMON";
+			reg = <0x0 0x100000>;
+			read-only;
+		};
+
+		user-fs@100000 {
+			label = "User FS";
+			reg = <0x100000 0x2e0000>;
+		};
+
+		board-config@3e0000 {
+			label = "Board Config";
+			reg = <0x3e0000 0x20000>;
+			read-only;
+		};
+	};
+
 	isa {
 		compatible = "isa";
 		#address-cells = <2>;
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 5afb484..d5d4816 100644
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
index 98f1387..ef6ef24 100644
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
index 3b5d591..3a49a77 100644
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
index 7322157..62e05eb 100644
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
index 5827af7..0407774 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -11,7 +11,6 @@ obj-y				+= malta-dtshim.o
 obj-y				+= malta-init.o
 obj-y				+= malta-int.o
 obj-y				+= malta-memory.o
-obj-y				+= malta-platform.o
 obj-y				+= malta-reset.o
 obj-y				+= malta-setup.o
 obj-y				+= malta-time.o
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 6433a39..cc67dbf 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -25,11 +25,8 @@
 #include <linux/serial_8250.h>
 #include <linux/module.h>
 #include <linux/irq.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <asm/mips-boards/maltaint.h>
-#include <mtd/mtd-abi.h>
 
 #define SMC_PORT(base, int)						\
 {									\
@@ -67,49 +64,8 @@ static struct platform_device malta_uart8250_device = {
 	},
 };
 
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
 static struct platform_device *malta_devices[] __initdata = {
 	&malta_uart8250_device,
-	&malta_flash_device,
 };
 
 static int __init malta_add_devices(void)
-- 
2.9.3
