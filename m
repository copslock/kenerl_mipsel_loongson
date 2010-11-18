Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 08:02:01 +0100 (CET)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:37560 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492043Ab0KRHBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 08:01:41 +0100
Received: by pvg7 with SMTP id 7so775496pvg.36
        for <multiple recipients>; Wed, 17 Nov 2010 23:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1/W/zOLpovt+kA92/y6DKOs6Igp8/p9BDUaLRZ5qJKk=;
        b=ny0OvviZZC9jCgX40NqqDZaywDuBAx0BMknUqPkPMmcn6be1L3uAJhYzRA+bZHJdCD
         LpmxlYvmq5rQOwOUH867tE5uxwpnvAtQBcjmv/5ADnpPY4ZHNz57eapKGcj4WWLDVIpZ
         iBOfLDWakjH5/FzFPlInxFkUu5An8k3oU6BRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EqmQhW4pKawkY1rkXoO+2GROQbANS76eK9lNt2lJ4iHXf5RcC/f12IS5Mxhyy7s8kB
         H2kGiS2N5IVoKMgl3RiBku/+I/NdtIEsXC08ataSSK2Jjg/oh4sm052s0XO8XpV9JTlr
         tG0bd8AbJVGCzXJDT6pdiBdwFMm2XVpJFCFQM=
Received: by 10.143.4.19 with SMTP id g19mr199244wfi.81.1290063692204;
        Wed, 17 Nov 2010 23:01:32 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id w27sm81044wfd.14.2010.11.17.23.01.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 23:01:31 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH 1/5] MIPS/Perf-events: Work with irq_work
Date:   Thu, 18 Nov 2010 14:56:37 +0800
Message-Id: <1290063401-25440-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the following commit by Peter Zijlstra:

e360adbe29241a0194e10e20595360dd7b98a2b3
	irq_work: Add generic hardirq context callbacks

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/perf_event.h   |   12 +-----------
 arch/mips/kernel/perf_event_mipsxx.c |    2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 67a2fa2..c44c38d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_IRQ_WORK
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
diff --git a/arch/mips/include/asm/perf_event.h b/arch/mips/include/asm/perf_event.h
index e00007c..d0c7749 100644
--- a/arch/mips/include/asm/perf_event.h
+++ b/arch/mips/include/asm/perf_event.h
@@ -11,15 +11,5 @@
 
 #ifndef __MIPS_PERF_EVENT_H__
 #define __MIPS_PERF_EVENT_H__
-
-/*
- * MIPS performance counters do not raise NMI upon overflow, a regular
- * interrupt will be signaled. Hence we can do the pending perf event
- * work at the tail of the irq handler.
- */
-static inline void
-set_perf_event_pending(void)
-{
-}
-
+/* Leave it empty here. The file is required by linux/perf_event.h */
 #endif /* __MIPS_PERF_EVENT_H__ */
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 5c7c6fc..fa00edc 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -696,7 +696,7 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	 * interrupt, not NMI.
 	 */
 	if (handled == IRQ_HANDLED)
-		perf_event_do_pending();
+		irq_work_run();
 
 #ifdef CONFIG_MIPS_MT_SMP
 	read_unlock(&pmuint_rwlock);
-- 
1.7.1
