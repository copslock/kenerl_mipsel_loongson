Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 07:07:59 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:62061 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491016Ab0JTFHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 07:07:06 +0200
Received: by gwj17 with SMTP id 17so1453020gwj.36
        for <multiple recipients>; Tue, 19 Oct 2010 22:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=95SeNBkG+hazknTGrAxsJdH9zZJdwGQ7M2FI76qk7UU=;
        b=Uk2P6zaTRt6tAOHl5TmayaJx4jBnHGqXU+2M/JxT5VdRk8oDI6I2aQtzJl7T7aYK1T
         5Dg23MlOkqwIB9HxlcDPw/kESJZDti8uBzI4WzN5udZ5XXcsVLXsGeeXEJ5OoQP/C58Y
         dCzY2mkX3jL77y19aD4SETB0dJIkjE20UXc+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fdrD6H3EVT0zn8KRTr+u1wrV1da+FDVE4KR4EP/TpPBu0O3RdwafVUluFiO7k5vESp
         H57AN5zsKmxWLStaWb1thnrXT5QfEYg+H0+mEtWwH/EyEIx1Fs7Fq/pUcBUTHXPFVoV0
         6ew7JGAtzl1+OVD+UIQ3rfAzBYzRYCbhbLxcM=
Received: by 10.151.143.15 with SMTP id v15mr506388ybn.81.1287551218268;
        Tue, 19 Oct 2010 22:06:58 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id v12sm886191ybk.11.2010.10.19.22.06.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 22:06:57 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kevink@paralogos.com
Cc:     eyal@mips.com, dengcheng.zhu@gmail.com
Subject: [PATCH 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
Date:   Wed, 20 Oct 2010 13:10:30 +0800
Message-Id: <1287551431-15737-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1287551431-15737-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1287551431-15737-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch makes 34K APRP (also known as APSP) works. Also, it allows the
RP side to run floating point heavy jobs and uses interrupt to wake up RP
side read. These functionalities need proper RP code to work correctly.

For a 34Kf core, currently we simply disable the FPU on the AP side. And RP
will init it and use it exclusively.

Sample programs were created and tests had been done sucessfully.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                                  |    8 +++++
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 ++
 arch/mips/kernel/rtlx.c                            |   34 +++++++++++++++++---
 arch/mips/kernel/vpe.c                             |    4 +-
 arch/mips/mti-malta/malta-int.c                    |   22 ++++++++++++-
 5 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fbaf08e..c73a07d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1756,6 +1756,14 @@ config MIPS_VPE_LOADER_TOM
 	  you to ensure the amount you put in the option and the space your
 	  program requires is less or equal to the amount physically present.
 
+config MIPS_SP_FP_INTENSIVE
+	bool "SP is used for running FP-intensive jobs"
+	depends on MIPS_VPE_LOADER
+	help
+	  If you intend to use the SP to run FP-intensive jobs, you probably
+	  want to say yes here. Your FPU will then be exclusively used by the
+	  SP, and the Linux on the AP side will not see the FPU.
+
 # this should possibly be in drivers/char, but it is rather cpu related. Hmmm
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
index 2848cea..26cc064 100644
--- a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
@@ -17,6 +17,9 @@
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
+#ifdef CONFIG_MIPS_SP_FP_INTENSIVE
+#define cpu_has_fpu		0
+#endif
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 26f9b9a..1c2e156 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2005, 2010 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -56,12 +56,15 @@ static struct chan_waitqueues {
 
 static struct vpe_notifications notify;
 static int sp_stopping;
+static void (*save_aprp_dispatch)(void);
 
 extern void *vpe_get_shared(int index);
+extern void (*aprp_dispatch)(void);
 
 static void rtlx_dispatch(void)
 {
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
+	if (read_c0_cause() & read_c0_status() & C_SW0)
+		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
 }
 
 
@@ -345,6 +348,18 @@ out:
 	return count;
 }
 
+static void _interrupt_sp(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	dvpe();
+	settc(1);
+	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
+	evpe(EVPE_ENABLE);
+	local_irq_restore(flags);
+}
+
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
 	struct rtlx_channel *rt;
@@ -385,6 +400,8 @@ out:
 	smp_wmb();
 	mutex_unlock(&channel_wqs[index].mutex);
 
+	_interrupt_sp();
+
 	return count;
 }
 
@@ -526,9 +543,15 @@ static int __init rtlx_module_init(void)
 	notify.stop = stopping;
 	vpe_notify(tclimit, &notify);
 
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
+	if (cpu_has_vint) {
+		/*
+		 * set_vi_handler() doesn't work in some cases: When sw0
+		 * gets set, a hw interrupt is signaled as well. Here we
+		 * are hooking it into platform specific dispatch.
+		 */
+		save_aprp_dispatch = aprp_dispatch;
+		aprp_dispatch = rtlx_dispatch;
+	} else {
 		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
 		goto out_chrdev;
@@ -554,6 +577,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
+	aprp_dispatch = save_aprp_dispatch;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 2bd2151..d0e757a 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2004, 2005, 2010 MIPS Technologies, Inc.  All rights reserved.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -192,7 +192,7 @@ static struct tc *get_tc(int index)
 	}
 	spin_unlock(&vpecontrol.tc_list_lock);
 
-	return NULL;
+	return res;
 }
 
 /* allocate a vpe and associate it with this minor (or index) */
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index b79b24a..0fec7b2 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -1,6 +1,6 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2000, 2001, 2004, 2010 MIPS Technologies, Inc.
  * Copyright (C) 2001 Ralf Baechle
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -30,6 +30,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
+#include <linux/module.h>
 
 #include <asm/traps.h>
 #include <asm/i8259.h>
@@ -117,6 +118,16 @@ static inline int get_int(void)
 	return irq;
 }
 
+#ifdef CONFIG_MIPS_VPE_APSP_API
+static void null_aprp_dispatch(void)
+{
+}
+
+void (*aprp_dispatch)(void) = null_aprp_dispatch;
+
+EXPORT_SYMBOL(aprp_dispatch);
+#endif
+
 static void malta_hw0_irqdispatch(void)
 {
 	int irq;
@@ -128,6 +139,15 @@ static void malta_hw0_irqdispatch(void)
 	}
 
 	do_IRQ(MALTA_INT_BASE + irq);
+
+#ifdef CONFIG_MIPS_VPE_APSP_API
+	/*
+	 * When sw0 gets set, a spurious hw interrupt is signaled as well.
+	 * The sw0 will not be handled until the hw interrupt is cleared.
+	 * We use the hook to handle sw0 and the hw interrupt gets cleared.
+	 */
+	aprp_dispatch();
+#endif
 }
 
 static void malta_ipi_irqdispatch(void)
-- 
1.7.0.4
