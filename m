Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 11:36:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52385 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991672AbdBHKgE6SxQE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 11:36:04 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 198FA1DC9EB77;
        Wed,  8 Feb 2017 10:35:56 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 8 Feb 2017 10:35:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Fix protected_cache(e)_op() for microMIPS
Date:   Wed, 8 Feb 2017 10:35:47 +0000
Message-ID: <20170208103547.22560-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

When building for microMIPS we need to ensure that the assembler always
knows that there is code at the target of a branch or jump. Commit
7170bdc77755 ("MIPS: Add return errors to protected cache ops")
introduced a fixup path to protected_cache(e)_op() which does not meet
this requirement. The fixup path jumps to the "2" label but we don't
know what will be placed at that label since it's at the end of the
inline asm. If the inline asm happens to be followed by an instruction
manually encoded with .word or similar then the toolchain will not know
that "2" labels code and linking will fail with:

  mips-img-linux-gnu-ld: arch/mips/mm/c-r4k.o: .fixup+0x0: Unsupported
  jump between ISA modes; consider recompiling with interlinking
  enabled.

Fix this by declaring that "2" labels code using the .insn directive.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 7170bdc77755 ("MIPS: Add return errors to protected cache ops")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
Ralf: This fixes microMIPS build since a patch that is already merged
into kvm/next. I was going to send you a pull request for those patches
anyway, so it probably makes sense if I just append to that branch first
and let the fix get upstream via the MIPS tree.
---
 arch/mips/include/asm/r4kcache.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 7227c158cbf8..55fd94e6cd0b 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -154,7 +154,8 @@ static inline void flush_scache_line(unsigned long addr)
 	"	.set	noreorder		\n"		\
 	"	.set "MIPS_ISA_ARCH_LEVEL"	\n"		\
 	"1:	cache	%1, (%2)		\n"		\
-	"2:	.set	pop			\n"		\
+	"2:	.insn				\n"		\
+	"	.set	pop			\n"		\
 	"	.section .fixup,\"ax\"		\n"		\
 	"3:	li	%0, %3			\n"		\
 	"	j	2b			\n"		\
@@ -177,7 +178,8 @@ static inline void flush_scache_line(unsigned long addr)
 	"	.set	mips0			\n"		\
 	"	.set	eva			\n"		\
 	"1:	cachee	%1, (%2)		\n"		\
-	"2:	.set	pop			\n"		\
+	"2:	.insn				\n"		\
+	"	.set	pop			\n"		\
 	"	.section .fixup,\"ax\"		\n"		\
 	"3:	li	%0, %3			\n"		\
 	"	j	2b			\n"		\
-- 
2.11.0
