Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:20:52 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48823 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008664AbaLRKUqlHbGP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:20:46 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:20:41 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 01/12] MIPS: OCTEON: Save/Restore wider multiply registers in OCTEON III CPUs
Date:   Thu, 18 Dec 2014 13:17:53 +0300
Message-ID: <1418897888-17669-2-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

The wide multiplier is twice as wide, so we need to save twice as much
state.  Detect the multiplier type (CPU type) at start up and install
model specific handlers.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
[aleksey.makarov@auriga.com:
	conflict resolution,
	support for old compilers]
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/setup.c       |  37 ++++++++++
 arch/mips/include/asm/octeon/octeon.h |  13 ++++
 arch/mips/include/asm/ptrace.h        |   4 +-
 arch/mips/kernel/octeon_switch.S      | 128 ++++++++++++++++++++++++++--------
 4 files changed, 150 insertions(+), 32 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 5ebdb32..627f9e8 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -615,6 +615,7 @@ void __init prom_init(void)
 	const char *arg;
 	char *p;
 	int i;
+	u64 t;
 	int argc;
 #ifdef CONFIG_CAVIUM_RESERVE32
 	int64_t addr = -1;
@@ -663,6 +664,42 @@ void __init prom_init(void)
 		octeon_io_clock_rate = sysinfo->cpu_clock_hz;
 	}
 
+	t = read_c0_cvmctl();
+	if ((t & (1ull << 27)) == 0) {
+		/*
+		 * Setup the multiplier save/restore code if
+		 * CvmCtl[NOMUL] clear.
+		 */
+		void *save;
+		void *save_end;
+		void *restore;
+		void *restore_end;
+		int save_len;
+		int restore_len;
+		int save_max = (char *)octeon_mult_save_end -
+			(char *)octeon_mult_save;
+		int restore_max = (char *)octeon_mult_restore_end -
+			(char *)octeon_mult_restore;
+		if (current_cpu_data.cputype == CPU_CAVIUM_OCTEON3) {
+			save = octeon_mult_save3;
+			save_end = octeon_mult_save3_end;
+			restore = octeon_mult_restore3;
+			restore_end = octeon_mult_restore3_end;
+		} else {
+			save = octeon_mult_save2;
+			save_end = octeon_mult_save2_end;
+			restore = octeon_mult_restore2;
+			restore_end = octeon_mult_restore2_end;
+		}
+		save_len = (char *)save_end - (char *)save;
+		restore_len = (char *)restore_end - (char *)restore;
+		if (!WARN_ON(save_len > save_max ||
+				restore_len > restore_max)) {
+			memcpy(octeon_mult_save, save, save_len);
+			memcpy(octeon_mult_restore, restore, restore_len);
+		}
+	}
+
 	/*
 	 * Only enable the LED controller if we're running on a CN38XX, CN58XX,
 	 * or CN56XX. The CN30XX and CN31XX don't have an LED controller.
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index d781f9e..3e505a2 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -229,6 +229,19 @@ static inline void octeon_npi_write32(uint64_t address, uint32_t val)
 	cvmx_read64_uint32(address ^ 4);
 }
 
+/* Octeon multiplier save/restore routines from octeon_switch.S */
+void octeon_mult_save(void);
+void octeon_mult_restore(void);
+void octeon_mult_save_end(void);
+void octeon_mult_restore_end(void);
+void octeon_mult_save3(void);
+void octeon_mult_save3_end(void);
+void octeon_mult_save2(void);
+void octeon_mult_save2_end(void);
+void octeon_mult_restore3(void);
+void octeon_mult_restore3_end(void);
+void octeon_mult_restore2(void);
+void octeon_mult_restore2_end(void);
 
 /**
  * Read a 32bit value from the Octeon NPI register space
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index fc783f8..ffc3203 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -40,8 +40,8 @@ struct pt_regs {
 	unsigned long cp0_cause;
 	unsigned long cp0_epc;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-	unsigned long long mpl[3];	  /* MTM{0,1,2} */
-	unsigned long long mtp[3];	  /* MTP{0,1,2} */
+	unsigned long long mpl[6];        /* MTM{0-5} */
+	unsigned long long mtp[6];        /* MTP{0-5} */
 #endif
 } __aligned(8);
 
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index f654768..3dec1e8 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -450,18 +450,23 @@ done_restore:
  * void octeon_mult_save()
  * sp is assumed to point to a struct pt_regs
  *
