Return-Path: <SRS0=dgrR=U6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B325AC0650E
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C90C20881
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfGAKFX (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:05:23 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54709 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbfGAKFW (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 1 Jul 2019 06:05:22 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1F8531BF20C;
        Mon,  1 Jul 2019 10:05:19 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 3/8] Documentation/bindings: net: ocelot: document the PTP ready IRQ
Date:   Mon,  1 Jul 2019 12:03:22 +0200
Message-Id: <20190701100327.6425-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701100327.6425-1-antoine.tenart@bootlin.com>
References: <20190701100327.6425-1-antoine.tenart@bootlin.com>
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
index 0afadfaa33ee..33bbeb998166 100644
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
+- interrupt-names: should contain the interrupt names: "xtr", "inj" and
+  "ptp_rdy".
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

