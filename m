Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:35:25 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36513 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab2D0Scz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:55 +0200
Received: by pbbrq13 with SMTP id rq13so1412689pbb.36
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U65mD96smMNdVPUVPLzIKPdlFkx1IpiF+80Kds/P3Qw=;
        b=oySMFTZrX3/6Kus4/5Xl2MJVcX0ENFsOYpEAKUqmF4ce4jY8Q2evNk1K79BQk7IR88
         coR/ZMHjf07pdHuDp/95pYqtfwWflGrp8v7Pnz8lb8olqMuLU/6UAHFmPQLYlDdR3lNT
         mDh4aFdIobnIf8Hn3AyaJyZHO5NraDfcBRy2UUoQgXx5RMx5jUr3aQTwIhlCm5HFtuiT
         yAuG/zbLJsFhDecGjV6uQTPZMIVH1gd3TMPw5jTzPH0+Q7ScBElhpqYTbTYeP7xN5SE+
         xIur9WRFJ3cpNvxOP2gRztTkxGfzT+q8/3EW7Z+wrpKiBcK4LqaGhYg1BS88n2xPferT
         eYTg==
Received: by 10.68.129.130 with SMTP id nw2mr8161992pbb.133.1335551568566;
        Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l1sm7160153pbe.54.2012.04.27.11.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWjoP019654;
        Fri, 27 Apr 2012 11:32:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWjfm019653;
        Fri, 27 Apr 2012 11:32:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 8/8] MIPS: OCTEON: Don't refer to  octeon_irq_cpu_offline_ciu() when !CONFIG_SMP
Date:   Fri, 27 Apr 2012 11:32:40 -0700
Message-Id: <1335551560-19581-9-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

... It is not defined in this case.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 1eb4461..da40e66 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -761,8 +761,8 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
 	.irq_unmask = octeon_irq_ciu_enable_v2,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
-#endif
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
 };
 
 static struct irq_chip octeon_irq_chip_ciu = {
@@ -774,8 +774,8 @@ static struct irq_chip octeon_irq_chip_ciu = {
 	.irq_unmask = octeon_irq_ciu_enable,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
-#endif
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
 };
 
 /* The mbox versions don't do any affinity or round-robin. */
@@ -1479,8 +1479,8 @@ static struct irq_chip octeon_irq_chip_ciu2 = {
 	.irq_unmask = octeon_irq_ciu2_enable,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
-#endif
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
 };
 
 static struct irq_chip octeon_irq_chip_ciu2_mbox = {
@@ -1513,8 +1513,8 @@ static struct irq_chip octeon_irq_chip_ciu2_gpio = {
 	.irq_set_type = octeon_irq_ciu_gpio_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
-#endif
 	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
 	.flags = IRQCHIP_SET_TYPE_MASKED,
 };
 
-- 
1.7.2.3
