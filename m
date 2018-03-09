Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:13:37 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:43795
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994808AbeCIPNP5-7fw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:15 +0100
Received: by mail-qt0-x243.google.com with SMTP id d26so11014652qtk.10
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4n7rgGpd33K41Gq9tlRc0j1oYUMsEYBnheQkNdJ0F+s=;
        b=MiG1uUSs7qNnp7TYkJLnl5Yv7I91yeYeYukig/tP9BpgEMzcgzDAI7P3DmP1LH4E+r
         gfp3bGyBiNhmadUT98+tn+FkvjPKGrUzr5HbwBI+FaE5RqkA2lEj/BCecK4cpSjUekF8
         rxM396gZ7xU85Q8H+6DlWzxRhB2EiKWQ/ZG6MEPcRDbmdoRS+9DUegs/nqGynqdUrQQO
         6yYlbhXByei+RshNZeTjRUKHuqGpE+JjoRsFe9d7DN7UYSB6R0Pariro7FUCidTVutcw
         fNSOxsUVqSKglmh0WPNTUq943mocwab6o7TsKngm30bSeIt6lB0r/co4df2ubaqKy8mY
         X45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4n7rgGpd33K41Gq9tlRc0j1oYUMsEYBnheQkNdJ0F+s=;
        b=SfFst3uoATIif3d1gIvF2tiZ0Xyu8PFrrlWBUjW3Wl+jfS34SO+8QFDSHrNXFmYJXT
         7sFGDy6L6eUQIIYT65Mz6TUBttZ2hx9019MAbB1u2gj8PljhGnUzyWhqqddGU03/rDNh
         C6J7FPFnW3NbA+GmMyqXwPseSTGDipIEDCw5+EdT8fOu+9ExqSrZ7XVhbMktEH646aKv
         wiPgsKDQGcWV/P8iM2uLiG/HkMABFZ46mp5l+cEuy7UPxz+UMhBNZ+JI/Fkl4rp3S9Ur
         o/Lt+6CAgQMexYWBlPhXSl4MycfXr3c5/BCxRkhfZhxeuVuqY3r93mJzE8pKu3mDXykw
         njqQ==
X-Gm-Message-State: AElRT7GbyjvcxCEwKm3E9U5y8GTOtd7QU5P7ZzsAdxu/kaI5FZ0YK+wB
        p6Hp15ZBN6Wex4JHFfHmARrXZg==
X-Google-Smtp-Source: AG47ELvGBYr3pm8GsU7kmZYKBgfFdcbelfk01jte32Kd5ONB5UhYyQg9TPXB+snsRsqM1XEjTbdfCg==
X-Received: by 10.200.8.56 with SMTP id u53mr48257616qth.315.1520608390191;
        Fri, 09 Mar 2018 07:13:10 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:09 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 01/14] mmc: jz4780: Order headers alphabetically
Date:   Fri,  9 Mar 2018 12:12:06 -0300
Message-Id: <20180309151219.18723-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62878
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

Just a minor cleanup to order the headers alphabetically.
This helps prevent merge conflicts.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 712e08d9a45e..8da2bfe82781 100644
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
