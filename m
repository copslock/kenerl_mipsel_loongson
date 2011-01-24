Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 08:36:28 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:63194 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab1AXHfv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 08:35:51 +0100
Received: by mail-iw0-f177.google.com with SMTP id 38so3850811iwn.36
        for <multiple recipients>; Sun, 23 Jan 2011 23:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1S0FlhTd9CkBlWbWyKD4h87sEFJAVcUAhoFzG3GZJwU=;
        b=sERdtL8mGyNxmJntvW/klnpLlDuJ3+jpO7N+P7ClGnu+m9z/nNbvP8G1VWy4MeKCdr
         kFIfQjDChIZ9qiUtYu+CqGWS9k0PvKEPMLYiUUW6hceZC2cDkPLXtT6Wb7GzV0uTV3RL
         zVFpPVzDMog0xYsl7J7HsNlx45lHZcex2Dqd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pli9zYLGBKP7+q3YlnCKJDy8AMhS/4nFS3STtS47j67NB5ecH9s5JYC8agHPvy2d9E
         RjgpUS1/HRvFclUdUWtDaglbljUHA5gK0vibx+FgPDIkQRqOCw6aTbWXw5wy7qdy4eY6
         9v2TARlpKYZZWHbu2IqqlfEr/LDBp2T00bUJg=
Received: by 10.42.223.198 with SMTP id il6mr4302647icb.284.1295854550630;
        Sun, 23 Jan 2011 23:35:50 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 8sm10781545iba.22.2011.01.23.23.35.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Jan 2011 23:35:50 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com, ddaney@caviumnetworks.com
Subject: [RESEND PATCH v4 1/5] MIPS/Perf-events: Work with irq_work
Date:   Mon, 24 Jan 2011 15:35:45 +0800
Message-Id: <1295854549-7928-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295854549-7928-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1295854549-7928-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29027
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
Acked-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
Changes:
v4 - v3:
o None
v3 - v2:
o Keep all mentioned commits in the form of number + title + original
summary + (MIPS specific info when needed).
v2 - v1:
o None

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
