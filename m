Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 23:29:47 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:47888 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011794AbbLIW3oxihTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Dec 2015 23:29:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=bxBOUcY0Qv1IB7cfojT1s2dCQP85ExroLgbOyX7J1TM=;
        b=psZm0gqsAYIGwEll4Hui6SJdiIizhzFkYlaVgyK/lboCb6bAmzR8sUMys4h9aaS2J49sKLgr9SSnGuKQknNQt6ocSNWHnb+ciUhOyiFicwEEOGHYTTu+5PuxDlpxha1cO7QP//YzJbCNbkgM/hRuuGrlPQbEq0R92x4UMyosF6YSiOSgbPDq7NljKhRDknqCColOUnx2Wsyk3UC66k6/y70nSI4/l6K0OjyDQl19B8VNnmyRfXjGhRiB3eOrq/0U9wrIBjnpZbYmhD2kxjDXbhPP7D1dmWbR0FeQDmstpFgCWDgUmO1AygsS+TalZ7TK10g684gFBORdXXkdCZbKtw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:56756 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a6nEu-0006r5-I3 (Exim); Wed, 09 Dec 2015 22:29:36 +0000
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Message-ID: <5668AB4F.7030100@simon.arlott.org.uk>
Date:   Wed, 9 Dec 2015 22:29:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50515
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

The BCM6358 contains power domains controlled with a register. Power
domains are indexed by bits in the register. Power domain bits can be
interleaved with other status bits and clocks in the same register.

Newer SoCs with dedicated power domain registers are active low.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt

diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
new file mode 100644
index 0000000..556c323
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
@@ -0,0 +1,53 @@
+Broadcom BCM6358 Power domain controller
+
+This binding uses the power domain bindings:
+        Documentation/devicetree/bindings/power/power_domain.txt
+
+The BCM6358 contains power domains controlled with a register. Power
+domains are indexed by bits in the register. Power domain bits can be
+interleaved with other status bits and clocks in the same register.
+
+Newer SoCs with dedicated power domain registers are active low.
+
+Required properties:
+- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
+- #power-domain-cells:  Should be <1>.
+- regmap:               The register map phandle
+- offset:               Offset in the register map for the power domain register (in bytes)
+- power-domain-indices: The bits in the register used for power domains.
+- power-domain-names:   Should be a list of strings of power domain names
+                        indexed by the power domain indices.
+
+Optional properties:
+- active-low:           Specify that the bits are active low.
+
+Example:
+
+misc_iddq_ctrl: power-controller {
+	compatible = "brcm,bcm63168-power-controller", "brcm,bcm6358-power-controller";
+	regmap = <&misc>;
+	offset = <0x4c>;
+
+	#power-domain-cells = <1>;
+	power-domain-indices =
+	                <0>,         <1>,      <2>,    <3>,         <4>,
+	                <5>,         <6>,      <7>,    <8>,         <9>,
+	                <10>,        <11>,     <12>,   <13>,        <17>,
+	                <18>;
+	power-domain-names =
+	                "sar",       "ipsec",  "mips", "dect",      "usbh",
+	                "usbd",      "robosw", "pcm",  "periph",    "vdsl_phy",
+	                "vdsl_mips", "fap",    "pcie", "wlan_pads", "gphy",
+	                "gmac";
+	active-low;
+};
+
+periph_iddq: power-controller {
+	compatible = "brcm,bcm6368-power-controller", "brcm,bcm6358-power-controller";
+	regmap = <&periph_cntl>;
+	offset = <0x4>;
+
+	#power-domain-cells = <1>;
+	power-domain-indices = <19>;
+	power-domain-names = "usbh";
+};
-- 
2.1.4

-- 
Simon Arlott
