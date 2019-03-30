Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FAC43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E1A2184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXlQKECP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfC3MeU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:34:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37733 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbfC3MeU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:34:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so2489867pgq.4;
        Sat, 30 Mar 2019 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNZb2SEz/Ir4EMYtCoFx3CIXyReZbxhA3HsmDWqvNJU=;
        b=VXlQKECPHPH414HVX0bDc5X+bOJQTDTAQuSQuT2nbpuR3bFy3GLm5C/pwM5oD6neyT
         HjuukcFt10APtUaix7plheoFlFftEU5vXQtuHD/tdawXF1EioUzoVInDEhr8e83P3fJN
         salsKQBo25wcMMUcrHFIjbfrchtGLZ1x1+gwNZ5Sfde2TbLR1OHUcbq1sYr1vOHfJ2Xf
         IuD9bJlFQ7UF2w4CshEyWqZPUXqJwZ5V7lF39fq9rvyRdCrG9cTqeA0e8U4Ab44UYL0Y
         iEGpQw3/mCPReCvUG2OA0JlNgCoT++qLNrp34vp7VpP4EqfXwWPsU4aOpqG1+6cE4/U4
         5XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNZb2SEz/Ir4EMYtCoFx3CIXyReZbxhA3HsmDWqvNJU=;
        b=qGIqk8zcGqcVuzHluFI8SMrL7Hx4TV6JD52n4HD/eqUKbXO8J/VQ/+s0FECqh1eQZY
         cYWN7FGR4C7PUcPzIux4ETxfmbf62GkWRTM7/IE5KRYoCLH1OeIYj50K50i/Pdz3UX0k
         NWc695SBafZeT8vxC+LV6cV8HE4rsiPR+lvTfp9i/w5f2Zof9eZ6Bj8Nob3C8l5zLSCi
         RL6kn9rTTfkJWAswiKkxzOeCjk/FNi00MXLNgo2cgcyLUx2eNvAatv9ftsAgjglrPp2U
         ZKVyPVwSwbf5NfXtOfMbCD9nhitepT2QlM9Oza7n5nKpszB8nDbe+7WO2T8ItacjhlcA
         V4AQ==
X-Gm-Message-State: APjAAAUWjgJIhCBNbXRRP/GilfW9WTKay9WV1DjsBGqlmLc40GB+d+9i
        yVOCTn/kvzgaufUmUqRAXLU=
X-Google-Smtp-Source: APXvYqxzuBwwNpV6Q5a95H2ISfgXAqNWjhZodntl01oByDR1HLKKooBzZwapJng9qVhO3j+VWaXEAA==
X-Received: by 2002:a63:79c3:: with SMTP id u186mr6438524pgc.20.1553949260031;
        Sat, 30 Mar 2019 05:34:20 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:34:19 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 4/5] mips: ralink: mt7628: add nodes for clock provider
Date:   Sat, 30 Mar 2019 21:33:16 +0900
Message-Id: <20190330123317.16821-5-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330123317.16821-1-drvlabo@gmail.com>
References: <20190330123317.16821-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7628a.dtsi | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
index 9ff7e8faaecc..67ce939f6b2b 100644
--- a/arch/mips/boot/dts/ralink/mt7628a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
@@ -26,6 +26,18 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	pll: pll {
+		compatible = "mediatek,mt7620-pll", "syscon";
+		#clock-cells = <1>;
+		clock-output-names = "cpu", "sys", "periph", "pcmi2s", "xtal";
+	};
+
+	clkctrl: clkctrl {
+		compatible = "mediatek,mt7628-clock", "ralink,rt2880-clock";
+		#clock-cells = <1>;
+		ralink,sysctl = <&sysc>;
+	};
+
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
@@ -62,10 +74,29 @@
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
 
@@ -79,6 +110,9 @@
 			compatible = "ns16550a";
 			reg = <0xd00 0x100>;
 
+			clocks = <&clkctrl 19>;
+			clock-names = "uart1";
+
 			resets = <&resetc 19>;
 			reset-names = "uart1";
 
@@ -92,6 +126,9 @@
 			compatible = "ns16550a";
 			reg = <0xe00 0x100>;
 
+			clocks = <&clkctrl 20>;
+			clock-names = "uart2";
+
 			resets = <&resetc 20>;
 			reset-names = "uart2";
 
-- 
2.20.1

