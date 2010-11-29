Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 10:17:51 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:47691 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491829Ab0K2JRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 10:17:22 +0100
Received: by gwj20 with SMTP id 20so2076191gwj.36
        for <multiple recipients>; Mon, 29 Nov 2010 01:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k9CWWvbFo98xN0pMYRovhucXrU7/i06ILTG1J8b503I=;
        b=Agx6Ja4ryM4w/Z7XanmA0Xtrv+ZCN0aIJnvrmsHr36XOoCub+giDzBpqLNUNjpOH28
         c70Vjr+hciVE2U90QDeMvj4Mlo1zyoWk4JH+5d6vI+lfZ/TZxdrcQs3108EUC8auhB2f
         Mj6573dr7BwWFr2dSe5ZhVBQcSB2saDIK4ccI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mRmVoBYmFPpPmsJI9x+DndT8d5A0bGiDWHRZzWP+4++EXa5IHVmNmj/lfF974Pzs6z
         nNFjgR+/bhe2w9htBYGtTEAr3weKKqMd/e3hbmr9Cs7a2d/FDOfSOYMTUJPJ+g2trVLL
         7M9cabhDY9m9GIklDrBOZsvE0C4ikPYH/nZg0=
Received: by 10.150.138.18 with SMTP id l18mr10267249ybd.106.1291022236555;
        Mon, 29 Nov 2010 01:17:16 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id u68sm522697yhc.47.2010.11.29.01.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 01:17:15 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com
Subject: [PATCH v3 1/5] MIPS/Perf-events: Work with irq_work
Date:   Mon, 29 Nov 2010 17:19:07 +0800
Message-Id: <1291022351-13152-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1291022351-13152-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1291022351-13152-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the following commit by Peter Zijlstra:

- e360adbe29241a0194e10e20595360dd7b98a2b3
    irq_work: Add generic hardirq context callbacks

    Provide a mechanism that allows running code in IRQ context. It is
    most useful for NMI code that needs to interact with the rest of the
    system -- like wakeup a task to drain buffers.

    Perf currently has such a mechanism, so extract that and provide it as
    a generic feature, independent of perf so that others may also
    benefit.

    The IRQ context callback is generated through self-IPIs where
    possible, or on architectures like powerpc the decrementer (the
    built-in timer facility) is set to generate an interrupt immediately.

    Architectures that don't have anything like this get to do with a
    callback from the timer tick. These architectures can call
    irq_work_run() at the tail of any IRQ handlers that might enqueue such
    work (like the perf IRQ handler) to avoid undue latencies in
    processing the work.

For MIPSXX, we need to call irq_work_run() at the tail of the perf IRQ
handler as described above.

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
