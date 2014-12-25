Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:04:32 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61261 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009921AbaLYR5p3JXf2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:45 +0100
Received: by mail-pa0-f53.google.com with SMTP id kq14so11859449pab.26;
        Thu, 25 Dec 2014 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dc+hh0T6apbxQ6myuM8hfS6waQ1Ch0fCH5oPV1j+VH8=;
        b=am301ugy81Nc8hAHlfKaBzHXocEOy56ipuRkYbKlMdekdOQZnoUridmql+0hB7SrB4
         Vtv2RW+iCmsZY106XXn5QpKaR5A2Qlr7i1rG1KkCIIbll0IJp9vM9zPD/4JiNDUH6udR
         9FYdsy9kiplENd5shHr0hTHUHXWRHa3t1z6n7GFovcCYh2ENgEyA/npuXlv1NRqzaeXh
         jxPzfdFBC2g5X3OAqTfv/NUBJ6pSXzsiYxT/orHelffwwHGNmR6jUR9aYpqYEsTvN7l8
         tUozmDzvQVHv5yBrWIWpQPhdYEwtnzF+ERXWa5KMTcDRiFmTdWoQ9L1Yd2v1zx9v9igk
         D68A==
X-Received: by 10.66.159.164 with SMTP id xd4mr63491221pab.54.1419530259450;
        Thu, 25 Dec 2014 09:57:39 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:38 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 25/25] MIPS: BMIPS: Add DTS files for several platforms
Date:   Thu, 25 Dec 2014 09:49:20 -0800
Message-Id: <1419529760-9520-26-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Most of the supported chips use legacy (non-DT) bootloaders, so they will
need to select an appropriate builtin DTB at compile time until the
bootloader is updated.  Provide suitable DTS files, and a means to compile
one of them into the kernel image.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/Kconfig                             |   1 +
 arch/mips/bmips/Kconfig                       |  58 +++++++
 arch/mips/boot/dts/brcm/Makefile              |  12 +-
 arch/mips/boot/dts/brcm/bcm3384_viper.dtsi    | 108 +++++++++++++
 arch/mips/boot/dts/brcm/bcm6328.dtsi          |  86 ++++++++++
 arch/mips/boot/dts/brcm/bcm6368.dtsi          |  93 +++++++++++
 arch/mips/boot/dts/brcm/bcm7125.dtsi          | 139 ++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi          | 224 +++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi          | 161 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi          | 161 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi          | 167 +++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi          | 184 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi          | 225 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm93384wvg_viper.dts |  25 +++
 arch/mips/boot/dts/brcm/bcm96368mvwg.dts      |  31 ++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts      |  31 ++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts     |  58 +++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts      |  34 ++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts      |  34 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts      |  34 ++++
 arch/mips/boot/dts/brcm/bcm97420c.dts         |  45 ++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts      |  60 +++++++
 arch/mips/boot/dts/brcm/bcm9ejtagprb.dts      |  22 +++
 23 files changed, 1992 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bmips/Kconfig
 create mode 100644 arch/mips/boot/dts/brcm/bcm3384_viper.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm6328.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm6368.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7125.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7346.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7358.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7360.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7362.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7420.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm7425.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm93384wvg_viper.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm96368mvwg.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97125cbmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97358svmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97360svmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97362svmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97420c.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm97425svmb.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm9ejtagprb.dts

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6f53dda..20799e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -892,6 +892,7 @@ source "arch/mips/ath25/Kconfig"
 source "arch/mips/ath79/Kconfig"
 source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
