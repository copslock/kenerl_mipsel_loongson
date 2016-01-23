Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:18:26 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36584 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010585AbcAWURuDhpId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:50 +0100
Received: by mail-lb0-f173.google.com with SMTP id oh2so56903641lbb.3
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cv8wLVwKUUApcGRHx0S+vEQieNb0PCy34Vj2yZ3Ixp0=;
        b=SzmrflRBGD+P2M6fmax1af50QTI9cwJF+Jh9NL8EVMIBqBh/GV03XWcqGliflrpEpw
         ZqHJ0MsLbFI1RkKlVYXUbQeCx4ngdtt6kLw61gUmGYge4QiT1KJ/kk8QOWdSFDbMW/y5
         FyKSChtl5zmv7v0lj5NMRNVhM+W3MnKxXKOdYe1MgRY6maJHbAG7V0Y527dX30N11MlI
         WINeiaGIXgJXYx4yGZMB+CzP6UbNOPGsQRcAuczZYUCFymEYTCUc4/RDbwm2Fjn5IIdp
         c5+97O4O6iPiGiAx28uI/tBJzTrzSHu+pVf4lvBcqwxPbrDQox11Qu0qWlaooTnbe5VX
         onkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cv8wLVwKUUApcGRHx0S+vEQieNb0PCy34Vj2yZ3Ixp0=;
        b=L4e0hyfatSElh6MHjBK/A5Swq40DzzPP4YrNrQTC8zdKOIHKX78Gpt4Nn28Yp7kwns
         88+kxlP00sNW1QKDlAJ+lzWUhIlp8jFdXEySDadj9Mw3Moh2kz9ytgOzCvNKQvhgB3uw
         Ut3QVLnnAMvdyi+mouJhsNRTKy2bTmXoygx8/CVxcRWN3wiAw2Smwq80RqCNun5UVY3i
         eLdFT/KIBn0nTZwAPcGgnSTX8PzOWubhRYHG8rqmrPveyQKyPjOBucyhspHS8xXfC/F2
         IkqP11YPHxoacObccBbHP+uzrudtyTfV2vvWcV0KEAzAHe3DbWudAk6PeOPhCVyEc8ki
         snTw==
X-Gm-Message-State: AG10YOQNMTw8j8QrqKpdbnQueZaAyHGHWGDfEvPvt6ZwaIRNrxf3VMe3rTLV9IvY49qMOg==
X-Received: by 10.112.149.230 with SMTP id ud6mr3511953lbb.12.1453580264770;
        Sat, 23 Jan 2016 12:17:44 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:44 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>
Subject: [RFC v3 02/14] MIPS: ath79: use clk-ath79.c driver for AR913X/AR933X
Date:   Sat, 23 Jan 2016 23:17:19 +0300
Message-Id: <1453580251-2341-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51328
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/clock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..8a287bf 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -24,6 +24,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	5000000
@@ -133,6 +134,10 @@ static void __init ar913x_clocks_init(void)
 	u32 freq;
 	u32 div;
 
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		return;
+	}
+
 	ref_rate = AR913X_BASE_FREQ;
 	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
 
@@ -167,6 +172,10 @@ static void __init ar933x_clocks_init(void)
 	u32 freq;
 	u32 t;
 
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		return;
+	}
+
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
 		ref_rate = (40 * 1000 * 1000);
@@ -483,8 +492,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
 #endif
-- 
2.6.2
