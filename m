Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:23:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7748 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992495AbcHZOVayEuPn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:21:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 255914DD77D3E;
        Fri, 26 Aug 2016 15:21:11 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:21:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/19] MIPS: SEAD3: Reset via generic syscon-reboot driver & DT
Date:   Fri, 26 Aug 2016 15:17:43 +0100
Message-ID: <20160826141751.13121-12-paul.burton@imgtec.com>
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
X-archive-position: 54774
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

Remove the SEAD3 implementation of _machine_restart & instead make use
of the generic syscon-reboot driver probed via device tree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/boot/dts/mti/sead3.dts  | 12 ++++++++++++
 arch/mips/configs/sead3_defconfig |  3 ++-
 arch/mips/mti-sead3/sead3-reset.c |  9 ---------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 0159450..047ff7a 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -93,6 +93,18 @@
 		};
 	};
 
+	fpga_regs: system-controller@1f000000 {
+		compatible = "mti,sead3-fpga", "syscon", "simple-mfd";
+		reg = <0x1f000000 0x200>;
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&fpga_regs>;
+			offset = <0x50>;
+			mask = <0x4d>;
+		};
+	};
+
 	system-controller@1f000200 {
 		compatible = "mti,sead3-cpld", "syscon", "simple-mfd";
 		reg = <0x1f000200 0x300>;
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index e1c6582..055af30 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -80,8 +80,9 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_SPI=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SENSORS_ADT7475=y
-CONFIG_MFD_SYSCON=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
index e6fb244..8f548f0 100644
--- a/arch/mips/mti-sead3/sead3-reset.c
+++ b/arch/mips/mti-sead3/sead3-reset.c
@@ -13,14 +13,6 @@
 #define SOFTRES_REG	0x1f000050
 #define GORESET		0x4d
 
-static void mips_machine_restart(char *command)
-{
-	unsigned int __iomem *softres_reg =
-		ioremap(SOFTRES_REG, sizeof(unsigned int));
-
-	__raw_writel(GORESET, softres_reg);
-}
-
 static void mips_machine_halt(void)
 {
 	unsigned int __iomem *softres_reg =
@@ -31,7 +23,6 @@ static void mips_machine_halt(void)
 
 static int __init mips_reboot_setup(void)
 {
-	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
 	pm_power_off = mips_machine_halt;
 
-- 
2.9.3
