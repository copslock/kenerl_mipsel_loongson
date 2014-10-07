Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 20:51:38 +0200 (CEST)
Received: from mail-yh0-f53.google.com ([209.85.213.53]:37014 "EHLO
        mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010743AbaJGSvg5LQqQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 20:51:36 +0200
Received: by mail-yh0-f53.google.com with SMTP id b6so3226651yha.26
        for <multiple recipients>; Tue, 07 Oct 2014 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ha7IiYl/jAExYtrEexGLyrr83qqSW276+ZiTry0S9Ko=;
        b=E+fBO3S67H92/82fy+VxaIqslQ8pbaXm9AbLBl4jwTAxhbahbgo1qhhPLyrqldQ4Cr
         klokmUBEEhTl3J02DbOymcjFDoYHZR2qSzXEY6hE0D18FwK7w5cGhXurqvXhnU6C8A7H
         IBMsFd5oeAzXpe2bCtRYlxgZklgyM+y+g2Fk8TjHFtIAjxmzpPBZqRgrOSOBL0A8YrxR
         ErGwhFrWbcyAo9xOLuE8OXAGnrNPBT45398aIiGzh3oXXUFjOhwdhz22c7Q3mewP5WW6
         /HniqMpOheZCgUGJ7+ZxU8QSgFlDhIpZVNtGyKcjyTydAXC8gH7KdVWW4b72Po15yjK0
         K7Qw==
X-Received: by 10.236.34.196 with SMTP id s44mr8573416yha.57.1412707890810;
        Tue, 07 Oct 2014 11:51:30 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id y42sm8836707yhy.55.2014.10.07.11.51.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 11:51:30 -0700 (PDT)
Received: from t430.minyard.home (t430.minyard.home [127.0.0.1])
        by t430.minyard.home (8.14.7/8.14.7) with ESMTP id s97IpIEX016088;
        Tue, 7 Oct 2014 13:51:28 -0500
Received: (from cminyard@localhost)
        by t430.minyard.home (8.14.7/8.14.7/Submit) id s97Iowac016068;
        Tue, 7 Oct 2014 13:50:58 -0500
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 1/3] mips: Save all registers when saving the frame
Date:   Tue,  7 Oct 2014 13:50:52 -0500
Message-Id: <1412707854-15555-2-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1412707854-15555-1-git-send-email-minyard@acm.org>
References: <1412707854-15555-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

The MIPS frame save code was just saving a few registers, enough to
do a backtrace if every function set up a frame.  However, this is
not working if you are using DWARF unwinding, because most of the
registers are wrong.  This was causing kdump backtraces to be short
or bogus.

So save all the registers.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/include/asm/stacktrace.h | 64 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/stacktrace.h b/arch/mips/include/asm/stacktrace.h
index 780ee2c..10c4e9c 100644
--- a/arch/mips/include/asm/stacktrace.h
+++ b/arch/mips/include/asm/stacktrace.h
@@ -2,6 +2,8 @@
 #define _ASM_STACKTRACE_H
 
 #include <asm/ptrace.h>
+#include <asm/asm.h>
+#include <linux/stringify.h>
 
 #ifdef CONFIG_KALLSYMS
 extern int raw_show_trace;
@@ -20,6 +22,14 @@ static inline unsigned long unwind_stack(struct task_struct *task,
 }
 #endif
 
+#define STR_PTR_LA    __stringify(PTR_LA)
+#define STR_LONG_S    __stringify(LONG_S)
+#define STR_LONG_L    __stringify(LONG_L)
+#define STR_LONGSIZE  __stringify(LONGSIZE)
+
+#define STORE_ONE_REG(r) \
+    STR_LONG_S   " $" __stringify(r)",("STR_LONGSIZE"*"__stringify(r)")(%1)\n\t"
+
 static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 #ifndef CONFIG_KALLSYMS
@@ -32,21 +42,47 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noat\n\t"
-#ifdef CONFIG_64BIT
-		"1: dla $1, 1b\n\t"
-		"sd $1, %0\n\t"
-		"sd $29, %1\n\t"
-		"sd $31, %2\n\t"
-#else
-		"1: la $1, 1b\n\t"
-		"sw $1, %0\n\t"
-		"sw $29, %1\n\t"
-		"sw $31, %2\n\t"
-#endif
+		/* Store $1 so we can use it */
+		STR_LONG_S " $1,"STR_LONGSIZE"(%1)\n\t"
+		/* Store the PC */
+		"1: " STR_PTR_LA " $1, 1b\n\t"
+		STR_LONG_S " $1,%0\n\t"
+		STORE_ONE_REG(2)
+		STORE_ONE_REG(3)
+		STORE_ONE_REG(4)
+		STORE_ONE_REG(5)
+		STORE_ONE_REG(6)
+		STORE_ONE_REG(7)
+		STORE_ONE_REG(8)
+		STORE_ONE_REG(9)
+		STORE_ONE_REG(10)
+		STORE_ONE_REG(11)
+		STORE_ONE_REG(12)
+		STORE_ONE_REG(13)
+		STORE_ONE_REG(14)
+		STORE_ONE_REG(15)
+		STORE_ONE_REG(16)
+		STORE_ONE_REG(17)
+		STORE_ONE_REG(18)
+		STORE_ONE_REG(19)
+		STORE_ONE_REG(20)
+		STORE_ONE_REG(21)
+		STORE_ONE_REG(22)
+		STORE_ONE_REG(23)
+		STORE_ONE_REG(24)
+		STORE_ONE_REG(25)
+		STORE_ONE_REG(26)
+		STORE_ONE_REG(27)
+		STORE_ONE_REG(28)
+		STORE_ONE_REG(29)
+		STORE_ONE_REG(30)
+		STORE_ONE_REG(31)
+		/* Restore $1 */
+		STR_LONG_L " $1,"STR_LONGSIZE"(%1)\n\t"
 		".set pop\n\t"
-		: "=m" (regs->cp0_epc),
-		"=m" (regs->regs[29]), "=m" (regs->regs[31])
-		: : "memory");
+		: "=m" (regs->cp0_epc)
+		: "r" (regs->regs)
+		: "memory");
 }
 
 #endif /* _ASM_STACKTRACE_H */
-- 
1.8.3.1
