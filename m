Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 14:06:40 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43274 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992925AbeG0MFwjT5Fs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 14:05:52 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 683DD20908; Fri, 27 Jul 2018 14:05:46 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id 36B60206EE;
        Fri, 27 Jul 2018 14:05:46 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 4/4] mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
Date:   Fri, 27 Jul 2018 14:05:35 +0200
Message-Id: <20180727120535.16504-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Ocelot PCB123 has a SPI NOR connected on its SPI bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 4ccd65379059..2266027759f9 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -26,6 +26,16 @@
 	status = "okay";
 };
 
+&spi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "macronix,mx25l25635f", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.18.0
