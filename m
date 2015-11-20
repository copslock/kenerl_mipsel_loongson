Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 05:53:46 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:49721 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010968AbbKTExZr-1Vp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Nov 2015 05:53:25 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1ZzdhC-00042S-IG; Fri, 20 Nov 2015 05:53:14 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1ZzdhA-0004Sy-Mg; Fri, 20 Nov 2015 05:53:12 +0100
Received: from mschille.tdtnet.local (10.1.3.20) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Fri, 20 Nov 2015
 05:53:11 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <ralf@linux-mips.org>, <blogic@openwrt.org>, <hauke@hauke-m.de>,
        <jogo@openwrt.org>, Martin Schiller <mschiller@tdt.de>
Subject: [PATCH 1/4] pinctrl/lantiq: update devicetree bindings Documentation
Date:   Fri, 20 Nov 2015 05:52:28 +0100
Message-ID: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.1.3.20]
X-EsetResult: clean, is OK
X-EsetId: 37303A29F17133606D7564
X-C2ProcessedOrg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Transfer-Encoding: 8BIT
X-purgate-relay-fid: relay-230693
X-purgate-sourceid: 1ZzdhA-0004Sy-Mg
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1447995193-00000715-E115B553/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-5443cb
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiller@tdt.de
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

This patch adds the new dedicated "lantiq,pinctrl-<chip>" compatible strings
to the devicetree bindings Documentation, where <chip> is one of "ase",
"danube", "xrx100", "xrx200" or "xrx300" and marks the "lantiq,pinctrl-xway"
and "lantiq,pinctrl-xr9" compatible strings as DEPRECATED.

Signed-off-by: Martin Schiller <mschiller@tdt.de>
---
 .../bindings/pinctrl/lantiq,pinctrl-xway.txt       | 108 +++++++++++++++++++--
 1 file changed, 100 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
index e89b467..16daa12 100644
--- a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
+++ b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
@@ -1,7 +1,14 @@
 Lantiq XWAY pinmux controller
 
 Required properties:
-- compatible: "lantiq,pinctrl-xway" or "lantiq,pinctrl-xr9"
+- compatible: "lantiq,pinctrl-xway", (DEPRECATED: Use XWAY DANUBE Family)
+	      "lantiq,pinctrl-xr9", (DEPRECATED: Use XWAY xRX100/xRX200 Family)
+	      "lantiq,pinctrl-<chip>", where <chip> is:
+		"ase" (XWAY AMAZON Family)
+		"danube" (XWAY DANUBE Family)
+		"xrx100" (XWAY xRX100 Family)
+		"xrx200" (XWAY xRX200 Family)
+		"xrx300" (XWAY xRX300 Family)
 - reg: Should contain the physical address and length of the gpio/pinmux
   register range
 
@@ -36,19 +43,87 @@ Required subnode-properties:
 
 Valid values for group and function names:
 
+XWAY: (DEPRECATED: Use DANUBE)
   mux groups:
     exin0, exin1, exin2, jtag, ebu a23, ebu a24, ebu a25, ebu clk, ebu cs1,
     ebu wait, nand ale, nand cs1, nand cle, spi, spi_cs1, spi_cs2, spi_cs3,
-    spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi , gpt1, gpt2,
+    spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi, gpt1, gpt2,
     gpt3, clkout0, clkout1, clkout2, clkout3, gnt1, gnt2, gnt3, req1, req2,
     req3
 
-  additional mux groups (XR9 only):
-    mdio, nand rdy, nand rd, exin3, exin4, gnt4, req4
+  functions:
+    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu
+
+XR9: ( DEPRECATED: Use xRX100/xRX200)
+  mux groups:
+    exin0, exin1, exin2, exin3, exin4, jtag, ebu a23, ebu a24, ebu a25,
+    ebu clk, ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy,
+    nand rd, spi, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5, spi_cs6,
+    asc0, asc0 cts rts, stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1,
+    clkout2, clkout3, gnt1, gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio,
+    gphy0 led0, gphy0 led1, gphy0 led2, gphy1 led0, gphy1 led1, gphy1 led2
+
+  functions:
+    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, mdio, gphy
+
+AMAZON:
+  mux groups:
+    exin0, exin1, exin2, jtag, spi_di, spi_do, spi_clk, spi_cs1, spi_cs2,
+    spi_cs3, spi_cs4, spi_cs5, spi_cs6, asc, stp, gpt1, gpt2, gpt3, clkout0,
+    clkout1, clkout2, mdio, dfe led0, dfe led1, ephy led0, ephy led1, ephy led2
+
+  functions:
+    spi, asc, cgu, jtag, exin, stp, gpt, mdio, ephy, dfe
+
+DANUBE:
+  mux groups:
+    exin0, exin1, exin2, jtag, ebu a23, ebu a24, ebu a25, ebu clk, ebu cs1,
+    ebu wait, nand ale, nand cs1, nand cle, spi_di, spi_do, spi_clk, spi_cs1,
+    spi_cs2, spi_cs3, spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi,
+    gpt1, gpt2, gpt3, clkout0, clkout1, clkout2, clkout3, gnt1, gnt2, gnt3,
+    req1, req2, req3, dfe led0, dfe led1
 
   functions:
