Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 15:33:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29325 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009509AbaIVNdQOK9ys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 15:33:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0AAE4C6C95DEC;
        Mon, 22 Sep 2014 14:33:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:09 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:08 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: ftrace.h: Fix the MCOUNT_INSN_SIZE definition
Date:   Mon, 22 Sep 2014 14:32:58 +0100
Message-ID: <1411392779-9554-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>
References: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The MCOUNT_INSN_SIZE is meant to be used to denote the overall
size of the mcount() call. Since a jal instruction is used to
call mcount() the delay slot should be taken into consideration
as well.
This also replaces the MCOUNT_INSN_SIZE usage with the real size
of a single MIPS instruction since, as described above, the
MCOUNT_INSN_SIZE is used to denote the total overhead of the
mcount() call.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/ftrace.h | 2 +-
 arch/mips/kernel/ftrace.c      | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 992aaba603b5..70d4a35fb560 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -13,7 +13,7 @@
 #ifdef CONFIG_FUNCTION_TRACER
 
 #define MCOUNT_ADDR ((unsigned long)(_mcount))
-#define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
+#define MCOUNT_INSN_SIZE 8		/* sizeof mcount call + delay slot */
 
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 937c54bc8ccc..211460d4617d 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -28,6 +28,8 @@
 #define MCOUNT_OFFSET_INSNS 4
 #endif
 
+#define FTRACE_MIPS_INSN_SIZE 4 /* Size of single MIPS instruction */
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Arch override because MIPS doesn't need to run this from stop_machine() */
@@ -395,7 +397,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	 */
 
 	insns = in_kernel_space(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
-	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
+	trace.func = self_ra - (FTRACE_MIPS_INSN_SIZE * insns);
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
-- 
2.1.0
