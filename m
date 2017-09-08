Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 20:37:09 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:48361 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993962AbdIHSgSpSmgf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Sep 2017 20:36:18 +0200
Received: from macbookpro.malat.net (unknown [78.225.226.121])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 6AD9613F8B3;
        Fri,  8 Sep 2017 20:36:18 +0200 (CEST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 25AB310C087A; Fri,  8 Sep 2017 20:36:18 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 3/3] MIPS: jz4780: DTS: Probe the jz4740-watchdog driver from devicetree
Date:   Fri,  8 Sep 2017 20:35:55 +0200
Message-Id: <20170908183558.1537-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170908183558.1537-1-malat@debian.org>
References: <20170908183558.1537-1-malat@debian.org>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu@macbookpro.malat.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59966
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

The jz4740-watchdog driver supports both jz4740 & jz4780.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 4853ef67b3ab..33d7f49186d6 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -207,6 +207,11 @@
 		status = "disabled";
 	};
 
+	watchdog: jz4780-watchdog@10002000 {
+		compatible = "ingenic,jz4740-watchdog";
+		reg = <0x10002000 0x100>;
+	};
+
 	nemc: nemc@13410000 {
 		compatible = "ingenic,jz4780-nemc";
 		reg = <0x13410000 0x10000>;
-- 
2.11.0
