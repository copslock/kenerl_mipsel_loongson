Return-Path: <SRS0=aTje=VC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F605C468A7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2F2133F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfGETzT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:55:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33835 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfGETzT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Jul 2019 15:55:19 -0400
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8F498240005;
        Fri,  5 Jul 2019 19:55:11 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next v2 3/8] Documentation/bindings: net: ocelot: document the PTP ready IRQ
Date:   Fri,  5 Jul 2019 21:52:08 +0200
Message-Id: <20190705195213.22041-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705195213.22041-1-antoine.tenart@bootlin.com>
References: <20190705195213.22041-1-antoine.tenart@bootlin.com>
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
index 4d05a3b0f786..3b6290b45ce5 100644
--- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -17,9 +17,10 @@ Required properties:
   - "ana"
   - "portX" with X from 0 to the number of last port index available on that
     switch
-- interrupts: Should contain the switch interrupts for frame extraction and
-  frame injection
-- interrupt-names: should contain the interrupt names: "xtr", "inj"
+- interrupts: Should contain the switch interrupts for frame extraction,
+  frame injection and PTP ready.
+- interrupt-names: should contain the interrupt names: "xtr", "inj". Can contain
+  "ptp_rdy" which is optional due to backward compatibility.
 - ethernet-ports: A container for child nodes representing switch ports.
 
 The ethernet-ports container has the following properties
@@ -63,8 +64,8 @@ Example:
 			    "port2", "port3", "port4", "port5", "port6",
 			    "port7", "port8", "port9", "port10", "qsys",
 			    "ana";
-		interrupts = <21 22>;
-		interrupt-names = "xtr", "inj";
+		interrupts = <18 21 22>;
+		interrupt-names = "ptp_rdy", "xtr", "inj";
 
 		ethernet-ports {
 			#address-cells = <1>;
-- 
2.21.0

