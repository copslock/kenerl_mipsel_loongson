Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFEEC43444
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0F520657
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAQKFE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60522 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfAQKFE (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D4E0020955; Thu, 17 Jan 2019 11:05:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF53F206DC;
        Thu, 17 Jan 2019 11:05:01 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 2/8] MIPS: dts: mscc: describe VCAP and PTP register ranges
Date:   Thu, 17 Jan 2019 11:02:06 +0100
Message-Id: <20190117100212.2336-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds two register ranges within the mscc,vsc7514-switch node,
to describe the VCAP and PTP registers.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 90c60d42f571..bb81652bebe8 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -119,7 +119,9 @@
 			compatible = "mscc,vsc7514-switch";
 			reg = <0x1010000 0x10000>,
 			      <0x1030000 0x10000>,
+			      <0x1060000 0x10000>,
 			      <0x1080000 0x100>,
+			      <0x10e0000 0x10000>,
 			      <0x11e0000 0x100>,
 			      <0x11f0000 0x100>,
 			      <0x1200000 0x100>,
@@ -133,10 +135,10 @@
 			      <0x1280000 0x100>,
 			      <0x1800000 0x80000>,
 			      <0x1880000 0x10000>;
-			reg-names = "sys", "rew", "qs", "port0", "port1",
-				    "port2", "port3", "port4", "port5", "port6",
-				    "port7", "port8", "port9", "port10", "qsys",
-				    "ana";
+			reg-names = "sys", "rew", "vcap", "qs", "ptp", "port0",
+				    "port1", "port2", "port3", "port4", "port5",
+				    "port6", "port7", "port8", "port9",
+				    "port10", "qsys", "ana";
 			interrupts = <21 22>;
 			interrupt-names = "xtr", "inj";
 
-- 
2.20.1

