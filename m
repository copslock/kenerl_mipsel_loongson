Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 18:40:00 +0200 (CEST)
Received: from mail-qy0-f193.google.com ([209.85.221.193]:64437 "EHLO
        mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492451Ab0DOQjR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Apr 2010 18:39:17 +0200
Received: by qyk31 with SMTP id 31so1605991qyk.20
        for <multiple recipients>; Thu, 15 Apr 2010 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=igA0X9v1WXPupNGpA7+1h5LTmrdMaeVdBLpiAFHNN5g=;
        b=vsLX5NCd65Y/dOUYu2UYD9yLxRrwWYOkpJuXImZii9W8vkhLDRIdnle/4YGmtm44vB
         f5yx+gS+B5X5NQXkmSMUpCD+U4dEEcXX2s0PT8WLS1Ysnq1jbUN41xrOYFUHVFqwBL45
         mcHylXV71iXaAbLVfChbeTc9fo4Sk+xiC20LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=TK3pPJF8B3omEIaCNo/9XoCSx6J/w35rtUKZCytfPXMD4G0FpsLHsefsBSfS2j2534
         40K7kOt888mxkl/D6sb4KdzAG950Y6YBclKZo8if02jz+GAYIEJ5ls3NXm2iqREV384t
         Ndl5Qobe3Kcq0VYZ8Ky6nMUiQ1o8h+UYm1aX8=
Received: by 10.229.227.5 with SMTP id iy5mr268342qcb.29.1271349549355;
        Thu, 15 Apr 2010 09:39:09 -0700 (PDT)
Received: from [192.168.1.101] ([114.84.94.52])
        by mx.google.com with ESMTPS id w30sm1892903qce.4.2010.04.15.09.39.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 09:39:08 -0700 (PDT)
Subject: [PATCH 2/3] MIPS: adding support for software perf events
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Apr 2010 00:39:00 +0800
Message-ID: <1271349540.7467.423.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the minimal support for the SW perf events, required as a part of
the measurable stuff by the Linux performance counter subsystem.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                  |    2 ++
 arch/mips/include/asm/perf_event.h |   28 ++++++++++++++++++++++++++++
 arch/mips/mm/fault.c               |   11 +++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7161751..cf33418 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,8 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_PERF_EVENTS
+	select PERF_USE_VMALLOC
 	select GENERIC_ATOMIC64
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/mips/include/asm/perf_event.h b/arch/mips/include/asm/perf_event.h
new file mode 100644
index 0000000..bcf54bc
--- /dev/null
+++ b/arch/mips/include/asm/perf_event.h
@@ -0,0 +1,28 @@
+/*
+ * linux/arch/mips/include/asm/perf_event.h
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MIPS_PERF_EVENT_H__
+#define __MIPS_PERF_EVENT_H__
+
+extern int (*perf_irq)(void);
+
+/*
+ * MIPS performance counters do not raise NMI upon overflow, a regular
+ * interrupt will be signaled. Hence we can do the pending perf event
+ * work at the tail of the irq handler.
+ */
+static inline void
+set_perf_event_pending(void)
+{
+}
+
+#endif /* __MIPS_PERF_EVENT_H__ */
+
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index b78f7d9..5987d2b 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>
+#include <linux/perf_event.h>
 
 #include <asm/branch.h>
 #include <asm/mmu_context.h>
@@ -132,6 +133,7 @@ good_area:
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -139,10 +141,15 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR)
+	if (fault & VM_FAULT_MAJOR) {
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+				1, 0, regs, address);
 		tsk->maj_flt++;
-	else
+	} else {
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+				1, 0, regs, address);
 		tsk->min_flt++;
+	}
 
 	up_read(&mm->mmap_sem);
 	return;
-- 
1.7.0.4
