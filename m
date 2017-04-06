Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:49:27 +0200 (CEST)
Received: from mail-pg0-x232.google.com ([IPv6:2607:f8b0:400e:c05::232]:34862
        "EHLO mail-pg0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990600AbdDFMtTDwpmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:19 +0200
Received: by mail-pg0-x232.google.com with SMTP id 81so35566580pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4rJBob+GPYFpJvmGHphbfLug5L8LzlwWwaFBFgk5NRI=;
        b=eFT631Z3vhkNm6NcSlb7GTp//lcfuN41Fd2kjm1331Y2W8nCJWtZJeD3bojWN7jx+d
         d94zDWFA6r43URLLgUixakXPDLpJ8vulTFof+nBeXfJ9iVCgM48BeQgWfTtmmxPBY2fr
         zCKAN5YV4p+20/Af8uWt7Jqv130IFnR2aIjZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4rJBob+GPYFpJvmGHphbfLug5L8LzlwWwaFBFgk5NRI=;
        b=Zy4tYIbMQm1jOYLZmWjc20F36BIPNsv9i3M6Vxwe3DYZlsyDb2C7B26jrbCKyXfKzz
         tsAHLsfpy6x4kMG7H+30F7IV045dPeFURgJl0CvgejK2JMOcnXMqNMyI5eQ4rWgOHDM+
         YMvZaSJSfHRPcRY/v7UKapRd+c4tQQmhQDQN+AARaEC8pij7vkwPFsyzLyLlTEvkFkfb
         6li/lO+q90C0ha3g/B+jHFdLg11onnGe9NCIqUaU7cn1lxhyfH86WHpLRdUvTg4v5Scz
         UsyCkGhiRsL7efzcTABt8UDGBPP1S6cwTheEDDwBuuaLF0PdGwaObu74hU+awxgRkziA
         AmCQ==
X-Gm-Message-State: AFeK/H1uYNY5XZk4yTH52b0EaTrsPynKskAPKGVqCIkJOZw2EUCqFOZex5DktmLGTlg9cxn4
X-Received: by 10.98.102.88 with SMTP id a85mr36390080pfc.33.1491482950163;
        Thu, 06 Apr 2017 05:49:10 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:09 -0700 (PDT)
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
Subject: [PATCH for-4.4 1/7] MIPS: Introduce irq_stack
Date:   Thu,  6 Apr 2017 18:18:54 +0530
Message-Id: <1491482940-1163-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57585
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
index 15e0fec..ebb9efb 100644
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
index 154e203..ec053ce 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -101,6 +101,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_REGS, thread_info, regs);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
+	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
 	BLANK();
 }
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 8eb5af8..dc1180a 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -25,6 +25,8 @@
 #include <linux/atomic.h>
 #include <asm/uaccess.h>
 
+void *irq_stack[NR_CPUS];
+
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -55,6 +57,15 @@ void __init init_IRQ(void)
 		irq_set_noprobe(i);
 
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
