Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CEC4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B95217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVbB3Cil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDEACR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:17 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42894 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:17 -0400
Received: by mail-pg1-f170.google.com with SMTP id p6so2034080pgh.9;
        Thu, 04 Apr 2019 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5adcmxZ37qROrXA1JIpPKzSBcDAOW7O0W6cn5r41jI=;
        b=QVbB3Cil4VU89CMumZyi+4YTvml//BGwVRG1vaD0nW57C8QlK2kFR837th5nd2Jbr5
         q24jG5JhRZgU2/Qtr7o9bG7SZl3+dGBsrwsZJB/YHMZmRWoP+TOgE2ATBMy/cqzTErnD
         aPQfRv1JIGds6v6uo56/S2U8JRisZcB3fxxo5LNTl7eyv2a0Bxf4wMp/zhFhLI+dU4YO
         +urA3sdCnJE4ficyLfWu+qst8oN9otXSOboUc+aOwM3sPdTIrQ8wVe1vpCV6ZRqjyXiL
         Ppugt2cdb203RzNc6//nDHRhA8wkfYYg8p2WSKQp778zbkh18Yx/pJp3EbcvQIhJEwqa
         K66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5adcmxZ37qROrXA1JIpPKzSBcDAOW7O0W6cn5r41jI=;
        b=kmq/Omh5J9q75lMdWxVnLUqzcFrDT/2IN4l4da5y7x5QIq6q68K/xDn/+gHuhZPavl
         qJ4vF+WnQq4UwK4dlAsx7NZXrHPmEJVviwpOqd5EraNMlSWXzwkNsWYMfG3Jfvqcc2rc
         poE+DhUO6HlZjU47Z1egUZVAc7dTZL9PzQWuHrR9BoIF7e6Bai+DEarG6sSPie5gwmqG
         ckpvYgtD1JdlmiMeY3TQfbkRp8c5bhJpGIibD1fnFsCH08rc+KMS4cH7L4PY1UmLbS69
         qE/a6mYl6FcwwjB8y2CgSL5X/u52p6xE3BpJhjHcSJxe8C/FYx1386lKtRkV9S08Q/L0
         vt/Q==
X-Gm-Message-State: APjAAAV4ccDSQgD2tTDo4ddyNl7HrUFwuttDuSKjrHIdUWtAm+rIuebi
        UprcoI+bieLRmHAhx5FddLg=
X-Google-Smtp-Source: APXvYqxyyeLYhnZbQUxJlicMAjALTydk+4e//4mo4GQ9NGhcMnT4THJqQAXU92Xp7mGGXo6N2fpLtw==
X-Received: by 2002:a63:f707:: with SMTP id x7mr8807877pgh.343.1554422536541;
        Thu, 04 Apr 2019 17:02:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:16 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 4/5] mips: ralink: mt76x8: add nodes for clocks
Date:   Fri,  5 Apr 2019 09:01:28 +0900
Message-Id: <20190405000129.19331-5-drvlabo@gmail.com>
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
 arch/mips/boot/dts/ralink/mt7628a.dtsi | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index 9ff7e8faaecc..f7630b52c8d7 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/clock/mt7620-clk.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -26,6 +28,31 @@
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
+				<16>, <17>, <18>, <19>,
+				<20>;
+		clock-output-names =
+				"uart0",
+				"i2c", "i2s", "spi", "uart1",
+				"uart2";
+		clocks =
+				<&pll MT7620_CLK_PERIPH>,
+				<&pll MT7620_CLK_PERIPH>, <&pll MT7620_CLK_PCMI2S>, <&pll MT7620_CLK_SYS>, <&pll MT7620_CLK_PERIPH>,
+				<&pll MT7620_CLK_PERIPH>;
+	};
+
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
@@ -62,10 +89,29 @@
 			reg = <0x300 0x100>;
 		};
 
+		spi0: spi@b00 {
+			compatible = "ralink,mt7621-spi";
+			reg = <0xb00 0x100>;
+
+			clocks = <&clkctrl 18>;
+			clock-names = "spi";
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
 
+			clocks = <&clkctrl 12>;
+			clock-names = "uart0";
+
 			resets = <&resetc 12>;
 			reset-names = "uart0";
 
@@ -79,6 +125,9 @@
 			compatible = "ns16550a";
 			reg = <0xd00 0x100>;
 
+			clocks = <&clkctrl 19>;
+			clock-names = "uart1";
+
 			resets = <&resetc 19>;
 			reset-names = "uart1";
 
@@ -92,6 +141,9 @@
 			compatible = "ns16550a";
 			reg = <0xe00 0x100>;
 
+			clocks = <&clkctrl 20>;
+			clock-names = "uart2";
+
 			resets = <&resetc 20>;
 			reset-names = "uart2";
 
-- 
2.20.1

