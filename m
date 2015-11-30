Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 21:57:39 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:57012 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008007AbbK3U5iSppPw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 21:57:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=WuX0u+Vu7LDVv8QUYQ37Ipreh0YaKB3eM4qqLwA3CWQ=;
        b=TbmYlGvyz79AKrG/sEiOQ+IbV8i1rtdOdLOpMd4YjttOByiCqNNenPztE80U6MSV28bcE6zYCQmgUY1qM42NLAQbGvKW7x53kptXrB11ezPrwI2SyV/37gz6JlgHsfVbjtla3In1+zWyAQrW9znq791+WmtDJ94j9vOK0C/wCvUUhxVSw6SRPIfynr7h6i3iuBoslMoVoFiRKzKtP1MVqv5xu6XKuqLK8/LtZzyMf01ULgezQLRiNE1aAt6ggHf3J3fmha7scrjrAkIv0US5yL25TqWRl6r0lS9VDqsrfE2txWdeDfEt6DTzmpQ6iuTFWAcMOT7KgEz58pdrOkhNIQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43544 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3VVu-00021m-KH (Exim); Mon, 30 Nov 2015 20:57:35 +0000
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH 1/2] reset: Add brcm,bcm63xx-reset device tree binding
Message-ID: <565CB83B.7010000@simon.arlott.org.uk>
Date:   Mon, 30 Nov 2015 20:57:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50217
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

Add device tree binding for the BCM63xx soft reset controller.

The BCM63xx contains a soft-reset controller activated by setting
a bit (that must previously have cleared).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 .../bindings/reset/brcm,bcm63xx-reset.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
new file mode 100644
index 0000000..48e9daf
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
@@ -0,0 +1,37 @@
+BCM63xx reset controller
+
+The BCM63xx contains a basic soft reset controller in the perf register
+set which resets components using a bit in a register.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm63xx-reset"
+- regmap:	The register map phandle
+- offset:	Offset in the register map for the reset register (in bytes)
+- #reset-cells:	Must be set to 1
+
+Optional properties:
+- mask:		Mask of valid reset bits in the reset register (32 bit access)
+		(Defaults to all bits)
+
+Example:
+
+periph_soft_rst: reset-controller {
+	compatible = "brcm,bcm63168-reset", "brcm,bcm63xx-reset";
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
