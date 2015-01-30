Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:10:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60535 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012301AbbA3MKTKFTvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:10:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5C2B9BA90F788
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:10:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:10:13 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:10:11 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 01/10] MIPS: push .set arch=r4000 into the functions needing it
Date:   Fri, 30 Jan 2015 12:09:30 +0000
Message-ID: <1422619779-9940-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
References: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45563
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

The {save,restore}_fp_context{,32} functions require that the assembler
allows the use of sdc instructions on any FP register, and this is
acomplished by setting the arch to r4000. However this has the effect
of enabling the assembler to use mips64 instructions in the expansion
of pseudo-instructions. This was done in the (now-reverted) commit
eec43a224cf1 "MIPS: Save/restore MSA context around signals" which
led to my mistakenly believing that there was an assembler bug, when
in reality the assembler was just emitting mips64 instructions. Avoid
the issue for future commits which will add code to r4k_fpu.S by
pushing the .set arch=r4000 directives into the functions that require
it, and remove the spurious assertion declaring the assembler bug.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v3.19-rc6.
---
 arch/mips/include/asm/asmmacro.h | 12 ++++--------
 arch/mips/kernel/r4k_fpu.S       |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6caf876..a4a5ec8 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -324,8 +324,7 @@
 	SET_HARDFLOAT
 	.insn
 	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
-	/* move triggers an assembler bug... */
-	or	\rd, $1, zero
+	move	\rd, $1
 	.set	pop
 	.endm
 
@@ -335,8 +334,7 @@
 	SET_HARDFLOAT
 	.insn
 	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
-	/* move triggers an assembler bug... */
-	or	\rd, $1, zero
+	move	\rd, $1
 	.set	pop
 	.endm
 
@@ -344,8 +342,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	/* move triggers an assembler bug... */
-	or	$1, \rs, zero
+	move	$1, \rs
 	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
@@ -354,8 +351,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	/* move triggers an assembler bug... */
-	or	$1, \rs, zero
+	move	$1, \rs
 	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 6c160c6..02872df 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -34,7 +34,6 @@
 	.endm
 
 	.set	noreorder
-	.set	arch=r4000
 
 LEAF(_save_fp_context)
 	.set	push
@@ -102,6 +101,7 @@ LEAF(_save_fp_context)
 	/* Save 32-bit process floating point context */
 LEAF(_save_fp_context32)
 	.set push
+	.set arch=r4000
 	SET_HARDFLOAT
 	cfc1	t1, fcr31
 
-- 
2.2.2
