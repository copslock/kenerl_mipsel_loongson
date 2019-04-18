Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F0C10F0B
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680022184B
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDRF1C (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:27:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfDRF0f (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 01:26:35 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hGzZ3-0003gO-UB; Thu, 18 Apr 2019 07:26:25 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hGzZ0-0005dS-DU; Thu, 18 Apr 2019 07:26:22 +0200
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
Subject: [PATCH v2 1/3] dt-bindings: net: add qca,ar71xx.txt documentation
Date:   Thu, 18 Apr 2019 07:26:18 +0200
Message-Id: <20190418052620.20835-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418052620.20835-1-o.rempel@pengutronix.de>
References: <20190418052620.20835-1-o.rempel@pengutronix.de>
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

Add binding documentation for Atheros/QCA networking IP core used
in many routers.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/net/qca,ar71xx.txt    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,ar71xx.txt

diff --git a/Documentation/devicetree/bindings/net/qca,ar71xx.txt b/Documentation/devicetree/bindings/net/qca,ar71xx.txt
new file mode 100644
index 000000000000..56abf224de2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,ar71xx.txt
@@ -0,0 +1,44 @@
+Required properties:
+- compatible:	Should be "qca,<soc>-eth". Currently support compatibles are:
+		qca,ar7100-eth - Atheros AR7100
+		qca,ar7240-eth - Atheros AR7240
+		qca,ar7241-eth - Atheros AR7241
+		qca,ar7242-eth - Atheros AR7242
+		qca,ar9130-eth - Atheros AR9130
+		qca,ar9330-eth - Atheros AR9330
+		qca,ar9340-eth - Atheros AR9340
+		qca,qca9530-eth - Qualcomm Atheros QCA9530
+		qca,qca9550-eth - Qualcomm Atheros QCA9550
+		qca,qca9560-eth - Qualcomm Atheros QCA9560
+
+- reg : Address and length of the register set for the device
+- interrupts : Should contain eth interrupt
+- phy-mode : See ethernet.txt file in the same directory
+- clocks: the clock used by the core
+- clock-names: the names of the clock listed in the clocks property. These are
+	"mdio".
+- resets: Should contain phandles to the reset signals
+- reset-names: Should contain the names of reset signal listed in the resets
+		property. These are "mac" and "mdio"
+
+Optional properties:
+- phy-handle : phandle to the PHY device connected to this device.
+- fixed-link : Assume a fixed link. See fixed-link.txt in the same directory.
+  Use instead of phy-handle.
+
+Optional subnodes:
+- mdio : specifies the mdio bus, used as a container for phy nodes
+  according to phy.txt in the same directory
+
+Example:
+
+ethernet@1a000000 {
+	compatible = "qca,ar9330-eth";
+	reg = <0x1a000000 0x200>;
+	interrupts = <5>;
+	resets = <&rst 13>, <&rst 23>;
+	reset-names = "mac", "mdio";
+	clocks = <&pll ATH79_CLK_MDIO>;
+	clock-names = "mdio";
+	phy-mode = "gmii";
+};
-- 
2.20.1

