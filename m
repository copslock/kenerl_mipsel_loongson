Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2642FC4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1747217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWNjqmYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfDEACM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45143 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACM (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so2189239pfi.12;
        Thu, 04 Apr 2019 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvO2rzEzTaZL1ix02x6cU2FrQptPs9zYsw9wVRWAPFM=;
        b=DWNjqmYy98PTMyvVaC+VH8qSUGsjPYjzg1poOIqCaKYO9pHIeGe+WpzIw+xJkWas6B
         Th1UCNTXdPt2MQ7aEa03LzmUYbYLLIVckJXpoeY6ofqTL5MBea80TedGr7iaIXMx23vm
         3tw4UKKZYSSvyPXqk+oTu/Vcol4H6uCRLZFTg9MZYR1N18ZxsGecovX+sWZb+LhoDIvd
         kuBVsexNLKnMUKm4lrben8jWe/ZZCivhZwnYkLl4Ll/Dnssl7RHwBbHdumqUyzll845C
         p43zqXUCuQEAbS0baaSxJYekDjhVIuo+8RKi9GNfnRxommDMq8YKBRPXdkaclfkkmjTg
         JoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvO2rzEzTaZL1ix02x6cU2FrQptPs9zYsw9wVRWAPFM=;
        b=i10CipAbZxI6c04rgWei1GzaoEdXqed8ti2eHXoJjXrqWe82uX2KgCptNMXuiifqAV
         Ong/f5xPCAz9TPrNtdMomVrOfp29ar2UfpSLWXL7SGliNEDLy5uAVejsSHFu23wR70+A
         vHP54SFvpOcxMDPLaOMWWfCX+vsHjFaxHaabINEqlszhYtEdfcr0G4/bIAsvQmFGOriB
         HggjVKHq3WeagQkhufD6oVWev258fn1w3oybk4IO9yg8h/+jhJP96ucGSVaz7YmqkfqV
         3r8Fn5std2LY/D7wUBbjhmQXQgmd5DHG5RAZoHg52Kfl188Sn/tXECwmQiUih/Jxax5F
         fFCw==
X-Gm-Message-State: APjAAAU2JPz1t1BvVSUIiNPFJTahkJQ8dgiiy6IKq8SJBYWk3hYPLh0/
        Nm5uGm5WkoescprM4Qeafhs=
X-Google-Smtp-Source: APXvYqwt4bas46Z6pfvaXUUs7b2tvMVYwTF35COZG6dYmOHq6ke9s87WkgpIoWHrNtIoQ5trFjZotg==
X-Received: by 2002:a62:5f84:: with SMTP id t126mr8928732pfb.185.1554422531703;
        Thu, 04 Apr 2019 17:02:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:11 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 2/5] dt-bindings: clk: add document for ralink clock driver
Date:   Fri,  5 Apr 2019 09:01:26 +0900
Message-Id: <20190405000129.19331-3-drvlabo@gmail.com>
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
 .../bindings/clock/ralink,rt2880-clock.txt    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
new file mode 100644
index 000000000000..2fc0d622e01e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
@@ -0,0 +1,58 @@
+* Clock bindings for Ralink/Mediatek MIPS based SoCs
+
+Required properties:
+ - compatible: must be "ralink,rt2880-clock"
+ - #clock-cells: must be 1
+ - ralink,sysctl: a phandle to a ralink syscon register region
+ - clock-indices: identifying number.
+       These must correspond to the bit number in CLKCFG1.
+       Clock consumers use one of them as #clock-cells index.
+ - clock-output-names: array of gating clocks' names
+ - clocks: array of phandles which points the parent clock
+       for gating clocks.
+       If gating clock does not need parent clock linkage,
+       we bind to dummy clock whose frequency is zero.
+
+
+Example:
+
+/* dummy parent clock node */
+dummy_ck: dummy_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+clkctrl: clkctrl {
+	compatible = "ralink,rt2880-clock";
+	#clock-cells = <1>;
+	ralink,sysctl = <&sysc>;
+
+	clock-indices =
+			<12>,
+			<16>, <17>, <18>, <19>,
+			<20>,
+			<26>;
+	clock-output-names =
+			"uart0",
+			"i2c", "i2s", "spi", "uart1",
+			"uart2",
+			"pcie0";
+	clocks =
+			<&pll MT7620_CLK_PERIPH>,
+			<&pll MT7620_CLK_PERIPH>, <&pll MT7620_CLK_PCMI2S>, <&pll MT7620_CLK_SYS>, <&pll MT7620_CLK_PERIPH>,
+			<&pll MT7620_CLK_PERIPH>,
+			<&dummy_ck>;
+	};
+};
+
+/* consumer which refers "uart0" clock */
+uart0: uartlite@c00 {
+	compatible = "ns16550a";
+	reg = <0xc00 0x100>;
+
+	clocks = <&clkctrl 12>;
+	clock-names = "uart0";
+
+	...
+};
-- 
2.20.1

