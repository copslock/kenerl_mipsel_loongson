Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2014 02:24:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56099 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008892AbaLQBYdUJvKg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Dec 2014 02:24:33 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBH1OWXn029341;
        Wed, 17 Dec 2014 02:24:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBH1OVHB029340;
        Wed, 17 Dec 2014 02:24:31 +0100
Date:   Wed, 17 Dec 2014 02:24:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Subject: Current kernels on Qemu
Message-ID: <20141217012431.GA28093@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Commit 4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05 (MIPS: Support for hybrid
FPRs) changes the kernel to execute read_c0_config5() even on processors
that don't have a Config5 register.  According to the arch spec the
behaviour of trying to read or write this register is UNDEFINED where this
register doesn't exist, that is merely looking at this register is
already cruel because that might kill a kitten.

In case of Qemu older than v2.2 Qemu has elected to implement this
UNDEFINED behaviour by taking a RI exception - which then fries the
kernel:

[...]
Freeing YAMON memory: 956k freed
Freeing unused kernel memory: 240K (80674000 - 806b0000)
Reserved instruction in kernel code[#1]:
CPU: 0 PID: 1 Comm: init Not tainted 3.18.0-rc6-00058-g4227a2d #26
task: 86047588 ti: 86048000 task.ti: 86048000
$ 0   : 00000000 77a638cc 00000000 00000000
[...]

For qemu v2.2.0 commit f31b035a9f10dc9b57f01c426110af845d453ce2
(target-mips: correctly handle access to unimplemented CP0 register)
changed the behaviour to returning zero on read and ignoring writes
which more matches how typical hardware implementations actually behave.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/fpu.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 994d219..978a2a4 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -64,7 +64,7 @@ static inline int __enable_fpu(enum fpu_mode mode)
 			return SIGFPE;
 
 		/* set FRE */
-		write_c0_config5(read_c0_config5() | MIPS_CONF5_FRE);
+		set_c0_config5(MIPS_CONF5_FRE);
 		goto fr_common;
 
 	case FPU_64BIT:
@@ -74,8 +74,10 @@ static inline int __enable_fpu(enum fpu_mode mode)
 #endif
 		/* fall through */
 	case FPU_32BIT:
-		/* clear FRE */
-		write_c0_config5(read_c0_config5() & ~MIPS_CONF5_FRE);
+		if (cpu_has_fre) {
+			/* clear FRE */
+			clear_c0_config5(MIPS_CONF5_FRE);
+		}
 fr_common:
 		/* set CU1 & change FR appropriately */
 		fr = (int)mode & FPU_FR_MASK;
@@ -182,16 +184,20 @@ static inline int init_fpu(void)
 	int ret = 0;
 
 	if (cpu_has_fpu) {
+		unsigned int config5;
+
 		ret = __own_fpu();
-		if (!ret) {
-			unsigned int config5 = read_c0_config5();
+		if (ret)
+			return ret;
 
+		if (cpu_has_fre) {
 			/*
 			 * Ensure FRE is clear whilst running _init_fpu, since
 			 * single precision FP instructions are used. If FRE
 			 * was set then we'll just end up initialising all 32
 			 * 64b registers.
 			 */
+			config5 = read_c0_config5();
 			write_c0_config5(config5 & ~MIPS_CONF5_FRE);
 			enable_fpu_hazard();
 
@@ -200,7 +206,12 @@ static inline int init_fpu(void)
 			/* Restore FRE */
 			write_c0_config5(config5);
 			enable_fpu_hazard();
+
+			return 0;
 		}
+
+		_init_fpu();
+		
 	} else
 		fpu_emulator_init_fpu();
 
