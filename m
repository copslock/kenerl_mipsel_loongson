Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 22:22:15 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7946 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491024Ab0L1VWM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 22:22:12 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1a552d0000>; Tue, 28 Dec 2010 13:22:53 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Dec 2010 13:22:07 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Dec 2010 13:22:07 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBSLLpd8014372;
        Tue, 28 Dec 2010 13:21:52 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBSLLcTY014369;
        Tue, 28 Dec 2010 13:21:39 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Mask jump target in ftrace_dyn_arch_init_insns().
Date:   Tue, 28 Dec 2010 13:21:37 -0800
Message-Id: <1293571297-14337-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 28 Dec 2010 21:22:07.0770 (UTC) FILETIME=[4813E7A0:01CBA6D5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The current code is abusing the uasm interface by passing jump target
addresses with high bits set.  Mask the addresses to avoid annoying
messages at boot time.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 5a84a1f..72008b5 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -37,6 +37,7 @@ static inline int in_module(unsigned long ip)
 
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
 #define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
+#define JUMP_RANGE_MASK ((1UL << 28) - 1)
 
 #define INSN_B_1F_4 0x10000004	/* b 1f; offset = 4 */
 #define INSN_B_1F_5 0x10000005	/* b 1f; offset = 5 */
@@ -60,12 +61,12 @@ static inline void ftrace_dyn_arch_init_insns(void)
 
 	/* jal (ftrace_caller + 8), jump over the first two instruction */
 	buf = (u32 *)&insn_jal_ftrace_caller;
-	uasm_i_jal(&buf, (FTRACE_ADDR + 8));
+	uasm_i_jal(&buf, (FTRACE_ADDR + 8) & JUMP_RANGE_MASK);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* j ftrace_graph_caller */
 	buf = (u32 *)&insn_j_ftrace_graph_caller;
-	uasm_i_j(&buf, (unsigned long)ftrace_graph_caller);
+	uasm_i_j(&buf, (unsigned long)ftrace_graph_caller & JUMP_RANGE_MASK);
 #endif
 }
 
-- 
1.7.2.3
