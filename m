Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:35:17 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34504 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011167AbcAUWemyw5CN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:42 +0100
Received: by mail-lf0-f44.google.com with SMTP id 17so36141540lfz.1
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+2Ygch3p+gP9skM2lWXtVvZikHnCmTbdaPp1aumMFeE=;
        b=v0zZmJVFIQNEw83pUmHS1fQv/pp9Q4mD4E8fQQbPrZPKvipSLqsTa9+I8p5WhJ1hU/
         HKjBNLGUgacQmE2kIRgD19VRJdiiIpydwBS4OAGpL958BSR+igIy9M1Wix/t1MquNUN0
         lYW2Lrh7AvqNRod4k907KzJMLvGad79Ol5kZGYKRH7PjhkXSoZLaW2M85hKLl5ppG9YX
         JnaQ2ZhDSomz0Nt5WKLzmQoXp7lRy+qAyt/MWgoe1jbvgEVfh6a3IrBo5s0GhvvAtchZ
         CSnA6iRIIKrXbypCbqymIDMrAXM0LEtQdGztgearqv7KxKrzCXJ4bMMNjXP5Z9Wc6s1k
         nz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+2Ygch3p+gP9skM2lWXtVvZikHnCmTbdaPp1aumMFeE=;
        b=WnaOR1laUyrbs1pF7h8R45s6yxs5fOTlawtm8TfYM9mNVxxlYlQLJd6IorheBy4HSZ
         exAjoNxkHSGWQHjU3r2X50H0xLQ6953Qu3hv6v2q/gRERrn/oMYInXqX+deQjPJNwbSb
         IAmZD2TLL8okIjPCFqnXcQQABoSiDjbQ9qXt6xSP63N0/YsOVpKlZZbIXFLYeWOGBrtO
         u3F2Wm1kH72U+psfy0yvlPwapDdAVNEXwPTt0YPGijMh+OhhrA6otCsW+Iuu1dyD0lt5
         BxPqIU8wUrI+n4O47n0hY6jyIJw7czlhEoiCqnfcnQp1/onLPs2SuVe9/ooKx4NsvtZs
         qG+A==
X-Gm-Message-State: ALoCoQl1Ifq2T9yBAcv3Fh8sm+07fa2xPwKZ99SZs2LRjeb+RE8mGWqSEFz5H86IJyaMP1xkpTfB9VnUrI6UF6PntHKLp6xGaQ==
X-Received: by 10.25.147.200 with SMTP id v191mr13767860lfd.167.1453415677694;
        Thu, 21 Jan 2016 14:34:37 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:37 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>
Subject: [RFC v2 2/7] WIP: MIPS: ath79: use drivers/clk/clk-ath79.c driver for ar933x
Date:   Fri, 22 Jan 2016 01:34:19 +0300
Message-Id: <1453415664-20307-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51285
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
 arch/mips/ath79/clock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..10bee3b 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -24,6 +24,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	5000000
@@ -167,6 +168,10 @@ static void __init ar933x_clocks_init(void)
 	u32 freq;
 	u32 t;
 
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		return;
+	}
+
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
 		ref_rate = (40 * 1000 * 1000);
@@ -484,7 +489,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
 #endif
-- 
2.6.2
