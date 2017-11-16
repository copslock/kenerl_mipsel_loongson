Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 09:33:48 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:51210
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKPIdhSeggE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 09:33:37 +0100
Received: by mail-pg0-x243.google.com with SMTP id p9so20067734pgc.8;
        Thu, 16 Nov 2017 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yzf7aSzwlAVMR57cMqvwHxDCIeCutjERZnJ0TmkqbRY=;
        b=ODDteCo5MQR8bSLxOwyFSsPkcIXloPJ043vCWUrpNUOIxNy+gZxNQCX+HNG+s6hyy2
         aLuLcvodiOIQg36d7Gyxoa2rO8JQmz/eOl4YKOFf9hcLPZLE3pJLCZcbaLwxJSSGnaK3
         S4wpsfqrcmIp1e7O0Sq6Lnl6XU6CCA9zDELC9+czzZIszkpGDxU9cN9hQO82pfp18ID0
         Hw1gD1SG9SUODl2qwJ9Lj3/BuBnArubKeIf1q1Jju8hzpKDsfN57DKUuPkP6f20X9VzQ
         ZfNZ3WrHKWnXrgzxqrx/bWmGEb1QhtudHlbkS3WlNMdyYG0zGYO6t/uzK3etIxwIAJ8o
         e6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yzf7aSzwlAVMR57cMqvwHxDCIeCutjERZnJ0TmkqbRY=;
        b=NwNdq/tSqsGYWJfqKuJclLk1asZ7eXP/0JH2G0rNh5og/F/i3zFN7kF2oczGjkibZE
         G1p+qUKZJB4ES19HqgasOBQje0f3yE7pp/v905I6io00wCMFEvuAYlv0Gg4i+eZR7SRY
         2rQ1Xd72dL020DF9ra4TyJlI7//ZAT4Ib8LJkk5FbPPnny97VEUlOnsPIsQTD95TPYno
         SlN3/5sAKO35NA6H/ZUxBsbXgNmmsMbUbHDE6kyATafyfZM4oNbBrHKLKFHWZDTXgFMj
         H0NXPttGCaLnEl3QjSuBli1Gw3iJsPEwvicn+pP+GP6/zEcwvNNCmMIlTY+JcsNEmKBP
         q8ZA==
X-Gm-Message-State: AJaThX4Ycpq9sUcHtpAnFAlT7cyVSoTs6R1VjxoaNfDNZayDo6gvdW3x
        5XzT1mJYUTvjK6ACzgGrjcB4ww==
X-Google-Smtp-Source: AGs4zMZ/TDALGnusjJCdZJvtDVSdfOAF5/VX+2vnfuKBFvvPpoleZSbR7yvUyiRaQ+doJV54GCBMmg==
X-Received: by 10.98.60.27 with SMTP id j27mr1045567pfa.68.1510821210537;
        Thu, 16 Nov 2017 00:33:30 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id m8sm1480095pgc.64.2017.11.16.00.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 00:33:29 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <James.Hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH Resend] MIPS: Ensure VDSO pages mapped above STACK_TOP
Date:   Thu, 16 Nov 2017 16:33:43 +0800
Message-Id: <1510821223-24497-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60971
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
index af34afb..7fff032 100644
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
index 019035d..6ec4537 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
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
@@ -128,7 +142,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
-- 
2.7.0
