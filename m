Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:32:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4779 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042338AbcFOSaS0ODsW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 811AF31C59137;
        Wed, 15 Jun 2016 19:30:07 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:11 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 08/17] MIPS: Clean up RDHWR handling
Date:   Wed, 15 Jun 2016 19:29:52 +0100
Message-ID: <1466015401-24433-9-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54061
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

No preprocessor definitions are used in the handling of the registers
accessible with the RDHWR instruction, nor the corresponding bits in the
CP0 HWREna register.

Add definitions for both the register numbers (MIPS_HWR_*) and HWREna
bits (MIPS_HWRENA_*) in asm/mipsregs.h and make use of them in the
initialisation of HWREna and emulation of the RDHWR instruction.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h   |  2 +-
 arch/mips/include/asm/mipsregs.h                     | 20 +++++++++++++++++++-
 arch/mips/kernel/traps.c                             | 17 ++++++++++-------
 arch/mips/kvm/emulate.c                              | 10 +++++-----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index d68e685cde60..bd8b9bbe1771 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -55,7 +55,7 @@
 #define cpu_has_mipsmt		0
 #define cpu_has_vint		0
 #define cpu_has_veic		0
-#define cpu_hwrena_impl_bits	0xc0000000
+#define cpu_hwrena_impl_bits	(MIPS_HWRENA_IMPL1 | MIPS_HWRENA_IMPL2)
 #define cpu_has_wsbh            1
 
 #define cpu_has_rixi		(cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e1ca65c62f6a..8b1b37d50d15 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -53,7 +53,7 @@
 #define CP0_SEGCTL2 $5, 4
 #define CP0_WIRED $6
 #define CP0_INFO $7
-#define CP0_HWRENA $7, 0
+#define CP0_HWRENA $7
 #define CP0_BADVADDR $8
 #define CP0_BADINSTR $8, 1
 #define CP0_COUNT $9
@@ -853,6 +853,24 @@
 #define MIPS_CDMMBASE_ADDR_SHIFT 11
 #define MIPS_CDMMBASE_ADDR_START 15
 
+/* RDHWR register numbers */
+#define MIPS_HWR_CPUNUM		0	/* CPU number */
+#define MIPS_HWR_SYNCISTEP	1	/* SYNCI step size */
+#define MIPS_HWR_CC		2	/* Cycle counter */
+#define MIPS_HWR_CCRES		3	/* Cycle counter resolution */
+#define MIPS_HWR_ULR		29	/* UserLocal */
+#define MIPS_HWR_IMPL1		30	/* Implementation dependent */
+#define MIPS_HWR_IMPL2		31	/* Implementation dependent */
+
+/* Bits in HWREna register */
+#define MIPS_HWRENA_CPUNUM	(_ULCAST_(1) << MIPS_HWR_CPUNUM)
+#define MIPS_HWRENA_SYNCISTEP	(_ULCAST_(1) << MIPS_HWR_SYNCISTEP)
+#define MIPS_HWRENA_CC		(_ULCAST_(1) << MIPS_HWR_CC)
+#define MIPS_HWRENA_CCRES	(_ULCAST_(1) << MIPS_HWR_CCRES)
+#define MIPS_HWRENA_ULR		(_ULCAST_(1) << MIPS_HWR_ULR)
+#define MIPS_HWRENA_IMPL1	(_ULCAST_(1) << MIPS_HWR_IMPL1)
+#define MIPS_HWRENA_IMPL2	(_ULCAST_(1) << MIPS_HWR_IMPL2)
+
 /*
  * Bitfields in the TX39 family CP0 Configuration Register 3
  */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 66e5820bfdae..7176a6057e26 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -619,17 +619,17 @@ static int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
 			1, regs, 0);
 	switch (rd) {
-	case 0:		/* CPU number */
+	case MIPS_HWR_CPUNUM:		/* CPU number */
 		regs->regs[rt] = smp_processor_id();
 		return 0;
-	case 1:		/* SYNCI length */
+	case MIPS_HWR_SYNCISTEP:	/* SYNCI length */
 		regs->regs[rt] = min(current_cpu_data.dcache.linesz,
 				     current_cpu_data.icache.linesz);
 		return 0;
-	case 2:		/* Read count register */
+	case MIPS_HWR_CC:		/* Read count register */
 		regs->regs[rt] = read_c0_count();
 		return 0;
-	case 3:		/* Count register resolution */
+	case MIPS_HWR_CCRES:		/* Count register resolution */
 		switch (current_cpu_type()) {
 		case CPU_20KC:
 		case CPU_25KF:
@@ -639,7 +639,7 @@ static int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
 			regs->regs[rt] = 2;
 		}
 		return 0;
-	case 29:
+	case MIPS_HWR_ULR:		/* Read UserLocal register */
 		regs->regs[rt] = ti->tp_value;
 		return 0;
 	default:
@@ -2070,10 +2070,13 @@ static void configure_hwrena(void)
 	unsigned int hwrena = cpu_hwrena_impl_bits;
 
 	if (cpu_has_mips_r2_r6)
-		hwrena |= 0x0000000f;
+		hwrena |= MIPS_HWRENA_CPUNUM |
+			  MIPS_HWRENA_SYNCISTEP |
+			  MIPS_HWRENA_CC |
+			  MIPS_HWRENA_CCRES;
 
 	if (!noulri && cpu_has_userlocal)
-		hwrena |= (1 << 29);
+		hwrena |= MIPS_HWRENA_ULR;
 
 	if (hwrena)
 		write_c0_hwrena(hwrena);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 80bb6212a067..892f36f56d32 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2296,17 +2296,17 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 			goto emulate_ri;
 		}
 		switch (rd) {
-		case 0:	/* CPU number */
+		case MIPS_HWR_CPUNUM:		/* CPU number */
 			arch->gprs[rt] = 0;
 			break;
-		case 1:	/* SYNCI length */
+		case MIPS_HWR_SYNCISTEP:	/* SYNCI length */
 			arch->gprs[rt] = min(current_cpu_data.dcache.linesz,
 					     current_cpu_data.icache.linesz);
 			break;
-		case 2:	/* Read count register */
+		case MIPS_HWR_CC:		/* Read count register */
 			arch->gprs[rt] = kvm_mips_read_count(vcpu);
 			break;
-		case 3:	/* Count register resolution */
+		case MIPS_HWR_CCRES:		/* Count register resolution */
 			switch (current_cpu_data.cputype) {
 			case CPU_20KC:
 			case CPU_25KF:
@@ -2316,7 +2316,7 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 				arch->gprs[rt] = 2;
 			}
 			break;
-		case 29:
+		case MIPS_HWR_ULR:		/* Read UserLocal register */
 			arch->gprs[rt] = kvm_read_c0_guest_userlocal(cop0);
 			break;
 
-- 
2.4.10
