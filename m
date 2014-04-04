Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 04:32:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53758 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900AbaDDCc3ljLuN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 04:32:29 +0200
Date:   Fri, 4 Apr 2014 03:32:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH v2 2/3] MIPS: __strncpy_from_user_asm CPU_DADDI_WORKAROUNDS
 bug fix
Message-ID: <alpine.LFD.2.11.1404040311580.18978@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

This corrects assembler warnings and broken code generated in 
__strncpy_from_user_asm:

arch/mips/lib/strncpy_user.S: Assembler messages:
arch/mips/lib/strncpy_user.S:52: Warning: Macro instruction expanded into 
multiple instructions in a branch delay slot

with the CPU_DADDI_WORKAROUNDS option set.  The function schedules delay 
slots manually where there is really no need to as GAS is happy to do it 
all itself, so undo it all and remove `.set noreorder'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-strncpy-user-nodaddi-fix.patch
Index: linux-20140404-4maxp64/arch/mips/lib/strncpy_user.S
===================================================================
--- linux-20140404-4maxp64.orig/arch/mips/lib/strncpy_user.S
+++ linux-20140404-4maxp64/arch/mips/lib/strncpy_user.S
@@ -35,7 +35,6 @@ LEAF(__strncpy_from_\func\()_asm)
 	bnez		v0, .Lfault\@
 
 FEXPORT(__strncpy_from_\func\()_nocheck_asm)
-	.set		noreorder
 	move		t0, zero
 	move		v1, a1
 .ifeqs "\func","kernel"
@@ -45,21 +44,21 @@ FEXPORT(__strncpy_from_\func\()_nocheck_
 .endif
 	PTR_ADDIU	v1, 1
 	R10KCBARRIER(0(ra))
+	sb		v0, (a0)
 	beqz		v0, 2f
-	 sb		v0, (a0)
 	PTR_ADDIU	t0, 1
+	PTR_ADDIU	a0, 1
 	bne		t0, a2, 1b
-	 PTR_ADDIU	a0, 1
 2:	PTR_ADDU	v0, a1, t0
 	xor		v0, a1
 	bltz		v0, .Lfault\@
-	 nop
+	move		v0, t0
 	jr		ra			# return n
-	 move		v0, t0
 	END(__strncpy_from_\func\()_asm)
 
-.Lfault\@: jr		ra
-	  li		v0, -EFAULT
+.Lfault\@:
+	li		v0, -EFAULT
+	jr		ra
 
 	.section	__ex_table,"a"
 	PTR		1b, .Lfault\@
