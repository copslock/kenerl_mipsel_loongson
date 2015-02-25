Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 04:57:27 +0100 (CET)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:40960 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007204AbbBYD4R3OjBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 04:56:17 +0100
Received: by mail-qg0-f73.google.com with SMTP id z60so218177qgd.0
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 19:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KXBm4VNWSjAuOnVNkXSoVeFmWkUX2kiMpw4OkAUSjQo=;
        b=Fm+mbdAw4CX4d/TrTS3djW+KLJ/My4HZJjn6ggDmZF7IaNJQxvCKCH+aLYJMT/XF4Z
         PT2Ag9yCY8ZsC6Tmht8Tf7h07sZE8eA4vHm3cdoU/FVjZ3J3zaXs9vQuswaUFHbu7Wdf
         gQCzFXML6JiWLC391Ya1elurjrr/PgL+DRz89CxaNMyIYNw01l/BvMnvSEilY/eiRw+P
         tdZf9m4TF0kKscN8+Ln06aY/ORhMOufHVZisaZt1aztegvb8FN7GvgX37vBFn9ha9/qb
         wPh6inomsTbRXrErKxX1kFRN60pF/t40DZXZImldEELFD1i3tdbehSSH+lzEKgHZlaQI
         QR9Q==
X-Gm-Message-State: ALoCoQkGWzCDGn3dxgn3M8mEkDydEi7luJGRvnyHDdP4/U79YuVOeEliELfYhMYsago1qVOQ2l/v
X-Received: by 10.236.209.33 with SMTP id r21mr1351025yho.6.1424836571814;
        Tue, 24 Feb 2015 19:56:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l42si1139272yhq.1.2015.02.24.19.56.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 19:56:11 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id IVGAzGn6.1; Tue, 24 Feb 2015 19:56:11 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 428D5221075; Tue, 24 Feb 2015 19:56:10 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 1/7] clk: Add binding document for Pistachio clock controllers
Date:   Tue, 24 Feb 2015 19:56:01 -0800
Message-Id: <1424836567-7252-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add a device-tree binding document describing the four clock
controllers present on the IMG Pistachio SoC.

Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/clock/pistachio-clock.txt  | 123 ++++++++++++++
 include/dt-bindings/clock/pistachio-clk.h          | 183 +++++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/pistachio-clock.txt
 create mode 100644 include/dt-bindings/clock/pistachio-clk.h

