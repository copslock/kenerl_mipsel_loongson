Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 00:45:22 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:43513 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab2FFWoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 00:44:25 +0200
Received: by dadm1 with SMTP id m1so10165404dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ni9N9RWe6Bj2pj6N64BiuJFd0BFAskmnAv+bPzlVOtA=;
        b=LwTvXlO7nPwcZW45vgtmo5pZbFs9QHuB7KjdNG9dPck9t3s5jfFg5OgNoZFmAHfpxm
         37sx8sytKoNUpGVou1HqTNmGvumluG+NJj6T59XDgEWNQX9V+k2ufIPZW2U6wv4VDQtz
         AxTI3Twg73+1zC6P6hoAnWdRLCx2kHLYC4mPOfmegF/PJ52COwTRCl3N8ExIJ3uBwQWJ
         RBESakAi8tBUminuJCE2CIQo1PgJ9oXBb3xLtV98wjgH3CzwgMO6lHL6hbwUwzEOXxIV
         HhqO37KAyMttfv/43NW2O4YxfFk4JkbhYS7p8i0NMoLlQXbRquB3E84z/23h4V+60qJ/
         as/Q==
Received: by 10.68.231.10 with SMTP id tc10mr1111096pbc.107.1339022659423;
        Wed, 06 Jun 2012 15:44:19 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pq1sm1799666pbb.5.2012.06.06.15.44.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 15:44:18 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56MiGFI019908;
        Wed, 6 Jun 2012 15:44:16 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56MiGbX019907;
        Wed, 6 Jun 2012 15:44:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/3] MIPS: OCTEON: Consolidate the edge and level irq_chip structures.
Date:   Wed,  6 Jun 2012 15:44:15 -0700
Message-Id: <1339022655-19860-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339022655-19860-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339022655-19860-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33579
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
index bccbda9..fac22a8 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -729,18 +729,6 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
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
@@ -754,19 +742,8 @@ static struct irq_chip octeon_irq_chip_ciu = {
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
@@ -993,7 +970,6 @@ static void __init octeon_irq_init_ciu(void)
 {
 	unsigned int i;
 	struct irq_chip *chip;
-	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
 	struct irq_chip *chip_gpio;
@@ -1008,7 +984,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_ip2 = octeon_irq_ip2_v2;
 		octeon_irq_ip3 = octeon_irq_ip3_v2;
 		chip = &octeon_irq_chip_ciu_v2;
-		chip_edge = &octeon_irq_chip_ciu_edge_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
 		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
@@ -1016,7 +991,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
 		chip = &octeon_irq_chip_ciu;
-		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
 		chip_gpio = &octeon_irq_chip_ciu_gpio;
@@ -1046,7 +1020,7 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip_edge, handle_edge_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip, handle_edge_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59, chip, handle_level_irq);
-- 
1.7.2.3
