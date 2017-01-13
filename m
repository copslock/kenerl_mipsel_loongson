Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 14:14:59 +0100 (CET)
Received: from mail-lf0-x22e.google.com ([IPv6:2a00:1450:4010:c07::22e]:34301
        "EHLO mail-lf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993940AbdAMNOweS7O8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 14:14:52 +0100
Received: by mail-lf0-x22e.google.com with SMTP id v186so37163815lfa.1
        for <linux-mips@linux-mips.org>; Fri, 13 Jan 2017 05:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fy/xJP9Omfrp4mmDXtJ1iZBSYajhhQzVn//A1Wc89Z4=;
        b=PyArgOpZNAvTMNYNbTDrd3G3obQoy4dtQtjgvWCQD+MDnMypeMJU5oRNPCKNl8J2ZM
         QxRTG37JuOb2rH0BsozWtqgMXbM5KJucXpS5esk9g4uhSloZl4Wx1D67+mtr52198MSe
         9+akniSogeb+iNs5u6GSWIj98XwNsMqlzkQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fy/xJP9Omfrp4mmDXtJ1iZBSYajhhQzVn//A1Wc89Z4=;
        b=FX47YUJ1jgK7tEFTosyx6Ibmf4uWODAWi3TtkTQFSJlxfqwAjBytbNpKebGuHgosl1
         jKt7aD/LaZBj5U0CzdYa1lAgOyOy0UdCvpXmho1LEcfa2XLM0pxmaZLFlNxX3y9DRpWo
         0aBdLQO36klgO2IQqrRqgdAi6J5UeT5tBTQ6frAqy5qcsN9m92bBAlTmYe/4Ex5CqKAN
         BEbsat/Qu6gcUfdGTjpjzBXUHmDZWB+c37kW5bB4FY2QQVsEVeiETeZm2lDL01QLOoB0
         Tv9076fHIIk/P42J4AfLWkLtUf7Jg11Hp6Dw92g0XKSrhWkGCAk74t35LIm/HKHLY8pk
         Qx5g==
X-Gm-Message-State: AIkVDXKWC/wo+NWfLPzcjUC/KHpqiKZ3l/fRgnzRPEVoNgd4ZZkAzhOPbu0IzZtJT9v9c8lO
X-Received: by 10.25.156.199 with SMTP id f190mr7435772lfe.166.1484313286887;
        Fri, 13 Jan 2017 05:14:46 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-67.na.cust.bahnhof.se. [155.4.221.67])
        by smtp.gmail.com with ESMTPSA id l67sm2931452lfb.15.2017.01.13.05.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 05:14:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH v3 04/15] MIPS: Alchemy: Don't rely on public mmc header to include interrupt.h
Date:   Fri, 13 Jan 2017 14:14:05 +0100
Message-Id: <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

The MIPS Alchemy db1300 dev board depends on interrupt.h. Explicitly
include it instead of relying on the public mmc header host.h.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I am seeking an ack for this change as following changes for mmc in the
series, has build-dependencies to it.

---
 arch/mips/alchemy/devboards/db1300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index d3c087f..a5504f5 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
-- 
1.9.1