-    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, mdio
+    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, dfe
 
+xRX100:
+  mux groups:
+    exin0, exin1, exin2, exin3, exin4, ebu a23, ebu a24, ebu a25, ebu clk,
+    ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy, nand rd,
+    spi_di, spi_do, spi_clk, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5,
+    spi_cs6, asc0, asc0 cts rts, stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1,
+    clkout2, clkout3, gnt1, gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio,
+    dfe led0, dfe led1
+
+  functions:
+    spi, asc, cgu, exin, stp, gpt, nmi, pci, ebu, mdio, dfe
+
+xRX200:
+  mux groups:
+    exin0, exin1, exin2, exin3, exin4, ebu a23, ebu a24, ebu a25, ebu clk,
+    ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy, nand rd,
+    spi_di, spi_do, spi_clk, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5,
+    spi_cs6, usif uart_rx, usif uart_tx, usif uart_rts, usif uart_cts,
+    usif uart_dtr, usif uart_dsr, usif uart_dcd, usif uart_ri, usif spi_di,
+    usif spi_do, usif spi_clk, usif spi_cs0, usif spi_cs1, usif spi_cs2,
+    stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1, clkout2, clkout3, gnt1,
+    gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio, dfe led0, dfe led1,
+    gphy0 led0, gphy0 led1, gphy0 led2, gphy1 led0, gphy1 led1, gphy1 led2
+
+  functions:
+    spi, usif, cgu, exin, stp, gpt, nmi, pci, ebu, mdio, dfe, gphy
+
+xRX300:
+  mux groups:
+    exin0, exin1, exin2, exin4, nand ale, nand cs0, nand cs1, nand cle,
+    nand rdy, nand rd, nand_d0, nand_d1, nand_d2, nand_d3, nand_d4, nand_d5,
+    nand_d6, nand_d7, nand_d1, nand wr, nand wp, nand se, spi_di, spi_do,
+    spi_clk, spi_cs1, spi_cs4, spi_cs6, usif uart_rx, usif uart_tx,
+    usif spi_di, usif spi_do, usif spi_clk, usif spi_cs0, stp, clkout2,
+    mdio, dfe led0, dfe led1, ephy0 led0, ephy0 led1, ephy1 led0, ephy1 led1
+
+  functions:
+    spi, usif, cgu, exin, stp, ebu, mdio, dfe, ephy
 
 
 Definition of pin configurations:
@@ -62,15 +137,32 @@ Optional subnode-properties:
     0: none, 1: down, 2: up.
 - lantiq,open-drain: Boolean, enables open-drain on the defined pin.
 
-Valid values for XWAY pin names:
+Valid values for XWAY pin names: (DEPRECATED: Use DANUBE)
   Pinconf pins can be referenced via the names io0-io31.
 
-Valid values for XR9 pin names:
+Valid values for XR9 pin names: (DEPRECATED: Use xrX100/xRX200)
   Pinconf pins can be referenced via the names io0-io55.
 
+Valid values for AMAZON pin names:
+  Pinconf pins can be referenced via the names io0-io31.
+
+Valid values for DANUBE pin names:
+  Pinconf pins can be referenced via the names io0-io31.
+
+Valid values for xRX100 pin names:
+  Pinconf pins can be referenced via the names io0-io55.
+
+Valid values for xRX200 pin names:
+  Pinconf pins can be referenced via the names io0-io49.
+
+Valid values for xRX300 pin names:
+  Pinconf pins can be referenced via the names io0-io1,io3-io6,io8-io11,
+						io13-io19,io23-io27,io34-io36,
+						io42-io43,io48-io61.
+
 Example:
 	gpio: pinmux@E100B10 {
-		compatible = "lantiq,pinctrl-xway";
+		compatible = "lantiq,pinctrl-danube";
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
-- 
2.1.4
