Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:00:18 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:38197
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeCLV7WUadzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:22 +0100
Received: by mail-qk0-x242.google.com with SMTP id 132so3332230qkd.5
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZ4jZu4j4ZZUd4rgq3nXghDxm0ELYr+1WLnyWSNe0Rw=;
        b=qzNqifFHQwHAB9ZBTB1U350BwdtLcHl8DoWT7X/Dlhem4d+fqV/vNuKPHYuf/7p/R4
         XXI6lzzTlC/Lat7TeKuLvxdO746Di93EJbPq6VYy4pM8fzC1SOQm07aeYBGbWp54ZodZ
         AeDcY0ZbRn0EYm6NG+sqT2pd0MDjHdYDSSg95RjHmIqPgeWgMT3rFYOcEZ8EByr3ouJX
         tY5vkZ5z+n5c7vzkELYOw140YPxuDPeLRz8Y8UN6w8WLl6eGbk+j3wcQm6HPx1IJqXqt
         RMaCfJ+lj5nSqFohYdFVwfJ4cz/GXn/rEioXj8jEy3OgcxGV+nEFP8hC5fpJGqPQxr3E
         lqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZ4jZu4j4ZZUd4rgq3nXghDxm0ELYr+1WLnyWSNe0Rw=;
        b=Hp9GcDVGE434ZpKq5XZOJX9snBXxakjZTsmDAqLHrqzCc9rUtKSTHOptt8ck/i1usZ
         bJSnAf6WNLfhthQWXrp3sEjIbbgQYzYp7ydEUrXhhdPyuOO2TkOY3wANXtQ6op3IdHa/
         9/pfxM7jSLm8j6dlvO0Mxp35rTQzgBGR4bv8c65A8TwG6iVBk6YACoP/rChW9dJRgP7e
         9Rk9v+mfRJqDrzZif7dJjhrtQTRy5Z6qkTaBy43RpBDDVtI3gu6zj+vYEN5hsDah40uZ
         quE/Orm0mVheSQIJdQmfzW47e4jTHaM7gH5QRWNAVD0nOypyK2XG1O7jkuOArMwY26nh
         vjfA==
X-Gm-Message-State: AElRT7FSJiUhi8uqkvWbLg1hECKaSkUFV89aul2TzOcQ6+lfr9vPCtqk
        WIMYRmN1hMfFbHginOovqmyKmQ==
X-Google-Smtp-Source: AG47ELsMhaOnslHETygCjfL8CprxSCyLzcERXUxhjavqa8JHWgQpX3HwgT9MZQJfFyVRQJb1DUIbow==
X-Received: by 10.55.191.1 with SMTP id p1mr14093712qkf.97.1520891956601;
        Mon, 12 Mar 2018 14:59:16 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:15 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 03/14] mmc: jz4780: Order headers alphabetically
Date:   Mon, 12 Mar 2018 18:55:43 -0300
Message-Id: <20180312215554.20770-4-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62934
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
