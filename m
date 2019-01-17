Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB0C43387
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F220657
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfAQKFE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60512 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfAQKFD (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 742EE207B2; Thu, 17 Jan 2019 11:05:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48F66206DC;
        Thu, 17 Jan 2019 11:05:01 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 1/8] Documentation/bindings: net: ocelot: document the VCAP and PTP banks
Date:   Thu, 17 Jan 2019 11:02:05 +0100
Message-Id: <20190117100212.2336-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Two additional register ranges needs to be described within the Ocelot
device tree node: the VCAP and the PTP ones. This patch documents the
binding needed to do so.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc-ocelot.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
index 9e5c17d426ce..08bc8d7f0c99 100644
--- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -11,7 +11,9 @@ Required properties:
 - reg-names: Must include the following entries:
   - "sys"
   - "rew"
+  - "vcap"
   - "qs"
+  - "ptp"
   - "qsys"
   - "ana"
   - "portX" with X from 0 to the number of last port index available on that
@@ -43,7 +45,9 @@ Example:
 		compatible = "mscc,vsc7514-switch";
 		reg = <0x1010000 0x10000>,
 		      <0x1030000 0x10000>,
+		      <0x1060000 0x10000>,
 		      <0x1080000 0x100>,
+		      <0x10e0000 0x10000>,
 		      <0x11e0000 0x100>,
 		      <0x11f0000 0x100>,
 		      <0x1200000 0x100>,
@@ -57,9 +61,10 @@ Example:
 		      <0x1280000 0x100>,
 		      <0x1800000 0x80000>,
 		      <0x1880000 0x10000>;
-		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
-			    "port3", "port4", "port5", "port6", "port7",
-			    "port8", "port9", "port10", "qsys", "ana";
+		reg-names = "sys", "rew", "vcap", "qs", "ptp", "port0",
+			    "port1", "port2", "port3", "port4", "port5",
+			    "port6", "port7", "port8", "port9", "port10",
+			    "qsys", "ana";
 		interrupts = <21 22>;
 		interrupt-names = "xtr", "inj";
 
-- 
2.20.1

