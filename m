Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 14:53:42 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:37782 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990430AbdL3NvgKz4Y0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 14:51:36 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/8] MIPS: jz4780: dts: Fix watchdog node
Date:   Sat, 30 Dec 2017 14:51:06 +0100
Message-Id: <20171230135108.6834-6-paul@crapouillou.net>
In-Reply-To: <20171230135108.6834-1-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514641895; bh=+tCJpqKOub7DjxEvVHq20nQ9FtHHQ8cH2vkKrBWMx9Q=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CZkGFiw7tzDipjXbZPzfWf+7fQEoGW+urQnkRMjGpyRlgNtCDOjXXLk1BifUpCPq9spmXXpBGiPnxOwSmn4LhTkjO70Fx/l6M41/Zu6Gnf4YR/XJBq2Nz8NthHyRHCoj3BxMgUh/9VroyG2QUJhWiyT6hTTP7C0zgQ8IkPWbznM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61783
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

- The previous node requested a memory area of 0x100 bytes, while the
  driver only manipulates four registers present in the first 0x10 bytes.

- The driver requests for the "rtc" clock, but the previous node did not
  provide any.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

 v2: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..a52f59bf58c7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -221,7 +221,10 @@
 
 	watchdog: watchdog@10002000 {
 		compatible = "ingenic,jz4780-watchdog";
-		reg = <0x10002000 0x100>;
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK>;
+		clock-names = "rtc";
 	};
 
 	nemc: nemc@13410000 {
-- 
2.11.0
