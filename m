Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:31:59 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCPObPNnmj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:31:15 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D37ACB50;
        Thu, 16 Mar 2017 14:31:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 15/35] MIPS: Netlogic: Fix CP0_EBASE redefinition warnings
Date:   Thu, 16 Mar 2017 23:29:34 +0900
Message-Id: <20170316142907.729850853@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142906.685052998@linuxfoundation.org>
References: <20170316142906.685052998@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 32eb6e8bee147b45e5e59230630d59541ccbb6e5 upstream.

A couple of netlogic assembly files define CP0_EBASE to $15, the same as
CP0_PRID in mipsregs.h, and use it for accessing both CP0_PRId and
CP0_EBase registers. However commit 609cf6f2291a ("MIPS: CPS: Early
debug using an ns16550-compatible UART") added a different definition of
CP0_EBASE to mipsregs.h, which included a register select of 1. This
causes harmless build warnings like the following:

  arch/mips/netlogic/common/reset.S:53:0: warning: "CP0_EBASE" redefined
  #define CP0_EBASE $15
  ^
  In file included from arch/mips/netlogic/common/reset.S:41:0:
  ./arch/mips/include/asm/mipsregs.h:63:0: note: this is the location of the previous definition
  #define CP0_EBASE $15, 1
  ^

Update the code to use the definitions from mipsregs.h for accessing
both registers.

Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Jayachandran C <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13183/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/netlogic/common/reset.S   |   11 +++++------
 arch/mips/netlogic/common/smpboot.S |    4 +---
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -50,7 +50,6 @@
 #include <asm/netlogic/xlp-hal/sys.h>
 #include <asm/netlogic/xlp-hal/cpucontrol.h>
 
-#define CP0_EBASE	$15
 #define SYS_CPU_COHERENT_BASE	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
 			XLP_IO_SYS_OFFSET(0) + XLP_IO_PCI_HDRSZ + \
 			SYS_CPU_NONCOHERENT_MODE * 4
@@ -92,7 +91,7 @@
  * registers. On XLPII CPUs, usual cache instructions work.
  */
 .macro	xlp_flush_l1_dcache
-	mfc0	t0, CP0_EBASE, 0
+	mfc0	t0, CP0_PRID
 	andi	t0, t0, PRID_IMP_MASK
 	slt	t1, t0, 0x1200
 	beqz	t1, 15f
@@ -171,7 +170,7 @@ FEXPORT(nlm_reset_entry)
 	nop
 
 1:	/* Entry point on core wakeup */
-	mfc0	t0, CP0_EBASE, 0	/* processor ID */
+	mfc0	t0, CP0_PRID		/* processor ID */
 	andi	t0, PRID_IMP_MASK
 	li	t1, 0x1500		/* XLP 9xx */
 	beq	t0, t1, 2f		/* does not need to set coherent */
@@ -182,8 +181,8 @@ FEXPORT(nlm_reset_entry)
 	nop
 
 	/* set bit in SYS coherent register for the core */
-	mfc0	t0, CP0_EBASE, 1
-	mfc0	t1, CP0_EBASE, 1
+	mfc0	t0, CP0_EBASE
+	mfc0	t1, CP0_EBASE
 	srl	t1, 5
 	andi	t1, 0x3			/* t1 <- node */
 	li	t2, 0x40000
@@ -232,7 +231,7 @@ EXPORT(nlm_boot_siblings)
 
 	 * NOTE: All GPR contents are lost after the mtcr above!
 	 */
-	mfc0	v0, CP0_EBASE, 1
+	mfc0	v0, CP0_EBASE
 	andi	v0, 0x3ff		/* v0 <- node/core */
 
 	/*
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -48,8 +48,6 @@
 #include <asm/netlogic/xlp-hal/sys.h>
 #include <asm/netlogic/xlp-hal/cpucontrol.h>
 
-#define CP0_EBASE	$15
-
 	.set	noreorder
 	.set	noat
 	.set	arch=xlr		/* for mfcr/mtcr, XLR is sufficient */
@@ -86,7 +84,7 @@ NESTED(nlm_boot_secondary_cpus, 16, sp)
 	PTR_L	gp, 0(t1)
 
 	/* a0 has the processor id */
-	mfc0	a0, CP0_EBASE, 1
+	mfc0	a0, CP0_EBASE
 	andi	a0, 0x3ff		/* a0 <- node/core */
 	PTR_LA	t0, nlm_early_init_secondary
 	jalr	t0
