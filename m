Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 03:43:48 +0200 (CEST)
Received: from smtpbgau2.qq.com ([54.206.34.216]:45856 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993929AbdHQBnmHJv8F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 03:43:42 +0200
X-QQ-mid: bizesmtp8t1502934180tryndr8sb
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 17 Aug 2017 09:41:44 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0B00A0000000
X-QQ-FEAT: nSUdqPGu3tvl9/YbIbXS1OkIF1UkT82lIiKoCK5vcde2SSjaxk5pgBcTmKpq/
        GcrGHKKO+3r+rH4l744xmx8wyPm+Z8CRAgQ2g6YGgOyU4F0tQDFX2zrTd8PkgxqpuQuWPU6
        t19YhajNlLOOQflh6yc3AGuhodZdhU9Mvu55jZrUDyTJR7rh05lvJBMqFP3l3nmXIBwwVVW
        H8qKlq7PxOfaj9DN4Qtkzzn6rRaOHriIF/bR6CaXgxmbAFjiCh6udzWOGyaimU+MfJiikIq
        Qctq0bzp0CVcY8lnBRvIjguiANf9EKaXUS8A==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Ensure VDSO pages mapped above STACK_TOP
Date:   Thu, 17 Aug 2017 09:42:39 +0800
Message-Id: <1502934159-21783-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59603
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
brk() failure and then a segmentation fault, because the application's
initial mm->brk is usually below VDSO (especially when COMPAT_BRK is
enabled) and there is no more room to expand its heap.

This patch reserve 4 MB space above STACK_TOP, and use the low 2 MB for
VDSO randomization (as a result, VDSO pages can use as much as 2 MB).

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/processor.h |  5 +++--
 arch/mips/kernel/vdso.c           | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 95b8c47..1c99e2c 100644
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
index 093517e..71fecec 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -95,6 +96,19 @@ void update_vsyscall_tz(void)
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
@@ -129,7 +143,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
-- 
2.7.0
