Return-Path: <SRS0=pfVP=T3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE4C282CE
	for <linux-mips@archiver.kernel.org>; Mon, 27 May 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0843821734
	for <linux-mips@archiver.kernel.org>; Mon, 27 May 2019 09:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0JNh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 27 May 2019 05:13:37 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:43408 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfE0JNh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 27 May 2019 05:13:37 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C17B5A108C;
        Mon, 27 May 2019 11:13:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 0i02r393Qw7Q; Mon, 27 May 2019 11:13:26 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 6/8 v2] MIPS: ralink: mt7628a.dtsi: Add SPI controller DT node
Date:   Mon, 27 May 2019 11:13:21 +0200
Message-Id: <20190527091323.4582-6-sr@denx.de>
In-Reply-To: <20190527091323.4582-1-sr@denx.de>
References: <20190527091323.4582-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds the SPI controller description to the MT7628A dtsi file.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v2:
- Use Harvey's new email address (not at imgtec)
- Use correct linux-mips list address

 arch/mips/boot/dts/ralink/mt7628a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index 64a425c7d639..0895ae62782a 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -186,6 +186,22 @@
 			status = "disabled";
 		};
 
+		spi: spi@b00 {
+			compatible = "ralink,mt7621-spi";
+			reg = <0xb00 0x100>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_spi_spi>;
+
+			resets = <&resetc 18>;
+			reset-names = "spi";
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
2.21.0

