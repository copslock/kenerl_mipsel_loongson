Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:11:22 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903643Ab2EQKLA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:11:00 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lBOp6hCI+Fy15gyaqGa1npArgT10Z7hIHbwquryDWfk=;
        b=C/nDSzu6hx2jl19Bsv0bbBNaLceHxQ3QcGUq7B5Apsxb28MAFBQU2aDqq+bV2m5wPi
         XkX226aqpSzFn3fgtprdK4lZAuO/F8V7af1SzLakW9utPUyQ+XQixtYytxyhk2Sf7ApV
         So2gaTDFw81/kbmklGKL9pLJOmkDocSUqA1G2b5Hy7HVrfnNw2nrJA925onM4xkyZn7N
         lv0ysRcPNXduNHG5FikhEbmYUq72ArIM7il66Po57EhDlz26AErYMqHMlOaR5IWz1/UI
         4Yei5r6pKCEATOyyBoKwo5w6LKhWRvamoEIGVpAcWXmYmHc/yD+2rW2mGHISE4Z86G+6
         inxA==
Received: by 10.68.222.134 with SMTP id qm6mr26759691pbc.14.1337249459917;
        Thu, 17 May 2012 03:10:59 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id gl5sm7831283pbc.58.2012.05.17.03.10.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:10:59 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 2/8] MIPS: BMIPS: delay irq enable to ->smp_finish()
Date:   Thu, 17 May 2012 18:10:04 +0800
Message-Id: <1337249410-7162-3-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33343
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
1.7.1
