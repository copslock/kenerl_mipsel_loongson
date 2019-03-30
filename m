Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B651C43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AD02184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAGBLdeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfC3MeM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:34:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33982 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbfC3MeM (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:34:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so2320919pfd.1;
        Sat, 30 Mar 2019 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WX//nb+5iiL7rJl5kpEr19r9DUBONGU99lNY/YoIEE4=;
        b=dAGBLdeHdW/ZUUQf2v5vf5gdGxve9p9yGxz8SeKGuKAZKpS84pv/LV231iJeLYxLg8
         1lqRBseTSp+pzncLKs1s+nPnj/g6IKm2N8uZg1PEGH248c9UBDUh9ahl7Y4Bp+wMb72B
         0lflZ5mSzEF6dYu0noBWIf1kvf9YY3I98KpkY69AlLrIBPAbkzcWkwb+AH+ALWqvJnUM
         cFqOi+4UcSc5syqJPVEeYKrs56tFbR6NuwOTm6Kq9nW9tZGT+DhhhbPNyncWQRlzAUp2
         fq2SSMEAGGsfGDo3y3epQra1WjO2+ySw/jCaEUV/tiG0Y0vGnRIvwoebDLcfHIYgfh6u
         Kepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WX//nb+5iiL7rJl5kpEr19r9DUBONGU99lNY/YoIEE4=;
        b=MBktKl9/NO5qkKq9dlVwT3LBX1XhMrBZurfyEV+GJ+b0eGT7aBz0yLGXlF7ngaRBke
         M59oT8il3gjm5/Haj/G17SgeLzTBOG/qrUXzq1q0qujYuwHx9L9+8QqZDbvnn4O1fw7e
         xHPBNFqv4nl/rKY7TFqiiIwwsHAKqsneN5AVsuXZyozKO8E0e6V8aETKPOBUUZjq8SAb
         3qNMvR/d/ZUXrYJwTsWU8vNhovvZnR+NtNo6jZTSwWBF2lDfdY36t79pGuFvlqnQJpYz
         eL6eb9ln63LaSIyXTk8ZZL80SachySG/hkPF6mAPtus6M3USQFif/wB+cnaX9tALCghZ
         Af0Q==
X-Gm-Message-State: APjAAAV74hJwNOM9E5SvlcwaZEkmrzdl7w9aKisIa76SVNhee9nuTIog
        Lg7gAEylzA3m+398hH7r3ic=
X-Google-Smtp-Source: APXvYqwl3NHz6jdBIbeNf5rFBfnIYUwqwEN1bjzVpVTAHwwxSrxIEZtfxPysthNEDgnBoqphExMLDw==
X-Received: by 2002:a62:209c:: with SMTP id m28mr13029624pfj.233.1553949252083;
        Sat, 30 Mar 2019 05:34:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:34:11 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 2/5] mips: ralink: add dt-binding document for rt2880-clock driver
Date:   Sat, 30 Mar 2019 21:33:14 +0900
Message-Id: <20190330123317.16821-3-drvlabo@gmail.com>
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
 .../bindings/clock/ralink,rt2880-clock.txt    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
new file mode 100644
index 000000000000..6f0757046df4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
@@ -0,0 +1,20 @@
+* Clock bindings for Ralink/Mediatek MIPS based SoCs
+
+Required properties:
+ - compatible: must be "ralink,rt2880-clock" and
+     one of the following, to identify SoC series
+        "mediatek,mt7620-clock"   for MT7620
+        "mediatek,mt7628-clock"   for MT7628/MT7688
+        "mediatek,mt7621-clock"   for MT7621
+ - #clock-cells: must be 1
+ - ralink,sysctl: a phandle to a ralink syscon register region
+
+
+Example:
+
+clkctrl: clkctrl {
+	compatible = "mediatek,mt7620-clock", "ralink,rt2880-clock";
+	#clock-cells = <1>;
+
+	ralink,sysctl = <&sysc>;
+};
-- 
2.20.1

