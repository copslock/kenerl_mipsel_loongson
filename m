Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC1C43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47C12184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB/82hog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfC3MeY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:34:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbfC3MeY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:34:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id b11so2268041plr.7;
        Sat, 30 Mar 2019 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTIleGg5lcma+80ozLurR9rNDB9sfnRnT3edQrG7QCs=;
        b=RB/82hoglDMcl+1idej9d7iBAjUhO+n0ciGZUGn53yiXg878VIYG89iofPfA9xl1aw
         mCW171ib2qYQhjM8q9vuUxX63WhBffaMxOAxNbWSdrMR3pxVSfBiaIMh8UzH6esjQuKD
         XDl943tU2hQuXSMQQHYsLkgfr5T2EaP14CMj44saKLTFw7wbQAerMfK5Ao3ZwyhXbRN6
         bLJg8BeQfLP/i3aBk4Ygh/p7uD+l71DRNUbyfk+DJkIemwo7VYCsexCXXV/t+jI1x+mi
         iwWQjJ7Jgb2afP4M44fCabRufJRSkck3Z3+s27H3x1A8RrDKgyIV0PmU4xrJFtVjup0I
         h/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTIleGg5lcma+80ozLurR9rNDB9sfnRnT3edQrG7QCs=;
        b=OqLkyvo4oFDJKOr2ploJ2epO0HexW91DdyT7s9LN/qnNt+i+DLrZLFSM6Mpq5aCE4U
         MwOPrjOK+HAnBHIdrp7BkXtdpj5jND2LtGhl58CSscnGEIMpjdgEsVrpgNHb6jGb9pDi
         cfXFCNVDFBS/iwKbbUzba5NNCWdtK5wvsOjzFHPO8xgr7fpo5F1isJmpof917tgUObDh
         OPIjSsbSJQznD0gfOqt3fxcROVE+70wx8D2cvg/GRc2LknDfJGZVAURqqaNi0eS6aN9X
         ET6bx3gfpJolxA+fYV49KQcLqNgvighRwOQ5PUAcpdzDuVk9qFzQK0nZDJ0docPkYuf+
         PMKw==
X-Gm-Message-State: APjAAAV0vONa12URhCjrEvEq2ErX7GW7hsLMQePHDrlvAm8z09jOaHHR
        FLrY3StzpWdOpPn3noMKLl/cQcSW
X-Google-Smtp-Source: APXvYqwnVMrzM/UCy8jdpbQHhreA8A4zLWcCNRJWaoABj81nJl+b7cKBAq2BDN+4F7W47kG4nnXU/w==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3mr53423090plb.166.1553949263732;
        Sat, 30 Mar 2019 05:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:34:23 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 5/5] mips: ralink: mt7620: add nodes for clock provider
Date:   Sat, 30 Mar 2019 21:33:17 +0900
Message-Id: <20190330123317.16821-6-drvlabo@gmail.com>
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
 arch/mips/boot/dts/ralink/mt7620a.dtsi | 34 +++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index 1f6e5320f486..bc56b8f9a530 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -5,11 +5,21 @@
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
@@ -17,6 +27,18 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	pll: pll {
+		compatible = "mediatek,mt7620-pll", "syscon";
+		#clock-cells = <1>;
+		clock-output-names = "cpu", "sys", "periph", "pcmi2s", "xtal";
+	};
+
+	clkctrl: clkctrl {
+		compatible = "mediatek,mt7620-clock", "ralink,rt2880-clock";
+		#clock-cells = <1>;
+		ralink,sysctl = <&sysc>;
+	};
+
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
@@ -25,8 +47,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		sysc@0 {
-			compatible = "ralink,mt7620a-sysc";
+		sysc: sysc@0 {
+			compatible = "ralink,mt7620a-sysc", "syscon";
 			reg = <0x0 0x100>;
 		};
 
@@ -46,10 +68,16 @@
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

