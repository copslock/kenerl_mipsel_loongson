Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 04:04:29 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:58345 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492139Ab0KZDEB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 04:04:01 +0100
Received: by gxk26 with SMTP id 26so791822gxk.36
        for <multiple recipients>; Thu, 25 Nov 2010 19:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=offC9kZMGROXhuBOmHRD7mGkn2MXSg+AgM0d64ZYjGk=;
        b=S1TBW4XxOat0Xic4Oxk6QO/1sQ3vKsw5yF8P1GCm7i0GNzDqHgax2WPk8RZxUGOe/4
         wZoCl1ucaCk48ylRMEgT95enwcvWeQGGQymiw2L1vE855qbcLKZJ9TyOH3PCpiIIR6+d
         PZHvnj02F9Q1nvpekKjYnfNbfgMnIDr3VW67A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rpRjgaaPLVKtxEGj4lhpigUW7r0Oghl+qmQx4H+uxD7QWpH7uFDBn4dgZFaLrwDhFQ
         iiQKxXASk086HVeu+wnMz+8cw34fpHikezsIzqxN3MLTKvsj/egT75dOcnu9MNXIQWuV
         mgIqSmaLRKQyD8kFQoDkTvqLmMFXi05oWZ8mM=
Received: by 10.150.148.17 with SMTP id v17mr1794375ybd.90.1290740635018;
        Thu, 25 Nov 2010 19:03:55 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 43sm933046yhl.37.2010.11.25.19.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 19:03:54 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH v2 1/5] MIPS/Perf-events: Work with irq_work
Date:   Fri, 26 Nov 2010 11:05:03 +0800
Message-Id: <1290740707-32586-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the commit:

e360adbe29241a0194e10e20595360dd7b98a2b3

Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
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
