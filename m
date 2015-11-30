Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 21:53:18 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:56855 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008007AbbK3UxQDZVGw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 21:53:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To; bh=XYGh0iqmvnRY37wTmw0xTFIdBg5NALX4Pf4BBeUMEX8=;
        b=XzvNgxdZ7x+ydivpt+5ngOberwrb7nbUCYBnmqZBlPd46YnGT5TM+eP1LXv3CnIIRYMgwKTGQ9KQQvkl9jYrgXtysY+MHaz5m3mBmmpo3OXqa+s42SM8UQdGqo/lJroUlCdshk41ddlUaRiaZsQeYfS8Bm9oMdR3xbWvrVlWtR8/1e0kYnJx9uQAgRsEXtT0ZcrS8c5s/gsB09WgrHkuRaysnaLPbq6564aig26qrPHXdhvt5IG8fIoHIIvZ+1G4rvj3eox1JqFbFvbX9UoHvKegQpPW0Id046K/WLMd5470izTU0oIzAAdxDgj26LurhNv00VW8xPGa/+y3m8mN/Q==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43478 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3VRR-0001pJ-Nq (Exim); Mon, 30 Nov 2015 20:53:01 +0000
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 1/2] clk: Add brcm,bcm63xx-gate-clk device tree binding
Message-ID: <565CB727.7030209@simon.arlott.org.uk>
Date:   Mon, 30 Nov 2015 20:52:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50215
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

Add device tree binding for the BCM63xx's gated clocks.

The BCM63xx contains clocks gated with a register. Clocks are indexed
by bits in the register and are active high. Clock gate bits are
interleaved with other status bits and configurable clocks in the same
register.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 .../bindings/clock/brcm,bcm63xx-gate-clk.txt       | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
new file mode 100644
index 0000000..3f4ead1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-gate-clk.txt
@@ -0,0 +1,58 @@
+Broadcom BCM63xx clocks
+
+This binding uses the common clock binding:
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The BCM63xx contains clocks gated with a register. Clocks are indexed
+by bits in the register and are active high. Clock gate bits are
+interleaved with other status bits and configurable clocks in the same
+register.
+
+Required properties:
+- compatible:	Should be "brcm,bcm<soc>-gate-clk", "brcm,bcm63xx-gate-clk"
+- #clock-cells:	Should be <1>.
+- regmap:	The register map phandle
+- offset:	Offset in the register map for the reboot register (in bytes)
+- clocks:	The external oscillator clock phandle
+
+Example:
+
+periph_clk: periph_clk {
+	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm63xx-gate-clk";
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
+	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm63xx-gate-clk";
+	regmap = <&timer_cntl>;
+	offset = <0x4>;
+
+	#clock-cells = <1>;
+	clock-indices = <17>, <18>;
+	clock-output-names = "uto_extin", "usb_ref";
+};
+
+ehci0: usb@10002500 {
+	compatible = "brcm,bcm63168-ehci", "brcm,bcm63xx-ehci", "generic-ehci";
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
