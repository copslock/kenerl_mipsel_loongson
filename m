Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 19:08:44 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:40673
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994240AbeJ2SIk3CqaY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2018 19:08:40 +0100
Received: by mail-pg1-x541.google.com with SMTP id o14-v6so4288936pgv.7
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2018 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
        b=ViKF3X5QZz1G04Kuc+UrpCLOIvvtASddvUpgEhbE2NwCsDxuq6JsW/AfF3MtdzfNcH
         x4aFvJIFkNdrS8l2CQjvpOEnAdP+LsFKZAoe9CdyAH5M9odaITFSuzPbsiwDohBeU3UQ
         YDDibS0wr7JOOkRxMW/g3gib7jVbkYmN9FZJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
        b=Iw8f5EJv1yKrBQ9k4lPek0vfM/fdoWfo9bKbwwDU8DE5GYhzAQeH+WJuy4OGva/szB
         RUbL9C8+6VNxQq9Ue1Q0qVnD7OZSEFn8Arh4t1Kx+JsHc9ybgCJPL5xKIksTgQpgnKgv
         tsJiD+3Zmj/twrzyBEHFd8wWyTWWcM5xfGBOG0ydcLteUNEvA7XR9TUmK4Qqks6Y5LFN
         bjv/yORP58BNrshFx6eVyKVqTQChY7IeG43u207EW0x/ri92lAMPvcjqFdvlQytkMHGn
         NzpczMX6Lk1aUgmoxl2n03IoJwJZHVQHFBaRZgm4i0Ca+QzSxJY2OdMIFWbIWnIPKtQ/
         r4EQ==
X-Gm-Message-State: AGRZ1gJYhxCItRxYiY2Kd1mCkSRSFqgZhzODWkyNTCD2d/lxF/KCF9JW
        uJ8cHiMDnuaGT7HmWzTZ7iJYJQ==
X-Google-Smtp-Source: AJdET5dnes+lqSdsKf+M8kej513uIWGXuNg0nbxyLNaYWMhztTpOmHr2lEByvMdxDcC5rsUHz1VWbw==
X-Received: by 2002:a62:7a92:: with SMTP id v140-v6mr9434788pfc.46.1540836514355;
        Mon, 29 Oct 2018 11:08:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        peterz@infradead.org, linux-hexagon@vger.kernel.org,
        frederic@kernel.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
Date:   Mon, 29 Oct 2018 11:07:06 -0700
Message-Id: <20181029180707.207546-7-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

In kgdb_roundup_cpus() we've got code that looks like:
  local_irq_enable();
  smp_call_function(kgdb_call_nmi_hook, NULL, 0);
  local_irq_disable();

In certain cases when we drop into kgdb (like with sysrq-g on a serial
console) we'll get a big yell that looks like:

  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Let's add kgdb to the list of reasons not to warn in
smp_call_function_many().  That will allow us (in a future patch) to
stop calling local_irq_enable() which will get rid of the original
splat.

NOTE: with this change comes the obvious question: will we start
deadlocking more often now when we drop into the debugger.  I can't
say that for sure one way or the other, but the fact that we do the
same logic for "oops_in_progress" makes me feel like it shouldn't
happen too often.  Also note that the old logic of turning on
interrupts temporarily wasn't exactly safe since (I presume) that
could have violated spin_lock_irqsave() semantics and ended up with a
deadlock of its own.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 163c451af42e..bb581e58c8dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/kgdb.h>
 
 #include "smpboot.h"
 
@@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * can't happen.
 	 */
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+		     && !oops_in_progress && !early_boot_irqs_disabled
+		     && !in_dbg_master());
 
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
-- 
2.19.1.568.g152ad8e336-goog
