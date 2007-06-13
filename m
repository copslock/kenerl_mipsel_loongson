Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 00:02:41 +0100 (BST)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:11363
	"EHLO mail.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20022571AbXFMXCh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 00:02:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sicortex.com (Postfix) with ESMTP id 8259C1E7CB3;
	Wed, 13 Jun 2007 19:02:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at sicortex.com
Received: from mail.sicortex.com ([127.0.0.1])
	by localhost (mail.sicortex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KLt1bS+Vf0v1; Wed, 13 Jun 2007 19:02:01 -0400 (EDT)
Received: from localhost.localdomain (gsrv020.sicortex.com [10.2.2.20])
	by mail.sicortex.com (Postfix) with ESMTP id 425C51E5C1A;
	Wed, 13 Jun 2007 19:02:01 -0400 (EDT)
From:	pwatkins@sicortex.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	pwatkins@sicortex.com
Cc:	Peter Watkins <pwatkins@gsrv020.sicortex.com>
Subject: [PATCH] [MIPS] Add smp_call_function_single.
Date:	Wed, 13 Jun 2007 19:02:01 -0400
Message-Id: <11817757212061-git-send-email-pwatkins@sicortex.com>
X-Mailer: git-send-email 1.4.2.4
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

From: Peter Watkins <pwatkins@gsrv020.sicortex.com>

Signed-off-by: Peter Watkins <pwatkins@gsrv020.sicortex.com>
---
 arch/mips/kernel/smp.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/smp.h |    2 ++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 67edfa7..26f0f55 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -203,6 +203,56 @@ void smp_call_function_interrupt(void)
 	}
 }
 
+int smp_call_function_single (int cpu, void (*func) (void *info), void *info, int retry,
+			      int wait)
+{
+	struct call_data_struct data;
+	int me = smp_processor_id();
+
+	/*
+	 * Can die spectacularly if this CPU isn't yet marked online
+	 */
+	BUG_ON(!cpu_online(me));
+
+	if (cpu == me) {
+		WARN_ON(1);
+		return -EBUSY;
+	}
+
+	if (!cpu_online(cpu))
+		return 0;
+
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&smp_call_lock);
+	call_data = &data;
+	smp_mb();
+
+	/* Send a message to the other CPU */
+	core_send_ipi(cpu, SMP_CALL_FUNCTION);
+
+	/* Wait for response */
+	/* FIXME: lock-up detection, backtrace on lock-up */
+	while (atomic_read(&data.started) != 1)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != 1)
+			barrier();
+	call_data = NULL;
+	spin_unlock(&smp_call_lock);
+
+	return 0;
+}
+
 static void stop_this_cpu(void *dummy)
 {
 	/*
diff --git a/include/asm-mips/smp.h b/include/asm-mips/smp.h
index 1608fd7..1aa6bb4 100644
--- a/include/asm-mips/smp.h
+++ b/include/asm-mips/smp.h
@@ -109,6 +109,8 @@ static inline void smp_send_reschedule(i
 	core_send_ipi(cpu, SMP_RESCHEDULE_YOURSELF);
 }
 
+extern int smp_call_function_single(int cpuid, void (*func) (void *info),
+				void *info, int retry, int wait);
 extern asmlinkage void smp_call_function_interrupt(void);
 
 #endif /* CONFIG_SMP */
-- 
1.4.2.4
