Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:53:06 +0200 (CEST)
Received: from mail-pg0-x22f.google.com ([IPv6:2607:f8b0:400e:c05::22f]:35640
        "EHLO mail-pg0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdDFNweytXkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:34 +0200
Received: by mail-pg0-x22f.google.com with SMTP id 81so37118161pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yT+JYRa9QZ7UM+rLY8vnkaCFnyuMqFyDqEHLZkTyXE=;
        b=Bfn6Skq6rxSeTj2hAkZ1SHqwRiZYMfJv/EZzgmyIBgk/hHz16w5aCvhy4lUFPvoI8N
         BcIxZ7yol6WqiyQsJJLvEQ/KOcRfLs9MSThu8+BRdW9o5VX3G01xjdxEvH3In+rryWBa
         BUyfHTpeoBzv9GMxUiVfXaogGlZfxKavA5g+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yT+JYRa9QZ7UM+rLY8vnkaCFnyuMqFyDqEHLZkTyXE=;
        b=sddz/4ztpf0pr+pVTMAbkN+D/HMet9FHuci91PIvSuAP5m0gHpvR5z5kPLFt8Fzlkz
         XsK3p/ly3HhsvDRQdqVdovmv5Xeao4uqgWCTEB5MtuWP7A1yi9d2fNoJjiCBiJnRenym
         nqSfSBmWQmpHlxWHVMAja68oHCz2coaFNkj/qSy6n0S2ITorWFigkMNMC2+2faxbE/P7
         pZwCUjOE4rTLhlmR/wyfFis83iqyoM2aSxmGrnokqQv3j3wAX2JYADDclDD4GXt35Nt5
         jFNKB/ZYQRmphclO5S+0t0B5LtvzkkkgzaaVBFwdRUTK3txhCZW7PfLIvl1SQmZt7o+K
         xn5g==
X-Gm-Message-State: AFeK/H1JEn0FB7OgSSgGeo+hzPOvNu3UbPkaclgs7k0Et1bMqC+AnsVjEAqKkMtuadFqQ+yg
X-Received: by 10.84.174.129 with SMTP id r1mr43837891plb.173.1491486749120;
        Thu, 06 Apr 2017 06:52:29 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:28 -0700 (PDT)
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
Subject: [PATCH for-4.10 2/6] MIPS: Stack unwinding while on IRQ stack
Date:   Thu,  6 Apr 2017 19:22:10 +0530
Message-Id: <1491486734-15668-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57602
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
index 7d80447..efa1df5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -33,6 +33,7 @@
 #include <asm/dsemul.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/irq.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -556,7 +557,19 @@ EXPORT_SYMBOL(unwind_stack_by_address);
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
