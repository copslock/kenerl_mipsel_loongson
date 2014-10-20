Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 10:39:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15913 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011880AbaJTIjmOHlTm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 10:39:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E18EF3EAB8CB8;
        Mon, 20 Oct 2014 09:39:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 20 Oct 2014 09:39:35 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.141) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 20 Oct 2014 09:39:34 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: ftrace: Fix a microMIPS build problem
Date:   Mon, 20 Oct 2014 09:39:31 +0100
Message-ID: <1413794371-5272-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.141]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43349
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

Code before the .fixup section needs to have the .insn directive.
This has no side effects on MIPS32/64 but it affects the way microMIPS
loads the address for the return label.

Fixes the following build problem:
mips-linux-gnu-ld: arch/mips/built-in.o: .fixup+0x4a0: Unsupported jump between
ISA modes; consider recompiling with interlinking enabled.
mips-linux-gnu-ld: final link failed: Bad value
Makefile:819: recipe for target 'vmlinux' failed

The fix is similar to 1658f914ff91c3bf ("MIPS: microMIPS:
Disable LL/SC and fix linker bug.")

Cc: stable@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 992aaba603b5..b463f2aa5a61 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -24,7 +24,7 @@ do {							\
 	asm volatile (					\
 		"1: " load " %[tmp_dst], 0(%[tmp_src])\n"	\
 		"   li %[tmp_err], 0\n"			\
-		"2:\n"					\
+		"2: .insn\n"				\
 							\
 		".section .fixup, \"ax\"\n"		\
 		"3: li %[tmp_err], 1\n"			\
@@ -46,7 +46,7 @@ do {						\
 	asm volatile (				\
 		"1: " store " %[tmp_src], 0(%[tmp_dst])\n"\
 		"   li %[tmp_err], 0\n"		\
-		"2:\n"				\
+		"2: .insn\n"			\
 						\
 		".section .fixup, \"ax\"\n"	\
 		"3: li %[tmp_err], 1\n"		\
-- 
2.1.2
