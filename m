Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 15:26:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3896 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026035AbbDXN0DcxpA- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 15:26:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8F8F0E0F7EFFE;
        Fri, 24 Apr 2015 14:25:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 14:25:56 +0100
Received: from localhost (192.168.159.76) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 14:25:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@linaro.org>,
        Pawel Moll <pawel.moll@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 24/37] devicetree: add Ingenic CGU binding documentation
Date:   Fri, 24 Apr 2015 14:17:24 +0100
Message-ID: <1429881457-16016-25-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.76]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47058
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

Document the devicetree binding for Ingenic SoC CGUs, and add headers
defining the clock specifiers for clocks provided by the JZ4740 & JZ4780
CGU blocks.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
Changes in v4:
  - s/TCU/CGU/

Changes in v3:
  - Merge binding documentation for various Ingenic SoCs which differ only
    by compatible strings.

Changes in v2:
  - None.
---
 .../devicetree/bindings/clock/ingenic,cgu.txt      | 53 +++++++++++++
 include/dt-bindings/clock/jz4740-cgu.h             | 37 +++++++++
 include/dt-bindings/clock/jz4780-cgu.h             | 88 ++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,cgu.txt
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.txt b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
new file mode 100644
index 0000000..f8d4134
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
@@ -0,0 +1,53 @@
+Ingenic SoC CGU binding
+
+The CGU in an Ingenic SoC provides all the clocks generated on-chip. It
+typically includes a variety of PLLs, multiplexers, dividers & gates in order
+to provide many different clock signals derived from only 2 external source
+clocks.
+
+Required properties:
+- compatible : Should be "ingenic,<soctype>-cgu".
+  For example "ingenic,jz4740-cgu" or "ingenic,jz4780-cgu".
+- reg : The address & length of the CGU registers.
+- clocks : List of phandle & clock specifiers for clocks external to the CGU.
+  Two such external clocks should be specified - first the external crystal
+  "ext" and second the RTC clock source "rtc".
+- clock-names : List of name strings for the external clocks.
+- #clock-cells: Should be 1.
+  Clock consumers specify this argument to identify a clock. The valid values
+  may be found in <dt-bindings/clock/<soctype>-cgu.h>.
+
+Example SoC include file:
+
+/ {
+	cgu: jz4740-cgu {
+		compatible = "ingenic,jz4740-cgu";
+		reg = <0x10000000 0x100>;
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		clocks = <&cgu JZ4740_CLK_UART0>;
+	};
+};
+
+Example board file:
+
+/ {
+	ext: clock@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
+	rtc: clock@1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	&cgu {
+		clocks = <&ext> <&rtc>;
+		clock-names: "ext", "rtc";
+	};
+};
diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/jz4740-cgu.h
new file mode 100644
index 0000000..43153d3
--- /dev/null
+++ b/include/dt-bindings/clock/jz4740-cgu.h
@@ -0,0 +1,37 @@
+/*
+ * This header provides clock numbers for the ingenic,jz4740-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the jz4740 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
+
+#define JZ4740_CLK_EXT		0
+#define JZ4740_CLK_RTC		1
+#define JZ4740_CLK_PLL		2
+#define JZ4740_CLK_PLL_HALF	3
+#define JZ4740_CLK_CCLK		4
+#define JZ4740_CLK_HCLK		5
+#define JZ4740_CLK_PCLK		6
+#define JZ4740_CLK_MCLK		7
+#define JZ4740_CLK_LCD		8
+#define JZ4740_CLK_LCD_PCLK	9
+#define JZ4740_CLK_I2S		10
+#define JZ4740_CLK_SPI		11
+#define JZ4740_CLK_MMC		12
+#define JZ4740_CLK_UHC		13
+#define JZ4740_CLK_UDC		14
+#define JZ4740_CLK_UART0	15
+#define JZ4740_CLK_UART1	16
+#define JZ4740_CLK_DMA		17
+#define JZ4740_CLK_IPU		18
+#define JZ4740_CLK_ADC		19
+#define JZ4740_CLK_I2C		20
+#define JZ4740_CLK_AIC		21
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4740_CGU_H__ */
diff --git a/include/dt-bindings/clock/jz4780-cgu.h b/include/dt-bindings/clock/jz4780-cgu.h
new file mode 100644
index 0000000..467165e
--- /dev/null
+++ b/include/dt-bindings/clock/jz4780-cgu.h
@@ -0,0 +1,88 @@
+/*
+ * This header provides clock numbers for the ingenic,jz4780-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the jz4780 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4780_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4780_CGU_H__
+
+#define JZ4780_CLK_EXCLK	0
+#define JZ4780_CLK_RTCLK	1
+#define JZ4780_CLK_APLL		2
+#define JZ4780_CLK_MPLL		3
+#define JZ4780_CLK_EPLL		4
+#define JZ4780_CLK_VPLL		5
+#define JZ4780_CLK_OTGPHY	6
+#define JZ4780_CLK_SCLKA	7
+#define JZ4780_CLK_CPUMUX	8
+#define JZ4780_CLK_CPU		9
+#define JZ4780_CLK_L2CACHE	10
+#define JZ4780_CLK_AHB0		11
+#define JZ4780_CLK_AHB2PMUX	12
+#define JZ4780_CLK_AHB2		13
+#define JZ4780_CLK_PCLK		14
+#define JZ4780_CLK_DDR		15
+#define JZ4780_CLK_VPU		16
+#define JZ4780_CLK_I2SPLL	17
+#define JZ4780_CLK_I2S		18
+#define JZ4780_CLK_LCD0PIXCLK	19
+#define JZ4780_CLK_LCD1PIXCLK	20
+#define JZ4780_CLK_MSCMUX	21
+#define JZ4780_CLK_MSC0		22
+#define JZ4780_CLK_MSC1		23
+#define JZ4780_CLK_MSC2		24
+#define JZ4780_CLK_UHC		25
+#define JZ4780_CLK_SSIPLL	26
+#define JZ4780_CLK_SSI		27
+#define JZ4780_CLK_CIMMCLK	28
+#define JZ4780_CLK_PCMPLL	29
+#define JZ4780_CLK_PCM		30
+#define JZ4780_CLK_GPU		31
+#define JZ4780_CLK_HDMI		32
+#define JZ4780_CLK_BCH		33
+#define JZ4780_CLK_NEMC		34
+#define JZ4780_CLK_OTG0		35
+#define JZ4780_CLK_SSI0		36
+#define JZ4780_CLK_SMB0		37
+#define JZ4780_CLK_SMB1		38
+#define JZ4780_CLK_SCC		39
+#define JZ4780_CLK_AIC		40
+#define JZ4780_CLK_TSSI0	41
+#define JZ4780_CLK_OWI		42
+#define JZ4780_CLK_KBC		43
+#define JZ4780_CLK_SADC		44
+#define JZ4780_CLK_UART0	45
+#define JZ4780_CLK_UART1	46
+#define JZ4780_CLK_UART2	47
+#define JZ4780_CLK_UART3	48
+#define JZ4780_CLK_SSI1		49
+#define JZ4780_CLK_SSI2		50
+#define JZ4780_CLK_PDMA		51
+#define JZ4780_CLK_GPS		52
+#define JZ4780_CLK_MAC		53
+#define JZ4780_CLK_SMB2		54
+#define JZ4780_CLK_CIM		55
+#define JZ4780_CLK_LCD		56
+#define JZ4780_CLK_TVE		57
+#define JZ4780_CLK_IPU		58
+#define JZ4780_CLK_DDR0		59
+#define JZ4780_CLK_DDR1		60
+#define JZ4780_CLK_SMB3		61
+#define JZ4780_CLK_TSSI1	62
+#define JZ4780_CLK_COMPRESS	63
+#define JZ4780_CLK_AIC1		64
+#define JZ4780_CLK_GPVLC	65
+#define JZ4780_CLK_OTG1		66
+#define JZ4780_CLK_UART4	67
+#define JZ4780_CLK_AHBMON	68
+#define JZ4780_CLK_SMB4		69
+#define JZ4780_CLK_DES		70
+#define JZ4780_CLK_X2D		71
+#define JZ4780_CLK_CORE1	72
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4780_CGU_H__ */
-- 
2.3.5
