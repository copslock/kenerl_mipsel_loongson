Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2012 20:46:20 +0100 (CET)
Received: from bluegiga.fi ([194.100.31.45]:33826 "EHLO darkblue.bluegiga.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903704Ab2CATqQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Mar 2012 20:46:16 +0100
Received: from bluegiga.com ([10.1.1.102]) by darkblue.bluegiga.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 1 Mar 2012 21:46:13 +0200
Received: by bluegiga.com (sSMTP sendmail emulation); Thu, 01 Mar 2012 21:46:07 +0200
From:   Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] mm: module_alloc: check if size is 0
Date:   Thu,  1 Mar 2012 21:45:19 +0200
Message-Id: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
X-Mailer: git-send-email 1.7.5.4
X-OriginalArrivalTime: 01 Mar 2012 19:46:13.0597 (UTC) FILETIME=[F58988D0:01CCF7E3]
X-archive-position: 32591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veli-pekka.peltola@bluegiga.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

After commit de7d2b567d040e3b67fe7121945982f14343213d (mm/vmalloc.c: report
more vmalloc failures) users will get a warning if vmalloc_node_range() is
called with size 0. This happens if module's init size equals to 0. This
patch changes ARM, MIPS and x86 module_alloc() to return NULL before calling
vmalloc_node_range() that would also return NULL and print a warning.

Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
I found this with ARM but after checking out various implementations of
module_alloc() I thought it would be better to fix all at once.

One way to replicate the warning:
compile kernel with CONFIG_KALLSYMS=n
insmod module without init, I used usb-common.ko

 arch/arm/kernel/module.c  |    4 ++--
 arch/mips/kernel/module.c |    4 ++--
 arch/x86/kernel/module.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..d44d212 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -39,8 +39,8 @@
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
+	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULES_VADDR,
+				MODULES_END, GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index a5066b1..cd768e9 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -47,8 +47,8 @@ static DEFINE_SPINLOCK(dbe_lock);
 #ifdef MODULE_START
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
-				GFP_KERNEL, PAGE_KERNEL, -1,
+	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULE_START,
+				MODULE_END, GFP_KERNEL, PAGE_KERNEL, -1,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 925179f..bff6118 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -38,7 +38,7 @@
 
 void *module_alloc(unsigned long size)
 {
-	if (PAGE_ALIGN(size) > MODULES_LEN)
+	if (size == 0 || PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 				GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC,
-- 
1.7.5.4
