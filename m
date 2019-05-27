Return-Path: <SRS0=pfVP=T3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472FC28CBF
	for <linux-mips@archiver.kernel.org>; Mon, 27 May 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D13A2173C
	for <linux-mips@archiver.kernel.org>; Mon, 27 May 2019 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfE0JNg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 27 May 2019 05:13:36 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:54164 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE0JNg (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 27 May 2019 05:13:36 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 20B6150692;
        Mon, 27 May 2019 11:13:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id R2nYu5I4SNRK; Mon, 27 May 2019 11:13:24 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 3/8 v2] MIPS: ralink: mt7628a.dtsi: Add pinctrl DT properties to the UART nodes
Date:   Mon, 27 May 2019 11:13:18 +0200
Message-Id: <20190527091323.4582-3-sr@denx.de>
In-Reply-To: <20190527091323.4582-1-sr@denx.de>
References: <20190527091323.4582-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Now that pinmux is available, let's use it for the UART DT nodes.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v2:
- Use Harvey's new email address (not at imgtec)
- Use correct linux-mips list address

 arch/mips/boot/dts/ralink/mt7628a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index d87f53bd6d72..a239a2405670 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -161,6 +161,9 @@
 			compatible = "ns16550a";
 			reg = <0xc00 0x100>;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_uart0_uart>;
+
 			resets = <&resetc 12>;
 			reset-names = "uart0";
 
@@ -174,6 +177,9 @@
 			compatible = "ns16550a";
 			reg = <0xd00 0x100>;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_uart1_uart>;
+
 			resets = <&resetc 19>;
 			reset-names = "uart1";
 
@@ -187,6 +193,9 @@
 			compatible = "ns16550a";
 			reg = <0xe00 0x100>;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_uart2_uart>;
+
 			resets = <&resetc 20>;
 			reset-names = "uart2";
 
-- 
2.21.0

