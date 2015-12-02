Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 22:03:32 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:42293 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008265AbbLBVDa4xngM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2015 22:03:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:To:Subject:From; bh=ochK14C6rCnhWaOC716hjQfMFs6DOFFtXdv894yrer4=;
        b=R/qejRkdFLoE+bNs+a9RfXxTsJ1HUOHEr7BImUxAIzKlfKbWVDR1CavaBAwedtVcy+Ftx0s2b5r8xG+s+J2RVMDZA90az36VEPoO+2yiZiD1myrwPTAi1Uy5UJzqvsIE6vz5QdRtKcbqTK2BW2krCNXaDeNddghjqjja9dx8XqTNMs3T9ap822txjnQESg8zYFz3N3annszlE6V38pF7rIUbVk28qXQrDmg6jRtDbfTcv44KGo7eM2t5xxvoXKv6TBcKNUxXURkM9FA4BQN6mEfs56MEzBayVto+EAddJEzKFXSFDP3apD848mpPrU6hYo4/AXxPSgH/E9lQVuh0DA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:48890 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a4EYZ-0006nl-I8 (Exim); Wed, 02 Dec 2015 21:03:19 +0000
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH (v2) 1/2] reset: Add brcm,bcm6345-reset device tree binding
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <565F5C96.5090700@simon.arlott.org.uk>
Date:   Wed, 2 Dec 2015 21:03:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50299
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

Add device tree binding for the BCM6345 soft reset controller.

The BCM6345 contains a soft-reset controller activated by setting
a bit (that must previously have cleared).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Renamed to bcm6345, removed "mask" property.

 .../bindings/reset/brcm,bcm6345-reset.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
new file mode 100644
index 0000000..bb9ca6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
@@ -0,0 +1,33 @@
+Broadcom BCM6345 reset controller
+
+The BCM6345 contains a basic soft reset controller in the perf register
+set which resets components using a bit in a register.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm6345-reset"
+- regmap:	The register map phandle
+- offset:	Offset in the register map for the reset register (in bytes)
+- #reset-cells:	Must be set to 1
+
+Example:
+
+periph_soft_rst: reset-controller {
+	compatible = "brcm,bcm63168-reset", "brcm,bcm6345-reset";
+	regmap = <&periph_cntl>;
+	offset = <0x10>;
+
+	#reset-cells = <1>;
+};
+
+usbh: usbphy@10002700 {
+	compatible = "brcm,bcm63168-usbh";
+	reg = <0x10002700 0x38>;
+	clocks = <&periph_clk 13>, <&timer_clk 18>;
+	resets = <&periph_soft_rst 6>;
+	power-supply = <&power_usbh>;
+	#phy-cells = <0>;
+};
+
-- 
2.1.4

-- 
Simon Arlott
