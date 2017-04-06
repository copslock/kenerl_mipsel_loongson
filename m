Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:49:57 +0200 (CEST)
Received: from mail-pg0-x22e.google.com ([IPv6:2607:f8b0:400e:c05::22e]:34620
        "EHLO mail-pg0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992183AbdDFMtUaS2Gi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:20 +0200
Received: by mail-pg0-x22e.google.com with SMTP id 21so35594346pgg.1
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oIM6W3JWgwhacxm915ljVSVBeQBEhShLWURkpWncr7Q=;
        b=eK5F7a48xMm7ycNVEwk8obW88k3UY0jLg6SyeGNaca5f5/zJ0mQyXGf1CLUrLM3Kd7
         di+XFSo2pCtplShTpoPlun9eBfUVe/rTe8qRroDDAomAYdeWDpiZazJqUA3TB55z+Qu6
         ryrXxsaj4eDOakDAyWnBmvNY6XVIX3gdqXdE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oIM6W3JWgwhacxm915ljVSVBeQBEhShLWURkpWncr7Q=;
        b=tkKAn+HbvSfQofY4en/tvaEf9utJeBmpFlGTOFCZxTkJ/PT99VedzLUHPfuQcWN5sN
         FJD4gx40+BFWfbQerfXmLafPm0XxlNH01R/ilI6p1+96ezMOPS54MzUmlX33aL06AFxB
         AdVqZbKCYzWzzSq9qQexqnDR36jMsmBDlCfN2rmeTth80NqP372yXCxLJpBE1aQKuIx6
         hM3mAK1oOKWYCKVT+caQTMVPfPWP9YuVNh2Js62vJd9mddC6HTbjP5p5HmfnWR35LqlP
         Q6HtMFskjCl5a+q7ChEYcr1BqDntSwXgDjH+s4q7Jvh9gMKf3I//q5j+OXKNWXkydoFU
         tE8A==
X-Gm-Message-State: AFeK/H0g1NEyassgqKsUR3u6hX69JJcfhHM+WMoNrP7jzUe7B1JVlGBig0cluaIer5ANRoaL
X-Received: by 10.99.176.5 with SMTP id h5mr36291190pgf.179.1491482954679;
        Thu, 06 Apr 2017 05:49:14 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:14 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 2/7] MIPS: Stack unwinding while on IRQ stack
Date:   Thu,  6 Apr 2017 18:18:55 +0530
Message-Id: <1491482940-1163-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

Within unwind stack, check if the stack pointer being unwound is within
the CPU's irq_stack and if so use that page rather than the task's stack
page.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14741/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit d42d8d106b0275b027c1e8992c42aecf933436ea)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/kernel/process.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index fc537d1..8c26eca 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -32,6 +32,7 @@
 #include <asm/cpu.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/irq.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -552,7 +553,19 @@ EXPORT_SYMBOL(unwind_stack_by_address);
 unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
 			   unsigned long pc, unsigned long *ra)
 {
-	unsigned long stack_page = (unsigned long)task_stack_page(task);
+	unsigned long stack_page = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (on_irq_stack(cpu, *sp)) {
+			stack_page = (unsigned long)irq_stack[cpu];
+			break;
+		}
+	}
+
+	if (!stack_page)
+		stack_page = (unsigned long)task_stack_page(task);
+
 	return unwind_stack_by_address(stack_page, sp, pc, ra);
 }
 #endif
-- 
2.7.4
