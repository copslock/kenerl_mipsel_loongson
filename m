Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:49:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992742AbcHZPor4Uv9I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:44:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 26790BC3CFE60;
        Fri, 26 Aug 2016 16:44:26 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:44:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 26/26] MIPS: generic: Support MIPS Boston development boards
Date:   Fri, 26 Aug 2016 16:37:25 +0100
Message-ID: <20160826153725.11629-27-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54810
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

 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/img/Makefile               |   7 +
 arch/mips/boot/dts/img/boston.dts             | 230 ++++++++++++++++++++++++++
 arch/mips/configs/generic/board-boston.config |  46 ++++++
 arch/mips/generic/Kconfig                     |   8 +
 arch/mips/generic/vmlinux.its.S               |  25 +++
 6 files changed, 317 insertions(+)
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/configs/generic/board-boston.config

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index fc7a0a9..b9db492 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dts-dirs	+= brcm
 dts-dirs	+= cavium-octeon
+dts-dirs	+= img
 dts-dirs	+= ingenic
 dts-dirs	+= lantiq
 dts-dirs	+= mti
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
new file mode 100644
index 0000000..ae119d3
--- /dev/null
+++ b/arch/mips/boot/dts/img/Makefile
@@ -0,0 +1,7 @@
+dtb-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= boston.dtb
+
+# Force kbuild to make empty built-in.o if necessary
+obj-					+= dummy.o
+
+always					:= $(dtb-y)
+clean-files				:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
new file mode 100644
index 0000000..b357376
--- /dev/null
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -0,0 +1,230 @@
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
+		interrupt-map = <0 0 0 1 &pci0_intc 0>,
+				<0 0 0 2 &pci0_intc 1>,
+				<0 0 0 3 &pci0_intc 2>,
+				<0 0 0 4 &pci0_intc 3>;
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
+		interrupt-map = <0 0 0 1 &pci1_intc 0>,
+				<0 0 0 2 &pci1_intc 1>,
+				<0 0 0 3 &pci1_intc 2>,
+				<0 0 0 4 &pci1_intc 3>;
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
+		interrupt-map = <0 0 0 1 &pci2_intc 0>,
+				<0 0 0 2 &pci2_intc 1>,
+				<0 0 0 3 &pci2_intc 2>,
+				<0 0 0 4 &pci2_intc 3>;
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
+		u-boot,dm-pre-reloc;
+	};
+
+	clk_boston: clock {
+		compatible = "img,boston-clock";
+		#clock-cells = <1>;
+		regmap = <&plat_regs>;
+		u-boot,dm-pre-reloc;
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
+		reg-io-width = <4>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&clk_boston BOSTON_CLK_SYS>;
+
+		u-boot,dm-pre-reloc;
+	};
+
+	lcd: lcd@17fff000 {
+		compatible = "img,boston-lcd";
+		reg = <0x17fff000 0x8>;
+	};
+};
diff --git a/arch/mips/configs/generic/board-boston.config b/arch/mips/configs/generic/board-boston.config
new file mode 100644
index 0000000..09864a4
--- /dev/null
+++ b/arch/mips/configs/generic/board-boston.config
@@ -0,0 +1,46 @@
+CONFIG_FIT_IMAGE_FDT_BOSTON=y
+
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SCSI=y
+
+CONFIG_AUXDISPLAY=y
+CONFIG_IMG_ASCII_LCD=y
+
+CONFIG_COMMON_CLK_BOSTON=y
+
+CONFIG_DMADEVICES=y
+CONFIG_PCH_DMA=y
+
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
index a606b3f..16eb939 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -16,4 +16,12 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
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
index f67fbf1..3390e2f 100644
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
2.9.3
