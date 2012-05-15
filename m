Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:07:04 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:45536 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2EOAFE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:04 +0200
Received: by dadm1 with SMTP id m1so7456808dad.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UfGtMuPzl+I01RZgSJcvJzJK/pAUsJL88XreYVLImUg=;
        b=0R2WLL5dI9z6iwPY663hhfOIrmVbELYSoiFQh6+YRcCGcOmo4xoHVYKyj3vihSrqXU
         5P88AP6HUx58xhs417sq8X9m4m1M6fu7W3f08xVIf2DQ2kPH55FGWfTAmDHgaSanDpVj
         0sFrdP7Q7HL4cyBqSj481B+FzeoY8x16HRtsUBi9WJuSkEcr1+h/IMSzFVU+EQE6sXOw
         h0vdyBPevEJFfebYg3mho6Z2w00L4HMKtEpVZsF0OQp/QwPwSMgnFa6gKAzYA96u2xH8
         ypVhZKuhYq19DojMXO+WOLD7xyTND92SMRHlvlW8FcGzIjUt+3ufvtdRpC3OJRjtPm6V
         /OIw==
Received: by 10.68.234.73 with SMTP id uc9mr4425785pbc.65.1337040297577;
        Mon, 14 May 2012 17:04:57 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id kb12sm23700053pbb.15.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04que016073;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04q4E016072;
        Mon, 14 May 2012 17:04:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
Date:   Mon, 14 May 2012 17:04:50 -0700
Message-Id: <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

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
 arch/mips/include/asm/setup.h |    3 ++-
 arch/mips/kernel/setup.c      |    2 ++
 arch/mips/kernel/smp.c        |    2 +-
 arch/mips/kernel/traps.c      |    9 +++++----
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 6dce6d8..2560b6b 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -14,7 +14,8 @@ extern void *set_vi_handler(int n, vi_handler_t addr);
 
 extern void *set_except_vector(int n, void *addr);
 extern unsigned long ebase;
-extern void per_cpu_trap_init(void);
+extern void per_cpu_trap_init(bool);
+extern void cpu_cache_init(void);
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c504b21..a53f8ec 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -605,6 +605,8 @@ void __init setup_arch(char **cmdline_p)
 
 	resource_init();
 	plat_smp_setup();
+
+	cpu_cache_init();
 }
 
 unsigned long kernelsp[NR_CPUS];
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index ba9376b..dc019a1 100644
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
index 2b5675b..0ba66c0 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1538,7 +1538,6 @@ void *set_vi_handler(int n, vi_handler_t addr)
 	return set_vi_srs_handler(n, addr, 0);
 }
 
-extern void cpu_cache_init(void);
 extern void tlb_init(void);
 extern void flush_tlb_handlers(void);
 
@@ -1565,7 +1564,7 @@ static int __init ulri_disable(char *s)
 }
 __setup("noulri", ulri_disable);
 
-void __cpuinit per_cpu_trap_init(void)
+void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int status_set = ST0_CU0;
@@ -1664,7 +1663,9 @@ void __cpuinit per_cpu_trap_init(void)
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
@@ -1741,7 +1742,7 @@ void __init trap_init(void)
 
 	if (board_ebase_setup)
 		board_ebase_setup();
-	per_cpu_trap_init();
+	per_cpu_trap_init(true);
 
 	/*
 	 * Copy the generic exception handlers to their final destination.
-- 
1.7.2.3
