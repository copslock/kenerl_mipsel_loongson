Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:43:29 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36437 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014856AbcBEAnOAgwYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:14 +0100
Received: by mail-pf0-f193.google.com with SMTP id n128so4498440pfn.3;
        Thu, 04 Feb 2016 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOI8k4yw/XMwUYGFpXZR5Sz7xBpTRKP0emVwn2oDstQ=;
        b=zqXqBz7+5I3UC6PN+7qcVplfsDrdq6k8zwopFA9kmKL+rFJ+ujbC/3C7IPwF7znlxE
         WBnhDMBqFGIy3RhGS1o1snaNgrpetsQragggvKE1XorPctPDBjepVzvyonvNOoNhX6J6
         cyBzD14UmXSBkDcPAkoNvL2W1ldveT6G5tpABFWhAKCxKI65uzTGp22mmFLb4GZLrtUH
         7wnkwP2t8WHfOcPrUBaQt3xECc8l8/DLQLQ4MIsHACSwkh8uk/JBiyJLlG8xga75Ifof
         UlwvK4DRNzokw1aqWWJ/6ZG81hzaP+6KmN8UnhvdmR7tlUW8yD0eF9EH7pr12AEO6wST
         j5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOI8k4yw/XMwUYGFpXZR5Sz7xBpTRKP0emVwn2oDstQ=;
        b=FKLaAKRHloyI9zcUkzQYC01oFYn/D/irRCcGrHop+muAfJGBe+XX/sDZQBL54ziXOB
         vM7GEn43AFK/cFpvkILmgUwYfcmJYGz/qCijKmrvTZ8RtUGu7uVktcHbOdb0IeEL7K/q
         98a8PGubewXsD8NUXry26QP1VVUlbcEI3YnWM5kchyIdFrVVuG/Jx3oONXV71PHOKaRY
         HiE13nTQHiDMXJTnZ6KxlkocziIwoLMzW0xE3RkyfJPw4Uf7kHufrZ/oUFUeTovq+vai
         r2tnTpcDEr16EqE5Z210KysIan9nw94MkmUC578d5GOQdv89MfvDEEZqZjZqk8tPPe4k
         +VmA==
X-Gm-Message-State: AG10YOQYtGzU2ZwUG1ReieR6+zlRo2SRTGwNU5Vg/pKa+zcuAJo86pr+tC1vSxetb6/R1g==
X-Received: by 10.98.11.9 with SMTP id t9mr15500332pfi.71.1454632988030;
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id m5sm19735227pfi.84.2016.02.04.16.43.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:04 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h3ha007731;
        Thu, 4 Feb 2016 16:43:03 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h3nE007730;
        Thu, 4 Feb 2016 16:43:03 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/7] MIPS: OCTEON: Remove some code limiting NR_IRQS to 255
Date:   Thu,  4 Feb 2016 16:42:48 -0800
Message-Id: <1454632974-7686-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51795
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
