Return-Path: <SRS0=LSmN=SY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91899C282E3
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 06:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1492075A
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 06:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDVGlA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:41:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDVGk7 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 22 Apr 2019 02:40:59 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hISdH-0005vw-2o; Mon, 22 Apr 2019 08:40:51 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hISdD-0000ks-PC; Mon, 22 Apr 2019 08:40:47 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org
Subject: [PATCH v3 2/3] MIPS: ath79: ar9331: add Ethernet nodes
Date:   Mon, 22 Apr 2019 08:40:45 +0200
Message-Id: <20190422064046.2822-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422064046.2822-1-o.rempel@pengutronix.de>
References: <20190422064046.2822-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@vger.kernel.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add ethernet nodes supported by ag71xx driver.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/mips/boot/dts/qca/ar9331.dtsi           | 25 ++++++++++++++++++++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts |  8 +++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index 2bae201aa365..2f56fd894df9 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -116,6 +116,31 @@
 			};
 		};
 
+		eth0: ethernet@19000000 {
+			compatible = "qca,ar9330-eth";
+			reg = <0x19000000 0x200>;
+			interrupts = <4>;
+
+			resets = <&rst 9>;
+			reset-names = "mac";
+
+			status = "disabled";
+		};
+
+		eth1: ethernet@1a000000 {
+			compatible = "qca,ar9330-eth";
+			reg = <0x1a000000 0x200>;
+			interrupts = <5>;
+
+			resets = <&rst 13>, <&rst 23>;
+			reset-names = "mac", "mdio";
+
+			clocks = <&pll ATH79_CLK_MDIO>;
+			clock-names = "mdio";
+
+			status = "disabled";
+		};
+
 		usb: usb@1b000100 {
 			compatible = "chipidea,usb2";
 			reg = <0x1b000000 0x200>;
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index e7af2cf5f4c1..77bab823eb3b 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -76,3 +76,11 @@
 		reg = <0>;
 	};
 };
+
+&eth0 {
+	status = "okay";
+};
+
+&eth1 {
+	status = "okay";
+};
-- 
2.20.1

