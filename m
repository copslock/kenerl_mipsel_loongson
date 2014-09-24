Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:46:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1131 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008868AbaIXJqf5NpSG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:46:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 91D785EEBD4E4
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:46:26 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:46:28 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:46:28 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:46:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/11] MIPS: push .set arch=r4000 into the functions needing it
Date:   Wed, 24 Sep 2014 10:45:32 +0100
Message-ID: <1411551942-11153-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.158]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42756
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
 arch/mips/include/asm/asmmacro.h | 12 ++++--------
 arch/mips/kernel/r4k_fpu.S       | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index cd9a98b..f6293ef 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -312,8 +312,7 @@
 	.set	noat
 	.insn
 	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
-	/* move triggers an assembler bug... */
-	or	\rd, $1, zero
+	move	\rd, $1
 	.set	pop
 	.endm
 
@@ -322,16 +321,14 @@
 	.set	noat
 	.insn
 	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
-	/* move triggers an assembler bug... */
-	or	\rd, $1, zero
+	move	\rd, $1
 	.set	pop
 	.endm
 
 	.macro	insert_w	wd, n, rs
 	.set	push
 	.set	noat
-	/* move triggers an assembler bug... */
-	or	$1, \rs, zero
+	move	$1, \rs
 	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
@@ -339,8 +336,7 @@
 	.macro	insert_d	wd, n, rs
 	.set	push
 	.set	noat
-	/* move triggers an assembler bug... */
-	or	$1, \rs, zero
+	move	$1, \rs
 	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 8352523..787d3db 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -30,9 +30,10 @@
 	.endm
 
 	.set	noreorder
-	.set	arch=r4000
 
 LEAF(_save_fp_context)
+	.set	push
+	.set	arch=r4000
 	cfc1	t1, fcr31
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
@@ -84,11 +85,14 @@ LEAF(_save_fp_context)
 	EX	sw t1, SC_FPC_CSR(a0)
 	jr	ra
 	 li	v0, 0					# success
+	.set	pop
 	END(_save_fp_context)
 
 #ifdef CONFIG_MIPS32_COMPAT
 	/* Save 32-bit process floating point context */
 LEAF(_save_fp_context32)
+	.set	push
+	.set	arch=r4000
 	cfc1	t1, fcr31
 
 	mfc0	t0, CP0_STATUS
@@ -137,6 +141,7 @@ LEAF(_save_fp_context32)
 
 	jr	ra
 	 li	v0, 0					# success
+	.set	pop
 	END(_save_fp_context32)
 #endif
 
@@ -146,6 +151,8 @@ LEAF(_save_fp_context32)
  *  - cp1 status/control register
  */
 LEAF(_restore_fp_context)
+	.set	push
+	.set	arch=r4000
 	EX	lw t1, SC_FPC_CSR(a0)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
@@ -194,10 +201,13 @@ LEAF(_restore_fp_context)
 	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
+	.set	pop
 	END(_restore_fp_context)
 
 #ifdef CONFIG_MIPS32_COMPAT
 LEAF(_restore_fp_context32)
+	.set	push
+	.set	arch=r4000
 	/* Restore an o32 sigcontext.  */
 	EX	lw t1, SC32_FPC_CSR(a0)
 
@@ -242,6 +252,7 @@ LEAF(_restore_fp_context32)
 	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
+	.set	pop
 	END(_restore_fp_context32)
 #endif
 
-- 
2.0.4
