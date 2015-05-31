Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 23:39:44 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:34319 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbbEaVjmofcw4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2015 23:39:42 +0200
Received: by laat2 with SMTP id t2so88758036laa.1
        for <linux-mips@linux-mips.org>; Sun, 31 May 2015 14:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :user-agent:mime-version:content-transfer-encoding:content-type;
        bh=Z5EMNQJXFIPuqueJ+ObSFJatf5xr3CiPIOOFrG26Ycw=;
        b=YZFfAi8OC8Eom18NOKU+XfJFPr2tieXp6MVkhCc0WPiVFcKopWay16/TP9CIx12rlY
         cJlXJz1kYhEYxFPmo8GJ0d7FUnEFefd1MuZr8clYtnWtCXp4T22p9kCdp7LBy7XR3KFy
         Eqhwyzr770f0e+jfJ4IghPbfdqFLxEh1nxlLeF0Lt6H6J2ATGJNKi+6KOkiY3vB2aogh
         r8un54pA+NDkosfofRw3KI/5FryVqhiKb6oLpEncrKVQBxyr5cxH+GY+G+apU2pFzQTP
         6ojf0Fz9P0RoETFHdpQIMnDWIhXIcaiIDqUgFw1ewzT6PypTUc8JSBGHD9hlzjaSXzhy
         31mw==
X-Gm-Message-State: ALoCoQnaRDPhwlcUAK78CqxceubppbhHt9s/UWt+0ydKR7W3B7GkfcJRxpZhsT5N13kIU8Ab8SPZ
X-Received: by 10.112.48.68 with SMTP id j4mr17828232lbn.60.1433108375584;
        Sun, 31 May 2015 14:39:35 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp27-48.pppoe.mtu-net.ru. [81.195.27.48])
        by mx.google.com with ESMTPSA id ej5sm3632665lad.5.2015.05.31.14.39.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 14:39:30 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPSL get rid of 'kgdb_early_setup' cruft
Date:   Mon, 01 Jun 2015 00:39:28 +0300
Message-ID: <3329877.R0BkkWOk0j@wasted.cogentembedded.com>
Organization: Cogent Embedded Inc.
User-Agent: KMail/4.14.7 (Linux/3.19.8-100.fc20.x86_64; KDE/4.14.7; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Commit 854700115ecf ([MIPS] kgdb: add arch support for the kernel's kgdb core)
added the 'kgdb_early_setup' flag to avoid  calling trap_init() and init_IRQ()
the second time, however the code that called these functions earlier,  from
kgdb_arch_init(), had been already removed by that  time,  so the flag never
served any useful purpose. Remove the related code along with ugly #ifdef'ery
at last.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the recent Linus' repo.  Tell me if you want it to be
rebased against some MIPS repo...

 arch/mips/include/asm/kgdb.h |    1 -
 arch/mips/kernel/irq.c       |   15 ---------------
 arch/mips/kernel/kgdb.c      |    4 ----
 arch/mips/kernel/traps.c     |    6 ------
 4 files changed, 26 deletions(-)

Index: linux/arch/mips/include/asm/kgdb.h
===================================================================
--- linux.orig/arch/mips/include/asm/kgdb.h
+++ linux/arch/mips/include/asm/kgdb.h
@@ -33,7 +33,6 @@
 #define CACHE_FLUSH_IS_SAFE	0
 
 extern void arch_kgdb_breakpoint(void);
-extern int kgdb_early_setup;
 extern void *saved_vectors[32];
 extern void handle_exception(struct pt_regs *regs);
 extern void breakinst(void);
Index: linux/arch/mips/kernel/irq.c
===================================================================
--- linux.orig/arch/mips/kernel/irq.c
+++ linux/arch/mips/kernel/irq.c
@@ -19,16 +19,11 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
-#include <linux/kgdb.h>
 #include <linux/ftrace.h>
 
 #include <linux/atomic.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_KGDB
-int kgdb_early_setup;
-#endif
-
 static DECLARE_BITMAP(irq_map, NR_IRQS);
 
 int allocate_irqno(void)
@@ -93,20 +88,10 @@ void __init init_IRQ(void)
 {
 	int i;
 
-#ifdef CONFIG_KGDB
-	if (kgdb_early_setup)
-		return;
-#endif
-
 	for (i = 0; i < NR_IRQS; i++)
 		irq_set_noprobe(i);
 
 	arch_init_irq();
-
-#ifdef CONFIG_KGDB
-	if (!kgdb_early_setup)
-		kgdb_early_setup = 1;
-#endif
 }
 
 #ifdef DEBUG_STACKOVERFLOW
Index: linux/arch/mips/kernel/kgdb.c
===================================================================
--- linux.orig/arch/mips/kernel/kgdb.c
+++ linux/arch/mips/kernel/kgdb.c
@@ -378,10 +378,6 @@ int kgdb_arch_handle_exception(int vecto
 
 struct kgdb_arch arch_kgdb_ops;
 
-/*
- * We use kgdb_early_setup so that functions we need to call now don't
- * cause trouble when called again later.
- */
 int kgdb_arch_init(void)
 {
 	union mips_instruction insn = {
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c
+++ linux/arch/mips/kernel/traps.c
@@ -29,7 +29,6 @@
 #include <linux/bootmem.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
-#include <linux/kgdb.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/notifier.h>
@@ -2184,11 +2183,6 @@ void __init trap_init(void)
 
 	check_wait();
 
-#if defined(CONFIG_KGDB)
-	if (kgdb_early_setup)
-		return; /* Already done */
-#endif
-
 	if (cpu_has_veic || cpu_has_vint) {
 		unsigned long size = 0x200 + VECTORSPACING*64;
 		ebase = (unsigned long)
