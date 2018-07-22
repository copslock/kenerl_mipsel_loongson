Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:22:22 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993928AbeGVVU3g1rdS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F08FAFCB;
        Sun, 22 Jul 2018 21:20:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 06/15] MIPS: dts: img: pistachio_marduk: Add 6Lowpan node
Date:   Sun, 22 Jul 2018 23:20:01 +0200
Message-Id: <20180722212010.3979-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

The CA8210's clock output is needed for the SPI-UART bridge.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index d723b68084c9..b0b6b534a41f 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -158,6 +158,20 @@
 		   <&gpio1 12 GPIO_ACTIVE_HIGH>,
 		   <&gpio1 13 GPIO_ACTIVE_HIGH>,
 		   <&gpio1 14 GPIO_ACTIVE_HIGH>;
+
+	ca8210: sixlowpan@4 {
+		compatible = "cascoda,ca8210";
+		reg = <4>;
+		spi-max-frequency = <3000000>;
+		spi-cpol;
+		reset-gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		irq-gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+
+		extclock-enable;
+		extclock-freq = <16000000>;
+		extclock-gpio = <2>; /* spiuart_clk */
+		#clock-cells = <0>;
+	};
 };
 
 &spfi1 {
-- 
2.16.4
