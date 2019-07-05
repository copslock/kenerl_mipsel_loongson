Return-Path: <SRS0=aTje=VC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCADFC468AA
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DDF216FD
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGETzN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:55:13 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40413 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfGETzN (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Jul 2019 15:55:13 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9000EFF809;
        Fri,  5 Jul 2019 19:55:02 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next v2 1/8] Documentation/bindings: net: ocelot: document the PTP bank
Date:   Fri,  5 Jul 2019 21:52:06 +0200
Message-Id: <20190705195213.22041-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705195213.22041-1-antoine.tenart@bootlin.com>
References: <20190705195213.22041-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

One additional register range needs to be described within the Ocelot
device tree node: the PTP. This patch documents the binding needed to do
so.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc-ocelot.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
index 9e5c17d426ce..4d05a3b0f786 100644
--- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -12,6 +12,7 @@ Required properties:
   - "sys"
   - "rew"
   - "qs"
+  - "ptp" (optional due to backward compatibility)
   - "qsys"
   - "ana"
   - "portX" with X from 0 to the number of last port index available on that
@@ -44,6 +45,7 @@ Example:
 		reg = <0x1010000 0x10000>,
 		      <0x1030000 0x10000>,
 		      <0x1080000 0x100>,
+		      <0x10e0000 0x10000>,
 		      <0x11e0000 0x100>,
 		      <0x11f0000 0x100>,
 		      <0x1200000 0x100>,
@@ -57,9 +59,10 @@ Example:
 		      <0x1280000 0x100>,
 		      <0x1800000 0x80000>,
 		      <0x1880000 0x10000>;
-		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
-			    "port3", "port4", "port5", "port6", "port7",
-			    "port8", "port9", "port10", "qsys", "ana";
+		reg-names = "sys", "rew", "qs", "ptp", "port0", "port1",
+			    "port2", "port3", "port4", "port5", "port6",
+			    "port7", "port8", "port9", "port10", "qsys",
+			    "ana";
 		interrupts = <21 22>;
 		interrupt-names = "xtr", "inj";
 
-- 
2.21.0

