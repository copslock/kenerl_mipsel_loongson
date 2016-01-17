Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 00:57:26 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36664 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008389AbcAQX5KEAB-D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 00:57:10 +0100
Received: by mail-lb0-f170.google.com with SMTP id oh2so339170619lbb.3
        for <linux-mips@linux-mips.org>; Sun, 17 Jan 2016 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VtjMTkEtww+ywdylPdl0jEq6D4aAdRi+/zDW+0aio/w=;
        b=HCQEa/KY3ndqH3qT/jzo9V7MF5ffPwoq3IbLyw/ZcoII1qXnk9O0hdMTROr6wSQBpQ
         3DVe9E4Fc57/fLyAm1B4ywXea+KTrzEi78QiJ3A6LmN1GdvHfgSMpPWiv6qo4RityO9F
         nt0P/a9nKgBDGvfZLKDnNjLITcnrYAiMhVBDrxKovwz7fH5BgukORMZDRJPaQcQr3QWN
         /DLxd5DlJAXyPiNWDjW+9rMMEha5qn5b41TmfBmZQZWzxnnWFhrdd4UgFkaIN2I4i7Rx
         sp7t5JtGgf2819Bn9zKvp4yZQhXi4hsUTDxMb8tATs61BuRGqViF8Qjq0Ivc7u+oVT2Y
         T+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VtjMTkEtww+ywdylPdl0jEq6D4aAdRi+/zDW+0aio/w=;
        b=K8HWr49QQh3zoOZAoZ8n5P8DQPp5moCP/YF93gklhYEl2RK/oSoc7i7pA9jgxlObrD
         IJ4720CvY0sQvbSqjs2D39+4aCnl9xXQfq6ZgFdGUYue504eXY/zNbrutBiSEHCoxg6s
         F5JLpS5u+RDxCyUoqokHuvUrcH8lszRdi+I6ZcNFyS0me7eSdh7IS3Cq/B/LBUq4KY6B
         mWpuruXGotTAxGov2d6CjxKz2BACppiMFWD0ogG+6ZUF/SmWYSoknk3Vd0dS9vXBPlpy
         D5mLKIV1rF4ALDwDWhjehmM+yfeIi6y+EAxSey+M3UcobHFfcWNmKM4twopA94jWfB/b
         dv3Q==
X-Gm-Message-State: ALoCoQkzQmThtcHyfQmphL9sieUzQ7VyaQeVgZEcjYrYSsVsFF8PB3giNHe1Wr5ZDPbyC2Q8iq9+kHspgnU8UTLTYrj0glhNVA==
X-Received: by 10.112.184.133 with SMTP id eu5mr5708905lbc.99.1453075024782;
        Sun, 17 Jan 2016 15:57:04 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id xe8sm2783445lbb.41.2016.01.17.15.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 15:57:04 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more devicetree-friendly
Date:   Mon, 18 Jan 2016 02:56:24 +0300
Message-Id: <1453074987-3356-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

At the moment ar933x of-enabled drivers use use clock names
(e.g. "uart" or "ahb") to get clk descriptor.
On the other hand Documentation/devicetree/bindings/clock/clock-bindings.txt
states that the 'clocks' property is required for passing clk
to clock consumers.

This commit prepares ar933x clk code for using 'clocks' property
in the clock consumers code.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/ath79/clock.c                | 20 +++++++++++++-------
 include/dt-bindings/clock/ar933x-clk.h | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..4c20813 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -156,6 +156,10 @@ static void __init ar913x_clocks_init(void)
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
+#include <dt-bindings/clock/ar933x-clk.h>
+
+static struct clk *ar933x_clks[AR933X_CLK_END];
+
 static void __init ar933x_clocks_init(void)
 {
 	unsigned long ref_rate;
@@ -167,6 +171,9 @@ static void __init ar933x_clocks_init(void)
 	u32 freq;
 	u32 t;
 
+	clk_data.clks = ar933x_clks;
+	clk_data.clk_num = AR933X_CLK_END;
+
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
 		ref_rate = (40 * 1000 * 1000);
@@ -209,13 +216,12 @@ static void __init ar933x_clocks_init(void)
 		ahb_rate = freq / t;
 	}
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
+	ar933x_clks[AR933X_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
+	ar933x_clks[AR933X_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	ar933x_clks[AR933X_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	ar933x_clks[AR933X_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ar933x_clks[AR933X_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
+	ar933x_clks[AR933X_CLK_UART] = ath79_add_sys_clkdev("uart", ref_rate);
 }
 
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
diff --git a/include/dt-bindings/clock/ar933x-clk.h b/include/dt-bindings/clock/ar933x-clk.h
new file mode 100644
index 0000000..ed9e5d5
--- /dev/null
+++ b/include/dt-bindings/clock/ar933x-clk.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2014, 2016 Antony Pavlov <antonynpavlov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_AR933X_CLK_H
+#define __DT_BINDINGS_AR933X_CLK_H
+
+#define AR933X_CLK_REF		0
+#define AR933X_CLK_CPU		1
+#define AR933X_CLK_DDR		2
+#define AR933X_CLK_AHB		3
+#define AR933X_CLK_WDT		4
+#define AR933X_CLK_UART		5
+
+#define AR933X_CLK_END		6
+
+#endif /* __DT_BINDINGS_AR933X_CLK_H */
-- 
2.6.2
