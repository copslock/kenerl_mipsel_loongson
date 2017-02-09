Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 15:06:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18850 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990601AbdBIOFr0qvhz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 15:05:47 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2AF45733048A9;
        Thu,  9 Feb 2017 14:05:38 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Feb 2017 14:05:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, "Maciej W. Rozycki" <macro@imgtec.com>
Subject: [PATCH v2] MIPS: Fix protected_cache(e)_op() for microMIPS
Date:   Thu, 9 Feb 2017 14:04:53 +0000
Message-ID: <20170209140453.26188-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56741
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
this requirement. The fixup path jumps to the "2" label but the .section
pseudo-op immediately following it causes the label to be marked as
data. Linking then fails with:

  mips-img-linux-gnu-ld: arch/mips/mm/c-r4k.o: .fixup+0x0: Unsupported
  jump between ISA modes; consider recompiling with interlinking
  enabled.

Fix this by declaring that "2" labels code using the .insn directive.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Fixes: 7170bdc77755 ("MIPS: Add return errors to protected cache ops")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
---
Ralf: This fixes microMIPS build since a patch that is already merged
into kvm/next. I was going to send you a pull request for those patches
anyway, so it probably makes sense if I just append to that branch first
and let the fix get upstream via the MIPS tree.

Changes in v2:
- Correct description, its the .section, not any following assembly
  which triggers the issue (Maciej)
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
