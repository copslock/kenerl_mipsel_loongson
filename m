Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:53:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62080 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992181AbcIBPwThNvRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:52:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CC4A77970A19;
        Fri,  2 Sep 2016 16:51:59 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:52:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Stephan Linz <linz@li-pro.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/12] MIPS: Malta: Use syscon-reboot driver to reboot
Date:   Fri, 2 Sep 2016 16:48:55 +0100
Message-ID: <20160902154859.24269-10-paul.burton@imgtec.com>
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
X-archive-position: 55013
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

Make use of the generic syscon-reboot driver to reboot the Malta board,
reducing the amount of platform code it requires.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/malta.dts            | 12 ++++++++++++
 arch/mips/configs/malta_defconfig           |  2 ++
 arch/mips/configs/malta_kvm_defconfig       |  2 ++
 arch/mips/configs/malta_kvm_guest_defconfig |  2 ++
 arch/mips/configs/malta_qemu_32r6_defconfig |  2 ++
 arch/mips/configs/maltaaprp_defconfig       |  2 ++
 arch/mips/configs/maltasmvp_defconfig       |  2 ++
 arch/mips/configs/maltasmvp_eva_defconfig   |  2 ++
 arch/mips/configs/maltaup_defconfig         |  2 ++
 arch/mips/configs/maltaup_xpa_defconfig     |  2 ++
 arch/mips/mti-malta/malta-reset.c           | 15 ++-------------
 11 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 2e594ec..71bd0da 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -75,6 +75,18 @@
 		};
 	};
 
+	fpga_regs: system-controller@1f000000 {
+		compatible = "mti,malta-fpga", "syscon", "simple-mfd";
+		reg = <0x1f000000 0x1000>;
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&fpga_regs>;
+			offset = <0x500>;
+			mask = <0x4d>;
+		};
+	};
+
 	isa {
 		compatible = "isa";
 		#address-cells = <2>;
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index d5d4816..58d43f3 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -318,6 +318,8 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index ef6ef24..c8f7e28 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -331,6 +331,8 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index 3a49a77..d2f54e5 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -331,6 +331,8 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 65f140e..cbf37dd 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -132,6 +132,8 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 799c433..35f6ba2 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -132,6 +132,8 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index ac0eb4d..900f145 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -134,6 +134,8 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 3184600..8e2738b 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -137,6 +137,8 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index a79107d..6dc4e30 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -131,6 +131,8 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 62e05eb..3d0d9cb 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -326,6 +326,8 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 2fd2cc2..04d6b9c 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -8,21 +8,11 @@
  */
 #include <linux/io.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 
 #include <asm/reboot.h>
 #include <asm/mach-malta/malta-pm.h>
 
-#define SOFTRES_REG	0x1f000500
-#define GORESET		0x42
-
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
 	while (true);
@@ -33,12 +23,11 @@ static void mips_machine_power_off(void)
 	mips_pm_suspend(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF);
 
 	pr_info("Failed to power down, resetting\n");
-	mips_machine_restart(NULL);
+	machine_restart(NULL);
 }
 
 static int __init mips_reboot_setup(void)
 {
-	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
 	pm_power_off = mips_machine_power_off;
 
-- 
2.9.3
