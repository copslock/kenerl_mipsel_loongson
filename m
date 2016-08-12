Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:53:25 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33041 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993264AbcHLKwYPCnJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:52:24 +0200
Received: by mail-pf0-f195.google.com with SMTP id i6so1383430pfe.0
        for <linux-mips@linux-mips.org>; Fri, 12 Aug 2016 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skjjA/cDkM7BtWu5ygE35Wbq8oqFXWrVZBzu865+Vqk=;
        b=0uMIbLmPHyU+HV1U2f+mObrllbAIh1XmFIzdLEfwRDBRmhDuzpcwqUohApP1T6iaee
         meqy8mQpRz2VZR9o8G2rWMh6dn0YptQloQW4X3KZZ8lEDn/iBSfLa0aIriNAIiSFV+iX
         zUiq17pCnunPmlFzVrS4g0s5EL6WybZ/gmiAOiTSW2pJhiLyXgPFPA9zO4Wxi+6t87BY
         0F4XJvEDiI0AzlAKwgn9cXopibLWaQDrblDYv44vS/I4zHvr+gCwYR8ypQR989+LRrY/
         RscyXVzP/QbPSTdP35xMtgSk9l2COw6VkgtiqE30LosR9NzG+86nIjdjDLD04XEazacO
         w4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skjjA/cDkM7BtWu5ygE35Wbq8oqFXWrVZBzu865+Vqk=;
        b=RwpWGFd+TF752JdGsog/Jj2Yimve35I0fRWgHxYEH/V3vP4K4ZzCbZdI6JalFRu/J0
         6QXecUYji3DCK9HwiTGruL2anulj0QDhfqU6hWeauRtG8/yjqZse/jE9etdQWgP//eH7
         UdhMgsWDIaZfC9+N83lnr2DpJeN549c7hdXJTodriHcpNsnGfQs2PcO7kd0SDMUCt+jO
         7oAxm4pUC2DCBa0Ox3Jylyi8Zlyznz43eLChP2uuHxcNXtBiUcQtvgENFvEIjDOfl5mF
         /avKgpmzXcn/7xLioNdb2mYXbaaMlZ4lVoikGCmedPUzAOZ1wUPl/JbQKRdGdqhukEnK
         H0HA==
X-Gm-Message-State: AEkooutBvOkRrVEWpybZbTZpH+AFmUa58tlF4DwR9Zb+YypLg9Xn9PfZWxDbNTxxvdbC2Q==
X-Received: by 10.98.60.217 with SMTP id b86mr25975419pfk.129.1470999138525;
        Fri, 12 Aug 2016 03:52:18 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id k78sm12034940pfa.78.2016.08.12.03.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 03:52:17 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 3/3] clk: Loongson1: Make use of GENMASK
Date:   Fri, 12 Aug 2016 18:51:48 +0800
Message-Id: <1470999108-9851-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
References: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

Make use of GENMASK instead of open coding the equivalent operation,
and update the PLL formula.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/loongson1/clk-loongson1b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index 2302ee5..5cedb28 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -26,7 +26,7 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
+	rate = 12 + (pll & GENMASK(5, 0));
 	rate *= OSC;
 	rate >>= 1;
 
-- 
1.9.1