- * NOTE: This is called in SAVE_SOME in stackframe.h. It can only
- *	 safely modify k0 and k1.
+ * NOTE: This is called in SAVE_TEMP in stackframe.h. It can
+ *       safely modify v1,k0, k1,$10-$15, and $24.  It will
+ *	 be overwritten with a processor specific version of the code.
  */
-	.align	7
+	.p2align 7
 	.set push
 	.set noreorder
 	LEAF(octeon_mult_save)
-	dmfc0	k0, $9,7	/* CvmCtl register. */
-	bbit1	k0, 27, 1f	/* Skip CvmCtl[NOMUL] */
+	jr	ra
 	 nop
+	.space 30 * 4, 0
+octeon_mult_save_end:
+	EXPORT(octeon_mult_save_end)
+	END(octeon_mult_save)
 
-	/* Save the multiplier state */
+	LEAF(octeon_mult_save2)
+	/* Save the multiplier state OCTEON II and earlier*/
 	v3mulu	k0, $0, $0
 	v3mulu	k1, $0, $0
 	sd	k0, PT_MTP(sp)	      /* PT_MTP	   has P0 */
@@ -476,44 +481,107 @@ done_restore:
 	sd	k0, PT_MPL+8(sp)      /* PT_MPL+8  has MPL1 */
 	jr	ra
 	 sd	k1, PT_MPL+16(sp)     /* PT_MPL+16 has MPL2 */
-
-1:	/* Resume here if CvmCtl[NOMUL] */
+octeon_mult_save2_end:
+	EXPORT(octeon_mult_save2_end)
+	END(octeon_mult_save2)
+
+	LEAF(octeon_mult_save3)
+	/* Save the multiplier state OCTEON III */
+	v3mulu	$10, $0, $0		/* read P0 */
+	v3mulu	$11, $0, $0		/* read P1 */
+	v3mulu	$12, $0, $0		/* read P2 */
+	sd	$10, PT_MTP+(0*8)(sp)	/* store P0 */
+	v3mulu	$10, $0, $0		/* read P3 */
+	sd	$11, PT_MTP+(1*8)(sp)	/*  store P1 */
+	v3mulu	$11, $0, $0		/* read P4 */
+	sd	$12, PT_MTP+(2*8)(sp)	/* store P2 */
+	ori	$13, $0, 1
+	v3mulu	$12, $0, $0		/* read P5 */
+	sd	$10, PT_MTP+(3*8)(sp)	/* store P3 */
+	v3mulu	$13, $13, $0		/* P4-P0 = MPL5-MPL1, $13 = MPL0 */
+	sd	$11, PT_MTP+(4*8)(sp)	/* store P4 */
+	v3mulu	$10, $0, $0		/* read MPL1 */
+	sd	$12, PT_MTP+(5*8)(sp)	/* store P5 */
+	v3mulu	$11, $0, $0		/* read MPL2 */
+	sd	$13, PT_MPL+(0*8)(sp)	/* store MPL0 */
+	v3mulu	$12, $0, $0		/* read MPL3 */
+	sd	$10, PT_MPL+(1*8)(sp)	/* store MPL1 */
+	v3mulu	$10, $0, $0		/* read MPL4 */
+	sd	$11, PT_MPL+(2*8)(sp)	/* store MPL2 */
+	v3mulu	$11, $0, $0		/* read MPL5 */
+	sd	$12, PT_MPL+(3*8)(sp)	/* store MPL3 */
+	sd	$10, PT_MPL+(4*8)(sp)	/* store MPL4 */
 	jr	ra
-	END(octeon_mult_save)
+	 sd	$11, PT_MPL+(5*8)(sp)	/* store MPL5 */
+octeon_mult_save3_end:
+	EXPORT(octeon_mult_save3_end)
+	END(octeon_mult_save3)
 	.set pop
 
 /*
  * void octeon_mult_restore()
  * sp is assumed to point to a struct pt_regs
  *
- * NOTE: This is called in RESTORE_SOME in stackframe.h.
+ * NOTE: This is called in RESTORE_TEMP in stackframe.h.
  */
