Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 07:50:35 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:40884
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeIOFucS0vlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 07:50:32 +0200
Received: by mail-pf1-x444.google.com with SMTP id s13-v6so5220823pfi.7;
        Fri, 14 Sep 2018 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oF015cDzQJ9UTBvMCkiQB2+Ypti3191FxmHaSrbmCvM=;
        b=MsG4SRZzhmBUB9S2CQdqRWB9qz+PT5hwMrCqFJKKEVgMHVA2GmA50+7F+RPRxdcIsY
         BwwW9/rMExvCi8WUb02U/t08A56RVt7U1UJ5W3uSg7exq0BKn6VfXvbP/TOHYRNcwOsA
         DM52308k0i+kopQnlb1dJ8e3cg06JSInIuoN983ASrS9em7QL9i2oUmwu7taAzyXf12S
         cwvrp8InKPEg/kpUn0a1godhXW7iqoPDK+HXMxDuIgJiO8BeEISNvTdXIhstq7vAEFOB
         iS1pKwPs2Webp/PHjohposfqGXIqllCys8HTnKyM4dJzK7YjWGrQN1EFpAInCYSioCCX
         LyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oF015cDzQJ9UTBvMCkiQB2+Ypti3191FxmHaSrbmCvM=;
        b=VGHHTLdvyHHXdjWlOHqqnw7czE818jD5JR/bvwct04DXt7ch82ruS77ymHVfXt7lPi
         YYZxvOJ7c7jJv6BAXEyAH/pPiTVMk4gSv28AMqZcuq9WaW0rfjrE74pxgrIuqntPvx5a
         O14/STkWayyeTQWCZWjA3eHOcE7T3VpshJRy+c0PjnKUnYm7MfhDbiJwUHStmEf12ejs
         FokU5yNzERD111hOJARjYIsi6p/6VVQlRi0BPAvk+K8j8qsMqtvDIhfV9M88htJV2tge
         2JL8H4oWxpJ+ci9yyprJD/K/xXKs4H892N6xxKRqJSAa97SbzkcFkQIuAO7/Q335wk80
         e2vg==
X-Gm-Message-State: APzg51BTKDIesUxCK5ot/cljKiuCdnIBgLYYnKy257K0XXOjdCnoPWen
        h9IuI8RZd/L+UdzI26YoH6560kHsao4=
X-Google-Smtp-Source: ANB0VdagVwyTk0xFLz4rQBCouy7r6t+t5ZmJsPOB4PRiz8aLXhCo+SIcm7fCFOAhuyxZjmUrt9idMQ==
X-Received: by 2002:a63:d401:: with SMTP id a1-v6mr14560542pgh.414.1536990625390;
        Fri, 14 Sep 2018 22:50:25 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id p19-v6sm18177406pgh.60.2018.09.14.22.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 22:50:24 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH Resend] MIPS: Ensure VDSO pages mapped above STACK_TOP
Date:   Sat, 15 Sep 2018 13:51:30 +0800
Message-Id: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Unlimited stack size (ulimit -s unlimited) causes kernel to use legacy
layout for applications. Thus, if VDSO isn't mapped above STACK_TOP, it
will be mapped at a very low address. This will probably cause an early
brk() failure, because the application's initial mm->brk is usually
below VDSO (especially when COMPAT_BRK is enabled) and there is no more
room to expand its heap.

This patch reserve 4 MB space above STACK_TOP, and use the low 2 MB for
VDSO randomization (as a result, VDSO pages can use as much as 2 MB).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/processor.h |  5 +++--
 arch/mips/kernel/vdso.c           | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index b2fa629..8964eca 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -13,6 +13,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/sizes.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
@@ -82,9 +83,9 @@ extern unsigned int vced_count, vcei_count;
 
 /*
  * One page above the stack is used for branch delay slot "emulation".
- * See dsemul.c for details.
+ * See dsemul.c for details, other pages are for VDSO.
  */
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
+#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - SZ_4M)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 8f845f6..9a17467 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -97,6 +98,19 @@ void update_vsyscall_tz(void)
 	}
 }
 
+static unsigned long vdso_base(void)
+{
+	unsigned long offset = 0UL;
+
+	if (current->flags & PF_RANDOMIZE) {
+		offset = get_random_int();
+		offset <<= PAGE_SHIFT;
+		offset &= 0x1ffffful; /* 2 MB */
+	}
+
+	return STACK_TOP + PAGE_SIZE + offset;
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
@@ -137,7 +151,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (cpu_has_dc_aliases)
 		size += shm_align_mask + 1;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
-- 
2.7.0
