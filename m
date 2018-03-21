Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:33:33 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:33967
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994688AbeCUT2uiIz-Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:50 +0100
Received: by mail-qt0-x244.google.com with SMTP id l25so6503405qtj.1
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZ4jZu4j4ZZUd4rgq3nXghDxm0ELYr+1WLnyWSNe0Rw=;
        b=AyB5UPCCWsYk5RO1bYFvulbUxq6Gsc46XoO9ZcU1jc1A3j21koXZaY81ZmCFGWN8bB
         TrsP048YG6kaSDC5Sgzke9050LJM9XevK3wRVeu3weXupOgNOAklLLVoE4xJO4I1E9qZ
         kxSRB3ypB78amgauad2Yth6yKOGaizjf+ZwtFLjpWVTXn/m/vQoifbAaswfCGG8khi+m
         Avxw77jqb1Iw61IGhklZOdoy6emGPqSkrrMTZ1Wbuv1Jp6O1ojBgAanepU5iHi8kaEJr
         5hPkdQEWW2W0gOmKUhbvA4bDxrgvGi9H3aIEs4+NNmuKgzwFk9k025np9dJMjfxHiMDv
         1deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZ4jZu4j4ZZUd4rgq3nXghDxm0ELYr+1WLnyWSNe0Rw=;
        b=iSv5GDecvqL+ZoLMzMfhI4TVJVZTQNu9ev7QFyCaA3rQJ7lG9Rjw0Y35bdZE1rOCqo
         QASHH8ou6WHPZQ/GmdGFhS0qrmwhj88kIVKhQGJM7IUcw8Jf7pBmnmVFGAxO+fLIjXoW
         eZuCvpwivrP7R3lbi9jedUCP59fjfgEjI6K1xF5vXBliC0isMXRlA0GSWoZDcpIfULMP
         XmEu1F9tvJ/1Db+bBtDNhSZxJqRdr20v3VuKZhfYsMmI3w8wCSSnImhoTcVrWDPY/ilO
         6YcfzKKlSHvXY9LdwudHkhBLQlWmJJCoylMdjXDysSUtPOhPv4o2+OSEZd94iGsWzmXH
         WqvQ==
X-Gm-Message-State: AElRT7Esskhcs/LqNY2h0pgS7IcebZWnqJS2UzyHv6DrIr8/hNktdkGb
        BMaUFnWbyFkIb725+38TbvCCXrNQ
X-Google-Smtp-Source: AG47ELsk2LyR8po2rUpvPxuWB4PmrF06fkjbxJmhqARDcd2wTeFH9AU0vTsK8Ym1yyOxGfIInjVb0Q==
X-Received: by 10.237.42.56 with SMTP id c53mr31079741qtd.199.1521660524881;
        Wed, 21 Mar 2018 12:28:44 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:44 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 03/14] mmc: jz4780: Order headers alphabetically
Date:   Wed, 21 Mar 2018 16:27:30 -0300
Message-Id: <20180321192741.25872-4-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Just a minor cleanup to order the headers alphabetically.
This helps prevent merge conflicts.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 97727cd34fc1..eb57f514a459 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -13,24 +13,24 @@
  *
  */
 
-#include <linux/mmc/host.h>
-#include <linux/mmc/slot-gpio.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/interrupt.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/scatterlist.h>
-#include <linux/clk.h>
 
-#include <linux/bitops.h>
-#include <linux/gpio.h>
 #include <asm/cacheflush.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
 
 #include <asm/mach-jz4740/dma.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
-- 
2.16.2
