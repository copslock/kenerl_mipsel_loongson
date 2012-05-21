Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:01:43 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:62783 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903556Ab2EUGBB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:01:01 +0200
Received: by wibhm14 with SMTP id hm14so1822458wib.6
        for <multiple recipients>; Sun, 20 May 2012 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ctq8XlIBhwCRbL/go/aIipBP31rSJYNdySWPF/xlPG8=;
        b=dqJF61O5oCeHYW4uAuhe40jVOOd0hV5n5psae3AINVOBWHqSQaSMiCUjcGUATMszQE
         hCKd9xM/l+j1SfEPAKUjER/Cf5J2im4bvPzNMyaNY5NwB8rWiMvaOVPuaqas01/ts+2o
         HwaAlTrjOAesgVB0Ovnn545JBKY/yKDL+jV2LU0Q6IHotM3DDY7J4DL9HBphzX4nReHt
         dNF7VDuqHMyX9WvIqbBtKVyziPL3SrSJtKVomX33Jxmcl69qalQwWrAe3awtNeagp++V
         7IWP8wEEhY9wgYw9mYEwZ3DFhBwyoOgGDHR2s5ZEDi1pU+0o5wJzSbCw+a6La3kkoS/a
         9Yug==
Received: by 10.180.24.103 with SMTP id t7mr21719518wif.16.1337580056012;
        Sun, 20 May 2012 23:00:56 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id fm1sm23606396wib.10.2012.05.20.23.00.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:00:55 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 2/8] MIPS: BMIPS: delay irq enable to ->smp_finish()
Date:   Mon, 21 May 2012 14:00:02 +0800
Message-Id: <1337580008-7280-3-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

To prepare for smoothing set_cpu_[active|online]() mess up

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/smp-bmips.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 3046e29..298b437 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -197,13 +197,6 @@ static void bmips_init_secondary(void)
 
 	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
 #endif
-
-	/* make sure there won't be a timer interrupt for a little while */
-	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
-
-	irq_enable_hazard();
-	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ1 | IE_IRQ5 | ST0_IE);
-	irq_enable_hazard();
 }
 
 /*
@@ -212,6 +205,13 @@ static void bmips_init_secondary(void)
 static void bmips_smp_finish(void)
 {
 	pr_info("SMP: CPU%d is running\n", smp_processor_id());
+
+	/* make sure there won't be a timer interrupt for a little while */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+
+	irq_enable_hazard();
+	set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ1 | IE_IRQ5 | ST0_IE);
+	irq_enable_hazard();
 }
 
 /*
-- 
1.7.5.4
