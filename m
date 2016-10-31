Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 21:41:55 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:40022 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbcJaUkTIDs90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 21:40:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 5/7] MIPS: jz4740: DTS: Probe the jz4740-rtc driver from devicetree
Date:   Mon, 31 Oct 2016 21:39:49 +0100
Message-Id: <20161031203951.5444-5-paul@crapouillou.net>
In-Reply-To: <20161031203951.5444-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161031203951.5444-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1477946418; bh=u8OFy4ogbdE/gfvwyaS7QzuIfaiJ3O9nXyFRpkrEnds=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZvukspquorRDj2c5JzP3XSxDUUk8iPUsw1OTVFsx6qmq8tUStJOrkEttncsB6pgh4+HaSPhS8G6tJYPjfaTsQ8x/8PgIEExv/BH6r4LrDBnCCufjlzrA51vi27FuPXuwr3mft1PYQ4x3rW1JS06fVTxlA9xC5r05CGA62yTSbiI=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Now that the jz4740-rtc driver supports devicetree, we can add a
devicetree node for it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

v2: Previous patch 5/5 was garbage. This is a new patch.
v3: Changed 'jz4740-rtc@10003000' to 'rtc@10003000'

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index f6ae6ed..c6acd6a 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -44,6 +44,17 @@
 		#clock-cells = <1>;
 	};
 
+	rtc_dev: rtc@10003000 {
+		compatible = "ingenic,jz4740-rtc";
+		reg = <0x10003000 0x40>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <15>;
+
+		clocks = <&cgu JZ4740_CLK_RTC>;
+		clock-names = "rtc";
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
-- 
2.9.3
