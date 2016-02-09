Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:15:19 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33532 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011672AbcBIIObjMj95 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:31 +0100
Received: by mail-lf0-f49.google.com with SMTP id m1so112107180lfg.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLMVgHNnRyrcOm4kics0S4oqRykVtBoPEVSudvw37uM=;
        b=pB8vRMpnlJXNzjie8aY2Vi6fG8of5UyYffjh3IUfKyfmIxr8mBzNbY+ZJx7fQPHxLQ
         UiIfshanZQ4CKsU1sq81lpBODCKp7jHXU2kB8Lk0GqRQi8CIMwTlpj3UbIUWqDb0O6BX
         +JAc6Z4OHG5TYWy1EK8Hn1duTHjPSTnVdaCyNPvtDzty6i9jnI42nDDdYjcJALkHzzMp
         S3Lp59yORb3bAqLQ8MY1VbGvVY6stHLiZ8BZX4exj+wpVBPiSCD4gig91iQ67MmaccYm
         AEHPihu6A1bp1r8ROy6mhycHi0SNzEDjlECzBGPjsVmC1P5AJAHgRLleDDzx08kR3Oj5
         dYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLMVgHNnRyrcOm4kics0S4oqRykVtBoPEVSudvw37uM=;
        b=C8oynokGwtLugQ/oPP5KQTVcZb1ewfuN9kjb2JtsLHNTZ24jQ6vg9LUk/DV3+r5XK1
         IS05sAScX3PrIe5FX7HshgX3w+Vn9218JNehv8D3b5L/fOu0mOXFlxAflIpfC+NZXPGd
         ixk8x0aDH/1yLNMCPMx53vZxle0tH6nI4CcWlhcertetCJTSuqERyTgDcAOUU08nEdWF
         OIl11V3cYVmoEI5ac/SETLX6E7aS87/gCVsnzJe77d1z9b7KTipfrICC8VEx5103kMnX
         NtpCRRZsPMxPXtaqmiYpFyZn0Ox2/m5E4xh2KLTVCEdRGA5Hm3J8BUAwy10LnuUL2+U6
         I+vQ==
X-Gm-Message-State: AG10YOSQVRW+zqa6uYfVHHvfmV3CR+gBOjBTpTWmGOokTYrWF9EoJ7Xl9lFy9ZiSt20PTQ==
X-Received: by 10.25.153.15 with SMTP id b15mr1353539lfe.136.1455005666405;
        Tue, 09 Feb 2016 00:14:26 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:25 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC v5 03/15] MIPS: ath79: use clk-ath79.c driver for AR933X
Date:   Tue,  9 Feb 2016 11:13:49 +0300
Message-Id: <1455005641-7079-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51879
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
 arch/mips/ath79/clock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..3c98eba 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -24,6 +24,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	5000000
@@ -441,7 +442,9 @@ static void __init qca955x_clocks_init(void)
 
 void __init ath79_clocks_init(void)
 {
-	if (soc_is_ar71xx())
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		/* pass */
+	} else if (soc_is_ar71xx())
 		ar71xx_clocks_init();
 	else if (soc_is_ar724x())
 		ar724x_clocks_init();
@@ -484,7 +487,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
 #endif
-- 
2.7.0
