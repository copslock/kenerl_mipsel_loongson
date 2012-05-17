Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:11:47 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50802 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903707Ab2EQKLM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:11:12 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so2660880pbb.36
        for <multiple recipients>; Thu, 17 May 2012 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=u3t54XALBywwMrcxYP5Mdmn+lW5KBF/X5G4OHWdvo8s=;
        b=juB+TKgixU8WJ03/hszp4r5PytPcdKVDsanN3dr9aRnxHxrdFrN9CW583UtVoUi+xZ
         7Wu9uaL8yqIkHRbc8FjfwEO/tkpLAa+87j7CjUWO6zXANXswsAbb2ajnGpQXYV0sbMbN
         kaCDxvJZg9TbuQEPyts84gx+u5Cusj/Y8fWExno2+z/9lk6m75LvcwamgmbQH9wq41LN
         7NXNRU4wscUhodH3zCFZxhNVWBPnQ1/G3j8lM7CrMMI/6o2e5NsyW7SFZmxX/HeqdW/p
         4XRojy6UJAeCBK651dC8cCoZ8tAnIVMg7Zx+wTS6b4de/3QdjYT8seTXYwbipEn15AOy
         1NPA==
Received: by 10.68.197.99 with SMTP id it3mr6358949pbc.148.1337249471525;
        Thu, 17 May 2012 03:11:11 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id ny10sm8646819pbb.38.2012.05.17.03.11.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:11:10 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 3/8] MIPS: SMTC: delay irq enable to ->smp_finish()
Date:   Thu, 17 May 2012 18:10:05 +0800
Message-Id: <1337249410-7162-4-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33344
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
---
 arch/mips/kernel/smtc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index f5dd38f..af46fdd 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -615,7 +615,6 @@ void __cpuinit smtc_boot_secondary(int cpu, struct task_struct *idle)
 
 void smtc_init_secondary(void)
 {
-	local_irq_enable();
 }
 
 void smtc_smp_finish(void)
@@ -631,6 +630,8 @@ void smtc_smp_finish(void)
 	if (cpu > 0 && (cpu_data[cpu].vpe_id != cpu_data[cpu - 1].vpe_id))
 		write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
 
+	local_irq_enable();
+
 	printk("TC %d going on-line as CPU %d\n",
 		cpu_data[smp_processor_id()].tc_id, smp_processor_id());
 }
-- 
1.7.1
