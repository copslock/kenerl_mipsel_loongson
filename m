Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:01:03 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34346 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012125AbcBITBBxwA3R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:01 +0100
Received: by mail-pa0-f65.google.com with SMTP id yy13so7335499pab.1;
        Tue, 09 Feb 2016 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOI8k4yw/XMwUYGFpXZR5Sz7xBpTRKP0emVwn2oDstQ=;
        b=zqqSE81du7xBHT9/4uDVCmWl8WagFbD7tezQ4LyI0u4l83jBE53BJlvL2z27BNyiMO
         8oypWphAdisy8uyer+CGl2P6zcExwqjwkI7fvaI7ANc5rA2Fyc2wVdI8benP3KEJLtL6
         bp/HEb7utcBYGd7I9zqpNb19Cne140PgehgrrDvuTOXJIDhypVp5ldhRe4LOCU4qCM9t
         YvcprMZkDmtqabo2+ZYNoWFAZQul6g2SfpdFyoVGNtnGpUELr+11UbqxQgHJ3slRROLD
         mWxwYjyMuhZhAOOOSx6zRb3MQ9hLqGAgXLIcq8SlG6jiU06GEU2+Ue6Y50EZYNRpxOof
         iN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOI8k4yw/XMwUYGFpXZR5Sz7xBpTRKP0emVwn2oDstQ=;
        b=V1QmLQVKNtm/xhg2iVe8RY9cszbtScj2X8/8KZaxqmnDe3AICT6qQzgns5j1sAhFNb
         CmUWz6+NoYtXSwJMdCbUPG++9zMTZewfIF2AgO8YJW5RtSXVTG7mx8cHQ3Kj5eM87YgZ
         PH7RkG9/3BtGe350z7+YwE9rvrJOEaRczzyrwvyz91eKhrIyUWkg5mjmN6WKYfrm3BT2
         gIGdS7GHqHIPyWAciZIKubzbNLzOSH61n2QIZsoMwTh33H5AJAGqZbODZgisUTIeWUfk
         ECRMjXjpq8TGFxpo044gw3XRaa8LuonCyA85gvL+mC9bcLIQNSr2c4lSgPfUVHobHN5i
         m49Q==
X-Gm-Message-State: AG10YOQ014HoPMEz5JsnrfuLpR53NVIM1X6PKz0YF7eWa7NEZNNMFh+rgHMmd8RbaDKGbQ==
X-Received: by 10.66.120.200 with SMTP id le8mr52811416pab.61.1455044455826;
        Tue, 09 Feb 2016 11:00:55 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id xv2sm52411592pab.10.2016.02.09.11.00.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:53 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0qAj009872;
        Tue, 9 Feb 2016 11:00:52 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0qOQ009871;
        Tue, 9 Feb 2016 11:00:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/8] MIPS: OCTEON: Remove some code limiting NR_IRQS to 255
Date:   Tue,  9 Feb 2016 11:00:06 -0800
Message-Id: <1455044413-9823-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Follow-on patches for OCTEON III will increase the number of irqs to
potentially more than 256.

Increase the width of the octeon_irq_ciu_to_irq to int to be able to
handle this case.  Remove the hacky code that verified that u8 would
not be overflowed.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 4f9eb05..bc30d3a 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2014 Cavium, Inc.
+ * Copyright (C) 2004-2016 Cavium, Inc.
  */
 
 #include <linux/of_address.h>
@@ -28,7 +28,7 @@ struct octeon_irq_ciu_domain_data {
 	int num_sum;  /* number of sum registers (2 or 3). */
 };
 
-static __read_mostly u8 octeon_irq_ciu_to_irq[8][64];
+static __read_mostly int octeon_irq_ciu_to_irq[8][64];
 
 struct octeon_ciu_chip_data {
 	union {
@@ -1158,16 +1158,6 @@ static struct irq_chip *octeon_irq_ciu_chip;
 static struct irq_chip *octeon_irq_ciu_chip_edge;
 static struct irq_chip *octeon_irq_gpio_chip;
 
-static bool octeon_irq_virq_in_range(unsigned int virq)
-{
-	/* We cannot let it overflow the mapping array. */
-	if (virq < (1ul << 8 * sizeof(octeon_irq_ciu_to_irq[0][0])))
-		return true;
-
-	WARN_ONCE(true, "virq out of range %u.\n", virq);
-	return false;
-}
-
 static int octeon_irq_ciu_map(struct irq_domain *d,
 			      unsigned int virq, irq_hw_number_t hw)
 {
@@ -1176,13 +1166,6 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
 	unsigned int bit = hw & 63;
 	struct octeon_irq_ciu_domain_data *dd = d->host_data;
 
-	if (!octeon_irq_virq_in_range(virq))
-		return -EINVAL;
-
-	/* Don't map irq if it is reserved for GPIO. */
-	if (line == 0 && bit >= 16 && bit <32)
-		return 0;
-
 	if (line >= dd->num_sum || octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
@@ -1215,9 +1198,6 @@ static int octeon_irq_gpio_map(struct irq_domain *d,
 	unsigned int line, bit;
 	int r;
 
-	if (!octeon_irq_virq_in_range(virq))
-		return -EINVAL;
-
 	line = (hw + gpiod->base_hwirq) >> 6;
 	bit = (hw + gpiod->base_hwirq) & 63;
 	if (line > ARRAY_SIZE(octeon_irq_ciu_to_irq) ||
@@ -1899,9 +1879,6 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
 	unsigned int line = hw >> 6;
 	unsigned int bit = hw & 63;
 
-	if (!octeon_irq_virq_in_range(virq))
-		return -EINVAL;
-
 	/*
 	 * Don't map irq if it is reserved for GPIO.
 	 * (Line 7 are the GPIO lines.)
-- 
1.7.11.7
