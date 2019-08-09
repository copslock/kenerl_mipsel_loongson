Return-Path: <SRS0=CBkT=WF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE65C31E40
	for <linux-mips@archiver.kernel.org>; Fri,  9 Aug 2019 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5954208C3
	for <linux-mips@archiver.kernel.org>; Fri,  9 Aug 2019 12:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIMT1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:19:27 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:41162 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfHIMT1 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 9 Aug 2019 08:19:27 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 3F62CA019B;
        Fri,  9 Aug 2019 14:19:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id jaKAKTXVOwTb; Fri,  9 Aug 2019 14:19:18 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/3 v3] MIPS: ralink: mt7628a.dtsi: Add I2C controller DT node
Date:   Fri,  9 Aug 2019 14:19:16 +0200
Message-Id: <20190809121918.25047-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds the I2C controller description to the MT7628A dtsi file.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v3:
- No change (I2C controller driver is now available in mainline)

v2:
- Use Harvey's new email address (not at imgtec)
- Use correct linux-mips list address

 arch/mips/boot/dts/ralink/mt7628a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index 61f8621e88b3..742bcc1dc2e0 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -199,6 +199,22 @@
 			status = "disabled";
 		};
 
+		i2c: i2c@900 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x900 0x100>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_i2c_i2c>;
+
+			resets = <&resetc 16>;
+			reset-names = "i2c";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		uart0: uartlite@c00 {
 			compatible = "ns16550a";
 			reg = <0xc00 0x100>;
-- 
2.22.0

