Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 12:20:18 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:49507 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492127Ab0BALTb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 12:19:31 +0100
Received: by pxi11 with SMTP id 11so4007616pxi.22
        for <multiple recipients>; Mon, 01 Feb 2010 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=neHg06tC7/Qo8R1SH2eZh9Dd5zAxpZcWF7Y/ymje6uc=;
        b=f/wGYH9OR+AmAJ3Nti3OMUgk0EE2stXluPoOkSQCQa6TmozQkpj3jld6s0Tk89qJHp
         0FR1W+xM+sdrN1ai9TJ0x+7i+lTxIyX4zOzXvhKea6wuLuSEQe6AQtX1ULtXNLNxgdHF
         CoI4O7F3bNk44LcjPo5fTE4dSFWnTCDuebPCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dKAFXPsRvrf55JxOYqZOJE6qu6jVJTnSveHUAvmcSPBgz92yHRzzZBO+zYypKicC/t
         Vk/F/vwiE/2oDyjSfZeKGi0UjioouBtSsas4+4DVcoLaCN+k8ptwoR6f751R+na/nwC/
         YOH5bfwNv3qI5YwkljgnFVtD9Gr5of1c1JQZQ=
Received: by 10.142.60.4 with SMTP id i4mr3003776wfa.296.1265023163482;
        Mon, 01 Feb 2010 03:19:23 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm561769pzk.10.2010.02.01.03.19.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 03:19:23 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue v8 3/3] MIPS: r4k: Add a high resolution sched_clock()
Date:   Mon,  1 Feb 2010 19:13:12 +0800
Message-Id: <9b83e460caf96b638c3dec30a2d49bb445797d28.1265022593.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <d1cd5f2c5a8d0cc70ed943a204d83e08f95225f7.1265022593.git.wuzhangjin@gmail.com>
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
 <d1cd5f2c5a8d0cc70ed943a204d83e08f95225f7.1265022593.git.wuzhangjin@gmail.com>
In-Reply-To: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(v7 -> v8:

 O Make it works with the exisiting clocksource_mips.mult,
 clocksource_mips.shift and copes with the 64bit calculation's overflow
 problem with the method introduced by David Daney in "MIPS: Octeon: Use
 non-overflowing arithmetic in sched_clock".

 To reduce the duplication, I have abstracted an inline
 mips_sched_clock() function to arch/mips/include/asm/time.h from
 arch/mips/cavium-octeon/csrc-octeon.c.

 v6 -> v7:

 O Make it depends on !CPU_FREQ and CPU_HAS_FIXED_C0_COUNT

 This sched_clock() is only available with the processor has fixed cp0
 MIPS count register or even has dynamic cp0 MIPS count register but
 with CPU_FREQ disabled.

 NOTE: If your processor has fixed c0 count, please select
 CPU_HAS_FIXED_C0_COUNT for it and send a related patch to Ralf.

 v5 -> v6:

 o hard-codes the cycle2ns_scale_factor as 8 for 30(cs->shift) is too
 big. With 30, the return value of sched_clock() will also overflow quickly.
 o moves the sched_clock() back into csrc-r4k.c as David and Sergei
 recommended.
 o inits c0 count as zero for PRINTK_TIME=y.
 o drops the HR_SCHED_CLCOK option for the current sched_clock() is stable
 enough to replace the jiffies based one.
)

This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
which provides high resolution.

Without it, the Ftrace for MIPS will give useless timestamp information.

Because cnt32_to_63() needs to be called at least once per half period
to work properly, Differ from the old version, this v2 revision set up a
kernel timer to ensure the requirement of some MIPSs which have short c0
count period.

And also, we init the c0 count as ZERO(just as jiffies does) in
time_init() before plat_time_init(), without it, PRINTK_TIME=y will get
wrong timestamp information. (NOTE: some platforms have initiazlied c0
count as zero, but some not, this may introduce some duplication,
perhaps a new patch is needed to remove the initialized of c0 count in
the platforms later?)

This is originally from arch/arm/plat-orion/time.c

This revision works well for function graph tracer now, and also,
PRINTK_TIME=y will get normal timestamp informatin.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig           |   12 +++++++++++
 arch/mips/kernel/csrc-r4k.c |   45 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c     |    5 ++++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8741671..1a76ab7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1933,6 +1933,18 @@ config NR_CPUS
 source "kernel/time/Kconfig"
 
 #
+# High Resolution sched_clock() support
+#
+
+config CPU_HAS_FIXED_C0_COUNT
+	bool
+
+config CPU_SUPPORTS_HR_SCHED_CLOCK
+	bool
+	depends on CPU_HAS_FIXED_C0_COUNT || !CPU_FREQ
+	default y
+
+#
 # Timer Interrupt Frequency Configuration
 #
 
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..89473ba 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,7 +6,9 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/time.h>
 
@@ -22,6 +24,47 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+/*
+ * MIPS sched_clock implementation.
+ *
+ * Because the hardware timer period is quite short and because cnt32_to_63()
+ * needs to be called at least once per half period to work properly, a kernel
+ * timer is set up to ensure this requirement is always met.
+ *
+ * Please refer to include/linux/cnt32_to_63.h, arch/arm/plat-orion/time.c and
+ * arch/mips/include/asm/time.h (mips_sched_clock)
+ */
+unsigned long long notrace sched_clock(void)
+{
+	u64 cnt = cnt32_to_63(read_c0_count());
+
+	if (cnt & 0x8000000000000000)
+		cnt &= 0x7fffffffffffffff;
+
+	return mips_sched_clock(&clocksource_mips, cnt);
+}
+
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+static void cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	sched_clock();
+}
+#endif
+
+static inline void setup_hres_sched_clock(unsigned long clock)
+{
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+	unsigned long data;
+
+	data = 0x80000000UL / clock * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+#endif
+}
+
 int __init init_r4k_clocksource(void)
 {
 	if (!cpu_has_counter || !mips_hpt_frequency)
@@ -32,6 +75,8 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 
+	setup_hres_sched_clock(mips_hpt_frequency);
+
 	clocksource_register(&clocksource_mips);
 
 	return 0;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index fb74974..86cf18a 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -119,6 +119,11 @@ static __init int cpu_has_mfc0_count_bug(void)
 
 void __init time_init(void)
 {
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+		write_c0_count(0);
+#endif
+
 	plat_time_init();
 
 	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
-- 
1.6.6
