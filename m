Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:17:40 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:44602 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S22301571AbYJXPRg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:17:36 +0100
Received: by mo.po.2iij.net (mo32) id m9OFHUm7036968; Sat, 25 Oct 2008 00:17:30 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox304) id m9OFHPZU027606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Oct 2008 00:17:25 +0900
Date:	Sat, 25 Oct 2008 00:17:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix kgdb build error
Message-Id: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

ptrace.h needs #include <linux/types.h>

In file included from include/linux/ptrace.h:49,
                 from arch/mips/kernel/kgdb.c:25:
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:83: error: expected specifier-qualifier-list before 'uint32_t'
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:98: error: expected specifier-qualifier-list before 'uint64_t'
In file included from include/linux/ptrace.h:49,
                 from arch/mips/kernel/kgdb.c:25:
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:123: error: expected declaration specifiers or '...' before '__s64'
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:124: error: expected declaration specifiers or '...' before '__s64'
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:126: error: expected declaration specifiers or '...' before '__u32'
/home/yuasa/src/linux/test/generic/linux/arch/mips/include/asm/ptrace.h:127: error: expected declaration specifiers or '...' before '__u32'
make[1]: *** [arch/mips/kernel/kgdb.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/ptrace.h linux/arch/mips/include/asm/ptrace.h
--- linux-orig/arch/mips/include/asm/ptrace.h	2008-10-22 09:41:24.013961262 +0900
+++ linux/arch/mips/include/asm/ptrace.h	2008-10-22 09:40:29.774870351 +0900
@@ -9,6 +9,8 @@
 #ifndef _ASM_PTRACE_H
 #define _ASM_PTRACE_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_64BIT
 #define __ARCH_WANT_COMPAT_SYS_PTRACE
 #endif
