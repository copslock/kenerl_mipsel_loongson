Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:47:58 +0200 (CEST)
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40196 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeFSVrXh60Nr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:23 +0200
Received: by mail-yb0-f195.google.com with SMTP id v17-v6so477672ybe.7;
        Tue, 19 Jun 2018 14:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LC5sN3D4i3c7rmr3NVM7+l7w8yoxwsjrueH4YGTx6Bw=;
        b=Qql2VDVI5OzsEDoaPSUze0owvrlcSLL8c0tq2KBQPEol1BHeXvul1H6GXTdV2MTrad
         CuwnaGwvaMGKdtVQHV27+0Bbsv4TnFVwy78jqToZ2P5Vxs7mmewuHu8+HYc5MliNj0t9
         G5xWdaEyt/ctppvLFtPkuEmNfoxAL2L6mOZmXGzSmBPe5mpBfbEKbeaznVLl2OCoBoOK
         yUZyciL23daPT1LLpKEYxZiVGJyxtMZHycu7QRQomm3BCG/1RTXNwLdhl/y0o5MwzByi
         8wVFb77Vr18LoItiFTaCCjNPV+M2+bbo9Uu0Pq6yTNkQ12POu9qyaZrR2NWZQ1lD/miE
         LPLg==
X-Gm-Message-State: APt69E2zxsRCcfpmUQOIki3BUF9falosrgvViyrVf4vLxeWzd5CAhlrf
        VnaBRlStrOUS1cGloOVDbZUA/3A=
X-Google-Smtp-Source: ADUXVKLuJ8i9DyLEFpRBFtxIAH7bgHir/IWUJ8F0iE7gvlar1QLWrkqL920xOe7TKU7oRFGkryq+NA==
X-Received: by 2002:a25:7e05:: with SMTP id z5-v6mr9708903ybc.442.1529444835927;
        Tue, 19 Jun 2018 14:47:15 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/5] MIPS: netlogic: remove unnecessary of_platform_bus_probe call
Date:   Tue, 19 Jun 2018 15:47:07 -0600
Message-Id: <20180619214710.22066-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The DT core code will probe "simple-bus" by default, so remove
the Netlogic specific call. The probing of simple-bus happens at
arch_initcall_sync, so the call being removed here is already a nop.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/netlogic/xlp/dt.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 856a6e6d296e..b5ba83f4c646 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -93,17 +93,3 @@ void __init device_tree_init(void)
 {
 	unflatten_and_copy_device_tree();
 }
-
-static struct of_device_id __initdata xlp_ids[] = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-int __init xlp8xx_ds_publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		return 0;
-	return of_platform_bus_probe(NULL, xlp_ids, NULL);
-}
-
-device_initcall(xlp8xx_ds_publish_devices);
-- 
2.17.1