-	.align	7
+	.p2align 7
 	.set push
 	.set noreorder
 	LEAF(octeon_mult_restore)
-	dmfc0	k1, $9,7		/* CvmCtl register. */
-	ld	v0, PT_MPL(sp)		/* MPL0 */
-	ld	v1, PT_MPL+8(sp)	/* MPL1 */
-	ld	k0, PT_MPL+16(sp)	/* MPL2 */
-	bbit1	k1, 27, 1f		/* Skip CvmCtl[NOMUL] */
-	/* Normally falls through, so no time wasted here */
-	nop
+	jr	ra
+	 nop
+	.space 30 * 4, 0
+octeon_mult_restore_end:
+	EXPORT(octeon_mult_restore_end)
+	END(octeon_mult_restore)
 
+	LEAF(octeon_mult_restore2)
+	ld	v0, PT_MPL(sp)        	/* MPL0 */
+	ld	v1, PT_MPL+8(sp)      	/* MPL1 */
+	ld	k0, PT_MPL+16(sp)     	/* MPL2 */
 	/* Restore the multiplier state */
-	ld	k1, PT_MTP+16(sp)	/* P2 */
-	MTM0	v0			/* MPL0 */
+	ld	k1, PT_MTP+16(sp)     	/* P2 */
+	mtm0	v0			/* MPL0 */
 	ld	v0, PT_MTP+8(sp)	/* P1 */
-	MTM1	v1			/* MPL1 */
-	ld	v1, PT_MTP(sp)		/* P0 */
-	MTM2	k0			/* MPL2 */
-	MTP2	k1			/* P2 */
-	MTP1	v0			/* P1 */
+	mtm1	v1			/* MPL1 */
+	ld	v1, PT_MTP(sp)   	/* P0 */
+	mtm2	k0			/* MPL2 */
+	mtp2	k1			/* P2 */
+	mtp1	v0			/* P1 */
 	jr	ra
-	 MTP0	v1			/* P0 */
-
-1:	/* Resume here if CvmCtl[NOMUL] */
+	 mtp0	v1			/* P0 */
+octeon_mult_restore2_end:
+	EXPORT(octeon_mult_restore2_end)
+	END(octeon_mult_restore2)
+
+	LEAF(octeon_mult_restore3)
+	ld	$12, PT_MPL+(0*8)(sp)	/* read MPL0 */
+	ld	$13, PT_MPL+(3*8)(sp)	/* read MPL3 */
+	ld	$10, PT_MPL+(1*8)(sp)	/* read MPL1 */
+	ld	$11, PT_MPL+(4*8)(sp)	/* read MPL4 */
+	.word	0x718d0008
+	/* mtm0	$12, $13		   restore MPL0 and MPL3 */
+	ld	$12, PT_MPL+(2*8)(sp)	/* read MPL2 */
+	.word	0x714b000c
+	/* mtm1	$10, $11		   restore MPL1 and MPL4 */
+	ld	$13, PT_MPL+(5*8)(sp)	/* read MPL5 */
+	ld	$10, PT_MTP+(0*8)(sp)	/* read P0 */
+	ld	$11, PT_MTP+(3*8)(sp)	/* read P3 */
+	.word	0x718d000d
+	/* mtm2	$12, $13		   restore MPL2 and MPL5 */
+	ld	$12, PT_MTP+(1*8)(sp)	/* read P1 */
+	.word	0x714b0009
+	/* mtp0	$10, $11		   restore P0 and P3 */
+	ld	$13, PT_MTP+(4*8)(sp)	/* read P4 */
+	ld	$10, PT_MTP+(2*8)(sp)	/* read P2 */
+	ld	$11, PT_MTP+(5*8)(sp)	/* read P5 */
+	.word	0x718d000a
+	/* mtp1	$12, $13		   restore P1 and P4 */
 	jr	ra
-	 nop
-	END(octeon_mult_restore)
+	.word	0x714b000b
+	/* mtp2	$10, $11		   restore P2 and P5 */
+
+octeon_mult_restore3_end:
+	EXPORT(octeon_mult_restore3_end)
+	END(octeon_mult_restore3)
 	.set pop
-- 
2.1.3
