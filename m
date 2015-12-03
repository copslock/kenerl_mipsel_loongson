Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 20:24:27 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:45151 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007545AbbLCTYXeK8FS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2015 20:24:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:To:From; bh=nC6HQTQp2C9BOSZQt2hJeM80K5Pg+5xy/lsB9NeVK2o=;
        b=IyXAbcvNN51utCxl4lnqOb/yoO6kO0dbp1OrT9AWl891csRBP/FJCAB1Obe7HrFB1ujElO4Tp9FdxTgjtLrG2S5MauCq3FbckK+889tlYX4XvYQDT+Eafza07cZdtGJ9jtwWJ/Cxp+8R82B45pFaWAS8YJ7EYvWvNZoBieZuFvJNFUbuntCDyBzHuXF4QiduTZfzKyz37WL3pdIXweRbGQJk8w5+KLa3lC3iA5pCSOIEh1JcikPxFCnAFTt4f9N9gQ47g7qObM1VTEXgNvm4OZZ2DzWt956oTdkg3ATyrBBW/Dx9QtyvIu8o5xrtALoOaaU93AEz3redSwBofM9VEw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:51866 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a4ZU9-0005kT-1U (Exim); Thu, 03 Dec 2015 19:24:10 +0000
From:   Simon Arlott <simon@fire.lp0.eu>
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
Subject: [PATCH linux-next 1/2] clk: Add brcm,bcm6345-gate-clk device tree
 binding
Message-ID: <566096D4.3050102@simon.arlott.org.uk>
Date:   Thu, 3 Dec 2015 19:24:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50323
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
by bits in the register and are active high. Clock gate bits are
interleaved with other status bits and configurable clocks in the same
register.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Renamed to BCM6345.

 .../bindings/clock/brcm,bcm6345-gate-clk.txt       | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
new file mode 100644
index 0000000..5801264
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm6345-gate-clk.txt
@@ -0,0 +1,58 @@
+Broadcom BCM6345 clocks
+
+This binding uses the common clock binding:
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The BCM6345 contains clocks gated with a register. Clocks are indexed
+by bits in the register and are active high. Clock gate bits are
+interleaved with other status bits and configurable clocks in the same
+register.
+
+Required properties:
+- compatible:	Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm6345-gate-clk"
+- #clock-cells:	Should be <1>.
+- regmap:	The register map phandle
+- offset:	Offset in the register map for the clock register (in bytes)
+- clocks:	The external oscillator clock phandle
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
