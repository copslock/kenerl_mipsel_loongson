Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2018 13:57:32 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:34369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990429AbeFZL5ZQtfYn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jun 2018 13:57:25 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D5FF5206ED; Tue, 26 Jun 2018 13:57:18 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AAE95203D9;
        Tue, 26 Jun 2018 13:57:18 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/2] mips: mscc: build FIT image for Ocelot
Date:   Tue, 26 Jun 2018 13:57:11 +0200
Message-Id: <20180626115712.11643-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Ocelot now has a u-boot port, allow building FIT images instead of relying
on the legacy detection and builtin DTB.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
---
Changes in v2:
 - require -> requires

 arch/mips/boot/dts/mscc/Makefile            |  2 +-
 arch/mips/generic/Kconfig                   | 12 +++++++++--
 arch/mips/generic/Platform                  |  1 +
 arch/mips/generic/board-ocelot_pcb123.its.S | 23 +++++++++++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/generic/board-ocelot_pcb123.its.S

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index 3c6aed9f5439..9a9bb7ea0503 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
-dtb-$(CONFIG_LEGACY_BOARD_OCELOT)	+= ocelot_pcb123.dtb
+dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index ba9b2c8cce68..08e33c6b2539 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -35,13 +35,13 @@ config LEGACY_BOARD_OCELOT
 	depends on LEGACY_BOARD_SEAD3=n
 	select LEGACY_BOARDS
 	select MSCC_OCELOT
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
 
 config MSCC_OCELOT
 	bool
 	select GPIOLIB
 	select MSCC_OCELOT_IRQ
-	select SYS_HAS_EARLY_PRINTK
-	select USE_GENERIC_EARLY_PRINTK_8250
 
 comment "FIT/UHI Boards"
 
@@ -65,6 +65,14 @@ config FIT_IMAGE_FDT_XILFPGA
 	  Enable this to include the FDT for the MIPSfpga platform
 	  from Imagination Technologies in the FIT kernel image.
 
+config FIT_IMAGE_FDT_OCELOT_PCB123
+	bool "Include FDT for Microsemi Ocelot PCB123"
+	select MSCC_OCELOT
+	help
+	  Enable this to include the FDT for the Ocelot PCB123 platform
+	  from Microsemi in the FIT kernel image.
+	  This requires u-boot on the platform.
+
 config VIRT_BOARD_RANCHU
 	bool "Support Ranchu platform for Android emulator"
 	help
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 0dd0d5d460a5..879cb80396c8 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,4 +16,5 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_OCELOT_PCB123) += board-ocelot_pcb123.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
diff --git a/arch/mips/generic/board-ocelot_pcb123.its.S b/arch/mips/generic/board-ocelot_pcb123.its.S
new file mode 100644
index 000000000000..5a7d5e1c878a
--- /dev/null
+++ b/arch/mips/generic/board-ocelot_pcb123.its.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/ {
+	images {
+		fdt@ocelot_pcb123 {
+			description = "MSCC Ocelot PCB123 Device Tree";
+			data = /incbin/("boot/dts/mscc/ocelot_pcb123.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		conf@ocelot_pcb123 {
+			description = "Ocelot Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ocelot_pcb123";
+		};
+	};
+};
-- 
2.18.0
