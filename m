Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:47:45 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50306 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842532AbaGWNnoAZkks (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:44 +0200
Received: by mail-wg0-f42.google.com with SMTP id l18so1185500wgh.13
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N0gKPvPdScN7kS7A9x4En1JAvhUsz/I4zWqv3VrT0Kw=;
        b=JX7pNqoH1aSwPQcgcESMPceMuLSoLJXd5IUAhk5Kwp92G08xGfFW1LWGS2lZMwcXiw
         M7242wZyxM4+0YWXh6B7pZGaKlzyq/olPl4CXMiQFnqvyYJpW1CfG0mOlgzHhELMZKp/
         AY9aY64pj4b2oVdcsDIRC+SkSCFGUUUXutltlZT8s0ad5YuJXr2PHnAX9r0rdL6ZhLIz
         cZC8Y9TwBaI99Dbv8Un+CZzV4Ydst+ZpGD9wH7ddPChKDAIgEC4rU+Uw1nI2DIzfvxwX
         RwNQ+WdA8Sr0r+2jiiMK6YskqE40GXXAo2CvJ7O5jPnd9rtry7Ebk3VVXjTrxqHgLJpz
         jJ+w==
X-Gm-Message-State: ALoCoQl7XZD3TyE/n7enZ/O9tVfd/s1U5llQFJy7zEcpEAlu7OM1cabuomhBGMHnIxH8IXAe0ETx
X-Received: by 10.194.222.5 with SMTP id qi5mr2097895wjc.62.1406123016168;
        Wed, 23 Jul 2014 06:43:36 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:35 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 10/11] MIPS: Remove asm/user.h
Date:   Wed, 23 Jul 2014 14:40:15 +0100
Message-Id: <1406122816-2424-11-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

The struct user definition in this file is not used anywhere (the ELF
core dumper does not use that format). Therefore, remove the header and
instead enable the asm-generic user.h which is an empty header to
satisfy a few generic headers which still try to include user.h.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
---
 arch/mips/include/asm/Kbuild |  1 +
 arch/mips/include/asm/user.h | 58 --------------------------------------------
 arch/mips/kernel/process.c   |  2 +-
 arch/mips/kernel/ptrace.c    |  1 -
 arch/mips/kernel/ptrace32.c  |  2 +-
 5 files changed, 3 insertions(+), 61 deletions(-)
 delete mode 100644 arch/mips/include/asm/user.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 0543918..335e529 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -15,4 +15,5 @@ generic-y += segment.h
 generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
+generic-y += user.h
 generic-y += xor.h
diff --git a/arch/mips/include/asm/user.h b/arch/mips/include/asm/user.h
deleted file mode 100644
index 6bad61b..0000000
--- a/arch/mips/include/asm/user.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994, 1995, 1996, 1999 by Ralf Baechle
- */
-#ifndef _ASM_USER_H
-#define _ASM_USER_H
-
-#include <asm/page.h>
-#include <asm/reg.h>
-
-/*
- * Core file format: The core file is written in such a way that gdb
- * can understand it and provide useful information to the user (under
- * linux we use the `trad-core' bfd, NOT the irix-core).  The file
- * contents are as follows:
- *
- *  upage: 1 page consisting of a user struct that tells gdb
- *	what is present in the file.  Directly after this is a
- *	copy of the task_struct, which is currently not used by gdb,
- *	but it may come in handy at some point.	 All of the registers
- *	are stored as part of the upage.  The upage should always be
- *	only one page long.
- *  data: The data segment follows next.  We use current->end_text to
- *	current->brk to pick up all of the user variables, plus any memory
- *	that may have been sbrk'ed.  No attempt is made to determine if a
- *	page is demand-zero or if a page is totally unused, we just cover
- *	the entire range.  All of the addresses are rounded in such a way
- *	that an integral number of pages is written.
- *  stack: We need the stack information in order to get a meaningful
- *	backtrace.  We need to write the data from usp to
- *	current->start_stack, so we round each of these in order to be able
- *	to write an integer number of pages.
- */
-struct user {
-	unsigned long	regs[EF_SIZE /		/* integer and fp regs */
-			sizeof(unsigned long) + 64];
-	size_t		u_tsize;		/* text size (pages) */
-	size_t		u_dsize;		/* data size (pages) */
-	size_t		u_ssize;		/* stack size (pages) */
-	unsigned long	start_code;		/* text starting address */
-	unsigned long	start_data;		/* data starting address */
-	unsigned long	start_stack;		/* stack starting address */
-	long int	signal;			/* signal causing core dump */
-	unsigned long	u_ar0;			/* help gdb find registers */
-	unsigned long	magic;			/* identifies a core file */
-	char		u_comm[32];		/* user command name */
-};
-
-#define NBPG			PAGE_SIZE
-#define UPAGES			1
-#define HOST_TEXT_START_ADDR	(u.start_code)
-#define HOST_DATA_START_ADDR	(u.start_data)
-#define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
-
-#endif /* _ASM_USER_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7564c37..2dafceb 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -21,7 +21,6 @@
 #include <linux/mman.h>
 #include <linux/personality.h>
 #include <linux/sys.h>
-#include <linux/user.h>
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/kallsyms.h>
@@ -36,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
+#include <asm/reg.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/elf.h>
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c0c582e..ea99743 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -24,7 +24,6 @@
 #include <linux/ptrace.h>
 #include <linux/regset.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/security.h>
 #include <linux/tracehook.h>
 #include <linux/audit.h>
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index dee8729..283b5a1 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -22,7 +22,6 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
 #include <asm/cpu.h>
@@ -32,6 +31,7 @@
 #include <asm/mipsmtregs.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/reg.h>
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 
-- 
1.9.1
