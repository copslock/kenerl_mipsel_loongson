Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:19:09 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:63483 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903758Ab1LSXQ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:56 +0100
Received: by yenl2 with SMTP id l2so3851999yen.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=82fXj28wcPsM65yHKeGeaQfA61vdmtOW8CHCmE1OhjY=;
        b=rViDqa4v2KfixKKLTJjQle+J/C6my1kQDi6hQ6IUZ6YHCZfuMzx/CxrpPW7mmDqLtn
         P5v692AeerotUc3CkM+OdvVDQaSpHCWmISm+w6bjKPvXA1rmd8HecoRpYqn03uQGorO3
         RjB0JAeCI4BmpisTASXEStDjQXPcGkHH5a9aE=
Received: by 10.236.73.230 with SMTP id v66mr31836794yhd.61.1324336610321;
        Mon, 19 Dec 2011 15:16:50 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id x8sm23538229anh.17.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGlXA029869;
        Mon, 19 Dec 2011 15:16:47 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGltF029868;
        Mon, 19 Dec 2011 15:16:47 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 5/5] MIPS: Move cache setup to setup_arch().
Date:   Mon, 19 Dec 2011 15:16:42 -0800
Message-Id: <1324336602-29812-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
References: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15610

From: David Daney <david.daney@cavium.com>

commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa (jump-label: initialize
jump-label subsystem much earlier) breaks MIPS.  The jump_label_init()
call was moved before trap_init() which is where we initialize
flush_icache_range().

In order to be good citizens, we move cache initialization earlier so
that we don't jump through a null flush_icache_range function pointer
when doing the jump label initialization.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/system.h |    2 +-
 arch/mips/kernel/setup.c       |    3 +++
 arch/mips/kernel/smp.c         |    2 +-
 arch/mips/kernel/traps.c       |    8 +++++---
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index 6018c80..28f16a2 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -222,7 +222,7 @@ extern void *set_vi_handler(int n, vi_handler_t addr);
 
 extern void *set_except_vector(int n, void *addr);
 extern unsigned long ebase;
-extern void per_cpu_trap_init(void);
+extern void per_cpu_trap_init(bool);
 
 /*
  * See include/asm-ia64/system.h; prevents deadlock on SMP
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 84af26a..2e0bb49 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -547,6 +547,7 @@ static void __init resource_init(void)
 	}
 }
 
+extern void cpu_cache_init(void);
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -570,6 +571,8 @@ void __init setup_arch(char **cmdline_p)
 
 	resource_init();
 	plat_smp_setup();
+
+	cpu_cache_init();
 }
 
 unsigned long kernelsp[NR_CPUS];
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 32c1e95..43cd1ed 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -106,7 +106,7 @@ asmlinkage __cpuinit void start_secondary(void)
 #endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
 	cpu_report();
-	per_cpu_trap_init();
+	per_cpu_trap_init(false);
 	mips_clockevent_init();
 	mp_ops->init_secondary();
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0430700..0d55eb8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1508,7 +1508,7 @@ static int __init ulri_disable(char *s)
 }
 __setup("noulri", ulri_disable);
 
-void __cpuinit per_cpu_trap_init(void)
+void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int status_set = ST0_CU0;
@@ -1607,7 +1607,9 @@ void __cpuinit per_cpu_trap_init(void)
 #ifdef CONFIG_MIPS_MT_SMTC
 	if (bootTC) {
 #endif /* CONFIG_MIPS_MT_SMTC */
-		cpu_cache_init();
+		/* Boot CPU's cache setup in setup_arch(). */
+		if (!is_boot_cpu)
+			cpu_cache_init();
 		tlb_init();
 #ifdef CONFIG_MIPS_MT_SMTC
 	} else if (!secondaryTC) {
@@ -1682,7 +1684,7 @@ void __init trap_init(void)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
-	per_cpu_trap_init();
+	per_cpu_trap_init(true);
 
 	/*
 	 * Copy the generic exception handlers to their final destination.
-- 
1.7.2.3
