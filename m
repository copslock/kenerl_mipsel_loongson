Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 03:13:27 +0200 (CEST)
Received: from mail-yh0-f73.google.com ([209.85.213.73]:34520 "EHLO
        mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026272AbbD2BNKDVj-S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 03:13:10 +0200
Received: by yhl29 with SMTP id 29so456566yhl.1
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 18:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfAlAApfgKJwsLxKZqbRK+B9xPkrO47sYWkqqcg36tM=;
        b=Oz1fUs62PPwYecKofNT6hhaYXpaIv3gICa1+ondxTLdsJTFiYnl/3frD9JFAo6BaKO
         REa5SUhc4SMVkJBEKPr1ocZDBDzWF3q0PrVMAwCDVgTPHz6bp0wbUzNeMuOROWzDEb1W
         i1IJymau2uYz1G8BtYVJdvBcVWSCKRPFnVVv46/w3aDcIB2+VbKpF/lGRhcRGJZHEheV
         DMACB7/St9S2aFrTxUSM8SBV2HtcFRzesNtZTvN0CvWVl4Mjf2TMxsHt+PYrn6yR2d9M
         MD0ieDhVxjrIJ3l8UPMHbBO7Ppea9LDXwGhtLpUL2VfdVS1Ne42frYQTuVzJa65KcqAD
         tHDA==
X-Gm-Message-State: ALoCoQk+vOtmt3UcwDYLjYm+1hD9buHtbqvTKJDaoSnuCKHSgODnMcPGQ1UKFhnB+be0hdZsX3cQ
X-Received: by 10.140.151.85 with SMTP id 82mr32569664qhx.1.1430269985831;
        Tue, 28 Apr 2015 18:13:05 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id i27si1309107yha.6.2015.04.28.18.13.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 18:13:05 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id y4v41pYD.1; Tue, 28 Apr 2015 18:13:05 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 44BBAA438C; Tue, 28 Apr 2015 18:13:04 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH V4 1/2] pinctrl: Add Pistachio SoC pin control binding document
Date:   Tue, 28 Apr 2015 18:13:01 -0700
Message-Id: <1430269982-24129-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
References: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47147
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

Add a device-tree binding document for the pin controller present
on the IMG Pistachio SoC.

Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
No changes from v2/v3.
Changes from v1:
 - Change compatible string to "img,pistachio-system-pinctrl".
 - Specify GPIO sub-node names rather than forcing the nodes to be in order.
---
 .../bindings/pinctrl/img,pistachio-pinctrl.txt     | 217 +++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
