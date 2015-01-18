Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:42:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15995 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011783AbbARWmOKVkUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:42:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1A6092B825A4E;
        Sun, 18 Jan 2015 22:42:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:42:07 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:42:02 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 29/36] devicetree: add ingenic,jz4780-cgu binding documentation
Date:   Sun, 18 Jan 2015 14:41:59 -0800
Message-ID: <1421620919-25356-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45278
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

Document the devictree binding for the Ingenic jz4780 CGU driver.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: devicetree@vger.kernel.org
---
 .../bindings/clock/ingenic,jz4780-cgu.txt          | 52 +++++++++++++
 include/dt-bindings/clock/jz4780-cgu.h             | 88 ++++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt b/Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt
new file mode 100644
index 0000000..2432a49
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt
@@ -0,0 +1,52 @@
+Ingenic jz4780 SoC CGU binding
+
+The CGU in a jz4780 SoC provides all the clocks generated on-chip. It includes
+PLLs, multiplexers, dividers & gates in order to provide a variety of different
+clock signals derived from only 2 external source clocks.
+
+Required properties:
+- compatible: Should be "ingenic,jz4780-cgu"
+- reg: Should be the address & length of the CGU registers
+- clocks: Should contain the phandle & clock specifier for two clocks external
+          to the TCU. First the external crystal "ext" and second the RTC
+          clock source "rtc".
+- clock-names: Should be set to strings naming the clocks specified in the
+               "clocks" property.
+- #clock-cells: Should be 1.
+                Clock consumers specify this argument to identify a clock. The
+                valid values may be found in <dt-bindings/clock/jz4780-cgu.h>.
+
+Example SoC include file:
+
+/ {
+	cgu: jz4780-cgu {
+		compatible = "ingenic,jz4780-cgu";
+		reg = <0x10000000 0x100>;
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		clocks = <&cgu JZ4780_CLK_UART0>;
+	};
+};
+
+Example board file:
+
+/ {
+	ext: clock@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
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
2.2.1
