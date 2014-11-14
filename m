Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 13:27:13 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:33224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013705AbaKNM0yJZt1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 13:26:54 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15E5475020;
        Fri, 14 Nov 2014 12:26:53 +0000 (UTC)
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.83)
        (envelope-from <jslaby@suse.cz>)
        id 1XpFxe-0002X4-7t; Fri, 14 Nov 2014 13:26:46 +0100
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: ftrace: Fix a microMIPS build problem
Date:   Fri, 14 Nov 2014 13:25:15 +0100
Message-Id: <1415968006-9521-15-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1415968006-9521-1-git-send-email-jslaby@suse.cz>
References: <1415968006-9521-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit aedd153f5bb5b1f1d6d9142014f521ae2ec294cc upstream.

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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8117/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9af0c28..370ae7cc588a 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -24,7 +24,7 @@ do {							\
 	asm volatile (					\
 		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
 		"   li %[" STR(error) "], 0\n"		\
-		"2:\n"					\
+		"2: .insn\n"				\
 							\
 		".section .fixup, \"ax\"\n"		\
 		"3: li %[" STR(error) "], 1\n"		\
@@ -46,7 +46,7 @@ do {						\
 	asm volatile (				\
 		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
 		"   li %[" STR(error) "], 0\n"	\
-		"2:\n"				\
+		"2: .insn\n"			\
 						\
 		".section .fixup, \"ax\"\n"	\
 		"3: li %[" STR(error) "], 1\n"	\
-- 
2.1.3
