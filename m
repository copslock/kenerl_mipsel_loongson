Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:16:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58053 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992022AbcKGLP4r9Wrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:15:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E544B6F3496D8;
        Mon,  7 Nov 2016 11:15:45 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:15:47 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/10] MIPS: Export _mcount alongside its definition
Date:   Mon, 7 Nov 2016 11:14:11 +0000
Message-ID: <20161107111417.11486-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-1-paul.burton@imgtec.com>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55688
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

 arch/mips/kernel/mcount.S     | 2 ++
 arch/mips/kernel/mips_ksyms.c | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 2f7c734..a8209ac 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -66,6 +66,7 @@
 NESTED(ftrace_caller, PT_SIZE, ra)
 	.globl _mcount
 _mcount:
+EXPORT_SYMBOL(_mcount)
 	b	ftrace_stub
 #ifdef CONFIG_32BIT
 	 addiu sp,sp,8
@@ -114,6 +115,7 @@ ftrace_stub:
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
