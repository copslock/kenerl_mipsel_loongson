Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:02:10 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:62309 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903559Ab2EUGBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:01:16 +0200
Received: by wibhm14 with SMTP id hm14so1744885wib.6
        for <multiple recipients>; Sun, 20 May 2012 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4qc/dbltux3drxkq+ZCpwZnU2EmvK7yviOnaqZkPAr0=;
        b=CdvBXkFi3Iq3PnX8U/xfFR4kWs/aIWBynw2h+Fmfy5s7u47wpU+kNhKIkzouW+CAOY
         VGjGx6Sj6ucdqMj3YVqQk4RMRu3gaww9fK79MmxICiUSXGm+rl5+Kmcc+djrUSeDsu+6
         3aVm2bSu51jMB9Qjotqm7BusLWIHpDS55SfIx6A5HfiWjIMDvX63d57vgbdTG4UerZgR
         FLjFioPFxKQh9gPsvXMX1VaIMNZe2GxfIJwKYkFptcRK0APNBle5WnY33uIYwNz4SN35
         sC6eqfBMLQjORQ/qRUnJJh2UUoNFb+IGIhJ7P/Xi8P2OzZy7BMljt3pKKZkt/8+A/KXE
         IfnQ==
Received: by 10.180.80.228 with SMTP id u4mr20565875wix.5.1337580070930;
        Sun, 20 May 2012 23:01:10 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id n11sm36659446wiv.9.2012.05.20.23.01.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:01:10 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 3/8] MIPS: SMTC: delay irq enable to ->smp_finish()
Date:   Mon, 21 May 2012 14:00:03 +0800
Message-Id: <1337580008-7280-4-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33392
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
Acked-by: David Daney <david.daney@cavium.com>
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
1.7.5.4
