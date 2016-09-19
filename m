Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 06:40:38 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35851 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbcISEjaQwBhr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 06:39:30 +0200
Received: by mail-pf0-f194.google.com with SMTP id n24so6630209pfb.3
        for <linux-mips@linux-mips.org>; Sun, 18 Sep 2016 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zbys2TN4oO80r3FVBn4g3G85fYi1PFofP8BA4NSdeiY=;
        b=C8oeLnHCLCAUMakqD9DOUxX/BLWpKDBCrJtBKHWSzK3LO784zs6HjEAvYMUA51YueR
         RnsKCSnOhti225ntYe+wKn3tG+NTt1gAfk813X002QfHuOsiWI+mesDSqn+Ax5dBQzWt
         uVbUsSmMekFvr93f6asqvMz1mbQgixBrCTJnwBc9/EdcQZaJXr7NBBqqo9XAHegAqLsc
         GDpr2y+lQtdVACfmZmRlgdTBUGo3WgrJLdlcSqOdTeBWpKHHZ3fHcuxr2rSrJ3xQMg11
         VhmxqCCRY/v2fOnsp++5Pzs8X3fkKwQKE3mDCpVJRHjqenO8z2rM4ony2O8sIX9UOzQv
         XrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zbys2TN4oO80r3FVBn4g3G85fYi1PFofP8BA4NSdeiY=;
        b=FfXjkrPzLmM9dYnV0NMk2/qWCqY7EYyTBqCTQQmksULafVavoNrShjMmyM0xfAG9zn
         KpYOa31R1m/5sDESV++tjlEkUt9GW+9LxVTJd+WxnC2Oq6VOhAsrpvbGF0LPWTM3GSxu
         vOAEqcTr3mNc1+KhhYZ7Gby4zcVhFaVWycFKvLq0qNc/dS6GdPLTXnKFA92YUGHAoe8n
         PT5Zhu8JLmm/a5GzBx4yuFVL1BQm6N2d/YYiFDZx8tPq6KQZ3gAEShjgBQxLeYQ6fUXR
         6v6w4mbKx9QCSAmBbOdrDJ0gAtQwnCbnK2l/xTuzstSRnPW8draE10GFbDho/PjB/Fy6
         AozA==
X-Gm-Message-State: AE9vXwPDunx+LaXbIUlXbCXBecj2fBfusuF3uZKX32tUguaoIfHHnuMt1vgqZgzFhzVVUA==
X-Received: by 10.98.28.146 with SMTP id c140mr39270988pfc.158.1474259964539;
        Sun, 18 Sep 2016 21:39:24 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id p7sm19598950paa.3.2016.09.18.21.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Sep 2016 21:39:23 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 3/3] clk: Loongson1: Make use of GENMASK
Date:   Mon, 19 Sep 2016 12:38:56 +0800
Message-Id: <1474259936-9657-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
References: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55164
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
index 4b3d9d2..f36a97e 100644
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
