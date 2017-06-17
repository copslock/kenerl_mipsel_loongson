Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:55:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35751 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994913AbdFQUzH0s-FF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 22:55:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A8B6A2AB5D706;
        Sat, 17 Jun 2017 21:54:55 +0100 (IST)
Received: from localhost (10.20.78.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 21:54:59 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v5 4/4] MIPS: generic: Support MIPS Boston development boards
Date:   Sat, 17 Jun 2017 13:52:49 -0700
Message-ID: <20170617205249.1391-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170617205249.1391-1-paul.burton@imgtec.com>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.225]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58596
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

Add support for the MIPS Boston development board to generic kernels,
which essentially amounts to:

  - Adding the device tree source for the MIPS Boston board.

  - Adding a Kconfig fragment which enables the appropriate drivers for
    the MIPS Boston board.

With these changes in place generic kernels will support the board by
default, and kernels with only the drivers needed for Boston enabled can
be configured by setting BOARDS=boston during configuration. For
example:

  $ make ARCH=mips 64r6el_defconfig BOARDS=boston

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v5:
- Adjust interrupt-map to match pcie-xilinx driver patchset changes.

Changes in v4:
- Most of the series already went in, rebase on v4.12-rc3.
- Adjust DT to move img,boston-clock under the plat_regs syscon node.
- Enable CONFIG_BLK_DEV_SD in board-boston.cfg to SATA disk access.
- Enable CONFIG_GPIOLIB so that the GPIO driver is actually enabled.
- Update MAINTAINERS entry.

Changes in v3: None
Changes in v2: None

 MAINTAINERS                                   |   2 +
 arch/mips/boot/dts/img/Makefile               |   2 +
 arch/mips/boot/dts/img/boston.dts             | 224 ++++++++++++++++++++++++++
 arch/mips/configs/generic/board-boston.config |  48 ++++++
 arch/mips/generic/Kconfig                     |  12 ++
 arch/mips/generic/vmlinux.its.S               |  25 +++
 6 files changed, 313 insertions(+)
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/configs/generic/board-boston.config

diff --git a/MAINTAINERS b/MAINTAINERS
index 2749877a4574..70acd8ee18ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8503,6 +8503,8 @@ M:	Paul Burton <paul.burton@imgtec.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
+F:	arch/mips/boot/dts/img/boston.dts
+F:	arch/mips/configs/generic/board-boston.config
 F:	drivers/clk/imgtec/clk-boston.c
 F:	include/dt-bindings/clock/boston-clock.h
 
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
index c178cf56f5b8..3d70958d0f5a 100644
--- a/arch/mips/boot/dts/img/Makefile
+++ b/arch/mips/boot/dts/img/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= boston.dtb
+
 dtb-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb
 obj-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb.o
 
diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
new file mode 100644
index 000000000000..53bfa29a7093
--- /dev/null
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -0,0 +1,224 @@
+/dts-v1/;
+
+#include <dt-bindings/clock/boston-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "img,boston";
+
+	chosen {
+		stdout-path = "uart0:115200";
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "img,mips";
+			reg = <0>;
+			clocks = <&clk_boston BOSTON_CLK_CPU>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	pci0: pci@10000000 {
+		compatible = "xlnx,axi-pcie-host-1.00.a";
+		device_type = "pci";
+		reg = <0x10000000 0x2000000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges = <0x02000000 0 0x40000000
+			  0x40000000 0 0x40000000>;
+
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pci0_intc 1>,
+				<0 0 0 2 &pci0_intc 2>,
+				<0 0 0 3 &pci0_intc 3>,
+				<0 0 0 4 &pci0_intc 4>;
+
+		pci0_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
+
+	pci1: pci@12000000 {
+		compatible = "xlnx,axi-pcie-host-1.00.a";
+		device_type = "pci";
+		reg = <0x12000000 0x2000000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges = <0x02000000 0 0x20000000
+			  0x20000000 0 0x20000000>;
+
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pci1_intc 1>,
+				<0 0 0 2 &pci1_intc 2>,
+				<0 0 0 3 &pci1_intc 3>,
+				<0 0 0 4 &pci1_intc 4>;
+
+		pci1_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
+
+	pci2: pci@14000000 {
+		compatible = "xlnx,axi-pcie-host-1.00.a";
+		device_type = "pci";
+		reg = <0x14000000 0x2000000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges = <0x02000000 0 0x16000000
+			  0x16000000 0 0x100000>;
+
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pci2_intc 1>,
+				<0 0 0 2 &pci2_intc 2>,
+				<0 0 0 3 &pci2_intc 3>,
+				<0 0 0 4 &pci2_intc 4>;
+
+		pci2_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+
+		pci2_root@0,0,0 {
+			compatible = "pci10ee,7021";
+			reg = <0x00000000 0 0 0 0>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			eg20t_bridge@1,0,0 {
+				compatible = "pci8086,8800";
+				reg = <0x00010000 0 0 0 0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+
+				eg20t_mac@2,0,1 {
+					compatible = "pci8086,8802";
+					reg = <0x00020100 0 0 0 0>;
+					phy-reset-gpios = <&eg20t_gpio 6
+							   GPIO_ACTIVE_LOW>;
+				};
+
+				eg20t_gpio: eg20t_gpio@2,0,2 {
+					compatible = "pci8086,8803";
+					reg = <0x00020200 0 0 0 0>;
+
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
+				eg20t_i2c@2,12,2 {
+					compatible = "pci8086,8817";
+					reg = <0x00026200 0 0 0 0>;
+
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					rtc@0x68 {
+						compatible = "st,m41t81s";
+						reg = <0x68>;
+					};
+				};
+			};
+		};
+	};
+
+	gic: interrupt-controller@16120000 {
+		compatible = "mti,gic";
+		reg = <0x16120000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks = <&clk_boston BOSTON_CLK_CPU>;
+		};
+	};
+
+	cdmm@16140000 {
+		compatible = "mti,mips-cdmm";
+		reg = <0x16140000 0x8000>;
+	};
+
+	cpc@16200000 {
+		compatible = "mti,mips-cpc";
+		reg = <0x16200000 0x8000>;
+	};
+
+	plat_regs: system-controller@17ffd000 {
+		compatible = "img,boston-platform-regs", "syscon";
+		reg = <0x17ffd000 0x1000>;
+
+		clk_boston: clock {
+			compatible = "img,boston-clock";
+			#clock-cells = <1>;
+		};
+	};
+
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&plat_regs>;
+		offset = <0x10>;
+		mask = <0x10>;
+	};
+
+	uart0: uart@17ffe000 {
+		compatible = "ns16550a";
+		reg = <0x17ffe000 0x1000>;
+		reg-shift = <2>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&clk_boston BOSTON_CLK_SYS>;
+	};
+
+	lcd: lcd@17fff000 {
+		compatible = "img,boston-lcd";
+		reg = <0x17fff000 0x8>;
+	};
+};
diff --git a/arch/mips/configs/generic/board-boston.config b/arch/mips/configs/generic/board-boston.config
new file mode 100644
index 000000000000..19560a45b683
--- /dev/null
+++ b/arch/mips/configs/generic/board-boston.config
@@ -0,0 +1,48 @@
+CONFIG_FIT_IMAGE_FDT_BOSTON=y
+
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+
+CONFIG_AUXDISPLAY=y
+CONFIG_IMG_ASCII_LCD=y
+
+CONFIG_COMMON_CLK_BOSTON=y
+
+CONFIG_DMADEVICES=y
+CONFIG_PCH_DMA=y
+
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCH=y
+
+CONFIG_I2C=y
+CONFIG_I2C_EG20T=y
+
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PCI=y
+
+CONFIG_NETDEVICES=y
+CONFIG_PCH_GBE=y
+
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_XILINX=y
+
+CONFIG_PCH_PHUB=y
+
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+
+CONFIG_SPI=y
+CONFIG_SPI_TOPCLIFF_PCH=y
+
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index a606b3f9196c..3b74d4ed9140 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -9,6 +9,8 @@ config LEGACY_BOARDS
 	  kernel is booted without being provided with an FDT via the UHI
 	  boot protocol.
 
+comment "Legacy (non-UHI/non-FIT) Boards"
+
 config LEGACY_BOARD_SEAD3
 	bool "Support MIPS SEAD-3 boards"
 	select LEGACY_BOARDS
@@ -16,4 +18,14 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+comment "FIT/UHI Boards"
+
+config FIT_IMAGE_FDT_BOSTON
+	bool "Include FDT for MIPS Boston boards"
+	help
+	  Enable this to include the FDT for the MIPS Boston development board
+	  from Imagination Technologies in the FIT kernel image. You should
+	  enable this if you wish to boot on a MIPS Boston board, as it is
+	  expected by the bootloader.
+
 endif
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index f67fbf1c8541..3390e2f80b80 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -29,3 +29,28 @@
 		};
 	};
 };
+
+#ifdef CONFIG_FIT_IMAGE_FDT_BOSTON
+/ {
+	images {
+		fdt@boston {
+			description = "img,boston Device Tree";
+			data = /incbin/("boot/dts/img/boston.dtb");
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
+		conf@boston {
+			description = "Boston Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@boston";
+		};
+	};
+};
+#endif /* CONFIG_FIT_IMAGE_FDT_BOSTON */
-- 
2.13.1
