Return-Path: <SRS0=hTb5=TC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C04AA8
	for <linux-mips@archiver.kernel.org>; Thu,  2 May 2019 12:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC230205C9
	for <linux-mips@archiver.kernel.org>; Thu,  2 May 2019 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jeymr1W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBM1q (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 2 May 2019 08:27:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37424 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBM1q (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 2 May 2019 08:27:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so1942493edw.4;
        Thu, 02 May 2019 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQHrb8U8TVMSSdWsHAvzbKgvStq8NFwo8FcvdTWbX6s=;
        b=Jeymr1W7ySBcRM8iWy3UBTmiq5qayp39VvblU3+AhXfHn1a/+XDpv4m95YOxOwdLF5
         UKm3eJQ9HxTCNOSI5lRpZXEkOSSl/imLFPqhhVoGXxmB2UMEtrDptDbxuhGjR5UdzO1p
         cGAZw31Q9euon3xnZfapaW/jM/L7sCcM3cmR8mm/7U5WF0ie4x0VY021aB3JFw4AsPF7
         975xwR4rxf6xyt2QtfmSsZmZUml+0i9EazRpg88Tyj/iMmwF2l6tPhDyEyFNFSspZ4nT
         r+M3EotxV/egK2EQWTCe900DGPgq6YsznzsjxlL4hV6+kbVHZNMwG9LN1gvSmwgTNpQH
         t9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YQHrb8U8TVMSSdWsHAvzbKgvStq8NFwo8FcvdTWbX6s=;
        b=FfH4IciYld633LgUC4RxWeL4+fb+9laUiH0caiDQ9ZQSX6zu31bu31Q83mPYdB1Q2Z
         uVcHOS3799RW321u8MiM+2R1Tuf3iyjI/At2/MF7I05lVvy9mwioHfn5DhzGsDoF26/Q
         XPgO67TPrf2eAXglQi86aql5x5/mnjxIa/3MUO8385VTb2/jEGg4sZkSZ1fOPhLRldcC
         AwzYD+uL9eyitBrYbcmUoYzmI2RRv/UaiOLNnT4Ekh6ycncdY91Mrf4xJIgZUpm2Iv0R
         4LFWj25O/HnCLASxuy4S1BlumPQh8Wgvo21xNkAAcvLV3CHBdlKmLA3zaAOGQlMonxqm
         RIcg==
X-Gm-Message-State: APjAAAXiuV4izhy6SlpAwCSSL55AsG17FpY+EdRUePnEbVJ6ppFaUyFt
        KmwSyqU1XfwhAh2sxm8dOYPeSlue
X-Google-Smtp-Source: APXvYqze8GT0mHuhV3R3Wv0DYB0fYxC/JeAGtEB/Vd0U1tXmaHjzq/d5nIvfAMEE8sfN706NYXb2nA==
X-Received: by 2002:a17:906:3ed1:: with SMTP id d17mr1691898ejj.221.1556800063922;
        Thu, 02 May 2019 05:27:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
        by smtp.gmail.com with ESMTPSA id k18sm2030453eda.92.2019.05.02.05.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:27:43 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 1/3] devicetree: document the BCM63XX gated clock bindings
Date:   Thu,  2 May 2019 14:26:55 +0200
Message-Id: <20190502122657.15577-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20190502122657.15577-1-jonas.gorski@gmail.com>
References: <20190502122657.15577-1-jonas.gorski@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add binding documentation for the gated clock controller found on MIPS
based BCM63XX SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .../bindings/clock/brcm,bcm63xx-clocks.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
new file mode 100644
index 000000000000..3041657e2f96
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
@@ -0,0 +1,22 @@
+Gated Clock Controller Bindings for MIPS based BCM63XX SoCs
+
+Required properties:
+- compatible: must be one of:
+	 "brcm,bcm3368-clocks"
+	 "brcm,bcm6328-clocks"
+	 "brcm,bcm6358-clocks"
+	 "brcm,bcm6362-clocks"
+	 "brcm,bcm6368-clocks"
+	 "brcm,bcm63268-clocks"
+
+- reg: Address and length of the register set
+- #clock-cells: must be <1>
+
+
+Example:
+
+clkctl: clock-controller@10000004 {
+	compatible = "brcm,bcm6328-clocks";
+	reg = <0x10000004 0x4>;
+	#clock-cells = <1>;
+};
-- 
2.13.2