+source "arch/mips/bmips/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
new file mode 100644
index 0000000..6ffc42c
--- /dev/null
+++ b/arch/mips/bmips/Kconfig
@@ -0,0 +1,58 @@
+choice
+	prompt "Built-in device tree"
+	help
+	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
+	  if a "wrapper" is not being used, the kernel will need to include
+	  a device tree that matches the target board.
+
+	  The builtin DTB will only be used if the firmware does not supply
+	  a valid DTB.
+
+config DT_NONE
+	bool "None"
+
+config DT_BCM93384WVG
+	bool "BCM93384WVG Zephyr CPU"
+	select BUILTIN_DTB
+
+config DT_BCM93384WVG_VIPER
+	bool "BCM93384WVG Viper CPU (EXPERIMENTAL)"
+	select BUILTIN_DTB
+
+config DT_BCM96368MVWG
+	bool "BCM96368MVWG"
+	select BUILTIN_DTB
+
+config DT_BCM9EJTAGPRB
+	bool "BCM9EJTAGPRB"
+	select BUILTIN_DTB
+
+config DT_BCM97125CBMB
+	bool "BCM97125CBMB"
+	select BUILTIN_DTB
+
+config DT_BCM97346DBSMB
+	bool "BCM97346DBSMB"
+	select BUILTIN_DTB
+
+config DT_BCM97358SVMB
+	bool "BCM97358SVMB"
+	select BUILTIN_DTB
+
+config DT_BCM97360SVMB
+	bool "BCM97360SVMB"
+	select BUILTIN_DTB
+
+config DT_BCM97362SVMB
+	bool "BCM97362SVMB"
+	select BUILTIN_DTB
+
+config DT_BCM97420C
+	bool "BCM97420C"
+	select BUILTIN_DTB
+
+config DT_BCM97425SVMB
+	bool "BCM97425SVMB"
+	select BUILTIN_DTB
+
+endchoice
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 530ed23..1c8353b 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,4 +1,14 @@
-dtb-$(CONFIG_BMIPS_GENERIC)	+= bcm93384wvg.dtb
+dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
+dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
+dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
+dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
+dtb-$(CONFIG_DT_BCM97125CBMB)		+= bcm97125cbmb.dtb
+dtb-$(CONFIG_DT_BCM97346DBSMB)		+= bcm97346dbsmb.dtb
+dtb-$(CONFIG_DT_BCM97358SVMB)		+= bcm97358svmb.dtb
+dtb-$(CONFIG_DT_BCM97360SVMB)		+= bcm97360svmb.dtb
+dtb-$(CONFIG_DT_BCM97362SVMB)		+= bcm97362svmb.dtb
+dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
+dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/brcm/bcm3384_viper.dtsi b/arch/mips/boot/dts/brcm/bcm3384_viper.dtsi
new file mode 100644
index 0000000..aa406b4
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm3384_viper.dtsi
@@ -0,0 +1,108 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm3384-viper", "brcm,bcm33843-viper";
+
+	memory@0 {
+		device_type = "memory";
+
+		/* Typical ranges.  The bootloader should fill these in. */
+		reg = <0x06000000 0x02000000>,
+		      <0x0e000000 0x02000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1/2 of the CPU core clock (standard MIPS behavior) */
+		mips-hpt-frequency = <300000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "brcm,ubus", "simple-bus";
+		ranges;
+		/* No dma-ranges on Viper. */
+
+		periph_intc: periph_intc@14e00048 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x14e00048 0x4 0x14e0004c 0x4>,
+			      <0x14e00350 0x4 0x14e00354 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		cmips_intc: cmips_intc@151f8048 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x151f8048 0x4 0x151f804c 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+			brcm,int-map-mask = <0xffffffff>;
+		};
+
+		uart0: serial@14e00520 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x14e00520 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		ehci0: usb@15400300 {
+			compatible = "brcm,bcm3384-ehci", "generic-ehci";
+			reg = <0x15400300 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <41>;
+			status = "disabled";
+		};
+
+		ohci0: usb@15400400 {
+			compatible = "brcm,bcm3384-ohci", "generic-ohci";
+			reg = <0x15400400 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <40>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
new file mode 100644
index 0000000..41891c1
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -0,0 +1,86 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6328";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <160000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges;
+
+		periph_intc: periph_intc@10000020 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x10000024 0x4 0x1000002c 0x4>,
+			      <0x10000020 0x4 0x10000028 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@10000100 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000100 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <28>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		timer: timer@10000040 {
+			compatible = "syscon";
+			reg = <0x10000040 0x2c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&timer>;
+			offset = <0x28>;
+			mask = <0x1>;
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
new file mode 100644
index 0000000..45152bc
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -0,0 +1,93 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6368";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <200000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges;
+
+		periph_intc: periph_intc@10000020 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x10000024 0x4 0x1000002c 0x4>,
+			      <0x10000020 0x4 0x10000028 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@10000100 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000100 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		ehci0: usb@10001500 {
+			compatible = "brcm,bcm6368-ehci", "generic-ehci";
+			reg = <0x10001500 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <7>;
+			status = "disabled";
+		};
+
+		ohci0: usb@10001600 {
+			compatible = "brcm,bcm6368-ohci", "generic-ohci";
+			reg = <0x10001600 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <5>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
new file mode 100644
index 0000000..1a7efa8
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -0,0 +1,139 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7125";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <202500000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4380";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips4380";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@441400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x441400 0x30>, <0x441600 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@401800 {
+			compatible = "brcm,l2-intc";
+			reg = <0x401800 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <23>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x2f7>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "pci_0",
+						     "bsp_0", "rdc_0", "rptd_0",
+						     "avd_0", "jtag_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406780 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406780 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <18>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7125-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x60c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,bcm7038-reboot";
+			syscon = <&sun_top_ctrl 0x8 0x14>;
+		};
+
+		uart0: serial@406b00 {
+			compatible = "ns16550a";
+			reg = <0x406b00 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <21>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		ehci0: usb@488300 {
+			compatible = "brcm,bcm7125-ehci", "generic-ehci";
+			reg = <0x488300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <60>;
+			status = "disabled";
+		};
+
+		ohci0: usb@488400 {
+			compatible = "brcm,bcm7125-ohci", "generic-ohci";
+			reg = <0x488400 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
new file mode 100644
index 0000000..1f30728
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -0,0 +1,224 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7346";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <163125000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@411400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x411400 0x30>, <0x411600 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <51>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x673>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "bsp_0",
+						     "rdc_0", "raaga_0",
+						     "jtag_0", "svd_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406780 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406780 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <59>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7346-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406900 {
+			compatible = "ns16550a";
+			reg = <0x406900 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <64>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@430000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v2";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x430000 0x4c8c>;
+			interrupts = <24>, <25>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v2";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7346-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <68>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7346-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <70>;
+			status = "disabled";
+		};
+
+		ehci1: usb@480500 {
+			compatible = "brcm,bcm7346-ehci", "generic-ehci";
+			reg = <0x480500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <69>;
+			status = "disabled";
+		};
+
+		ohci1: usb@480600 {
+			compatible = "brcm,bcm7346-ohci", "generic-ohci";
+			reg = <0x480600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <71>;
+			status = "disabled";
+		};
+
+		ehci2: usb@490300 {
+			compatible = "brcm,bcm7346-ehci", "generic-ehci";
+			reg = <0x490300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <73>;
+			status = "disabled";
+		};
+
+		ohci2: usb@490400 {
+			compatible = "brcm,bcm7346-ohci", "generic-ohci";
+			reg = <0x490400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <75>;
+			status = "disabled";
+		};
+
+		ehci3: usb@490500 {
+			compatible = "brcm,bcm7346-ehci", "generic-ehci";
+			reg = <0x490500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <74>;
+			status = "disabled";
+		};
+
+		ohci3: usb@490600 {
+			compatible = "brcm,bcm7346-ohci", "generic-ohci";
+			reg = <0x490600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <76>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
new file mode 100644
index 0000000..2c2aa93
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -0,0 +1,161 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7358";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <375000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips3300";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@411400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x411400 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x2f3>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "bsp_0",
+						     "rdc_0", "raaga_0",
+						     "avd_0", "jtag_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406600 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406600 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <56>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7358-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406800 {
+			compatible = "ns16550a";
+			reg = <0x406800 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@430000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v2";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x430000 0x4c8c>;
+			interrupts = <24>, <25>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v2";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7358-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7358-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
new file mode 100644
index 0000000..f23b0ae
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -0,0 +1,161 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7360";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <375000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips3300";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@411400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x411400 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x2f3>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "bsp_0",
+						     "rdc_0", "raaga_0",
+						     "avd_0", "jtag_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406600 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406600 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <56>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7360-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406800 {
+			compatible = "ns16550a";
+			reg = <0x406800 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@430000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v2";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x430000 0x4c8c>;
+			interrupts = <24>, <25>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v2";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7360-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7360-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
new file mode 100644
index 0000000..da99db6
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -0,0 +1,167 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7362";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <375000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4380";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips4380";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@411400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x411400 0x30>, <0x411600 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x2f3>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "bsp_0",
+						     "rdc_0", "raaga_0",
+						     "avd_0", "jtag_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406600 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406600 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <56>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7362-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406800 {
+			compatible = "ns16550a";
+			reg = <0x406800 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@430000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v2";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x430000 0x4c8c>;
+			interrupts = <24>, <25>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v2";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7362-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7362-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
new file mode 100644
index 0000000..5f55d0a
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -0,0 +1,184 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7420";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <93750000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@441400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x441400 0x30>, <0x441600 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@401800 {
+			compatible = "brcm,l2-intc";
+			reg = <0x401800 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <23>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x3ff>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "pci_0",
+						     "pcie_0", "bsp_0", "rdc_0",
+						     "rptd_0", "avd_0", "avd_1",
+						     "jtag_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406780 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406780 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <18>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7420-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x60c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,bcm7038-reboot";
+			syscon = <&sun_top_ctrl 0x8 0x14>;
+		};
+
+		uart0: serial@406b00 {
+			compatible = "ns16550a";
+			reg = <0x406b00 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <21>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@468000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v1";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0x468000 0x3c8c>;
+			interrupts = <69>, <79>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v1";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,65nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@488300 {
+			compatible = "brcm,bcm7420-ehci", "generic-ehci";
+			reg = <0x488300 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <60>;
+			status = "disabled";
+		};
+
+		ohci0: usb@488400 {
+			compatible = "brcm,bcm7420-ohci", "generic-ohci";
+			reg = <0x488400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			status = "disabled";
+		};
+
+		ehci1: usb@488500 {
+			compatible = "brcm,bcm7420-ehci", "generic-ehci";
+			reg = <0x488500 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <55>;
+			status = "disabled";
+		};
+
+		ohci1: usb@488600 {
+			compatible = "brcm,bcm7420-ohci", "generic-ohci";
+			reg = <0x488600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
new file mode 100644
index 0000000..5b660b6
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -0,0 +1,225 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7425";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <163125000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@41a400 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x41a400 0x30>, <0x41a600 0x30>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <47>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0x177b>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "pcie_0",
+						     "bsp_0", "rdc_0",
+						     "raaga_0", "avd_1",
+						     "jtag_0", "svd_0",
+						     "vice_0";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406780 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406780 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <55>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406b00 {
+			compatible = "ns16550a";
+			reg = <0x406b00 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@b80000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v3";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0xb80000 0x11c88>;
+			interrupts = <17>, <18>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v3";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7425-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7425-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <67>;
+			status = "disabled";
+		};
+
+		ehci1: usb@480500 {
+			compatible = "brcm,bcm7425-ehci", "generic-ehci";
+			reg = <0x480500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			status = "disabled";
+		};
+
+		ohci1: usb@480600 {
+			compatible = "brcm,bcm7425-ohci", "generic-ohci";
+			reg = <0x480600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <68>;
+			status = "disabled";
+		};
+
+		ehci2: usb@490300 {
+			compatible = "brcm,bcm7425-ehci", "generic-ehci";
+			reg = <0x490300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <70>;
+			status = "disabled";
+		};
+
+		ohci2: usb@490400 {
+			compatible = "brcm,bcm7425-ohci", "generic-ohci";
+			reg = <0x490400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <72>;
+			status = "disabled";
+		};
+
+		ehci3: usb@490500 {
+			compatible = "brcm,bcm7425-ehci", "generic-ehci";
+			reg = <0x490500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <71>;
+			status = "disabled";
+		};
+
+		ohci3: usb@490600 {
+			compatible = "brcm,bcm7425-ohci", "generic-ohci";
+			reg = <0x490600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <73>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm93384wvg_viper.dts b/arch/mips/boot/dts/brcm/bcm93384wvg_viper.dts
new file mode 100644
index 0000000..1ecb269
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm93384wvg_viper.dts
@@ -0,0 +1,25 @@
+/dts-v1/;
+
+/include/ "bcm3384_viper.dtsi"
+
+/ {
+	compatible = "brcm,bcm93384wvg-viper", "brcm,bcm3384-viper";
+	model = "Broadcom BCM93384WVG-viper";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96368mvwg.dts b/arch/mips/boot/dts/brcm/bcm96368mvwg.dts
new file mode 100644
index 0000000..0e890c2
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm96368mvwg.dts
@@ -0,0 +1,31 @@
+/dts-v1/;
+
+/include/ "bcm6368.dtsi"
+
+/ {
+	compatible = "brcm,bcm96368mvwg", "brcm,bcm6368";
+	model = "Broadcom BCM96368MVWG";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x04000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* FIXME: need to set up USB_CTRL registers first */
+&ehci0 {
+	status = "disabled";
+};
+
+&ohci0 {
+	status = "disabled";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
new file mode 100644
index 0000000..e046b11
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -0,0 +1,31 @@
+/dts-v1/;
+
+/include/ "bcm7125.dtsi"
+
+/ {
+	compatible = "brcm,bcm97125cbmb", "brcm,bcm7125";
+	model = "Broadcom BCM97125CBMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* FIXME: USB is wonky; disable it for now */
+&ehci0 {
+	status = "disabled";
+};
+
+&ohci0 {
+	status = "disabled";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
new file mode 100644
index 0000000..70f196d
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -0,0 +1,58 @@
+/dts-v1/;
+
+/include/ "bcm7346.dtsi"
+
+/ {
+	compatible = "brcm,bcm97346dbsmb", "brcm,bcm7346";
+	model = "Broadcom BCM97346DBSMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
new file mode 100644
index 0000000..d18e6d9
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -0,0 +1,34 @@
+/dts-v1/;
+
+/include/ "bcm7358.dtsi"
+
+/ {
+	compatible = "brcm,bcm97358svmb", "brcm,bcm7358";
+	model = "Broadcom BCM97358SVMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
new file mode 100644
index 0000000..4fe5155
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -0,0 +1,34 @@
+/dts-v1/;
+
+/include/ "bcm7360.dtsi"
+
+/ {
+	compatible = "brcm,bcm97360svmb", "brcm,bcm7360";
+	model = "Broadcom BCM97360SVMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
new file mode 100644
index 0000000..b7b88e5
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -0,0 +1,34 @@
+/dts-v1/;
+
+/include/ "bcm7362.dtsi"
+
+/ {
+	compatible = "brcm,bcm97362svmb", "brcm,bcm7362";
+	model = "Broadcom BCM97362SVMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
new file mode 100644
index 0000000..67fe1f3
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/include/ "bcm7420.dtsi"
+
+/ {
+	compatible = "brcm,bcm97420c", "brcm,bcm7420";
+	model = "Broadcom BCM97420C";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>,
+		      <0x20000000 0x30000000>,
+		      <0x60000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* FIXME: MAC driver comes up but cannot attach to PHY */
+&enet0 {
+	status = "disabled";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
new file mode 100644
index 0000000..689c68a
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -0,0 +1,60 @@
+/dts-v1/;
+
+/include/ "bcm7425.dtsi"
+
+/ {
+	compatible = "brcm,bcm97425svmb", "brcm,bcm7425";
+	model = "Broadcom BCM97425SVMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>,
+		      <0x20000000 0x30000000>,
+		      <0x90000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm9ejtagprb.dts b/arch/mips/boot/dts/brcm/bcm9ejtagprb.dts
new file mode 100644
index 0000000..1da4608
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm9ejtagprb.dts
@@ -0,0 +1,22 @@
+/dts-v1/;
+
+/include/ "bcm6328.dtsi"
+
+/ {
+	compatible = "brcm,bcm9ejtagprb", "brcm,bcm6328";
+	model = "Broadcom BCM9EJTAGPRB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.1
