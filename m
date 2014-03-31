Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 01:58:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41096 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822260AbaCaX5pYBZtZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 01:57:45 +0200
Date:   Tue, 1 Apr 2014 00:57:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: csum_partial.S CPU_DADDI_WORKAROUNDS bug fix
In-Reply-To: <alpine.LFD.2.11.1404010020510.27402@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1404010042130.27402@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404010020510.27402@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39600
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

This change reverts most of commit 
60724ca59eda766a30be57aec6b49bc3e2bead91 [MIPS: IP checksums: Remove 
unncessary .set pseudos] that introduced warnings with the 
CPU_DADDI_WORKAROUNDS option set:

arch/mips/lib/csum_partial.S: Assembler messages:
arch/mips/lib/csum_partial.S:450: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:450: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:450: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:452: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:452: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:452: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:454: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:454: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:454: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:456: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:456: Warning: used $3 with ".set at=$3"
arch/mips/lib/csum_partial.S:456: Warning: used $3 with ".set at=$3"
[and so on, and so on...]

The warnings are benign and good code is produced regardless because no 
macros that'd use the assembler's temporary register are involved, however 
the `.set noat' directives removed by the commit referred are crucial to 
guarantee this is still going to be the case after any changes in the 
future.  Therefore they need to be brought back to place which this 
change does.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 It take it is because of the lack of -Werror enabled for this file it 
took so long to discover the problem.  What would those "meaningful 
warnings" you referred to in 60724ca59eda766a30be57aec6b49bc3e2bead91 be 
anyway?

  Maciej

linux-mips-csum-partial-nodaddi-fix.patch
Index: linux-20140329-4maxp64/arch/mips/lib/csum_partial.S
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/lib/csum_partial.S
+++ linux-20140329-4maxp64/arch/mips/lib/csum_partial.S
@@ -55,14 +55,20 @@
 #define UNIT(unit)  ((unit)*NBYTES)
 
 #define ADDC(sum,reg)						\
+	.set	push;						\
+	.set	noat;						\
 	ADD	sum, reg;					\
 	sltu	v1, sum, reg;					\
 	ADD	sum, v1;					\
+	.set	pop
 
 #define ADDC32(sum,reg)						\
+	.set	push;						\
+	.set	noat;						\
 	addu	sum, reg;					\
 	sltu	v1, sum, reg;					\
 	addu	sum, v1;					\
+	.set	pop
 
 #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
 	LOAD	_t0, (offset + UNIT(0))(src);			\
@@ -662,6 +668,8 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	ADDC(sum, t2)
 .Ldone:
 	/* fold checksum */
+	.set	push
+	.set	noat
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
 	daddu	sum, v1
@@ -684,6 +692,7 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	or	sum, sum, t0
 1:
 #endif
+	.set	pop
 	.set reorder
 	ADDC32(sum, psum)
 	jr	ra
