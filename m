Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 22:30:52 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36104
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdL1VaYdroUH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 22:30:24 +0100
Received: by mail-wr0-x244.google.com with SMTP id u19so33870508wrc.3;
        Thu, 28 Dec 2017 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dNVU+qjLW88TvjOMJnzB9kZ0EzeVmHkwqLy+4V0tZD8=;
        b=JyuSfV7bQxzPKu7bCM59iDSoP0l98EWBHnwtfz5mds100jPw74GyueJ4PtEYVL9MKQ
         nYiJ+/LYqatyOLDdO5oOAGwkQM2V0IbCtproiFQjOTJOmh3OnaAjKMV9Wml3IUciIG/v
         7+KfahhSKsD22Yio282vYNGJ2Hyqc5+MJqoCCVpDzlDdKd3uxweMlfbSh7t6y4CraNl8
         4TyEg63bJ72R/UjQ2EKekdhV6ILuUtJcplfg9QzUvex+m6q+fHl5M0UvZfujJRiKuVyt
         +ugNLLQRZfYDnmKYnGoyPyrQtJPB6JlQfxsmL+JbNDktA9zkNYcATh4VraMcKNi2wuym
         KsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dNVU+qjLW88TvjOMJnzB9kZ0EzeVmHkwqLy+4V0tZD8=;
        b=diqbhkTXtzx9utboSmpzCtubVs9tYn1IU8S4OSeR226s6nAMZQRV/BqNccLPf8apT7
         9u6KuzheCI8YTghVUFltgFc5c9dH8m7qOQx/PBQFpScOsyfYgxnp1DhGx+EbT5iQlLvs
         Aoh73hA4DNTLAP9XM4PKQ6Zyi8cWKYFb3QX+SLez5SGOmUUMRDl5mepTz9Hr7jXaePX4
         NpyDROHyb0/G18yjlmp7Ly9CMXxeyd1jE41lgHkcaJovMaIJoJC51nw3CuDW0ruBHiGq
         eyHIwOP068Ui4sR2tKmtmpr/s1l/5rNwmuOAFbpbnREf7go/bzFCcdHOaxLru4QW/TXO
         6G7Q==
X-Gm-Message-State: AKGB3mJXSmNXT5ICyYrIo0xYFiIsGa+a31AGzXZasOTJJ/B/zGq+DNJD
        R795TeLgpGnhyEdzQVpm7Kk=
X-Google-Smtp-Source: ACJfBotFi7PhugjXy2qiy0PuLOIO2Q6M//cqMMc6cULEDnYfsDv6gVCPigFcGoWATnhXKJw0CgpjRQ==
X-Received: by 10.223.139.152 with SMTP id o24mr35260255wra.243.1514496618947;
        Thu, 28 Dec 2017 13:30:18 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id a203sm14673801wmh.45.2017.12.28.13.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:30:18 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 4766A10C32F6; Thu, 28 Dec 2017 22:30:17 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
Date:   Thu, 28 Dec 2017 22:29:52 +0100
Message-Id: <20171228212954.2922-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171228212954.2922-1-malat@debian.org>
References: <20171228212954.2922-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only expose
a read only access to the entire 8K bits efuse memory.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
 .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
 MAINTAINERS                                        |   5 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
 drivers/nvmem/Kconfig                              |  10 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
 7 files changed, 383 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
 create mode 100644 drivers/nvmem/jz4780-efuse.c

