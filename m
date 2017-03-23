Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2017 15:50:35 +0100 (CET)
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:12016
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990845AbdCWOu02s9rw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2017 15:50:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=satixfy.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iZqnWbBvHX7HxDddviOaQWnlefY+tYw9sJdAmx9QYV0=;
 b=veHNV1c7UC6IARGMyzv2VH82m7/Vw2n59e5buiUz7CyDdgd/0IYdtrk16SmEQGS9sTvdj3/Gkl9fZ2OTDT/KFGiqE7HfwlIED6ye+YciN1OLkPMmc2ArEEt8EdqPUhQBjcv6hC1R0tT/nIob3AYZBQ17UR9pC4dU4wwyevAlyXY=
Received: from VI1PR0201MB2190.eurprd02.prod.outlook.com (10.169.131.152) by
 VI1PR0201MB2191.eurprd02.prod.outlook.com (10.169.131.150) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.947.12; Thu, 23
 Mar 2017 14:50:18 +0000
Received: from VI1PR0201MB2190.eurprd02.prod.outlook.com ([10.169.131.152]) by
 VI1PR0201MB2190.eurprd02.prod.outlook.com ([10.169.131.152]) with mapi id
 15.01.0947.025; Thu, 23 Mar 2017 14:50:18 +0000
From:   Amit Kama IL <Amit.Kama@satixfy.com>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH] Add initial SX3000b platform code to MIPS arch
Thread-Topic: [PATCH] Add initial SX3000b platform code to MIPS arch
Thread-Index: AdKixekUbQFPjDVgTrSY9bXmSe8bMwBHqrtg
Date:   Thu, 23 Mar 2017 14:50:18 +0000
Message-ID: <VI1PR0201MB2190A52FE719D00FBACEBD15E43F0@VI1PR0201MB2190.eurprd02.prod.outlook.com>
References: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
In-Reply-To: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=satixfy.com;
x-originating-ip: [82.80.19.234]
x-ms-office365-filtering-correlation-id: 2dc2076c-97ef-43f5-ca12-08d471fbecac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075);SRVR:VI1PR0201MB2191;
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2191;7:4mE9Ry5OdBh/dHCiDP7yAQq+f/F9GOr/w/MHs2FBmXm9rt1ZFuskZiq6NkLQ7KVUAH1IbopZM/W6YZMEeYkrSljfdhHGqmJtnC5GiPdU5XXUiVoHBiu88nOlj6LKhdWurLSM0o5QxL9U6/PqlIbNQvFOEK9KMF9PSXQ+fq8+4zym+rL4pHj22iAQz6i0ZSaN6V2SrqNTNqQCIII5GLG9309SzMXxXDmak9LL8mJZFg6SR27iE+DfG3lcqo2UnnIZAIFOS+oym21Z6MIK3kDGkKKKzJFT8IA7BE33gSzigECsyP8ZB+gSglTmJb0GREGIvoNdqI2dDZXZ9rn8njZDxw==
x-microsoft-antispam-prvs: <VI1PR0201MB2191CF2E763625DDE500919CE43F0@VI1PR0201MB2191.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(20161123558025)(6072148);SRVR:VI1PR0201MB2191;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2191;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(39450400003)(13464003)(377454003)(3280700002)(54356999)(2351001)(2950100002)(53546009)(54906002)(53946003)(7696004)(6116002)(7736002)(6916009)(2906002)(50986999)(122556002)(189998001)(1730700003)(2900100001)(2501003)(66066001)(76176999)(305945005)(8936002)(6246003)(25786009)(9686003)(4326008)(77096006)(38730400002)(575784001)(8676002)(229853002)(99286003)(102836003)(6436002)(86362001)(74316002)(5640700003)(81166006)(55016002)(6506006)(53936002)(5660300001)(3846002)(110136004)(3660700001)(33656002)(5890100001)(2004002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0201MB2191;H:VI1PR0201MB2190.eurprd02.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: satixfy.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2017 14:50:18.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b7ec8c62-61c4-41e4-9993-e34196916505
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2191
Return-Path: <Amit.Kama@satixfy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Amit.Kama@satixfy.com
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

Will be sending a revised version splitting the irqchip related code to a different patch and using a generic platform code...

-----Original Message-----
From: Amit Kama IL 
Sent: Wednesday, March 22, 2017 7:38 AM
To: 'ralf@linux-mips.org' <ralf@linux-mips.org>
Cc: 'devicetree@vger.kernel.org' <devicetree@vger.kernel.org>; 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'linux-mips@linux-mips.org' <linux-mips@linux-mips.org>; 'tglx@linutronix.de' <tglx@linutronix.de>; 'jason@lakedaemon.net' <jason@lakedaemon.net>; 'marc.zyngier@arm.com' <marc.zyngier@arm.com>; 'linux-doc@vger.kernel.org' <linux-doc@vger.kernel.org>; 'corbet@lwn.net' <corbet@lwn.net>
Subject: [PATCH] Add initial SX3000b platform code to MIPS arch

Add initial support for boards based on Satixfy's SX3000b (Catniss) SoC.
The SoC includes a MIPS interAptiv dual core 4 VPE processor and boots 
using device-tree.

Signed-off-by: Amit Kama <amit.kama@staixfy.com>

The irqchip file (irq-sx3000b.c) is pertinent to the platform. 
IRQCHIP maintainers - is it possible to merge this through MIPS tree? 
 


diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
old mode 100666
new mode 100666
index a008a9f..1bcb300
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -551,6 +551,31 @@ config MACH_PIC32
	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
	  microcontrollers.

+config MACH_SX3000
+	bool "Satixfy SX3000 based boards"
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R3_5
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select DMA_MAYBE_COHERENT
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select LIBFDT
+	select USE_OF
+	select BUILTIN_DTB
+	select IRQ_MIPS_CPU
+	select MIPS_GIC
+	select SX3000_ICU
+	select MIPS_CPU_SCACHE
+	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
+	select BOOT_RAW
+	help
+	  This enables support for the Satixfy SX3000 SoC.
+
 config NEC_MARKEINS
	bool "NEC EMMA2RH Mark-eins board"
	select SOC_EMMA2RH
@@ -1022,6 +1047,7 @@ source "arch/mips/pmcs-msp71xx/Kconfig"
 source "arch/mips/ralink/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
+source "arch/mips/sx3000/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
diff --git a/arch/mips/boot/dts/sx3000/Makefile b/arch/mips/boot/dts/sx3000/Makefile
new file mode 100666
index 0000000..8b73c39
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/Makefile
@@ -0,0 +1,13 @@
+dtb-$(CONFIG_SX3000_DEVBOARD)	+= sx3000_devboard.dtb
+dtb-$(CONFIG_SX3000_BBB)	+= sx3000_bbb.dtb
+dtb-$(SX3000_IDU3)		+= sx3000_idu3.dtb
+dtb-$(SX3000_IDU4)		+= sx3000_idu4.dtb
+
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files	:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/sx3000/sx3000.dtsi b/arch/mips/boot/dts/sx3000/sx3000.dtsi
new file mode 100666
index 0000000..8557282
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/sx3000.dtsi
@@ -0,0 +1,141 @@
+/*
+ * Copyright (C) 2016 Satixfy Technologies
+ * Author: Amit Kama <amit.kama@satixfy.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "satixfy,sx3000";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			clocks	= <&ext>;
+			reg = <0>;
+		};
+	};
+
+	gic: interrupt-controller@1d900000 {
+		compatible = "mti,gic";
+		//reg = <0x1D900000 0x20000>;
+		memory-region = <&GIC_memory_mapped_area>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks = <&ext>;
+		};
+	};
+
+	icu: interrupt-controller@1d4d0000 {
+		compatible = "sx,icu";
+		reg = <0x1D4D0000 0x1C0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 25 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	uart0: uart@1D4D09C0 {
+		compatible = "ns16550a";
+		reg = <0x1D4D09C0 0x100>;
+
+		interrupt-parent = <&icu>;
+		interrupts = <3>;
+
+		clock-frequency = <270000000>;
+
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
+
+	uart1: uart@1D4D0AC0 {
+		compatible = "ns16550a";
+		reg = <0x1D4D0AC0 0x100>;
+
+		interrupt-parent = <&icu>;
+		interrupts = <4>;
+
+		clock-frequency = <270000000>;
+
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
+
+	i2c1@1d4d03c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,designware-i2c";
+		reg = <0x1D4D03C0 0x100>;
+		interrupt-parent = <&icu>;
+		interrupts = <0>;
+		clock-frequency = <100000>;
+		clocks = <&ext2>;
+	};
+
+	i2c2@1d4d04c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,designware-i2c";
+		reg = <0x1D4D04C0 0x100>;
+		interrupt-parent = <&icu>;
+		interrupts = <1>;
+		clock-frequency = <100000>;
+		clocks = <&ext2>;
+	};
+
+
+	gpio: gpio@1d4d0cc0 {
+		compatible = "snps,dw-apb-gpio";
+		reg = <0x1D4D0CC0 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks=<&ext2>;
+
+	porta: gpio-controller@0 {
+			compatible = "snps,dw-apb-gpio-port";
+			gpio-controller;
+			#gpio-cells = <2>;
+			snps,nr-gpios = <29>;
+			reg = <0>;
+		};
+
+	};
+
+
+	ext3: ext3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	ext2: ext2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+
+	ext1: ext1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+};
\ No newline at end of file
diff --git a/arch/mips/boot/dts/sx3000/sx3000_bbb.dts b/arch/mips/boot/dts/sx3000/sx3000_bbb.dts
new file mode 100666
index 0000000..75c6751
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/sx3000_bbb.dts
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2017 Satixfy Technologies
+ * Author: Amit Kama <amit.kama@satixfy.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "sx3000.dtsi"
+
+/ {
+	model = "Satixfy SX3000 BBB Board";
+	compatible = "satixfy,sx3000";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 init=/bin/sh";
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x0F800000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		// reserve memory for GIC memory mapped registers
+		GIC_memory_mapped_area: GIC@1D900000 {
+			reg = <0x1D900000 0x200000>;
+			no-map;
+		};
+
+	};
+
+	ethernet0: dwmac@1d4e0000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e0000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <33>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+		};
+
+	};
+
+	qspi: qspi@0x1D000000{
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible		= "satixfy,imgtec-qspi";
+	reg			=  <0x1D000000 0x1000>;
+
+
+		flash: mt25ql01gb@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "micron,mt25ql01gb", "jedec,spi-nor";
+			spi-max-frequency = <40000000>;
+			reg = <0 0x8000000>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition0@2400000 {
+					label = "partition0";
+					reg = <0x2400000 0x1C00000>;
+				};
+			};
+		};
+	};
+
+};
+
+
+
+&ext {
+	clock-frequency = <525000000>;
+};
+
+&ext1 {
+	clock-frequency = <125000000>;
+};
+
+&ext2 {
+	clock-frequency = <270000000>;
+};
+
+&ext3 {
+	clock-frequency = <32813000>;
+};
diff --git a/arch/mips/boot/dts/sx3000/sx3000_devboard.dts b/arch/mips/boot/dts/sx3000/sx3000_devboard.dts
new file mode 100666
index 0000000..f124cbf
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/sx3000_devboard.dts
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2016 Satixfy Technologies
+ * Author: Amit Kama <amit.kama@satixfy.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "sx3000.dtsi"
+
+/ {
+	model = "Satixfy SX3000 Development Board";
+	compatible = "satixfy,sx3000";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 init=/bin/sh";
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x0F800000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		// reserve memory for GIC memory mapped registers
+		GIC_memory_mapped_area: GIC@1D900000 {
+			reg = <0x1D900000 0x200000>;
+			no-map;
+		};
+
+	};
+
+	ethernet0: dwmac@1d4e0000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e0000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <33>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+		};
+
+	};
+
+	ethernet1: dwmac@1d4e2000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e2000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <31>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+			};
+		};
+
+	};
+
+	ethernet2: dwmac@1d4e4000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e4000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <29>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy3: ethernet-phy@3 {
+				reg = <3>;
+			};
+		};
+
+	};
+
+	qspi: qspi@0x1D000000{
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible		= "satixfy,imgtec-qspi";
+	reg			=  <0x1D000000 0x1000>;
+
+
+		flash: mt25ql02gc@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "micron,mt25ql02gc", "jedec,spi-nor";
+			spi-max-frequency = <40000000>;
+			reg = <0 0x10000000>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition0@2400000 {
+					label = "partition0";
+					reg = <0x2400000 0x1C00000>;
+				};
+			};
+		};
+	};
+
+	dwmmc0@0x1D4E6000  {
+
+		compatible = "snps,dw-mshc";
+		clocks = < &ext2 >, < &ext3 >;
+		clock-names = "biu", "ciu";
+		bus-width = <4>;
+		reg = <0x1D4E6000 0x1000>;
+		interrupt-parent = <&icu>;
+		interrupts = <26>;
+		num-slots = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+    	};
+
+
+};
+
+
+
+&ext {
+	clock-frequency = <525000000>;
+};
+
+&ext1 {
+	clock-frequency = <125000000>;
+};
+
+&ext2 {
+	clock-frequency = <270000000>;
+};
+
+&ext3 {
+	clock-frequency = <32813000>;
+};
diff --git a/arch/mips/boot/dts/sx3000/sx3000_idu3.dts b/arch/mips/boot/dts/sx3000/sx3000_idu3.dts
new file mode 100755
index 0000000..7ebaa40
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/sx3000_idu3.dts
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2017 Satixfy Technologies
+ * Author: Amit Kama <amit.kama@satixfy.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "sx3000.dtsi"
+
+/ {
+	model = "Satixfy SX3000 IDU3 Board";
+	compatible = "satixfy,sx3000";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 init=/bin/sh";
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x0f800000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		// reserve memory for GIC memory mapped registers
+		GIC_memory_mapped_area: GIC@1D900000 {
+			reg = <0x1D900000 0x200000>;
+			no-map;
+		};
+
+	};
+
+	ethernet0: dwmac@1d4e0000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e0000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <33>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+		};
+
+	};
+
+	ethernet1: dwmac@1d4e2000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e2000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <31>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+			};
+		};
+
+	};
+
+	qspi: qspi@0x1D000000{
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible		= "satixfy,imgtec-qspi";
+		reg			=  <0x1D000000 0x1000>;
+
+
+		flash: mt25ql512@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "micron,mt25ql512", "jedec,spi-nor";
+			spi-max-frequency = <40000000>;
+			reg = <0 0x4000000>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition0@2400000 {
+					label = "partition0";
+					reg = <0x2400000 0x1C00000>;
+				};
+			};
+		};
+	};
+
+	dwmmc0@0x1D4E6000  {
+
+		compatible = "snps,dw-mshc";
+		clocks = < &ext2 >, < &ext3 >;
+		clock-names = "biu", "ciu";
+		bus-width = <4>;
+		reg = <0x1D4E6000 0x1000>;
+		interrupt-parent = <&icu>;
+		interrupts = <26>;
+		num-slots = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+    	};
+
+
+};
+
+
+
+&ext {
+	clock-frequency = <525000000>;
+};
+
+&ext1 {
+	clock-frequency = <125000000>;
+};
+
+&ext2 {
+	clock-frequency = <270000000>;
+};
+
+&ext3 {
+	clock-frequency = <32813000>;
+};
diff --git a/arch/mips/boot/dts/sx3000/sx3000_idu4.dts b/arch/mips/boot/dts/sx3000/sx3000_idu4.dts
new file mode 100755
index 0000000..457dc76
--- /dev/null
+++ b/arch/mips/boot/dts/sx3000/sx3000_idu4.dts
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2017 Satixfy Technologies
+ * Author: Amit Kama <amit.kama@satixfy.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "sx3000.dtsi"
+
+/ {
+	model = "Satixfy SX3000 IDU4 Board";
+	compatible = "satixfy,sx3000";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 init=/bin/sh";
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x0f800000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		// reserve memory for GIC memory mapped registers
+		GIC_memory_mapped_area: GIC@1D900000 {
+			reg = <0x1D900000 0x200000>;
+			no-map;
+		};
+
+	};
+
+	ethernet0: dwmac@1d4e0000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e0000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <33>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+		};
+
+	};
+
+	ethernet1: dwmac@1d4e2000 {
+		compatible	= "snps,dwmac", "snps,dwmac-3.70a";
+
+		reg		= <0x1d4e2000 0x2000>;
+
+		interrupt-parent = <&icu>;
+		interrupts	= <31>;
+		interrupt-names = "macirq";
+
+		clock-names	= "stmmaceth";
+		clocks		= <&ext1>;
+		snps,multicast-filter-bins = <256>;
+
+		phy-mode = "rgmii";
+		mdio1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+			};
+		};
+
+	};
+
+	qspi: qspi@0x1D000000{
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible		= "satixfy,imgtec-qspi";
+		reg			=  <0x1D000000 0x1000>;
+
+
+		flash: mt25ql01gb@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "micron,mt25ql01gb", "jedec,spi-nor";
+			spi-max-frequency = <40000000>;
+			reg = <0 0x8000000>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition0@2400000 {
+					label = "partition0";
+					reg = <0x2400000 0x1C00000>;
+				};
+			};
+		};
+	};
+};
+
+
+
+&ext {
+	clock-frequency = <525000000>;
+};
+
+&ext1 {
+	clock-frequency = <125000000>;
+};
+
+&ext2 {
+	clock-frequency = <270000000>;
+};
+
+&ext3 {
+	clock-frequency = <32813000>;
+};
diff --git a/arch/mips/configs/sx3000b_defconfig b/arch/mips/configs/sx3000b_defconfig
new file mode 100755
index 0000000..521630a
--- /dev/null
+++ b/arch/mips/configs/sx3000b_defconfig
@@ -0,0 +1,2365 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux/mips 4.9.6 Kernel Configuration
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+# CONFIG_MIPS_GENERIC is not set
+# CONFIG_MIPS_ALCHEMY is not set
+# CONFIG_AR7 is not set
+# CONFIG_ATH25 is not set
+# CONFIG_ATH79 is not set
+# CONFIG_BMIPS_GENERIC is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_MACH_INGENIC is not set
+# CONFIG_LANTIQ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON32 is not set
+# CONFIG_MACH_LOONGSON64 is not set
+# CONFIG_MACH_PISTACHIO is not set
+# CONFIG_MACH_XILFPGA is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MACH_PIC32 is not set
+CONFIG_MACH_SX3000=y
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
+# CONFIG_PMC_MSP is not set
+# CONFIG_RALINK is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SNI_RM is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
+# CONFIG_CAVIUM_OCTEON_SOC is not set
+# CONFIG_NLM_XLR_BOARD is not set
+# CONFIG_NLM_XLP_BOARD is not set
+# CONFIG_MIPS_PARAVIRT is not set
+CONFIG_SX3000_DEVBOARD=y
+# CONFIG_SX3000_BBB is not set
+# CONFIG_SX3000_IDU3 is not set
+# CONFIG_SX3000_IDU4 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_BOOT_RAW=y
+CONFIG_MIPS_CLOCK_VSYSCALL=y
+# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_DMA_MAYBE_COHERENT=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_NEED_DMA_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+CONFIG_SYS_SUPPORTS_HOTPLUG_CPU=y
+CONFIG_SYNC_R4K=y
+# CONFIG_MIPS_MACHINE is not set
+# CONFIG_NO_IOPORT_MAP is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+# CONFIG_MIPS_HUGE_TLB_SUPPORT is not set
+CONFIG_MIPS_SPRAM=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32_3_5_FEATURES=y
+CONFIG_CPU_MIPS32_3_5_EVA=y
+CONFIG_SYS_HAS_CPU_MIPS32_R2=y
+CONFIG_SYS_HAS_CPU_MIPS32_R3_5=y
+CONFIG_WEAK_ORDERING=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR2=y
+CONFIG_EVA=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
+
+#
+# Kernel type
+#
+CONFIG_32BIT=y
+# CONFIG_PAGE_SIZE_4KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_BOARD_SCACHE=y
+CONFIG_MIPS_CPU_SCACHE=y
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_CPU_GENERIC_DUMP_TLB=y
+CONFIG_CPU_R4K_FPU=y
+CONFIG_CPU_R4K_CACHE_TLB=y
+CONFIG_MIPS_MT_SMP=y
+CONFIG_MIPS_MT=y
+CONFIG_SCHED_SMT=y
+CONFIG_SYS_SUPPORTS_SCHED_SMT=y
+CONFIG_SYS_SUPPORTS_MULTITHREADING=y
+# CONFIG_MIPS_MT_FPAFF is not set
+# CONFIG_MIPS_VPE_LOADER is not set
+CONFIG_MIPS_CPS=y
+CONFIG_MIPS_CPS_PM=y
+CONFIG_MIPS_CM=y
+CONFIG_MIPS_CPC=y
+CONFIG_CPU_NEEDS_NO_SMARTMIPS_OR_MICROMIPS=y
+CONFIG_CPU_HAS_RIXI=y
+CONFIG_CPU_MIPSR2_IRQ_VI=y
+CONFIG_CPU_MIPSR2_IRQ_EI=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_MIPS_ASID_SHIFT=0
+CONFIG_MIPS_ASID_BITS=8
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_CPU_SUPPORTS_MSA=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_HAVE_MEMBLOCK=y
+CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
+CONFIG_ARCH_DISCARD_MEMBLOCK=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_COMPACTION is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+# CONFIG_CLEANCACHE is not set
+# CONFIG_FRONTSWAP is not set
+# CONFIG_CMA is not set
+# CONFIG_ZPOOL is not set
+# CONFIG_ZBUD is not set
+# CONFIG_ZSMALLOC is not set
+# CONFIG_IDLE_PAGE_TRACKING is not set
+CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SMP_UP=y
+CONFIG_SYS_SUPPORTS_MIPS_CPS=y
+CONFIG_SYS_SUPPORTS_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_MIPS_PERF_SHARED_TC_COUNTERS=y
+# CONFIG_HZ_24 is not set
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=100
+CONFIG_SCHED_HRTICK=y
+# CONFIG_PREEMPT_NONE is not set
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_PREEMPT is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_MIPS_O32_FP64_SUPPORT is not set
+CONFIG_USE_OF=y
+CONFIG_BUILTIN_DTB=y
+CONFIG_MIPS_NO_APPENDED_DTB=y
+# CONFIG_MIPS_ELF_APPENDED_DTB is not set
+# CONFIG_MIPS_RAW_APPENDED_DTB is not set
+# CONFIG_MIPS_CMDLINE_FROM_DTB is not set
+# CONFIG_MIPS_CMDLINE_DTB_EXTEND is not set
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_PGTABLE_LEVELS=2
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_IRQ_WORK=y
+CONFIG_BUILDTIME_EXTABLE_SORT=y
+
+#
+# General setup
+#
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+# CONFIG_COMPILE_TEST is not set
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_DEFAULT_HOSTNAME="(none)"
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_CROSS_MEMORY_ATTACH=y
+CONFIG_FHANDLE=y
+# CONFIG_USELIB is not set
+# CONFIG_AUDIT is not set
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_GENERIC_IRQ_CHIP=y
+CONFIG_IRQ_DOMAIN=y
+CONFIG_IRQ_DOMAIN_HIERARCHY=y
+CONFIG_GENERIC_IRQ_IPI=y
+CONFIG_HANDLE_DOMAIN_IRQ=y
+# CONFIG_IRQ_DOMAIN_DEBUG is not set
+CONFIG_IRQ_FORCED_THREADING=y
+CONFIG_ARCH_CLOCKSOURCE_DATA=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+
+#
+# Timers subsystem
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ_COMMON=y
+# CONFIG_HZ_PERIODIC is not set
+CONFIG_NO_HZ_IDLE=y
+# CONFIG_NO_HZ_FULL is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
+# CONFIG_IRQ_TIME_ACCOUNTING is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_RCU_EXPERT is not set
+CONFIG_SRCU=y
+# CONFIG_TASKS_RCU is not set
+CONFIG_RCU_STALL_COMMON=y
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_RCU_EXPEDITE_BOOT is not set
+# CONFIG_BUILD_BIN2C is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=15
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
+CONFIG_NMI_LOG_BUF_SHIFT=13
+CONFIG_GENERIC_SCHED_CLOCK=y
+CONFIG_CGROUPS=y
+# CONFIG_MEMCG is not set
+# CONFIG_BLK_CGROUP is not set
+# CONFIG_CGROUP_SCHED is not set
+# CONFIG_CGROUP_PIDS is not set
+# CONFIG_CGROUP_FREEZER is not set
+# CONFIG_CPUSETS is not set
+# CONFIG_CGROUP_DEVICE is not set
+# CONFIG_CGROUP_CPUACCT is not set
+# CONFIG_CGROUP_DEBUG is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+# CONFIG_USER_NS is not set
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
+# CONFIG_SCHED_AUTOGROUP is not set
+# CONFIG_SYSFS_DEPRECATED is not set
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="${ROOTDIR}/buildrt/output/images/rootfs.cpio.lzma"
+CONFIG_INITRAMFS_ROOT_UID=0
+CONFIG_INITRAMFS_ROOT_GID=0
+CONFIG_RD_GZIP=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_SYSCTL_EXCEPTION_TRACE=y
+CONFIG_BPF=y
+# CONFIG_EXPERT is not set
+CONFIG_MULTIUSER=y
+CONFIG_SGETMASK_SYSCALL=y
+CONFIG_SYSFS_SYSCALL=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
+CONFIG_KALLSYMS_BASE_RELATIVE=y
+CONFIG_PRINTK=y
+CONFIG_PRINTK_NMI=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+# CONFIG_BPF_SYSCALL is not set
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_ADVISE_SYSCALLS=y
+# CONFIG_USERFAULTFD is not set
+CONFIG_MEMBARRIER=y
+# CONFIG_EMBEDDED is not set
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLAB_FREELIST_RANDOM is not set
+CONFIG_SLUB_CPU_PARTIAL=y
+# CONFIG_SYSTEM_DATA_VERIFICATION is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+# CONFIG_JUMP_LABEL is not set
+# CONFIG_UPROBES is not set
+# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
+CONFIG_ARCH_USE_BUILTIN_BSWAP=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_NMI=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_CONTIGUOUS=y
+CONFIG_GENERIC_SMP_IDLE_THREAD=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
+CONFIG_HAVE_CLK=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_ARCH_JUMP_LABEL=y
+CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
+CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
+CONFIG_HAVE_CC_STACKPROTECTOR=y
+# CONFIG_CC_STACKPROTECTOR is not set
+CONFIG_CC_STACKPROTECTOR_NONE=y
+# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
+# CONFIG_CC_STACKPROTECTOR_STRONG is not set
+CONFIG_HAVE_CONTEXT_TRACKING=y
+CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
+CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
+CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
+CONFIG_MODULES_USE_ELF_REL=y
+CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
+CONFIG_HAVE_EXIT_THREAD=y
+# CONFIG_HAVE_ARCH_HASH is not set
+# CONFIG_ISA_BUS_API is not set
+CONFIG_CLONE_BACKWARDS=y
+# CONFIG_CPU_NO_EFFICIENT_FFS is not set
+# CONFIG_HAVE_ARCH_VMAP_STACK is not set
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_ARCH_HAS_GCOV_PROFILE_ALL is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_MODULE_SIG is not set
+# CONFIG_MODULE_COMPRESS is not set
+# CONFIG_TRIM_UNUSED_KSYMS is not set
+CONFIG_BLOCK=y
+# CONFIG_LBDAF is not set
+CONFIG_BLK_DEV_BSG=y
+CONFIG_BLK_DEV_BSGLIB=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_CMDLINE_PARSER is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_FREEZER is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_PCI_DRIVERS_LEGACY=y
+CONFIG_MMU=y
+# CONFIG_PCCARD is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_ARCH_BINFMT_ELF_STATE=y
+CONFIG_ELFCORE=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_BINFMT_SCRIPT=y
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_COREDUMP=y
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Power management options
+#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_SUSPEND is not set
+# CONFIG_HIBERNATION is not set
+# CONFIG_PM is not set
+
+#
+# CPU Power Management
+#
+
+#
+# CPU Idle
+#
+# CONFIG_CPU_IDLE is not set
+# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
+CONFIG_NET=y
+CONFIG_NET_INGRESS=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_DIAG is not set
+CONFIG_UNIX=y
+# CONFIG_UNIX_DIAG is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_IP_FIB_TRIE_STATS is not set
+# CONFIG_IP_MULTIPLE_TABLES is not set
+# CONFIG_IP_ROUTE_MULTIPATH is not set
+# CONFIG_IP_ROUTE_VERBOSE is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+CONFIG_NET_IP_TUNNEL=y
+CONFIG_IP_MROUTE=y
+# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
+# CONFIG_IP_PIMSM_V1 is not set
+# CONFIG_IP_PIMSM_V2 is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_NET_IPVTI is not set
+# CONFIG_NET_UDP_TUNNEL is not set
+# CONFIG_NET_FOU is not set
+# CONFIG_NET_FOU_IP_TUNNELS is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_INET_DIAG_DESTROY is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_IPV6_ILA is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+# CONFIG_IPV6_VTI is not set
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_SIT_6RD is not set
+CONFIG_IPV6_NDISC_NODETYPE=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_FOU is not set
+# CONFIG_IPV6_FOU_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NET_PTP_CLASSIFY=y
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_BRIDGE_NETFILTER=y
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_INGRESS=y
+CONFIG_NETFILTER_NETLINK=y
+# CONFIG_NETFILTER_NETLINK_ACCT is not set
+# CONFIG_NETFILTER_NETLINK_QUEUE is not set
+# CONFIG_NETFILTER_NETLINK_LOG is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_PROCFS=y
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CONNTRACK_TIMEOUT is not set
+# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_SCTP=y
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+# CONFIG_NF_CONNTRACK_FTP is not set
+# CONFIG_NF_CONNTRACK_H323 is not set
+# CONFIG_NF_CONNTRACK_IRC is not set
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_SNMP is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SANE is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
+# CONFIG_NF_CT_NETLINK is not set
+# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
+CONFIG_NF_NAT=y
+CONFIG_NF_NAT_NEEDED=y
+CONFIG_NF_NAT_PROTO_DCCP=y
+CONFIG_NF_NAT_PROTO_SCTP=y
+# CONFIG_NF_NAT_AMANDA is not set
+# CONFIG_NF_NAT_FTP is not set
+# CONFIG_NF_NAT_IRC is not set
+# CONFIG_NF_NAT_SIP is not set
+# CONFIG_NF_NAT_TFTP is not set
+CONFIG_NF_NAT_REDIRECT=y
+CONFIG_NF_TABLES=y
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NFT_EXTHDR=y
+CONFIG_NFT_META=y
+# CONFIG_NFT_NUMGEN is not set
+# CONFIG_NFT_CT is not set
+# CONFIG_NFT_SET_RBTREE is not set
+# CONFIG_NFT_SET_HASH is not set
+# CONFIG_NFT_COUNTER is not set
+# CONFIG_NFT_LOG is not set
+# CONFIG_NFT_LIMIT is not set
+# CONFIG_NFT_MASQ is not set
+# CONFIG_NFT_REDIR is not set
+# CONFIG_NFT_NAT is not set
+# CONFIG_NFT_QUOTA is not set
+# CONFIG_NFT_REJECT is not set
+# CONFIG_NFT_REJECT_INET is not set
+# CONFIG_NFT_COMPAT is not set
+# CONFIG_NFT_HASH is not set
+CONFIG_NF_DUP_NETDEV=y
+CONFIG_NFT_DUP_NETDEV=y
+CONFIG_NFT_FWD_NETDEV=y
+CONFIG_NETFILTER_XTABLES=y
+
+#
+# Xtables combined modules
+#
+# CONFIG_NETFILTER_XT_MARK is not set
+CONFIG_NETFILTER_XT_CONNMARK=y
+
+#
+# Xtables targets
+#
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
+# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
+# CONFIG_NETFILTER_XT_TARGET_LOG is not set
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
+CONFIG_NETFILTER_XT_NAT=y
+CONFIG_NETFILTER_XT_TARGET_NETMAP=y
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
+CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
+# CONFIG_NETFILTER_XT_TARGET_TEE is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+
+#
+# Xtables matches
+#
+# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_BPF is not set
+# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
+# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
+# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
+# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+# CONFIG_NETFILTER_XT_MATCH_CPU is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ECN is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+CONFIG_NETFILTER_XT_MATCH_HELPER=y
+# CONFIG_NETFILTER_XT_MATCH_HL is not set
+# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
+# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
+# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_MAC is not set
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
+# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
+# CONFIG_NETFILTER_XT_MATCH_OSF is not set
+# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
+# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
+# CONFIG_IP_SET is not set
+# CONFIG_IP_VS is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_DEFRAG_IPV4=y
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_NF_TABLES_IPV4=y
+# CONFIG_NFT_CHAIN_ROUTE_IPV4 is not set
+# CONFIG_NFT_REJECT_IPV4 is not set
+# CONFIG_NFT_DUP_IPV4 is not set
+# CONFIG_NF_TABLES_ARP is not set
+# CONFIG_NF_DUP_IPV4 is not set
+# CONFIG_NF_LOG_ARP is not set
+# CONFIG_NF_LOG_IPV4 is not set
+# CONFIG_NF_REJECT_IPV4 is not set
+CONFIG_NF_NAT_IPV4=y
+# CONFIG_NFT_CHAIN_NAT_IPV4 is not set
+CONFIG_NF_NAT_MASQUERADE_IPV4=y
+# CONFIG_NF_NAT_PPTP is not set
+# CONFIG_NF_NAT_H323 is not set
+CONFIG_IP_NF_IPTABLES=y
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+CONFIG_IP_NF_FILTER=y
+# CONFIG_IP_NF_TARGET_REJECT is not set
+# CONFIG_IP_NF_TARGET_SYNPROXY is not set
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_NETMAP=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+# CONFIG_IP_NF_MANGLE is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# IPv6: Netfilter Configuration
+#
+# CONFIG_NF_DEFRAG_IPV6 is not set
+# CONFIG_NF_CONNTRACK_IPV6 is not set
+CONFIG_NF_TABLES_IPV6=y
+# CONFIG_NFT_CHAIN_ROUTE_IPV6 is not set
+# CONFIG_NFT_REJECT_IPV6 is not set
+# CONFIG_NFT_DUP_IPV6 is not set
+# CONFIG_NF_DUP_IPV6 is not set
+# CONFIG_NF_REJECT_IPV6 is not set
+# CONFIG_NF_LOG_IPV6 is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+CONFIG_NF_TABLES_BRIDGE=y
+# CONFIG_NFT_BRIDGE_META is not set
+# CONFIG_NF_LOG_BRIDGE is not set
+CONFIG_BRIDGE_NF_EBTABLES=y
+CONFIG_BRIDGE_EBT_BROUTE=y
+CONFIG_BRIDGE_EBT_T_FILTER=y
+CONFIG_BRIDGE_EBT_T_NAT=y
+CONFIG_BRIDGE_EBT_802_3=y
+CONFIG_BRIDGE_EBT_AMONG=y
+CONFIG_BRIDGE_EBT_ARP=y
+CONFIG_BRIDGE_EBT_IP=y
+CONFIG_BRIDGE_EBT_IP6=y
+CONFIG_BRIDGE_EBT_LIMIT=y
+CONFIG_BRIDGE_EBT_MARK=y
+CONFIG_BRIDGE_EBT_PKTTYPE=y
+CONFIG_BRIDGE_EBT_STP=y
+CONFIG_BRIDGE_EBT_VLAN=y
+CONFIG_BRIDGE_EBT_ARPREPLY=y
+CONFIG_BRIDGE_EBT_DNAT=y
+CONFIG_BRIDGE_EBT_MARK_T=y
+CONFIG_BRIDGE_EBT_REDIRECT=y
+CONFIG_BRIDGE_EBT_SNAT=y
+CONFIG_BRIDGE_EBT_LOG=y
+CONFIG_BRIDGE_EBT_NFLOG=y
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+CONFIG_STP=y
+CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
+CONFIG_HAVE_NET_DSA=y
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+CONFIG_LLC=y
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_PHONET is not set
+# CONFIG_6LOWPAN is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+CONFIG_DNS_RESOLVER=y
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETLINK_DIAG is not set
+# CONFIG_MPLS is not set
+# CONFIG_HSR is not set
+# CONFIG_NET_SWITCHDEV is not set
+# CONFIG_NET_L3_MASTER_DEV is not set
+# CONFIG_NET_NCSI is not set
+CONFIG_RPS=y
+CONFIG_RFS_ACCEL=y
+CONFIG_XPS=y
+# CONFIG_SOCK_CGROUP_DATA is not set
+# CONFIG_CGROUP_NET_PRIO is not set
+# CONFIG_CGROUP_NET_CLASSID is not set
+CONFIG_NET_RX_BUSY_POLL=y
+CONFIG_BQL=y
+# CONFIG_BPF_JIT is not set
+CONFIG_NET_FLOW_LIMIT=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_AF_KCM is not set
+# CONFIG_STREAM_PARSER is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+# CONFIG_LWTUNNEL is not set
+CONFIG_DST_CACHE=y
+# CONFIG_NET_DEVLINK is not set
+CONFIG_MAY_USE_DEVLINK=y
+CONFIG_HAVE_CBPF_JIT=y
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
+CONFIG_ALLOW_DEV_COREDUMP=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_GENERIC_CPU_DEVICES is not set
+CONFIG_REGMAP=y
+CONFIG_REGMAP_MMIO=y
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_BRCMSTB_GISB_ARB is not set
+# CONFIG_MIPS_CDMM is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
+# CONFIG_MTD_OOPS is not set
+# CONFIG_MTD_SWAP is not set
+# CONFIG_MTD_PARTITIONED_MASTER is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+CONFIG_MTD_ROM=y
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_PHYSMAP_OF is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+CONFIG_MTD_BLOCK2MTD=y
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOCG3 is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR & LPDDR2 PCM memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_MT81xx_NOR is not set
+CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_LIMIT=20
+CONFIG_MTD_UBI_FASTMAP=y
+# CONFIG_MTD_UBI_GLUEBI is not set
+CONFIG_MTD_UBI_BLOCK=y
+CONFIG_DTC=y
+CONFIG_OF=y
+# CONFIG_OF_UNITTEST is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_EARLY_FLATTREE=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_NET=y
+CONFIG_OF_MDIO=y
+# CONFIG_OF_OVERLAY is not set
+CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+
+#
+# Misc devices
+#
+# CONFIG_SENSORS_LIS3LV02D is not set
+# CONFIG_AD525X_DPOT is not set
+# CONFIG_DUMMY_IRQ is not set
+# CONFIG_ICS932S401 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_APDS9802ALS is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_ISL29020 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_SENSORS_BH1770 is not set
+# CONFIG_SENSORS_APDS990X is not set
+# CONFIG_HMC6352 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_USB_SWITCH_FSA9480 is not set
+# CONFIG_SRAM is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_MAX6875 is not set
+# CONFIG_EEPROM_93CX6 is not set
+
+#
+# Texas Instruments shared transport line discipline
+#
+# CONFIG_TI_ST is not set
+# CONFIG_SENSORS_LIS3_I2C is not set
+
+#
+# Altera FPGA firmware download module
+#
+# CONFIG_ALTERA_STAPL is not set
+
+#
+# Intel MIC Bus Driver
+#
+
+#
+# SCIF Bus Driver
+#
+
+#
+# VOP Bus Driver
+#
+
+#
+# Intel MIC Host Driver
+#
+
+#
+# Intel MIC Card Driver
+#
+
+#
+# SCIF Driver
+#
+
+#
+# Intel MIC Coprocessor State Management (COSM) Drivers
+#
+
+#
+# VOP Driver
+#
+# CONFIG_ECHO is not set
+# CONFIG_CXL_BASE is not set
+# CONFIG_CXL_AFU_DRIVER_OPS is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+CONFIG_MII=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+# CONFIG_DUMMY is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_MACSEC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+CONFIG_TUN=y
+# CONFIG_TUN_VNET_CROSS_LE is not set
+# CONFIG_VETH is not set
+# CONFIG_NLMON is not set
+
+#
+# CAIF transport drivers
+#
+
+#
+# Distributed Switch Architecture drivers
+#
+CONFIG_ETHERNET=y
+# CONFIG_ALTERA_TSE is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_AURORA is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_DM9000 is not set
+# CONFIG_DNET is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_ETHOC is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_NET_VENDOR_STMICRO=y
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_PLATFORM=y
+CONFIG_DWMAC_GENERIC=y
+CONFIG_NET_VENDOR_SYNOPSYS=y
+# CONFIG_SYNOPSYS_DWC_ETH_QOS is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_PHYLIB=y
+CONFIG_SWPHY=y
+
+#
+# MDIO bus device drivers
+#
+# CONFIG_MDIO_BCM_UNIMAC is not set
+# CONFIG_MDIO_BITBANG is not set
+# CONFIG_MDIO_BUS_MUX_GPIO is not set
+# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
+# CONFIG_MDIO_HISI_FEMAC is not set
+
+#
+# MII PHY device drivers
+#
+# CONFIG_AMD_PHY is not set
+# CONFIG_AQUANTIA_PHY is not set
+# CONFIG_AT803X_PHY is not set
+# CONFIG_BCM7XXX_PHY is not set
+# CONFIG_BCM87XX_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_DP83848_PHY is not set
+# CONFIG_DP83867_PHY is not set
+CONFIG_FIXED_PHY=y
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_INTEL_XWAY_PHY is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_MICREL_PHY is not set
+# CONFIG_MICROCHIP_PHY is not set
+# CONFIG_MICROSEMI_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_TERANETICS_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_XILINX_GMII2RGMII is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Host-side USB support is needed for USB Network Adapter support
+#
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_ISDN is not set
+# CONFIG_NVM is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+# CONFIG_INPUT_MATRIXKMAP is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+# CONFIG_RMI4_CORE is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_SERIO_PS2MULT is not set
+# CONFIG_SERIO_ARC_PS2 is not set
+# CONFIG_SERIO_APBPS2 is not set
+# CONFIG_USERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+CONFIG_DEVMEM=y
+CONFIG_DEVKMEM=y
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+# CONFIG_SERIAL_8250_FINTEK is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250_FSL is not set
+CONFIG_SERIAL_8250_DW=y
+# CONFIG_SERIAL_8250_RT288X is not set
+# CONFIG_SERIAL_8250_INGENIC is not set
+CONFIG_SERIAL_OF_PLATFORM=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_SCCNXP is not set
+# CONFIG_SERIAL_SC16IS7XX is not set
+# CONFIG_SERIAL_BCM63XX is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_XILINX_PS_UART is not set
+# CONFIG_SERIAL_ARC is not set
+# CONFIG_SERIAL_FSL_LPUART is not set
+# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_XILLYBUS is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+
+#
+# Multiplexer I2C Chip support
+#
+# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
+# CONFIG_I2C_MUX_GPIO is not set
+# CONFIG_I2C_MUX_PCA9541 is not set
+# CONFIG_I2C_MUX_PCA954x is not set
+# CONFIG_I2C_MUX_REG is not set
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_CBUS_GPIO is not set
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+# CONFIG_I2C_EMEV2 is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_IMG is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_PXA_PCI is not set
+# CONFIG_I2C_RK3X is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_SLAVE is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_SPI is not set
+# CONFIG_SPMI is not set
+# CONFIG_HSI is not set
+
+#
+# PPS support
+#
+CONFIG_PPS=y
+# CONFIG_PPS_DEBUG is not set
+
+#
+# PPS clients support
+#
+# CONFIG_PPS_CLIENT_KTIMER is not set
+# CONFIG_PPS_CLIENT_LDISC is not set
+# CONFIG_PPS_CLIENT_GPIO is not set
+
+#
+# PPS generators support
+#
+
+#
+# PTP clock support
+#
+CONFIG_PTP_1588_CLOCK=y
+
+#
+# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
+#
+CONFIG_GPIOLIB=y
+CONFIG_OF_GPIO=y
+CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_GENERIC=y
+
+#
+# Memory mapped GPIO drivers
+#
+# CONFIG_GPIO_74XX_MMIO is not set
+# CONFIG_GPIO_ALTERA is not set
+CONFIG_GPIO_DWAPB=y
+# CONFIG_GPIO_GENERIC_PLATFORM is not set
+# CONFIG_GPIO_GRGPIO is not set
+# CONFIG_GPIO_MOCKUP is not set
+# CONFIG_GPIO_SYSCON is not set
+# CONFIG_GPIO_XILINX is not set
+# CONFIG_GPIO_ZX is not set
+
+#
+# I2C GPIO expanders
+#
+# CONFIG_GPIO_ADP5588 is not set
+# CONFIG_GPIO_ADNP is not set
+# CONFIG_GPIO_MAX7300 is not set
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_SX150X is not set
+# CONFIG_GPIO_TPIC2810 is not set
+# CONFIG_GPIO_TS4900 is not set
+
+#
+# MFD GPIO expanders
+#
+
+#
+# SPI or I2C GPIO expanders
+#
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_AVS is not set
+# CONFIG_POWER_RESET is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+CONFIG_BCMA_POSSIBLE=y
+
+#
+# Broadcom specific AMBA
+#
+# CONFIG_BCMA is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_ACT8945A is not set
+# CONFIG_MFD_AS3711 is not set
+# CONFIG_MFD_AS3722 is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_AAT2870_CORE is not set
+# CONFIG_MFD_ATMEL_FLEXCOM is not set
+# CONFIG_MFD_ATMEL_HLCDC is not set
+# CONFIG_MFD_BCM590XX is not set
+# CONFIG_MFD_AXP20X_I2C is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_DA9052_I2C is not set
+# CONFIG_MFD_DA9055 is not set
+# CONFIG_MFD_DA9062 is not set
+# CONFIG_MFD_DA9063 is not set
+# CONFIG_MFD_DA9150 is not set
+# CONFIG_MFD_EXYNOS_LPASS is not set
+# CONFIG_MFD_MC13XXX_I2C is not set
+# CONFIG_MFD_HI6421_PMIC is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_HTC_I2CPLD is not set
+# CONFIG_INTEL_SOC_PMIC is not set
+# CONFIG_MFD_KEMPLD is not set
+# CONFIG_MFD_88PM800 is not set
+# CONFIG_MFD_88PM805 is not set
+# CONFIG_MFD_88PM860X is not set
+# CONFIG_MFD_MAX14577 is not set
+# CONFIG_MFD_MAX77620 is not set
+# CONFIG_MFD_MAX77686 is not set
+# CONFIG_MFD_MAX77693 is not set
+# CONFIG_MFD_MAX77843 is not set
+# CONFIG_MFD_MAX8907 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_MAX8997 is not set
+# CONFIG_MFD_MAX8998 is not set
+# CONFIG_MFD_MT6397 is not set
+# CONFIG_MFD_MENF21BMC is not set
+# CONFIG_MFD_RETU is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_RT5033 is not set
+# CONFIG_MFD_RC5T583 is not set
+# CONFIG_MFD_RK808 is not set
+# CONFIG_MFD_RN5T618 is not set
+# CONFIG_MFD_SEC_CORE is not set
+# CONFIG_MFD_SI476X_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_SKY81452 is not set
+# CONFIG_MFD_SMSC is not set
+# CONFIG_ABX500_CORE is not set
+# CONFIG_MFD_STMPE is not set
+CONFIG_MFD_SYSCON=y
+# CONFIG_MFD_TI_AM335X_TSCADC is not set
+# CONFIG_MFD_LP3943 is not set
+# CONFIG_MFD_LP8788 is not set
+# CONFIG_MFD_PALMAS is not set
+# CONFIG_TPS6105X is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TPS6507X is not set
+# CONFIG_MFD_TPS65086 is not set
+# CONFIG_MFD_TPS65090 is not set
+# CONFIG_MFD_TPS65217 is not set
+# CONFIG_MFD_TI_LP873X is not set
+# CONFIG_MFD_TPS65218 is not set
+# CONFIG_MFD_TPS6586X is not set
+# CONFIG_MFD_TPS65910 is not set
+# CONFIG_MFD_TPS65912_I2C is not set
+# CONFIG_MFD_TPS80031 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_TWL6040_CORE is not set
+# CONFIG_MFD_WL1273_CORE is not set
+# CONFIG_MFD_LM3533 is not set
+# CONFIG_MFD_TC3589X is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_ARIZONA_I2C is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X_I2C is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_DRM is not set
+
+#
+# ACP (Audio CoProcessor) Configuration
+#
+
+#
+# Frame buffer Devices
+#
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+CONFIG_FB_CMDLINE=y
+CONFIG_FB_NOTIFY=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_OPENCORES is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_FB_AUO_K190X is not set
+# CONFIG_FB_SIMPLE is not set
+# CONFIG_FB_SSD1307 is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_DUMMY_CONSOLE_COLUMNS=80
+CONFIG_DUMMY_CONSOLE_ROWS=25
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_LOGO is not set
+# CONFIG_SOUND is not set
+
+#
+# HID support
+#
+CONFIG_HID=y
+# CONFIG_HID_BATTERY_STRENGTH is not set
+# CONFIG_HIDRAW is not set
+# CONFIG_UHID is not set
+CONFIG_HID_GENERIC=y
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_ACRUX is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_AUREAL is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CMEDIA is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EMS_FF is not set
+# CONFIG_HID_ELECOM is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_GEMBIRD is not set
+# CONFIG_HID_GFRM is not set
+# CONFIG_HID_KEYTOUCH is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_WALTOP is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_ICADE is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LCPOWER is not set
+# CONFIG_HID_LENOVO is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MAGICMOUSE is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_MULTITOUCH is not set
+# CONFIG_HID_ORTEK is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_PLANTRONICS is not set
+# CONFIG_HID_PRIMAX is not set
+# CONFIG_HID_SAITEK is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SPEEDLINK is not set
+# CONFIG_HID_STEELSERIES is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_RMI is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TIVO is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_WACOM is not set
+# CONFIG_HID_XINMO is not set
+# CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
+# CONFIG_HID_SENSOR_HUB is not set
+# CONFIG_HID_ALPS is not set
+
+#
+# I2C HID support
+#
+# CONFIG_I2C_HID is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_UWB is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+CONFIG_PWRSEQ_EMMC=y
+CONFIG_PWRSEQ_SIMPLE=y
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_MINORS=16
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+CONFIG_MMC_TEST=y
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_PLTFM=y
+# CONFIG_MMC_DW_EXYNOS is not set
+# CONFIG_MMC_DW_K3 is not set
+# CONFIG_MMC_USDHI6ROL0 is not set
+# CONFIG_MMC_MTK is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+
+#
+# DMABUF options
+#
+# CONFIG_SYNC_FILE is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_VIRT_DRIVERS is not set
+
+#
+# Virtio drivers
+#
+# CONFIG_VIRTIO_MMIO is not set
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+CONFIG_MIPS_PLATFORM_DEVICES=y
+# CONFIG_GOLDFISH is not set
+CONFIG_CLKDEV_LOOKUP=y
+CONFIG_HAVE_CLK_PREPARE=y
+CONFIG_COMMON_CLK=y
+
+#
+# Common Clock Framework
+#
+# CONFIG_COMMON_CLK_SI5351 is not set
+# CONFIG_COMMON_CLK_SI514 is not set
+# CONFIG_COMMON_CLK_SI570 is not set
+# CONFIG_COMMON_CLK_CDCE706 is not set
+# CONFIG_COMMON_CLK_CDCE925 is not set
+# CONFIG_COMMON_CLK_CS2000_CP is not set
+# CONFIG_COMMON_CLK_NXP is not set
+# CONFIG_COMMON_CLK_PXA is not set
+# CONFIG_COMMON_CLK_PIC32 is not set
+
+#
+# Hardware Spinlock drivers
+#
+
+#
+# Clock Source drivers
+#
+CONFIG_CLKSRC_OF=y
+CONFIG_CLKSRC_PROBE=y
+# CONFIG_ARM_TIMER_SP804 is not set
+# CONFIG_ATMEL_PIT is not set
+# CONFIG_SH_TIMER_CMT is not set
+# CONFIG_SH_TIMER_MTU2 is not set
+# CONFIG_SH_TIMER_TMU is not set
+# CONFIG_EM_TIMER_STI is not set
+CONFIG_CLKSRC_MIPS_GIC=y
+# CONFIG_MAILBOX is not set
+# CONFIG_IOMMU_SUPPORT is not set
+
+#
+# Remoteproc drivers
+#
+# CONFIG_STE_MODEM_RPROC is not set
+
+#
+# Rpmsg drivers
+#
+
+#
+# SOC (System On Chip) specific Drivers
+#
+
+#
+# Broadcom SoC drivers
+#
+# CONFIG_SUNXI_SRAM is not set
+# CONFIG_SOC_TI is not set
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_PWM is not set
+CONFIG_IRQCHIP=y
+CONFIG_ARM_GIC_MAX_NR=1
+CONFIG_IRQ_MIPS_CPU=y
+CONFIG_MIPS_GIC=y
+CONFIG_SX3000_ICU=y
+# CONFIG_IPACK_BUS is not set
+CONFIG_RESET_CONTROLLER=y
+# CONFIG_RESET_ATH79 is not set
+# CONFIG_RESET_BERLIN is not set
+# CONFIG_RESET_LPC18XX is not set
+# CONFIG_RESET_MESON is not set
+# CONFIG_RESET_PISTACHIO is not set
+# CONFIG_RESET_SOCFPGA is not set
+# CONFIG_RESET_STM32 is not set
+# CONFIG_RESET_SUNXI is not set
+# CONFIG_TI_SYSCON_RESET is not set
+# CONFIG_RESET_ZYNQ is not set
+# CONFIG_FMC is not set
+
+#
+# PHY Subsystem
+#
+# CONFIG_GENERIC_PHY is not set
+# CONFIG_PHY_PXA_28NM_HSIC is not set
+# CONFIG_PHY_PXA_28NM_USB2 is not set
+# CONFIG_BCM_KONA_USB2_PHY is not set
+# CONFIG_POWERCAP is not set
+# CONFIG_MCB is not set
+
+#
+# Performance monitor support
+#
+# CONFIG_RAS is not set
+
+#
+# Android
+#
+# CONFIG_ANDROID is not set
+# CONFIG_NVMEM is not set
+# CONFIG_STM is not set
+# CONFIG_INTEL_TH is not set
+
+#
+# FPGA Configuration Support
+#
+# CONFIG_FPGA is not set
+
+#
+# Firmware Drivers
+#
+# CONFIG_FIRMWARE_MEMMAP is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_POSIX_ACL is not set
+# CONFIG_EXT4_FS_SECURITY is not set
+# CONFIG_EXT4_ENCRYPTION is not set
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD2=y
+# CONFIG_JBD2_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_F2FS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_EXPORTFS=y
+# CONFIG_EXPORTFS_BLOCK_OPS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_MANDATORY_FILE_LOCKING=y
+# CONFIG_FS_ENCRYPTION is not set
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
+# CONFIG_QUOTA_DEBUG is not set
+# CONFIG_QFMT_V1 is not set
+# CONFIG_QFMT_V2 is not set
+CONFIG_QUOTACTL=y
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+# CONFIG_OVERLAY_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_FAT_DEFAULT_UTF8 is not set
+CONFIG_NTFS_FS=y
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+# CONFIG_PROC_CHILDREN is not set
+CONFIG_KERNFS=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ORANGEFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_ECRYPT_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+# CONFIG_JFFS2_RTIME is not set
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+CONFIG_UBIFS_FS_LZO=y
+CONFIG_UBIFS_FS_ZLIB=y
+# CONFIG_UBIFS_ATIME_SUPPORT is not set
+# CONFIG_LOGFS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_MINIX_FS_NATIVE_ENDIAN is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V2=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+# CONFIG_NFS_SWAP is not set
+# CONFIG_NFS_V4_1 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFS_USE_LEGACY_DNS is not set
+CONFIG_NFS_USE_KERNEL_DNS=y
+# CONFIG_NFSD is not set
+CONFIG_GRACE_PERIOD=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_DEBUG is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_MAC_ROMAN is not set
+# CONFIG_NLS_MAC_CELTIC is not set
+# CONFIG_NLS_MAC_CENTEURO is not set
+# CONFIG_NLS_MAC_CROATIAN is not set
+# CONFIG_NLS_MAC_CYRILLIC is not set
+# CONFIG_NLS_MAC_GAELIC is not set
+# CONFIG_NLS_MAC_GREEK is not set
+# CONFIG_NLS_MAC_ICELAND is not set
+# CONFIG_NLS_MAC_INUIT is not set
+# CONFIG_NLS_MAC_ROMANIAN is not set
+# CONFIG_NLS_MAC_TURKISH is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+
+#
+# printk and dmesg options
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_DYNAMIC_DEBUG is not set
+
+#
+# Compile-time checks and compiler options
+#
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO_REDUCED is not set
+# CONFIG_DEBUG_INFO_SPLIT is not set
+# CONFIG_DEBUG_INFO_DWARF4 is not set
+# CONFIG_GDB_SCRIPTS is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_PAGE_OWNER is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+CONFIG_SECTION_MISMATCH_WARN_ONLY=y
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
+CONFIG_DEBUG_KERNEL=y
+
+#
+# Memory Debugging
+#
+# CONFIG_PAGE_EXTENSION is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PAGE_POISONING is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+CONFIG_HAVE_DEBUG_KMEMLEAK=y
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_VM is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_PER_CPU_MAPS is not set
+CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_SHIRQ is not set
+
+#
+# Debug Lockups and Hangs
+#
+# CONFIG_LOCKUP_DETECTOR is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_WQ_WATCHDOG is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+CONFIG_PANIC_TIMEOUT=0
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHED_INFO is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_SCHED_STACK_END_CHECK is not set
+# CONFIG_DEBUG_TIMEKEEPING is not set
+# CONFIG_TIMER_STATS is not set
+
+#
+# Lock Debugging (spinlocks, mutexes, etc...)
+#
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_LOCK_TORTURE_TEST is not set
+# CONFIG_STACKTRACE is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_PI_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_PROVE_RCU is not set
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_TORTURE_TEST is not set
+# CONFIG_RCU_PERF_TEST is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_RCU_CPU_STALL_TIMEOUT=210
+# CONFIG_RCU_TRACE is not set
+# CONFIG_RCU_EQS_DEBUG is not set
+# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
+CONFIG_HAVE_C_RECORDMCOUNT=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_BRANCH_PROFILE_NONE is not set
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
+
+#
+# Runtime Testing
+#
+# CONFIG_LKDTM is not set
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_PERCPU_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_TEST_HEXDUMP is not set
+# CONFIG_TEST_STRING_HELPERS is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_TEST_PRINTF is not set
+# CONFIG_TEST_BITMAP is not set
+# CONFIG_TEST_UUID is not set
+# CONFIG_TEST_RHASHTABLE is not set
+# CONFIG_TEST_HASH is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_TEST_LKM is not set
+# CONFIG_TEST_USER_COPY is not set
+# CONFIG_TEST_BPF is not set
+# CONFIG_TEST_FIRMWARE is not set
+# CONFIG_TEST_UDELAY is not set
+# CONFIG_MEMTEST is not set
+# CONFIG_TEST_STATIC_KEYS is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
+# CONFIG_UBSAN is not set
+CONFIG_EARLY_PRINTK=y
+CONFIG_EARLY_PRINTK_8250=y
+CONFIG_USE_GENERIC_EARLY_PRINTK_8250=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_SPINLOCK_TEST is not set
+# CONFIG_SCACHE_DEBUGFS is not set
+CONFIG_MIPS_CPS_NS16550=y
+CONFIG_MIPS_CPS_NS16550_BASE=0xBD4D09C0
+CONFIG_MIPS_CPS_NS16550_SHIFT=2
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+# CONFIG_PERSISTENT_KEYRINGS is not set
+# CONFIG_BIG_KEYS is not set
+# CONFIG_ENCRYPTED_KEYS is not set
+# CONFIG_KEY_DH_OPERATIONS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
+CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
+# CONFIG_HARDENED_USERCOPY is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_RNG_DEFAULT=y
+CONFIG_CRYPTO_AKCIPHER2=y
+CONFIG_CRYPTO_KPP2=y
+# CONFIG_CRYPTO_RSA is not set
+# CONFIG_CRYPTO_DH is not set
+# CONFIG_CRYPTO_ECDH is not set
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_USER is not set
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+CONFIG_CRYPTO_GF128MUL=y
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_NULL2=y
+# CONFIG_CRYPTO_PCRYPT is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+CONFIG_CRYPTO_CRYPTD=y
+# CONFIG_CRYPTO_MCRYPTD is not set
+CONFIG_CRYPTO_AUTHENC=y
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
+CONFIG_CRYPTO_SEQIV=y
+CONFIG_CRYPTO_ECHAINIV=y
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=y
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_LRW=y
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_KEYWRAP is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_CMAC is not set
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_XCBC=y
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+# CONFIG_CRYPTO_CRCT10DIF is not set
+CONFIG_CRYPTO_GHASH=y
+# CONFIG_CRYPTO_POLY1305 is not set
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+# CONFIG_CRYPTO_SHA3 is not set
+CONFIG_CRYPTO_TGR192=y
+CONFIG_CRYPTO_WP512=y
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_ANUBIS=y
+CONFIG_CRYPTO_ARC4=y
+CONFIG_CRYPTO_BLOWFISH=y
+CONFIG_CRYPTO_BLOWFISH_COMMON=y
+CONFIG_CRYPTO_CAMELLIA=y
+CONFIG_CRYPTO_CAST_COMMON=y
+CONFIG_CRYPTO_CAST5=y
+CONFIG_CRYPTO_CAST6=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_FCRYPT=y
+CONFIG_CRYPTO_KHAZAD=y
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_CHACHA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+CONFIG_CRYPTO_SERPENT=y
+CONFIG_CRYPTO_TEA=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRYPTO_TWOFISH_COMMON=y
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+# CONFIG_CRYPTO_842 is not set
+# CONFIG_CRYPTO_LZ4 is not set
+# CONFIG_CRYPTO_LZ4HC is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DRBG_MENU=y
+CONFIG_CRYPTO_DRBG_HMAC=y
+# CONFIG_CRYPTO_DRBG_HASH is not set
+# CONFIG_CRYPTO_DRBG_CTR is not set
+CONFIG_CRYPTO_DRBG=y
+CONFIG_CRYPTO_JITTERENTROPY=y
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+# CONFIG_CRYPTO_USER_API_RNG is not set
+# CONFIG_CRYPTO_USER_API_AEAD is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_ASYMMETRIC_KEY_TYPE is not set
+
+#
+# Certificates for signature checking
+#
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_HAVE_ARCH_BITREVERSE is not set
+CONFIG_RATIONAL=y
+CONFIG_GENERIC_NET_UTILS=y
+CONFIG_NO_GENERIC_PCI_IOPORT_MAP=y
+CONFIG_GENERIC_PCI_IOMAP=y
+CONFIG_GENERIC_IO=y
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC16=y
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+# CONFIG_CRC8 is not set
+# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
+# CONFIG_RANDOM32_SELFTEST is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_DECOMPRESS_BZIP2=y
+CONFIG_DECOMPRESS_LZMA=y
+CONFIG_ASSOCIATIVE_ARRAY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT_MAP=y
+CONFIG_HAS_DMA=y
+CONFIG_CPU_RMAP=y
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+# CONFIG_IRQ_POLL is not set
+CONFIG_LIBFDT=y
+CONFIG_OID_REGISTRY=y
+CONFIG_FONT_SUPPORT=y
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+# CONFIG_SG_SPLIT is not set
+# CONFIG_SG_POOL is not set
+# CONFIG_ARCH_HAS_SG_CHAIN is not set
+CONFIG_SBITMAP=y
+CONFIG_HAVE_KVM=y
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/mips/include/asm/mach-sx3000/irq.h b/arch/mips/include/asm/mach-sx3000/irq.h
new file mode 100755
index 0000000..2018718
--- /dev/null
+++ b/arch/mips/include/asm/mach-sx3000/irq.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Matt Redfearn <matt.redfearn@@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_MACH_SX3000_IRQ_H__
+#define __MIPS_ASM_MACH_SX3000_IRQ_H__
+
+#define NR_IRQS 128
+
+#include_next <irq.h>
+
+#endif /* __MIPS_ASM_MACH_SX3000_IRQ_H__ */
diff --git a/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h b/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h
new file mode 100755
index 0000000..63e7b04
--- /dev/null
+++ b/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h
@@ -0,0 +1,54 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Matt Redfearn <matt.redfearn@imgtec.com>
+ * Copyright (C) 2016 Imagination Technologies Ltd.
+ */
+#ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
+#define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
+
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+
+ /*
+ * Prepare segments for EVA boot:
+ */
+ .macro platform_eva_init
+
+ .endm
+
+ .macro kernel_entry_setup
+
+#ifdef CONFIG_EVA
+ sync
+ ehb
+
+ mfc0    t1, CP0_CONFIG
+ bgez    t1, 9f
+ mfc0 t0, CP0_CONFIG, 1
+ bgez t0, 9f
+ mfc0 t0, CP0_CONFIG, 2
+ bgez t0, 9f
+ mfc0 t0, CP0_CONFIG, 3
+ sll     t0, t0, 6   /* SC bit */
+ bgez    t0, 9f
+
+ platform_eva_init
+#endif /* CONFIG_EVA */
+9 : 
+ .endm
+
+/*
+ * Do SMP slave processor setup necessary before we can safely execute C code.
+ */
+ .macro smp_slave_setup
+#ifdef CONFIG_EVA
+ sync
+ ehb
+ platform_eva_init
+#endif
+ .endm
+
+#endif /* __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H */
diff --git a/arch/mips/sx3000/Kconfig b/arch/mips/sx3000/Kconfig
new file mode 100755
index 0000000..f20d88a
--- /dev/null
+++ b/arch/mips/sx3000/Kconfig
@@ -0,0 +1,18 @@
+choice
+	prompt "Machine type"
+	depends on MACH_SX3000
+	default SX3000_DEVBOARD
+
+config SX3000_DEVBOARD
+	bool "SX3000 Development board"
+
+config SX3000_BBB
+	bool "SX3000 BBB board"
+
+config SX3000_IDU3
+	bool "SX3000 IDU rev 3 board"
+
+config SX3000_IDU4
+	bool "SX3000 IDU rev 4 board"
+
+endchoice
diff --git a/arch/mips/sx3000/Makefile b/arch/mips/sx3000/Makefile
new file mode 100755
index 0000000..ac3c5d2
--- /dev/null
+++ b/arch/mips/sx3000/Makefile
@@ -0,0 +1 @@
+obj-y += init.o irq.o time.o sx3000-reset.o
diff --git a/arch/mips/sx3000/Platform b/arch/mips/sx3000/Platform
new file mode 100755
index 0000000..d6a55d5
--- /dev/null
+++ b/arch/mips/sx3000/Platform
@@ -0,0 +1,3 @@
+platform-$(CONFIG_MACH_SX3000) += sx3000/
+cflags-$(CONFIG_MACH_SX3000) += -I$(srctree)/arch/mips/include/asm/mach-sx3000
+load-$(CONFIG_MACH_SX3000) += 0xffffffff80400000
diff --git a/arch/mips/sx3000/init.c b/arch/mips/sx3000/init.c
new file mode 100755
index 0000000..5245d06
--- /dev/null
+++ b/arch/mips/sx3000/init.c
@@ -0,0 +1,123 @@
+/*
+ * SX3000 platform setup
+ *
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Matt Redfearn <matt.redfearn@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/cacheflush.h>
+#include <asm/dma-coherence.h>
+#include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/prom.h>
+#include <asm/traps.h>
+
+/* Uncached (KSEG1) virtual address of console UART */
+#define SX3000_UART0_BASE	0xBD4D09C0 // (0xA000_0000 for kseg1 + 0x1D4D09C0)
+
+/* Physical addresses where the CPC and CDMM regions can be mapped to */
+#define DEFAULT_CPC_BASE_ADDR	0x1DA00000
+#define DEFAULT_CDMM_BASE_ADDR	0x1DA20000
+
+const char *get_system_type(void)
+{
+	/*
+	 * If your SoC has a revision register, you should
+	 * read it here and return the appropriate name.
+	 */
+	return "SX3000";
+}
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return DEFAULT_CPC_BASE_ADDR;
+}
+
+phys_addr_t mips_cdmm_phys_base(void)
+{
+	return DEFAULT_CDMM_BASE_ADDR;
+}
+
+static void __init plat_setup_iocoherency(void)
+{
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off and use hardware
+	 * coherency instead.
+	 */
+	if (mips_cm_numiocu() != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("CMP IOCU detected\n");
+
+		hw_coherentio = 0;
+		coherentio = 0;
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency disabled\n");
+		else
+			pr_info("Hardware DMA cache coherency enabled\n");
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
+		else
+			pr_info("Software DMA cache coherency enabled\n");
+	}
+}
+
+void __init plat_mem_setup(void)
+{
+	__dt_setup_arch(__dtb_start);
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	// Change segctl 0,2 to confer with legacy mode
+	write_c0_segctl0(0x00230013);
+
+	write_c0_segctl2(0x00330033);
+	plat_setup_iocoherency();
+}
+
+void __init prom_init(void)
+{
+	/* Set up early printk (byte access, 50000 timeout */
+	setup_8250_early_printk_port(SX3000_UART0_BASE, 2, 50000);
+
+	mips_cm_probe();
+	mips_cpc_probe();
+#ifdef CONFIG_MIPS_CPS
+	register_cps_smp_ops();
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init device_tree_init(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	unflatten_and_copy_device_tree();
+}
+
+static int __init plat_of_setup(void)
+{
+	if (!of_have_populated_dt())
+		panic("Device tree not present");
+
+	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+		panic("Failed to populate DT");
+
+	return 0;
+}
+arch_initcall(plat_of_setup);
diff --git a/arch/mips/sx3000/irq.c b/arch/mips/sx3000/irq.c
new file mode 100755
index 0000000..76c4301
--- /dev/null
+++ b/arch/mips/sx3000/irq.c
@@ -0,0 +1,35 @@
+/*
+ * SX3000 IRQ setup
+ *
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Matt Redfearn <matt.redfearn@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/kernel.h>
+
+#include <asm/cpu-features.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+
+void __init arch_init_irq(void)
+{
+	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
+	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
+
+	pr_info("IRQ base, CPU: %d GIC: %d\n", MIPS_CPU_IRQ_BASE, MIPS_GIC_IRQ_BASE);
+
+	// Clear the IPL field in the status register to have minimum int level 0
+	clear_c0_status(ST0_IM);
+
+	if (!cpu_has_veic)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
diff --git a/arch/mips/sx3000/sx3000-reset.c b/arch/mips/sx3000/sx3000-reset.c
new file mode 100755
index 0000000..82c5bb3
--- /dev/null
+++ b/arch/mips/sx3000/sx3000-reset.c
@@ -0,0 +1,54 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Amit Kama, <amit.kama@satixfy.com>
+ * Copyright (C) 2017 Satixfy Technologies, Ltd.  All rights reserved.
+ */
+#include <linux/io.h>
+#include <asm/reboot.h>
+
+#define SX3000_GPIO_BASE	0x1D4D0CC0
+#define SX3000_RESET_GPIO	11
+#define SX3000_GPIO_SIZE	16
+#define SX3000_GPIO_DATA	0
+#define SX3000_GPIO_DIR		4
+#define SX3000_GPIO_CTRL	8
+
+static void sx3000_machine_restart(char *command)
+{
+	unsigned int data;
+	unsigned int dir;
+	unsigned int ctrl;
+
+	unsigned int __iomem *gpio_space =
+		ioremap_nocache(SX3000_GPIO_BASE, SX3000_GPIO_SIZE);
+
+	data =	__raw_readl(gpio_space + SX3000_GPIO_DATA);
+	dir =	__raw_readl(gpio_space + SX3000_GPIO_DIR);
+	ctrl =	__raw_readl(gpio_space + SX3000_GPIO_CTRL);
+
+	data = data | (1<<SX3000_RESET_GPIO);
+	dir  = dir	| (1<<SX3000_RESET_GPIO);
+	ctrl = ctrl & ~(1<<SX3000_RESET_GPIO);
+
+	*((unsigned int *)((unsigned int)gpio_space + SX3000_GPIO_DATA)) = data;
+	*((unsigned int *)((unsigned int)gpio_space + SX3000_GPIO_DIR)) = dir;
+	*((unsigned int *)((unsigned int)gpio_space + SX3000_GPIO_CTRL)) = ctrl;
+}
+
+static void sx3000_machine_halt(void)
+{
+	while (true);
+}
+
+static int __init sx3000_reboot_setup(void)
+{
+	_machine_restart = sx3000_machine_restart;
+	_machine_halt = sx3000_machine_halt;
+
+	return 0;
+}
+
+arch_initcall(sx3000_reboot_setup);
diff --git a/arch/mips/sx3000/time.c b/arch/mips/sx3000/time.c
new file mode 100755
index 0000000..e1d974e
--- /dev/null
+++ b/arch/mips/sx3000/time.c
@@ -0,0 +1,59 @@
+/*
+ * SX3000 clocksource/timer setup
+ *
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Matt Redfearn <matt.redfearn@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/of.h>
+
+#include <asm/time.h>
+
+unsigned int get_c0_compare_int(void)
+{
+	return gic_get_c0_compare_int();
+}
+
+int get_c0_perfcount_int(void)
+{
+	return gic_get_c0_perfcount_int();
+}
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
+
+int get_c0_fdc_int(void)
+{
+	return gic_get_c0_fdc_int();
+}
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+
+	of_clk_init(NULL);
+	clocksource_probe();
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	clk_put(clk);
+}
