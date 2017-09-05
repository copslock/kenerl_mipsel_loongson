Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 18:39:55 +0200 (CEST)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:25471 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994929AbdIEQjOJ7622 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2017 18:39:14 +0200
Received: from macbookpro.malat.net (unknown [78.225.226.121])
        by smtp3-g21.free.fr (Postfix) with ESMTP id CD1BD13F8BA;
        Tue,  5 Sep 2017 18:39:13 +0200 (CEST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 8A2E010C07EA; Tue,  5 Sep 2017 18:39:13 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: jz4780: DTS: Probe the jz4740-rtc driver from devicetree
Date:   Tue,  5 Sep 2017 18:38:59 +0200
Message-Id: <20170905163901.10542-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170905163901.10542-1-malat@debian.org>
References: <20170905163901.10542-1-malat@debian.org>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu@macbookpro.malat.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

The jz4740-rtc driver supports both jz4740 & jz4780, setup the compatible
string to jz4780.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 02a752eb6a8e..c338c7d1cbca 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -48,6 +48,17 @@
 		};
 	};
 
+	rtc_dev: rtc@10003000 {
+		compatible = "ingenic,jz4780-rtc";
+		reg = <0x10003000 0x4c>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <32>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK>;
+		clock-names = "rtc";
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4780-pinctrl";
 		reg = <0x10010000 0x600>;
-- 
2.11.0
