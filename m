Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A7C43444
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64420856
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAQKFF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60531 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfAQKFE (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3501920994; Thu, 17 Jan 2019 11:05:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0C100206DC;
        Thu, 17 Jan 2019 11:05:02 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 3/8] Documentation/bindings: net: ocelot: document the PTP ready IRQ
Date:   Thu, 17 Jan 2019 11:02:07 +0100
Message-Id: <20190117100212.2336-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

One additional interrupt needs to be described within the Ocelot device
tree node: the PTP ready one. This patch documents the binding needed to
do so.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc-ocelot.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
index 08bc8d7f0c99..aa33066f3403 100644
--- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -18,9 +18,10 @@ Required properties:
   - "ana"
   - "portX" with X from 0 to the number of last port index available on that
     switch
-- interrupts: Should contain the switch interrupts for frame extraction and
-  frame injection
-- interrupt-names: should contain the interrupt names: "xtr", "inj"
+- interrupts: Should contain the switch interrupts for frame extraction,
+  frame injection and PTP ready.
+- interrupt-names: should contain the interrupt names: "xtr", "inj" and
+  "ptp_rdy".
 - ethernet-ports: A container for child nodes representing switch ports.
 
 The ethernet-ports container has the following properties
@@ -65,8 +66,8 @@ Example:
 			    "port1", "port2", "port3", "port4", "port5",
 			    "port6", "port7", "port8", "port9", "port10",
 			    "qsys", "ana";
-		interrupts = <21 22>;
-		interrupt-names = "xtr", "inj";
+		interrupts = <18 21 22>;
+		interrupt-names = "ptp_rdy", "xtr", "inj";
 
 		ethernet-ports {
 			#address-cells = <1>;
-- 
2.20.1

