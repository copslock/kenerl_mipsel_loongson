Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:34:51 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:65479 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903630Ab2D0Scz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:55 +0200
Received: by dakb39 with SMTP id b39so1178940dak.35
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B5FbCdM1miJcjmn5rRMuyw1cVDwXpYM5ZJQFzaunAGY=;
        b=ACV3Wc1MnXsftMf7XVBF5BL71x4F+fWTfOuHk26Gn/7LCHeH2jj70AKowEIWRBrztc
         6yVUC0LZEZHaIllzfx6AQalIjxg9/qKg/AS7B7VuUEaSrZGSuoUC9PjbyKSuWWrVEDi3
         Rtdv7t9V9HdzZqnQOy5OaaGRYO/KoTz78As8cIXxzMcF9OL/+9TME4FL/G2o2mB7H/sP
         hyA1RLSIxxNfVj1jZ2/+NlBTUbqHb1l4lGupLCIYnjZJiW3mg87sduIwl5kKRjHgBZkD
         iU7k4nogoPrF1gY0Oyu2EC936FH+tOuzOm/C0/GaemPMbqgQNHAzfLZkiWkLC3B1raqf
         irmQ==
Received: by 10.68.218.72 with SMTP id pe8mr25505508pbc.45.1335551568793;
        Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ph10sm7185964pbb.2.2012.04.27.11.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWjTD019634;
        Fri, 27 Apr 2012 11:32:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWjVr019633;
        Fri, 27 Apr 2012 11:32:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 3/8] MIPS: OCTEON: Fix GPIO interrupt configuration.
Date:   Fri, 27 Apr 2012 11:32:35 -0700
Message-Id: <1335551560-19581-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The GPIO bit number is a fixed displacement (16) from the
corresponding CIU bit, and has no relation to the irq number nor
OCTEON_IRQ_GPIO0.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index f3d27ec..4d424ea 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -511,9 +511,11 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
 static void octeon_irq_gpio_setup(struct irq_data *data)
 {
 	union cvmx_gpio_bit_cfgx cfg;
-	int bit = data->irq - OCTEON_IRQ_GPIO0;
+	union octeon_ciu_chip_data cd;
 	u32 t = irqd_get_trigger_type(data);
 
+	cd.p = irq_data_get_irq_chip_data(data);
+
 	cfg.u64 = 0;
 	cfg.s.int_en = 1;
 	cfg.s.int_type = (t & IRQ_TYPE_EDGE_BOTH) != 0;
@@ -523,7 +525,7 @@ static void octeon_irq_gpio_setup(struct irq_data *data)
 	cfg.s.fil_cnt = 7;
 	cfg.s.fil_sel = 3;
 
-	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), cfg.u64);
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), cfg.u64);
 }
 
 static void octeon_irq_ciu_enable_gpio_v2(struct irq_data *data)
@@ -548,24 +550,31 @@ static int octeon_irq_ciu_gpio_set_type(struct irq_data *data, unsigned int t)
 
 static void octeon_irq_ciu_disable_gpio_v2(struct irq_data *data)
 {
-	int bit = data->irq - OCTEON_IRQ_GPIO0;
-	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
+	union octeon_ciu_chip_data cd;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), 0);
 
 	octeon_irq_ciu_disable_all_v2(data);
 }
 
 static void octeon_irq_ciu_disable_gpio(struct irq_data *data)
 {
-	int bit = data->irq - OCTEON_IRQ_GPIO0;
-	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
+	union octeon_ciu_chip_data cd;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), 0);
 
 	octeon_irq_ciu_disable_all(data);
 }
 
 static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
 {
-	int bit = data->irq - OCTEON_IRQ_GPIO0;
-	u64 mask = 1ull << bit;
+	union octeon_ciu_chip_data cd;
+	u64 mask;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	mask = 1ull << (cd.s.bit - 16);
 
 	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
 }
-- 
1.7.2.3
