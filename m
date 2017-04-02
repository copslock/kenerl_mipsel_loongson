Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:11:15 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991111AbdDBDKBceGEH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtw-0003GR-3C; Sun, 02 Apr 2017 04:10:00 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0004RB-0K; Sun, 02 Apr 2017 04:09:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.383525531@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 23/26] MIPS: Push .set mips64r* into the functions
 needing it
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.43-rc2 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 631afc65e8f4f845945ef9e90236d10cee601498 upstream.

The {save,restore}_fp_context{,32} functions require that the assembler
allows the use of sdc instructions on any FP register, and this is
acomplished by setting the arch to mips64r2 or mips64r6
(using MIPS_ISA_ARCH_LEVEL_RAW).

However this has the effect of enabling the assembler to use mips64
instructions in the expansion of pseudo-instructions. This was done in
the (now-reverted) commit eec43a224cf1 "MIPS: Save/restore MSA context
around signals" which led to my mistakenly believing that there was an
assembler bug, when in reality the assembler was just emitting mips64
instructions. Avoid the issue for future commits which will add code to
r4k_fpu.S by pushing the .set MIPS_ISA_ARCH_LEVEL_RAW directives into
the functions that require it, and remove the spurious assertion
declaring the assembler bug.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
[james.hogan@imgtec.com: Rebase on v4.0-rc1 and reword commit message to
 reflect use of MIPS_ISA_ARCH_LEVEL_RAW]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9612/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: in r4k_fpu.S, keep using arch=r4000]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 12 ++++--------
 arch/mips/kernel/r4k_fpu.S       |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

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
 
