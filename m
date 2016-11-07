Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:48:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2883 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGLsdrmXks (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:48:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3FFE97903F0F9;
        Mon,  7 Nov 2016 11:48:21 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:48:23 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 05/10] MIPS: Export _mcount alongside its definition
Date:   Mon, 7 Nov 2016 11:48:04 +0000
Message-ID: <20161107114804.22409-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-6-paul.burton@imgtec.com>
References: <20161107111417.11486-6-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Now that EXPORT_SYMBOL can be used from assembly source, move the
EXPORT_SYMBOL invocation for _mcount to be alongside its definition.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Inlcude asm/export.h

 arch/mips/kernel/mcount.S     | 3 +++
 arch/mips/kernel/mips_ksyms.c | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 2f7c734..f2ee7e1 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -10,6 +10,7 @@
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
+#include <asm/export.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/ftrace.h>
@@ -66,6 +67,7 @@
 NESTED(ftrace_caller, PT_SIZE, ra)
 	.globl _mcount
 _mcount:
+EXPORT_SYMBOL(_mcount)
 	b	ftrace_stub
 #ifdef CONFIG_32BIT
 	 addiu sp,sp,8
@@ -114,6 +116,7 @@ ftrace_stub:
 #else	/* ! CONFIG_DYNAMIC_FTRACE */
 
 NESTED(_mcount, PT_SIZE, ra)
+EXPORT_SYMBOL(_mcount)
 	PTR_LA	t1, ftrace_stub
 	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
 	bne	t1, t2, static_trace
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 84f169b..d12d243 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -80,7 +80,3 @@ EXPORT_SYMBOL(__csum_partial_copy_from_user);
 #endif
 
 EXPORT_SYMBOL(invalid_pte_table);
-#ifdef CONFIG_FUNCTION_TRACER
-/* _mcount is defined in arch/mips/kernel/mcount.S */
-EXPORT_SYMBOL(_mcount);
-#endif
-- 
2.10.2