new file mode 100644
index 0000000..08a4a32
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
@@ -0,0 +1,217 @@
+Imagination Technologies Pistachio SoC pin controllers
+======================================================
+
+The pin controllers on Pistachio are a combined GPIO controller, (GPIO)
+interrupt controller, and pinmux + pinconf device. The system ("east") pin
+controller on Pistachio has 99 pins, 90 of which are MFIOs which can be
+configured as GPIOs. The 90 GPIOs are divided into 6 banks of up to 16 GPIOs
+each. The GPIO banks are represented as sub-nodes of the pad controller node.
+
+Please refer to pinctrl-bindings.txt, ../gpio/gpio.txt, and
+../interrupt-controller/interrupts.txt for generic information regarding
+pin controller, GPIO, and interrupt bindings.
+
+Required properties for pin controller node:
+--------------------------------------------
+ - compatible: "img,pistachio-system-pinctrl".
+ - reg: Address range of the pinctrl registers.
+
+Required properties for GPIO bank sub-nodes:
+--------------------------------------------
+ - interrupts: Interrupt line for the GPIO bank.
+ - gpio-controller: Indicates the device is a GPIO controller.
+ - #gpio-cells: Must be two. The first cell is the GPIO pin number and the
+   second cell indicates the polarity. See <dt-bindings/gpio/gpio.h> for
+   a list of possible values.
+ - interrupt-controller: Indicates the device is an interrupt controller.
+ - #interrupt-cells: Must be two. The first cell is the GPIO pin number and
+   the second cell encodes the interrupt flags. See
+   <dt-bindings/interrupt-controller/irq.h> for a list of valid flags.
+
+Note that the N GPIO bank sub-nodes *must* be named gpio0, gpio1, ... gpioN-1.
+
+Required properties for pin configuration sub-nodes:
+----------------------------------------------------
+ - pins: List of pins to which the configuration applies. See below for a
+   list of possible pins.
+
+Optional properties for pin configuration sub-nodes:
+----------------------------------------------------
+ - function: Mux function for the specified pins. This is not applicable for
+   non-MFIO pins. See below for a list of valid functions for each pin.
+ - bias-high-impedance: Enable high-impedance mode.
+ - bias-pull-up: Enable weak pull-up.
+ - bias-pull-down: Enable weak pull-down.
+ - bias-bus-hold: Enable bus-keeper mode.
+ - drive-strength: Drive strength in mA. Supported values: 2, 4, 8, 12.
+ - input-schmitt-enable: Enable Schmitt trigger.
+ - input-schmitt-disable: Disable Schmitt trigger.
+ - slew-rate: Slew rate control. 0 for slow, 1 for fast.
+
+Pin		Functions
+---		---------
+mfio0		spim1
+mfio1		spim1, spim0, uart1
+mfio2		spim1, spim0, uart1
+mfio3		spim1
+mfio4		spim1
+mfio5		spim1
+mfio6		spim1
+mfio7		spim1
+mfio8		spim0
+mfio9		spim0
+mfio10		spim0
+mfio11		spis
+mfio12		spis
+mfio13		spis
+mfio14		spis
+mfio15		sdhost, mips_trace_clk, mips_trace_data
+mfio16		sdhost, mips_trace_dint, mips_trace_data
+mfio17		sdhost, mips_trace_trigout, mips_trace_data
+mfio18		sdhost, mips_trace_trigin, mips_trace_data
+mfio19		sdhost, mips_trace_dm, mips_trace_data
+mfio20		sdhost, mips_trace_probe_n, mips_trace_data
+mfio21		sdhost, mips_trace_data
+mfio22		sdhost, mips_trace_data
+mfio23		sdhost
+mfio24		sdhost
+mfio25		sdhost
+mfio26		sdhost
+mfio27		sdhost
+mfio28		i2c0, spim0
+mfio29		i2c0, spim0
+mfio30		i2c1, spim0
+mfio31		i2c1, spim1
+mfio32		i2c2
+mfio33		i2c2
+mfio34		i2c3
+mfio35		i2c3
+mfio36		i2s_out, audio_clk_in
+mfio37		i2s_out, debug_raw_cca_ind
+mfio38		i2s_out, debug_ed_sec20_cca_ind
+mfio39		i2s_out, debug_ed_sec40_cca_ind
+mfio40		i2s_out, debug_agc_done_0
+mfio41		i2s_out, debug_agc_done_1
+mfio42		i2s_out, debug_ed_cca_ind
+mfio43		i2s_out, debug_s2l_done
+mfio44		i2s_out
+mfio45		i2s_dac_clk, audio_sync
+mfio46		audio_trigger
+mfio47		i2s_in
+mfio48		i2s_in
+mfio49		i2s_in
+mfio50		i2s_in
+mfio51		i2s_in
+mfio52		i2s_in
+mfio53		i2s_in
+mfio54		i2s_in, spdif_in
+mfio55		uart0, spim0, spim1
+mfio56		uart0, spim0, spim1
+mfio57		uart0, spim0, spim1
+mfio58		uart0, spim1
+mfio59		uart1
+mfio60		uart1
+mfio61		spdif_out
+mfio62		spdif_in
+mfio63		eth, mips_trace_clk, mips_trace_data
+mfio64		eth, mips_trace_dint, mips_trace_data
+mfio65		eth, mips_trace_trigout, mips_trace_data
+mfio66		eth, mips_trace_trigin, mips_trace_data
+mfio67		eth, mips_trace_dm, mips_trace_data
+mfio68		eth, mips_trace_probe_n, mips_trace_data
+mfio69		eth, mips_trace_data
+mfio70		eth, mips_trace_data
+mfio71		eth
+mfio72		ir
+mfio73		pwmpdm, mips_trace_clk, sram_debug
+mfio74		pwmpdm, mips_trace_dint, sram_debug
+mfio75		pwmpdm, mips_trace_trigout, rom_debug
+mfio76		pwmpdm, mips_trace_trigin, rom_debug
+mfio77		mdc_debug, mips_trace_dm, rpu_debug
+mfio78		mdc_debug, mips_trace_probe_n, rpu_debug
+mfio79		ddr_debug, mips_trace_data, mips_debug
+mfio80		ddr_debug, mips_trace_data, mips_debug
+mfio81		dreq0, mips_trace_data, eth_debug
+mfio82		dreq1, mips_trace_data, eth_debug
+mfio83		mips_pll_lock, mips_trace_data, usb_debug
+mfio84		sys_pll_lock, mips_trace_data, usb_debug
+mfio85		wifi_pll_lock, mips_trace_data, sdhost_debug
+mfio86		bt_pll_lock, mips_trace_data, sdhost_debug
+mfio87		rpu_v_pll_lock, dreq2, socif_debug
+mfio88		rpu_l_pll_lock, dreq3, socif_debug
+mfio89		audio_pll_lock, dreq4, dreq5
+tck
+trstn
+tdi
+tms
+tdo
+jtag_comply
+safe_mode
+por_disable
+resetn
+
+Example:
+--------
+pinctrl@18101C00 {
+	compatible = "img,pistachio-system-pinctrl";
+	reg = <0x18101C00 0x400>;
+
+	gpio0: gpio0 {
+		interrupts = <GIC_SHARED 71 IRQ_TYPE_LEVEL_HIGH>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	...
+
+	gpio5: gpio5 {
+		interrupts = <GIC_SHARED 76 IRQ_TYPE_LEVEL_HIGH>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	...
+
+	uart0_xfer: uart0-xfer {
+		uart0-rxd {
+			pins = "mfio55";
+			function = "uart0";
+		};
+		uart0-txd {
+			pins = "mfio56";
+			function = "uart0";
+		};
+	};
+
+	uart0_rts_cts: uart0-rts-cts {
+		uart0-rts {
+			  pins = "mfio57";
+			  function = "uart0";
+		};
+		uart0-cts {
+			  pins = "mfio58";
+			  function = "uart0";
+		};
+	};
+};
+
+uart@... {
+	...
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_rts_cts>;
+	...
+};
+
+usb_vbus: fixed-regulator {
+	...
+	gpio = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	...
+};
-- 
2.2.0.rc0.207.ga3a616c
