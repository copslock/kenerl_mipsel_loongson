Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:52:40 +0200 (CEST)
Received: from mail-pg0-x232.google.com ([IPv6:2607:f8b0:400e:c05::232]:34383
        "EHLO mail-pg0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbdDFNwbx79mx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:31 +0200
Received: by mail-pg0-x232.google.com with SMTP id 21so37149811pgg.1
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZLt+ReFG5HwK4e9WTrqh1RqYyoWLQmxPCWzJYVbEOM=;
        b=IpLzlIZulsnPRRwpipgednd/0SJLfou9wjvanQRI7iljShdsXXpxvqJKVYZH9eXAH7
         dbYaF3dccatTrHAyWP/39GVUwyfmX9thh/Ktc5F6zS7fcz87tfidi+QRNNjaHJ7Womr0
         bF/4aL05QEIGEW8HKJjwbcf29tXg/voA2Uato=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZLt+ReFG5HwK4e9WTrqh1RqYyoWLQmxPCWzJYVbEOM=;
        b=fLaVP46IIPqWSFy4rkrJFscWoWHTN+GGmcrnhq0PC3aV+srx/Uhab5rW4Ni7JAl1kY
         WYZpaCkdKGnJxqF/CPPCUQeVdzv+mYJ8ua3J5WhcDe778XobAXPPSPPbtdT+jE0Jta2A
         iNKFXzR9YQZa5p4VH8lJl//Mm0MQgo9IjiLNtGyQMQhe7VNwV8WLHlUp2Zjz798Jcygd
         Z6Kt8WxJPqM6SOoZ6nUwV5Z3rPeiic6DDK9Q3UP03xwue6LbIk30CuHv3DkarUzmsjHQ
         GiN/946bJ0pb8MDlIPSd3qXFlYTFsYBNT7MDc3JOOXm3Sq2tIZlmEk7powl8d07B+C4b
         NO0Q==
X-Gm-Message-State: AFeK/H0P2DhUrVyPHOL+u4dosWg1EfFp9l1248xBrbnwWGnPTVFxPOj6UK86nwVlyomdx+4V
X-Received: by 10.99.47.67 with SMTP id v64mr17086028pgv.32.1491486744695;
        Thu, 06 Apr 2017 06:52:24 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:24 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.10 1/6] MIPS: Introduce irq_stack
Date:   Thu,  6 Apr 2017 19:22:09 +0530
Message-Id: <1491486734-15668-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57601
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

Allocate a per-cpu irq stack for use within interrupt handlers.

Also add a utility function on_irq_stack to determine if a given stack
pointer is within the irq stack for that cpu.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit fe8bd18ffea5327344d4ec2bf11f47951212abd0)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/include/asm/irq.h    | 12 ++++++++++++
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/irq.c         | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 6bf10e7..956db6e 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -17,6 +17,18 @@
 
 #include <irq.h>
 
+#define IRQ_STACK_SIZE			THREAD_SIZE
+
+extern void *irq_stack[NR_CPUS];
+
+static inline bool on_irq_stack(int cpu, unsigned long sp)
+{
+	unsigned long low = (unsigned long)irq_stack[cpu];
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return (low <= sp && sp <= high);
+}
+
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 6080582..a727769 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_REGS, thread_info, regs);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
+	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
 	BLANK();
 }
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index f8f5836..ba150c7 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -25,6 +25,8 @@
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
 
+void *irq_stack[NR_CPUS];
+
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -58,6 +60,15 @@ void __init init_IRQ(void)
 		clear_c0_status(ST0_IM);
 
 	arch_init_irq();
+
+	for_each_possible_cpu(i) {
+		int irq_pages = IRQ_STACK_SIZE / PAGE_SIZE;
+		void *s = (void *)__get_free_pages(GFP_KERNEL, irq_pages);
+
+		irq_stack[i] = s;
+		pr_debug("CPU%d IRQ stack at 0x%p - 0x%p\n", i,
+			irq_stack[i], irq_stack[i] + IRQ_STACK_SIZE);
+	}
 }
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-- 
2.7.4