diff --git a/Documentation/devicetree/bindings/clock/pistachio-clock.txt b/Documentation/devicetree/bindings/clock/pistachio-clock.txt
new file mode 100644
index 0000000..868db49
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/pistachio-clock.txt
@@ -0,0 +1,123 @@
+Imagination Technologies Pistachio SoC clock controllers
+========================================================
+
+Pistachio has four clock controllers (core clock, peripheral clock, peripheral
+general control, and top general control) which are instantiated individually
+from the device-tree.
+
+External clocks:
+----------------
+
+There are three external inputs to the clock controllers which should be
+defined with the following clock-output-names:
+- "xtal": External 52Mhz oscillator (required)
+- "audio_clk_in": Alternate audio reference clock (optional)
+- "enet_clk_in": Alternate ethernet PHY clock (optional)
+
+Core clock controller:
+----------------------
+
+The core clock controller generates clocks for the CPU, RPU (WiFi + BT
+co-processor), audio, and several peripherals.
+
+Required properties:
+- compatible: Must be "img,pistachio-clk".
+- reg: Must contain the base address and length of the core clock controller.
+- #clock-cells: Must be 1.  The single cell is the clock identifier.
+  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
+- clocks: Must contain an entry for each clock in clock-names.
+- clock-names: Must include "xtal" (see "External clocks") and
+  "audio_clk_in_gate", "enet_clk_in_gate" which are generated by the
+  top-level general control.
+
+Example:
+	clk_core: clock-controller@18144000 {
+		compatible = "img,pistachio-clk";
+		reg = <0x18144000 0x800>;
+		clocks = <&xtal>, <&cr_top EXT_CLK_AUDIO_IN>,
+			 <&cr_top EXT_CLK_ENET_IN>;
+		clock-names = "xtal", "audio_clk_in_gate", "enet_clk_in_gate";
+
+		#clock-cells = <1>;
+	};
+
+Peripheral clock controller:
+----------------------------
+
+The peripheral clock controller generates clocks for the DDR, ROM, and other
+peripherals.  The peripheral system clock ("periph_sys") generated by the core
+clock controller is the input clock to the peripheral clock controller.
+
+Required properties:
+- compatible: Must be "img,pistachio-periph-clk".
+- reg: Must contain the base address and length of the peripheral clock
+  controller.
+- #clock-cells: Must be 1.  The single cell is the clock identifier.
+  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
+- clocks: Must contain an entry for each clock in clock-names.
+- clock-names: Must include "periph_sys", the peripheral system clock generated
+  by the core clock controller.
+
+Example:
+	clk_periph: clock-controller@18144800 {
+		compatible = "img,pistachio-clk-periph";
+		reg = <0x18144800 0x800>;
+		clocks = <&clk_core CLK_PERIPH_SYS>;
+		clock-names = "periph_sys";
+
+		#clock-cells = <1>;
+	};
+
+Peripheral general control:
+---------------------------
+
+The peripheral general control block generates system interface clocks and
+resets for various peripherals.  It also contains miscellaneous peripheral
+control registers.  The system clock ("sys") generated by the peripheral clock
+controller is the input clock to the system clock controller.
+
+Required properties:
+- compatible: Must include "img,pistachio-periph-cr" and "syscon".
+- reg: Must contain the base address and length of the peripheral general
+  control registers.
+- #clock-cells: Must be 1.  The single cell is the clock identifier.
+  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
+- clocks: Must contain an entry for each clock in clock-names.
+- clock-names: Must include "sys", the system clock generated by the peripheral
+  clock controller.
+
+Example:
+	cr_periph: syscon@18144800 {
+		compatible = "img,pistachio-cr-periph", "syscon";
+		reg = <0x18148000 0x1000>;
+		clocks = <&clock_periph PERIPH_CLK_PERIPH_SYS>;
+		clock-names = "sys";
+
+		#clock-cells = <1>;
+	};
+
+Top-level general control:
+--------------------------
+
+The top-level general control block contains miscellaneous control registers and
+gates for the external clocks "audio_clk_in" and "enet_clk_in".
+
+Required properties:
+- compatible: Must include "img,pistachio-cr-top" and "syscon".
+- reg: Must contain the base address and length of the top-level
+  control registers.
+- clocks: Must contain an entry for each clock in clock-names.
+- clock-names: Two optional clocks, "audio_clk_in" and "enet_clk_in" (see
+  "External clocks").
+- #clock-cells: Must be 1.  The single cell is the clock identifier.
+  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
+
+Example:
+	cr_top: syscon@18144800 {
+		compatible = "img,pistachio-cr-top", "syscon";
+		reg = <0x18149000 0x200>;
+		clocks = <&audio_refclk>, <&ext_enet_in>;
+		clock-names = "audio_clk_in", "enet_clk_in";
+
+		#clock-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/pistachio-clk.h b/include/dt-bindings/clock/pistachio-clk.h
new file mode 100644
index 0000000..039f83f
--- /dev/null
+++ b/include/dt-bindings/clock/pistachio-clk.h
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_PISTACHIO_H
+#define _DT_BINDINGS_CLOCK_PISTACHIO_H
+
+/* PLLs */
+#define CLK_MIPS_PLL			0
+#define CLK_AUDIO_PLL			1
+#define CLK_RPU_V_PLL			2
+#define CLK_RPU_L_PLL			3
+#define CLK_SYS_PLL			4
+#define CLK_WIFI_PLL			5
+#define CLK_BT_PLL			6
+
+/* Fixed-factor clocks */
+#define CLK_WIFI_DIV4			16
+#define CLK_WIFI_DIV8			17
+
+/* Gate clocks */
+#define CLK_MIPS			32
+#define CLK_AUDIO_IN			33
+#define CLK_AUDIO			34
+#define CLK_I2S				35
+#define CLK_SPDIF			36
+#define CLK_AUDIO_DAC			37
+#define CLK_RPU_V			38
+#define CLK_RPU_L			39
+#define CLK_RPU_SLEEP			40
+#define CLK_WIFI_PLL_GATE		41
+#define CLK_RPU_CORE			42
+#define CLK_WIFI_ADC			43
+#define CLK_WIFI_DAC			44
+#define CLK_USB_PHY			45
+#define CLK_ENET_IN			46
+#define CLK_ENET			47
+#define CLK_UART0			48
+#define CLK_UART1			49
+#define CLK_PERIPH_SYS			50
+#define CLK_SPI0			51
+#define CLK_SPI1			52
+#define CLK_EVENT_TIMER			53
+#define CLK_AUX_ADC_INTERNAL		54
+#define CLK_AUX_ADC			55
+#define CLK_SD_HOST			56
+#define CLK_BT				57
+#define CLK_BT_DIV4			58
+#define CLK_BT_DIV8			59
+#define CLK_BT_1MHZ			60
+
+/* Divider clocks */
+#define CLK_MIPS_INTERNAL_DIV		64
+#define CLK_MIPS_DIV			65
+#define CLK_AUDIO_DIV			66
+#define CLK_I2S_DIV			67
+#define CLK_SPDIF_DIV			68
+#define CLK_AUDIO_DAC_DIV		69
+#define CLK_RPU_V_DIV			70
+#define CLK_RPU_L_DIV			71
+#define CLK_RPU_SLEEP_DIV		72
+#define CLK_RPU_CORE_DIV		73
+#define CLK_USB_PHY_DIV			74
+#define CLK_ENET_DIV			75
+#define CLK_UART0_INTERNAL_DIV		76
+#define CLK_UART0_DIV			77
+#define CLK_UART1_INTERNAL_DIV		78
+#define CLK_UART1_DIV			79
+#define CLK_SYS_INTERNAL_DIV		80
+#define CLK_SPI0_INTERNAL_DIV		81
+#define CLK_SPI0_DIV			82
+#define CLK_SPI1_INTERNAL_DIV		83
+#define CLK_SPI1_DIV			84
+#define CLK_EVENT_TIMER_INTERNAL_DIV	85
+#define CLK_EVENT_TIMER_DIV		86
+#define CLK_AUX_ADC_INTERNAL_DIV	87
+#define CLK_AUX_ADC_DIV			88
+#define CLK_SD_HOST_DIV			89
+#define CLK_BT_DIV			90
+#define CLK_BT_DIV4_DIV			91
+#define CLK_BT_DIV8_DIV			92
+#define CLK_BT_1MHZ_INTERNAL_DIV	93
+#define CLK_BT_1MHZ_DIV			94
+
+/* Mux clocks */
+#define CLK_AUDIO_REF_MUX		96
+#define CLK_MIPS_PLL_MUX		97
+#define CLK_AUDIO_PLL_MUX		98
+#define CLK_AUDIO_MUX			99
+#define CLK_RPU_V_PLL_MUX		100
+#define CLK_RPU_L_PLL_MUX		101
+#define CLK_RPU_L_MUX			102
+#define CLK_WIFI_PLL_MUX		103
+#define CLK_WIFI_DIV4_MUX		104
+#define CLK_WIFI_DIV8_MUX		105
+#define CLK_RPU_CORE_MUX		106
+#define CLK_SYS_PLL_MUX			107
+#define CLK_ENET_MUX			108
+#define CLK_EVENT_TIMER_MUX		109
+#define CLK_SD_HOST_MUX			110
+#define CLK_BT_PLL_MUX			111
+#define CLK_DEBUG_MUX			112
+
+#define CLK_NR_CLKS			113
+
+/* Peripheral gate clocks */
+#define PERIPH_CLK_SYS			0
+#define PERIPH_CLK_SYS_BUS		1
+#define PERIPH_CLK_DDR			2
+#define PERIPH_CLK_ROM			3
+#define PERIPH_CLK_COUNTER_FAST		4
+#define PERIPH_CLK_COUNTER_SLOW		5
+#define PERIPH_CLK_IR			6
+#define PERIPH_CLK_WD			7
+#define PERIPH_CLK_PDM			8
+#define PERIPH_CLK_PWM			9
+#define PERIPH_CLK_I2C0			10
+#define PERIPH_CLK_I2C1			11
+#define PERIPH_CLK_I2C2			12
+#define PERIPH_CLK_I2C3			13
+
+/* Peripheral divider clocks */
+#define PERIPH_CLK_ROM_DIV		32
+#define PERIPH_CLK_COUNTER_FAST_DIV	33
+#define PERIPH_CLK_COUNTER_SLOW_PRE_DIV	34
+#define PERIPH_CLK_COUNTER_SLOW_DIV	35
+#define PERIPH_CLK_IR_PRE_DIV		36
+#define PERIPH_CLK_IR_DIV		37
+#define PERIPH_CLK_WD_PRE_DIV		38
+#define PERIPH_CLK_WD_DIV		39
+#define PERIPH_CLK_PDM_PRE_DIV		40
+#define PERIPH_CLK_PDM_DIV		41
+#define PERIPH_CLK_PWM_PRE_DIV		42
+#define PERIPH_CLK_PWM_DIV		43
+#define PERIPH_CLK_I2C0_PRE_DIV		44
+#define PERIPH_CLK_I2C0_DIV		45
+#define PERIPH_CLK_I2C1_PRE_DIV		46
+#define PERIPH_CLK_I2C1_DIV		47
+#define PERIPH_CLK_I2C2_PRE_DIV		48
+#define PERIPH_CLK_I2C2_DIV		49
+#define PERIPH_CLK_I2C3_PRE_DIV		50
+#define PERIPH_CLK_I2C3_DIV		51
+
+#define PERIPH_CLK_NR_CLKS		52
+
+/* System gate clocks */
+#define SYS_CLK_I2C0			0
+#define SYS_CLK_I2C1			1
+#define SYS_CLK_I2C2			2
+#define SYS_CLK_I2C3			3
+#define SYS_CLK_I2S_IN			4
+#define SYS_CLK_PAUD_OUT		5
+#define SYS_CLK_SPDIF_OUT		6
+#define SYS_CLK_SPI0_MASTER		7
+#define SYS_CLK_SPI0_SLAVE		8
+#define SYS_CLK_PWM			9
+#define SYS_CLK_UART0			10
+#define SYS_CLK_UART1			11
+#define SYS_CLK_SPI1			12
+#define SYS_CLK_MDC			13
+#define SYS_CLK_SD_HOST			14
+#define SYS_CLK_ENET			15
+#define SYS_CLK_IR			16
+#define SYS_CLK_WD			17
+#define SYS_CLK_TIMER			18
+#define SYS_CLK_I2S_OUT			24
+#define SYS_CLK_SPDIF_IN		25
+#define SYS_CLK_EVENT_TIMER		26
+#define SYS_CLK_HASH			27
+
+#define SYS_CLK_NR_CLKS			28
+
+/* Gates for external input clocks */
+#define EXT_CLK_AUDIO_IN		0
+#define EXT_CLK_ENET_IN			1
+
+#define EXT_CLK_NR_CLKS			2
+
+#endif /* _DT_BINDINGS_CLOCK_PISTACHIO_H */
-- 
2.2.0.rc0.207.ga3a616c
