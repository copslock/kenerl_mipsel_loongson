Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 15:33:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8121 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009516AbaIVNdRefbbq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 15:33:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 50C63987E8DAD;
        Mon, 22 Sep 2014 14:33:08 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 22 Sep
 2014 14:33:10 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:10 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: mcount: Fix selfpc address for static trace
Date:   Mon, 22 Sep 2014 14:32:59 +0100
Message-ID: <1411392779-9554-3-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 42726
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

According to Documentation/trace/ftrace-design.txt, the selfpc
should be the return address minus the mcount overhead (8 bytes).
This brings static trace in line with the dynamic trace regarding
the selfpc argument to the tracing function.

This also removes the magic number '8' with the proper
MCOUNT_INSN_SIZE.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mcount.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 2f7c734771f4..3af48b7c7a47 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -79,7 +79,7 @@ _mcount:
 	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
 #endif
 
-	PTR_SUBU a0, ra, 8	/* arg1: self address */
+	PTR_SUBU a0, ra, MCOUNT_INSN_SIZE /* arg1: self address */
 	PTR_LA   t1, _stext
 	sltu     t2, a0, t1	/* t2 = (a0 < _stext) */
 	PTR_LA   t1, _etext
@@ -138,7 +138,7 @@ NESTED(_mcount, PT_SIZE, ra)
 static_trace:
 	MCOUNT_SAVE_REGS
 
-	move	a0, ra		/* arg1: self return address */
+	PTR_SUBU a0, ra, MCOUNT_INSN_SIZE	/* arg1: self address */
 	jalr	t2		/* (1) call *ftrace_trace_function */
 	 move	a1, AT		/* arg2: parent's return address */
 
-- 
2.1.0
