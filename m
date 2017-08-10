Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 20:28:28 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:36121
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdHJS1wZNe2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 20:27:52 +0200
Received: by mail-oi0-x243.google.com with SMTP id b130so1364937oii.3;
        Thu, 10 Aug 2017 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NTMqF/USbfIK+dRVqT95UH6qZSD6eZoePqdI0eLgEOw=;
        b=s2nCXeofwuWYOkDFK3nthm7Tv3HsKG2lG3B+xd78zVd5I/NMd5E6dmUT5l4PZj6Wio
         pJLwBzX0kPrszgK1nWicewTjVYntX+WwD1LS9bV75LVu1fzYlu/kLa5WdUpxPIJCJfEq
         34LCnM9QdxtHh2CjD4L5FZUmA+MwQa+H205g+i3fQe9MrY/sSUcZvvBGL8ZTgCRynyxr
         Lm+BpxR8A9Mzg3ZFnAsOeXWHalp6BiaP3MaXJkCy3Gu6SQp/Kny+/S9i61+Yrv3rEQdD
         jfu7fOeLZAMeLLIp/6Sc+xvmSLybEQDu+cx0v97ZsVoUWnvzEF6qyPzbcinM2cVfet1C
         K22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NTMqF/USbfIK+dRVqT95UH6qZSD6eZoePqdI0eLgEOw=;
        b=I73X5DBKK0u2VG2PknmdnB5QHOUTuxAcG2M0gE6PJE6SUA+AegRKAXyue92KeVNS+O
         hLgZTG5FAdF7gVs1fkFZiQKTjGEd4aHjI/a+Lh4A3CjRG/0+Ztc6D2yPCGQIuORiH5Y8
         4m4XBlEhvOOt1/EQ+JS9GPWzr8RsF8bmbeteny+bVfsu5FZwK/Ui4O5nAXHtjym3rQT6
         /F/lo+97jqpu1gTZPrpDym0C6L8ZmjdG+R25BtWhG31ptEwx4ro6ImvFWI/lqrKzuTia
         wqvRV3DtNFam8ZvoZZmTi2ETyqG74qMrsLwn07euQSgncN6vrSACFpGI8QC2WIXsqhpw
         Zajw==
X-Gm-Message-State: AHYfb5i/+xi6Jslbof2B9BOvbn8pEhMKptbqdtttrPJsBwHHEneBpKpW
        7jLxHklExXoFq1sd/rsx+Q==
X-Received: by 10.202.10.221 with SMTP id k90mr14040458oiy.245.1502389666265;
        Thu, 10 Aug 2017 11:27:46 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id q64sm9003030oib.12.2017.08.10.11.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:27:44 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id C933A95D;
        Thu, 10 Aug 2017 13:27:43 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 5F550300E01; Thu, 10 Aug 2017 13:27:42 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4/4] mips: Save all registers when saving the frame
Date:   Thu, 10 Aug 2017 13:27:40 -0500
Message-Id: <1502389660-8969-5-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502389660-8969-1-git-send-email-minyard@acm.org>
References: <1502389660-8969-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59478
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
2.7.4
