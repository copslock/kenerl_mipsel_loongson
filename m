Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C69C4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D9217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBpbr14C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfDEACT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:19 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46571 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:19 -0400
Received: by mail-pf1-f178.google.com with SMTP id 9so2188874pfj.13;
        Thu, 04 Apr 2019 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwXPdnH5ICk6KssGxyPxjOp8avxPzVDiI6ehncX/2eo=;
        b=fBpbr14C8U3Br5BwKSATJ6fSFq9xlTv7JNMcPG4bfSfEf62jhUHJRWPNZpTKZ8d3Si
         kzVQX337JLvEaN9ODbpNnEMrXS5J1VQGCe2uycRtOENueADd+VRO4nZIfONmJqYe2vDg
         u0ZA1+Yr+EuD+rCaXbBrSJ2YC45j1A6x4uAVHndCl3kDCFEDKXjt7xds2QuQZECAe9yG
         gnijSpL103isnV9yQ34aTKHz8XXlrm+dwPKsmI7/b1j8NauUu651jPiBro3opbAdrMtW
         FHSVrBMhCNnYOBE/KCynR4CMu9m7+sT5JNC5pcxX2bQfi6hha1vWTORlcQOiVeXdD6qb
         71nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwXPdnH5ICk6KssGxyPxjOp8avxPzVDiI6ehncX/2eo=;
        b=PZil6IpFlEJQ/Vqe7z2a1Ht25smIBirZUUPwFWTMgGVstKqqwR881Jrh/GWSGgz0AJ
         H6rbl6EUlkYG4C1KN9IfIGnvdB5TDUI5aVTC17iW8Ib4CqJJUHYjDbsvRsj882BqBK+A
         T+NPM+AtrEI0ZF/clQGSgmHSPnT8+ooVZmyXu0rhFdt+urueM6a2MH4iir4TxrKRfXHe
         dNOFpuWFTzertrXSOxFyywSqJqDadsTuzY2hcXLdWdj7iZ9HtkGZz4GXA17ywX4DI/D3
         8aFGmWoKtYsXMD6vcrCAtj3Gw0uDm6zc3ZRfLWirSb4ZP+oHzJhOv4tCbI20MLLbXDr3
         VB3g==
X-Gm-Message-State: APjAAAWXHc9sqHolyU4/ISEVzy9xzWWMYUCoyktQsBXoheZ4d3EE/Qi7
        IOKIm59yf4VoTN/kqRBZHM0=
X-Google-Smtp-Source: APXvYqxS6AfqkDwkcYgBs9jaAxPNwpXZcMfmC19ifYt6kCpP3BDCIzghHo3DTdVqyzlQ3ONB3lPHmw==
X-Received: by 2002:a63:28c:: with SMTP id 134mr8913056pgc.278.1554422538971;
        Thu, 04 Apr 2019 17:02:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:18 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 5/5] mips: ralink: mt7620: add nodes for clocks
Date:   Fri,  5 Apr 2019 09:01:29 +0900
Message-Id: <20190405000129.19331-6-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405000129.19331-1-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7620a.dtsi | 46 ++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index 1f6e5320f486..7c98cb6bb5b9 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -1,15 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/mt7620-clk.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "ralink,mtk7620a-soc";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
 			compatible = "mips,mips24KEc";
+			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
+	resetc: reset-controller {
+		compatible = "ralink,rt2880-reset";
+		#reset-cells = <1>;
+	};
+
 	cpuintc: cpuintc {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
@@ -17,6 +29,28 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	pll: pll {
+		compatible = "mediatek,mt7620-pll";
+		#clock-cells = <1>;
+		clock-output-names = "cpu", "sys", "periph", "pcmi2s", "xtal";
+	};
+
+	clkctrl: clkctrl {
+		compatible = "ralink,rt2880-clock";
+		#clock-cells = <1>;
+		ralink,sysctl = <&sysc>;
+
+		clock-indices =
+				<12>,
+				<16>, <17>, <18>, <19>;
+		clock-output-names =
+				"uart",
+				"i2c", "i2s", "spi", "uartl";
+		clocks =
+				<&pll MT7620_CLK_PERIPH>,
+				<&pll MT7620_CLK_PERIPH>, <&pll MT7620_CLK_PCMI2S>, <&pll MT7620_CLK_SYS>, <&pll MT7620_CLK_PERIPH>;
+	};
+
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
@@ -25,8 +59,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		sysc@0 {
-			compatible = "ralink,mt7620a-sysc";
+		sysc: sysc@0 {
+			compatible = "ralink,mt7620a-sysc", "syscon";
 			reg = <0x0 0x100>;
 		};
 
@@ -46,10 +80,16 @@
 			reg = <0x300 0x100>;
 		};
 
-		uartlite@c00 {
+		uartlite: uartlite@c00 {
 			compatible = "ralink,mt7620a-uart", "ralink,rt2880-uart", "ns16550a";
 			reg = <0xc00 0x100>;
 
+			clocks = <&clkctrl 19>;
+			clock-names = "uartl";
+
+			resets = <&resetc 19>;
+			reset-names = "uartl";
+
 			interrupt-parent = <&intc>;
 			interrupts = <12>;
 
-- 
2.20.1

