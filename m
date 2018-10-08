Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 12:16:04 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:55883 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994551AbeJHKPXkvox8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2018 12:15:23 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 21DEB20DD2; Mon,  8 Oct 2018 12:15:17 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0018A20DB5;
        Mon,  8 Oct 2018 12:14:52 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [RESEND PATCH v2 5/5] MIPS: mscc: add PCB120 to the ocelot fitImage
Date:   Mon,  8 Oct 2018 12:14:45 +0200
Message-Id: <20181008101445.25946-6-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008101445.25946-1-quentin.schulz@bootlin.com>
References: <20181008101445.25946-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

PCB120 and PCB123 are both development boards based on Microsemi Ocelot
so let's use the same fitImage for both.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/generic/Kconfig                       |  6 +++---
 arch/mips/generic/Platform                      |  2 +-
 ...d-ocelot_pcb123.its.S => board-ocelot.its.S} | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)
 rename arch/mips/generic/{board-ocelot_pcb123.its.S => board-ocelot.its.S} (55%)

diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 08e33c6b2539..fd6019802657 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -65,11 +65,11 @@ config FIT_IMAGE_FDT_XILFPGA
 	  Enable this to include the FDT for the MIPSfpga platform
 	  from Imagination Technologies in the FIT kernel image.
 
-config FIT_IMAGE_FDT_OCELOT_PCB123
-	bool "Include FDT for Microsemi Ocelot PCB123"
+config FIT_IMAGE_FDT_OCELOT
+	bool "Include FDT for Microsemi Ocelot development platforms"
 	select MSCC_OCELOT
 	help
-	  Enable this to include the FDT for the Ocelot PCB123 platform
+	  Enable this to include the FDT for the Ocelot development platforms
 	  from Microsemi in the FIT kernel image.
 	  This requires u-boot on the platform.
 
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 879cb80396c8..eaa19d189324 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,5 +16,5 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
-its-$(CONFIG_FIT_IMAGE_FDT_OCELOT_PCB123) += board-ocelot_pcb123.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_OCELOT)	+= board-ocelot.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
diff --git a/arch/mips/generic/board-ocelot_pcb123.its.S b/arch/mips/generic/board-ocelot.its.S
similarity index 55%
rename from arch/mips/generic/board-ocelot_pcb123.its.S
rename to arch/mips/generic/board-ocelot.its.S
index 5a7d5e1c878a..3da23988149a 100644
--- a/arch/mips/generic/board-ocelot_pcb123.its.S
+++ b/arch/mips/generic/board-ocelot.its.S
@@ -11,6 +11,17 @@
 				algo = "sha1";
 			};
 		};
+
+		fdt@ocelot_pcb120 {
+			description = "MSCC Ocelot PCB120 Device Tree";
+			data = /incbin/("boot/dts/mscc/ocelot_pcb120.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
 	};
 
 	configurations {
@@ -19,5 +30,11 @@
 			kernel = "kernel@0";
 			fdt = "fdt@ocelot_pcb123";
 		};
+
+		conf@ocelot_pcb120 {
+			description = "Ocelot Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ocelot_pcb120";
+		};
 	};
 };
-- 
2.17.1
