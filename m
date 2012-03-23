Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 23:54:01 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:50067 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903786Ab2CWWv4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 23:51:56 +0100
Received: by yenm10 with SMTP id m10so3641176yen.36
        for <multiple recipients>; Fri, 23 Mar 2012 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tfxRkhSDlGuDiJJiMzO3vcRpXFdwt/UW1p768cYijYg=;
        b=LJoGZHlq4FRRW1gssV/Qg8uVBAkXD7OFLNALfCmcuoT7yiPbpiFl7j6FCu6FLp7AaR
         D1QcF3dDKDZIEfd++QxACohVFEem7Ge3GoXeRJvml8j0h9sRkbfu6Mv9hm5/z7DCXuol
         Sln59vSl/Zpm406GgNEXrJcf8qwWLx+KZ7Ox1fexzEO/zeIy5cKH9YNvysegHtXzty02
         Q4InwW1s95dcxJsye+yDWgdkYOAXuxOW76BnKb/qScLKtFn6CGLg7PmFC6Y6x1IK5aMl
         RNpjL50lggYyYkOg6elMrPcWhOmhoIG/oMA9WlQn2gTwGSp45Nn/y87Z/finXnWetCgg
         riVQ==
Received: by 10.60.3.104 with SMTP id b8mr16364331oeb.13.1332543110242;
        Fri, 23 Mar 2012 15:51:50 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id yw3sm9040790obb.7.2012.03.23.15.51.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:51:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2NMpk3Z019978;
        Fri, 23 Mar 2012 15:51:46 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2NMpkeb019977;
        Fri, 23 Mar 2012 15:51:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] MIPS: OCTEON: Consolidate the edge and level irq_chip structures.
Date:   Fri, 23 Mar 2012 15:51:42 -0700
Message-Id: <1332543102-19922-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

We can consolidate octeon_irq_chip_ciu_edge and octeon_irq_chip_ciu as
they only differ in the .irq_ack element, and that is unused by the
level handler.  This gets rid of a bunch of duplicate definitions.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   30 ++----------------------------
 1 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 7c16bff..89b6f27 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -720,18 +720,6 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable_v2,
 	.irq_disable = octeon_irq_ciu_disable_all_v2,
-	.irq_mask = octeon_irq_ciu_disable_local_v2,
-	.irq_unmask = octeon_irq_ciu_enable_v2,
-#ifdef CONFIG_SMP
-	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
-	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
-#endif
-};
-
-static struct irq_chip octeon_irq_chip_ciu_edge_v2 = {
-	.name = "CIU-E",
-	.irq_enable = octeon_irq_ciu_enable_v2,
-	.irq_disable = octeon_irq_ciu_disable_all_v2,
 	.irq_ack = octeon_irq_ciu_ack,
 	.irq_mask = octeon_irq_ciu_disable_local_v2,
 	.irq_unmask = octeon_irq_ciu_enable_v2,
@@ -745,19 +733,8 @@ static struct irq_chip octeon_irq_chip_ciu = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable,
 	.irq_disable = octeon_irq_ciu_disable_all,
-	.irq_mask = octeon_irq_dummy_mask,
-#ifdef CONFIG_SMP
-	.irq_set_affinity = octeon_irq_ciu_set_affinity,
-	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
-#endif
-};
-
-static struct irq_chip octeon_irq_chip_ciu_edge = {
-	.name = "CIU-E",
-	.irq_enable = octeon_irq_ciu_enable,
-	.irq_disable = octeon_irq_ciu_disable_all,
-	.irq_mask = octeon_irq_dummy_mask,
 	.irq_ack = octeon_irq_ciu_ack,
+	.irq_mask = octeon_irq_dummy_mask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
@@ -984,7 +961,6 @@ static void __init octeon_irq_init_ciu(void)
 {
 	unsigned int i;
 	struct irq_chip *chip;
-	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
 	struct irq_chip *chip_gpio;
@@ -999,7 +975,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_ip2 = octeon_irq_ip2_v2;
 		octeon_irq_ip3 = octeon_irq_ip3_v2;
 		chip = &octeon_irq_chip_ciu_v2;
-		chip_edge = &octeon_irq_chip_ciu_edge_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
 		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
@@ -1007,7 +982,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
 		chip = &octeon_irq_chip_ciu;
-		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
 		chip_gpio = &octeon_irq_chip_ciu_gpio;
@@ -1037,7 +1011,7 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip_edge, handle_edge_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip, handle_edge_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59, chip, handle_level_irq);
-- 
1.7.2.3
