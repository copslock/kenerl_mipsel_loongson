Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:24:56 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43579 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827348AbaA0UWbZr0kP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 14/58] MIPS: lib: strncpy_user: Use macro to build the strncpy_from_user symbol
Date:   Mon, 27 Jan 2014 20:19:01 +0000
Message-ID: <1390853985-14246-15-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_26
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39132
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

Build the __strncpy_from_user symbol using a macro. In EVA mode we will
need to use similar code to do the userspace load operations so
it is better if we use a macro to avoid code duplications.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/strncpy_user.S | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 92870b6..51b38ab 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -28,16 +28,17 @@
  * it happens at most some bytes of the exceptions handlers will be copied.
  */
 
-LEAF(__strncpy_from_user_asm)
+	.macro __BUILD_STRNCPY_ASM func
+LEAF(__strncpy_from_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a1
-	bnez		v0, .Lfault
+	bnez		v0, .Lfault\@
 
-FEXPORT(__strncpy_from_user_nocheck_asm)
+FEXPORT(__strncpy_from_\func\()_nocheck_asm)
 	.set		noreorder
 	move		t0, zero
 	move		v1, a1
-1:	EX(lbu, v0, (v1), .Lfault)
+1:	EX(lbu, v0, (v1), .Lfault\@)
 	PTR_ADDIU	v1, 1
 	R10KCBARRIER(0(ra))
 	beqz		v0, 2f
@@ -47,15 +48,19 @@ FEXPORT(__strncpy_from_user_nocheck_asm)
 	 PTR_ADDIU	a0, 1
 2:	PTR_ADDU	v0, a1, t0
 	xor		v0, a1
-	bltz		v0, .Lfault
+	bltz		v0, .Lfault\@
 	 nop
 	jr		ra			# return n
 	 move		v0, t0
-	END(__strncpy_from_user_asm)
+	END(__strncpy_from_\func\()_asm)
 
-.Lfault: jr		ra
+.Lfault\@: jr		ra
 	  li		v0, -EFAULT
 
 	.section	__ex_table,"a"
-	PTR		1b, .Lfault
+	PTR		1b, .Lfault\@
 	.previous
+
+	.endm
+
+__BUILD_STRNCPY_ASM user
-- 
1.8.5.3