diff --git a/Documentation/ABI/testing/sysfs-driver-jz4780-efuse b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
new file mode 100644
index 000000000000..bb6f5d6ceea0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
@@ -0,0 +1,16 @@
+What:		/sys/devices/*/<our-device>/nvmem
+Date:		December 2017
+Contact:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+Description:	read-only access to the efuse on the Ingenic JZ4780 SoC
+		The SoC has a one time programmable 8K efuse that is
+		split into segments. The driver supports read only.
+		The segments are
+		0x000   64 bit Random Number
+		0x008  128 bit Ingenic Chip ID
+		0x018  128 bit Customer ID
+		0x028 3520 bit Reserved
+		0x1E0    8 bit Protect Segment
+		0x1E1 2296 bit HDMI Key
+		0x300 2048 bit Security boot key
+Users:		any user space application which wants to read the Chip
+		and Customer ID
diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
new file mode 100644
index 000000000000..cd6d67ec22fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
@@ -0,0 +1,17 @@
+Ingenic JZ EFUSE driver bindings
+
+Required properties:
+- "compatible"		Must be set to "ingenic,jz4780-efuse"
+- "reg"			Register location and length
+- "clocks"		Handle for the ahb clock for the efuse.
+- "clock-names"		Must be "bus_clk"
+
+Example:
+
+efuse: efuse@134100d0 {
+	compatible = "ingenic,jz4780-efuse";
+	reg = <0x134100D0 0xFF>;
+
+	clocks = <&cgu JZ4780_CLK_AHB2>;
+	clock-names = "bus_clk";
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index a6e86e20761e..7a050c20c533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,11 @@ M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
 S:	Maintained
 F:	drivers/dma/dma-jz4780.c
 
+INGENIC JZ4780 EFUSE Driver
+M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+S:	Maintained
+F:	drivers/nvmem/jz4780-efuse.c
+
 INGENIC JZ4780 NAND DRIVER
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mtd@lists.infradead.org
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..3fb9d916a2ea 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -224,21 +224,37 @@
 		reg = <0x10002000 0x100>;
 	};
 
-	nemc: nemc@13410000 {
-		compatible = "ingenic,jz4780-nemc";
-		reg = <0x13410000 0x10000>;
-		#address-cells = <2>;
+
+	ahb2: ahb2 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <1 0 0x1b000000 0x1000000
-			  2 0 0x1a000000 0x1000000
-			  3 0 0x19000000 0x1000000
-			  4 0 0x18000000 0x1000000
-			  5 0 0x17000000 0x1000000
-			  6 0 0x16000000 0x1000000>;
+		ranges = <>;
+
+		nemc: nemc@13410000 {
+			compatible = "ingenic,jz4780-nemc";
+			reg = <0x13410000 0x10000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <1 0 0x1b000000 0x1000000
+				  2 0 0x1a000000 0x1000000
+				  3 0 0x19000000 0x1000000
+				  4 0 0x18000000 0x1000000
+				  5 0 0x17000000 0x1000000
+				  6 0 0x16000000 0x1000000>;
+
+			clocks = <&cgu JZ4780_CLK_NEMC>;
+
+			status = "disabled";
+		};
 
-		clocks = <&cgu JZ4780_CLK_NEMC>;
+		efuse: efuse@134100d0 {
+			compatible = "ingenic,jz4780-efuse";
+			reg = <0x134100d0 0xff>;
 
-		status = "disabled";
+			clocks = <&cgu JZ4780_CLK_AHB2>;
+			clock-names = "bus_clk";
+		};
 	};
 
 	bch: bch@134d0000 {
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ff505af064ba..75400982abac 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -36,6 +36,16 @@ config NVMEM_IMX_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-imx-ocotp.
 
+config JZ4780_EFUSE
+	tristate "JZ4780 EFUSE Memory Support"
+	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say Y here to include support for JZ4780 efuse memory found on
+	  all JZ4780 SoC based devices.
+	  To compile this driver as a module, choose M here: the module
+	  will be called nvmem_jz4780_efuse.
+
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e54dcfa6565a..3b7c18df6771 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)	+= nvmem-imx-iim.o
 nvmem-imx-iim-y			:= imx-iim.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y		:= imx-ocotp.o
+obj-$(CONFIG_JZ4780_EFUSE)		+= nvmem_jz4780_efuse.o
+nvmem_jz4780_efuse-y		:= jz4780-efuse.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
new file mode 100644
index 000000000000..2490e5fc1a88
--- /dev/null
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -0,0 +1,305 @@
+/*
+ * JZ4780 EFUSE Memory Support driver
+ *
+ * Copyright (c) 2017 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ */
+
+/*
+ * Currently supports JZ4780 efuse which has 8K programmable bit.
+ * Efuse is separated into seven segments as below:
+ *
+ * -----------------------------------------------------------------------
+ * | 64 bit | 128 bit | 128 bit | 3520 bit | 8 bit | 2296 bit | 2048 bit |
+ * -----------------------------------------------------------------------
+ *
+ * The rom itself is accessed using a 9 bit address line and an 8 word wide bus
+ * which reads/writes based on strobes. The strobe is configured in the config
+ * register and is based on number of cycles of the bus clock.
+ *
+ * Driver supports read only as the writes are done in the Factory.
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+
+#define JZ_EFUCTRL			(0x0)	/* Control Register */
+#define JZ_EFUCFG			(0x4)	/* Configure Register*/
+#define JZ_EFUSTATE			(0x8)	/* Status Register */
+#define JZ_EFUDATA(n)			(0xC + (n)*4)
+
+#define JZ_EFUSE_START_ADDR		0x200
+#define JZ_EFUSE_SEG1_OFF		0x00	/* 64 bit Random Number */
+#define JZ_EFUSE_SEG2_OFF		0x08	/* 128 bit Ingenic Chip ID */
+#define JZ_EFUSE_SEG3_OFF		0x18	/* 128 bit Customer ID */
+#define JZ_EFUSE_SEG4_OFF		0x28	/* 3520 bit Reserved */
+#define JZ_EFUSE_SEG5_OFF		0x1E0	/* 8 bit Protect Segment */
+#define JZ_EFUSE_SEG6_OFF		0x1E1	/* 2296 bit HDMI Key */
+#define JZ_EFUSE_SEG7_OFF		0x300	/* 2048 bit Security boot key */
+#define JZ_EFUSE_END_ADDR		0x5FF
+
+#define JZ_EFUSE_EFUCTRL_CS		BIT(30)
+#define JZ_EFUSE_EFUCTRL_ADDR_MASK	0x1FF
+#define JZ_EFUSE_EFUCTRL_ADDR_SHIFT	21
+#define JZ_EFUSE_EFUCTRL_LEN_MASK	0x1F
+#define JZ_EFUSE_EFUCTRL_LEN_SHIFT	16
+#define JZ_EFUSE_EFUCTRL_PG_EN		BIT(15)
+#define JZ_EFUSE_EFUCTRL_WR_EN		BIT(1)
+#define JZ_EFUSE_EFUCTRL_RD_EN		BIT(0)
+
+#define JZ_EFUSE_EFUCFG_INT_EN		BIT(31)
+#define JZ_EFUSE_EFUCFG_RD_ADJ_MASK	0xF
+#define JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT	20
+#define JZ_EFUSE_EFUCFG_RD_STR_MASK	0xF
+#define JZ_EFUSE_EFUCFG_RD_STR_SHIFT	16
+#define JZ_EFUSE_EFUCFG_WR_ADJ_MASK	0xF
+#define JZ_EFUSE_EFUCFG_WR_ADJ_SHIFT	12
+#define JZ_EFUSE_EFUCFG_WR_STR_MASK	0xFFF
+#define JZ_EFUSE_EFUCFG_WR_STR_SHIFT	0
+
+#define JZ_EFUSE_EFUSTATE_WR_DONE	BIT(1)
+#define JZ_EFUSE_EFUSTATE_RD_DONE	BIT(0)
+
+#define JZ_EFUSE_WORD_SIZE		16
+#define JZ_EFUSE_STRIDE			8
+
+struct jz4780_efuse {
+	struct device *dev;
+	void __iomem *iomem;
+	struct clk *clk;
+	unsigned int rd_adj;
+	unsigned int rd_strobe;
+};
+
+/* We read 32 byte chunks to avoid complexity in the driver. */
+static int jz4780_efuse_read_32bytes(struct jz4780_efuse *efuse, char *buf,
+		unsigned int addr)
+{
+	unsigned int tmp = 0;
+	int i = 0;
+	int timeout = 1000;
+	int size = 32;
+
+	/* 1. Set config register */
+	tmp = readl(efuse->iomem + JZ_EFUCFG);
+	tmp &= ~((JZ_EFUSE_EFUCFG_RD_ADJ_MASK << JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT)
+	| (JZ_EFUSE_EFUCFG_RD_STR_MASK << JZ_EFUSE_EFUCFG_RD_STR_SHIFT));
+	tmp |= (efuse->rd_adj << JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT)
+	| (efuse->rd_strobe << JZ_EFUSE_EFUCFG_RD_STR_SHIFT);
+	writel(tmp, efuse->iomem + JZ_EFUCFG);
+
+	/*
+	 * 2. Set control register to indicate what to read data address,
+	 * read data numbers and read enable.
+	 */
+	tmp = readl(efuse->iomem + JZ_EFUCTRL);
+	tmp &= ~(JZ_EFUSE_EFUCFG_RD_STR_SHIFT
+		| (JZ_EFUSE_EFUCTRL_ADDR_MASK << JZ_EFUSE_EFUCTRL_ADDR_SHIFT)
+		| JZ_EFUSE_EFUCTRL_PG_EN | JZ_EFUSE_EFUCTRL_WR_EN
+		| JZ_EFUSE_EFUCTRL_WR_EN);
+
+	/* Need to select CS bit if address accesses upper 4Kbits memory */
+	if (addr >= (JZ_EFUSE_START_ADDR + 512))
+		tmp |= JZ_EFUSE_EFUCTRL_CS;
+
+	tmp |= (addr << JZ_EFUSE_EFUCTRL_ADDR_SHIFT)
+		| ((size - 1) << JZ_EFUSE_EFUCTRL_LEN_SHIFT)
+		| JZ_EFUSE_EFUCTRL_RD_EN;
+	writel(tmp, efuse->iomem + JZ_EFUCTRL);
+
+	/*
+	 * 3. Wait status register RD_DONE set to 1 or EFUSE interrupted,
+	 * software can read EFUSE data buffer 0 - 8 registers.
+	 */
+	do {
+		tmp = readl(efuse->iomem + JZ_EFUSTATE);
+		usleep_range(1000, 2000);
+		if (timeout--)
+			break;
+	} while (!(tmp & JZ_EFUSE_EFUSTATE_RD_DONE));
+
+	if (timeout <= 0) {
+		dev_err(efuse->dev, "Timed out while reading\n");
+		return -EAGAIN;
+	}
+
+	for (i = 0; i < (size / 4); i++)
+		*((unsigned int *)(buf + i * 4))
+			 = readl(efuse->iomem + JZ_EFUDATA(i));
+
+	return 0;
+}
+
+static unsigned int segments[][2] = {
+		/* offset	, size in bytes */
+		{ JZ_EFUSE_SEG1_OFF,   64 >> 3 }, /* bit Random Number */
+		{ JZ_EFUSE_SEG2_OFF,  128 >> 3 }, /* bit Ingenic Chip ID */
+		{ JZ_EFUSE_SEG3_OFF,  128 >> 3 }, /* bit Customer ID */
+		{ JZ_EFUSE_SEG4_OFF, 3520 >> 3 }, /* bit Reserved */
+		{ JZ_EFUSE_SEG5_OFF,    8 >> 3 }, /* bit Protect Segment */
+		{ JZ_EFUSE_SEG6_OFF, 2296 >> 3 }, /* bit HDMI Key */
+		{ JZ_EFUSE_SEG7_OFF, 2048 >> 3 }  /* bit Security boot key */
+};
+
+#define MAX(x, y) (((x) > (y)) ? (x) : (y))
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+
+/* PM recommends read/write each segment separately */
+static int jz4780_efuse_read_segment(struct jz4780_efuse *efuse, int segid,
+	unsigned int *offset, char *out, size_t *bytes)
+{
+	char buf[32];
+	unsigned int lpos, buflen, ncount, remain;
+	unsigned int *segment = segments[segid];
+	int j;
+	char *cur = out;
+	int ret;
+
+	if (*bytes == 0 ||
+		(*offset < segment[0] || *offset >= segment[0] + segment[1])) {
+		// nothing to see, move along
+		return 0;
+	}
+	lpos = MAX(segment[0], *offset);
+	buflen = MIN(segment[1], *bytes);
+	ncount = buflen / 32;
+	remain = buflen % 32;
+
+	for (j = 0; j < ncount ; ++j) {
+		ret = jz4780_efuse_read_32bytes(efuse, buf, lpos);
+		if (ret < 0)
+			return ret;
+
+		memcpy(cur, buf, sizeof(buf));
+		cur += sizeof(buf);
+		lpos += sizeof(buf);
+		}
+	if (remain) {
+		ret = jz4780_efuse_read_32bytes(efuse, buf, lpos);
+		if (ret < 0)
+			return ret;
+
+		memcpy(cur, buf, remain);
+		cur += remain;
+		}
+	*offset += buflen;
+	*bytes -= buflen;
+	return buflen;
+}
+
+/* main entry point */
+static int jz4780_efuse_read(void *context, unsigned int offset,
+					void *val, size_t bytes)
+{
+	static const int nsegments = sizeof(segments) / sizeof(*segments);
+	struct jz4780_efuse *efuse = context;
+	char *cur = val;
+	int i, ret;
+
+	for (i = 0; i < nsegments; ++i) {
+		ret = jz4780_efuse_read_segment(efuse, i, &offset, cur, &bytes);
+		if (ret < 0)
+			return ret;
+		cur += ret;
+	}
+
+	return 0;
+}
+
+static struct nvmem_config jz4780_efuse_nvmem_config = {
+	.name = "jz4780-efuse",
+	.read_only = true,
+	.word_size = JZ_EFUSE_WORD_SIZE,
+	.stride = JZ_EFUSE_STRIDE,
+	.owner = THIS_MODULE,
+	.reg_read = jz4780_efuse_read,
+};
+
+static int jz4780_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+	struct jz4780_efuse *efuse;
+	struct resource *res;
+	unsigned long clk_rate;
+	struct device *dev = &pdev->dev;
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	efuse->iomem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(efuse->iomem))
+		return PTR_ERR(efuse->iomem);
+
+	efuse->clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(efuse->clk))
+		return PTR_ERR(efuse->clk);
+
+	clk_rate = clk_get_rate(efuse->clk);
+	/*
+	 * rd_adj and rd_strobe are 4 bit values
+	 * bus clk period * (rd_adj + 1) > 6.5ns
+	 * bus clk period * (rd_adj + 5 + rd_strobe) > 35ns
+	 */
+	efuse->rd_adj = (((6500 * (clk_rate / 1000000)) / 1000000) + 1) - 1;
+	efuse->rd_strobe = ((((35000 * (clk_rate / 1000000)) / 1000000) + 1)
+						- 5 - efuse->rd_adj);
+
+	if ((efuse->rd_adj > 0x1F) || (efuse->rd_strobe > 0x1F)) {
+		dev_err(&pdev->dev, "Cannot set clock configuration\n");
+		return -EINVAL;
+	}
+	efuse->dev = dev;
+
+	jz4780_efuse_nvmem_config.size = 1024;
+	jz4780_efuse_nvmem_config.dev = &pdev->dev;
+	jz4780_efuse_nvmem_config.priv = efuse;
+
+	nvmem = nvmem_register(&jz4780_efuse_nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int jz4780_efuse_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static const struct of_device_id jz4780_efuse_match[] = {
+	{ .compatible = "ingenic,jz4780-efuse" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, jz4780_efuse_match);
+
+static struct platform_driver jz4780_efuse_driver = {
+	.probe  = jz4780_efuse_probe,
+	.remove = jz4780_efuse_remove,
+	.driver = {
+		.name = "jz4780-efuse",
+		.of_match_table = jz4780_efuse_match,
+	},
+};
+module_platform_driver(jz4780_efuse_driver);
+
+MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
+MODULE_DESCRIPTION("Ingenic JZ4780 efuse driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
