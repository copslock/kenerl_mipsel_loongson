Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 22:49:39 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:50433 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013651AbbLJVthjK13J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 22:49:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:To:Subject:From; bh=NvCzI2NZSgPe31/q9YF1zoQZ0qCLATfwc4ZeQs72OOQ=;
        b=YgAetqI9ZvuwByHlqT648OA6m6lH0yD5xh25RvyVvUZ1N68wc7+2eyWnodR84xDuBDhjxl0N8LCj1ypeNRQGiY7cqXjQEsyWQXp/9UwCFoYBjoTQRa/y9feMXYwwmaY1pcNCys1uCv4DVfnnTomQ7UM2kswMbYkgqJ5yO9VjhM3a65RsCexc55km99Wx1fQowHNfrD4rY+jszeiBc9DfrFN38zij6hsVNje86ag6K0EOguEkjpet2y/yollhe+zD4yUBtmOk4mdSskeLIgJu9X1RbZ9bgOvxEXzLdlFS2AxDkUwpnUQYCfMeo8iLP8C1DL25ezv0liTKnp56cxBf0A==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60775)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a795X-0000dQ-Oj (Exim); Thu, 10 Dec 2015 21:49:24 +0000
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next (v2) 1/2] clk: Add brcm,bcm6345-gate-clk device
 tree binding
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
Message-ID: <5669F361.60405@simon.arlott.org.uk>
Date:   Thu, 10 Dec 2015 21:49:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add device tree binding for the BCM6345's gated clocks.

The BCM6345 contains clocks gated with a register. Clocks are indexed
by bits in the register and are active high. Most MIPS-based BCM63xx
SoCs have a clock gating set of registers, but some have clock gate bits
interleaved with other status bits and configurable clocks in the same
register.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v2: Added clock-indices, clock-output-names (from clock-bindings.txt),
    these are required properties.

v1: Renamed from BCM63xx to BCM6345.

 .../bindings/clock/brcm,bcm6345-gate-clk.txt       | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
new file mode 100644
index 0000000..a6e264c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
@@ -0,0 +1,62 @@
+Broadcom BCM6345 clocks
+
+This binding uses the common clock binding:
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The BCM6345 contains clocks gated with a register. Clocks are indexed
+by bits in the register and are active high. Most MIPS-based BCM63xx
+SoCs have a clock gating set of registers, but some have clock gate bits
+interleaved with other status bits and configurable clocks in the same
+register.
+
+Required properties:
+- compatible:         Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm6345-gate-clk"
+- #clock-cells:       Should be <1>.
+- regmap:             The register map phandle
+- offset:             Offset in the register map for the clock register (in bytes)
+- clocks:             The external oscillator clock phandle
+- clock-indices:      The bits in the register used for gated clocks.
+- clock-output-names: Should be a list of strings of clock output signal
+                      names indexed by the clock indices.
+
+Example:
+
+periph_clk: periph_clk {
+	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
+	regmap = <&periph_cntl>;
+	offset = <0x4>;
+
+	#clock-cells = <1>;
+	clock-indices =
+		<1>,          <2>,        <3>,       <4>,     <5>,
+		<6>,          <7>,        <8>,       <9>,     <10>,
+		<11>,         <12>,       <13>,      <14>,    <15>,
+		<16>,         <17>,       <18>,      <19>,    <20>,
+		<27>,         <31>;
+	clock-output-names =
+		"vdsl_qproc", "vdsl_afe", "vdsl",    "mips",  "wlan_ocp",
+		"dect",       "fap0",     "fap1",    "sar",   "robosw",
+		"pcm",        "usbd",     "usbh",    "ipsec", "spi",
+		"hsspi",      "pcie",     "phymips", "gmac",  "nand",
+		"tbus",       "robosw250";
+};
+
+timer_clk: timer_clk {
+	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm6345-gate-clk";
+	regmap = <&timer_cntl>;
+	offset = <0x4>;
+
+	#clock-cells = <1>;
+	clock-indices = <17>, <18>;
+	clock-output-names = "uto_extin", "usb_ref";
+};
+
+ehci0: usb@10002500 {
+	compatible = "brcm,bcm63168-ehci", "brcm,bcm6345-ehci", "generic-ehci";
+	reg = <0x10002500 0x100>;
+	big-endian;
+	interrupt-parent = <&periph_intc>;
+	interrupts = <10>;
+	clocks = <&periph_clk 13>, <&timer_clk 18>;
+	phys = <&usbh>;
+};
-- 
2.1.4

-- 
Simon Arlott
