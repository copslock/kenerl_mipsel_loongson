Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 15:21:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54537 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993877AbdBAOTnS67Wg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 15:19:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A053322F66C64;
        Wed,  1 Feb 2017 14:19:31 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Feb 2017 14:19:34 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/5] KVM: MIPS/T&E: Implement CP0_EBase register
Date:   Wed, 1 Feb 2017 14:19:24 +0000
Message-ID: <182d76ad26dec5e9e3d9bf89d21668588f195af9.1485958267.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
References: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56577
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

The CP0_EBase register is a standard feature of MIPS32r2, so we should
always have been implementing it properly. However the register value
was ignored and wasn't exposed to userland.

Fix the emulation of exceptions and interrupts to use the value stored
in guest CP0_EBase, and fix the masks so that the top 3 bits (rather
than the standard 2) are fixed, so that it is always in the guest KSeg0
segment.

Also add CP0_EBASE to the KVM one_reg interface so it can be accessed by
userland, also allowing the CPU number field to be written (which isn't
permitted by the guest).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  1 +-
 arch/mips/include/asm/kvm_host.h  |  3 +-
 arch/mips/kvm/emulate.c           | 73 ++++++++++++++++++--------------
 arch/mips/kvm/interrupt.c         |  5 +-
 arch/mips/kvm/trap_emul.c         | 12 +++++-
 5 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 03145b7cafaa..8d52d0f990ae 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2074,6 +2074,7 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_CAUSE        | 32
   MIPS  | KVM_REG_MIPS_CP0_EPC          | 64
   MIPS  | KVM_REG_MIPS_CP0_PRID         | 32
+  MIPS  | KVM_REG_MIPS_CP0_EBASE        | 64
   MIPS  | KVM_REG_MIPS_CP0_CONFIG       | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG1      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG2      | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c6922762ff1a..72bb2d777ab8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -88,6 +88,7 @@
 
 #define KVM_GUEST_KUSEG			0x00000000UL
 #define KVM_GUEST_KSEG0			0x40000000UL
+#define KVM_GUEST_KSEG1			0x40000000UL
 #define KVM_GUEST_KSEG23		0x60000000UL
 #define KVM_GUEST_KSEGX(a)		((_ACAST32_(a)) & 0xe0000000)
 #define KVM_GUEST_CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
@@ -710,6 +711,8 @@ extern enum emulation_result kvm_mips_emulate_inst(u32 cause,
 						   struct kvm_run *run,
 						   struct kvm_vcpu *vcpu);
 
+long kvm_mips_guest_exception_base(struct kvm_vcpu *vcpu);
+
 extern enum emulation_result kvm_mips_emulate_syscall(u32 cause,
 						      u32 *opc,
 						      struct kvm_run *run,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index f2b054b80bca..d40cfaad4529 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1200,14 +1200,13 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 				er = EMULATE_FAIL;
 				break;
 			}
-#define C0_EBASE_CORE_MASK 0xff
 			if ((rd == MIPS_CP0_PRID) && (sel == 1)) {
-				/* Preserve CORE number */
-				kvm_change_c0_guest_ebase(cop0,
-							  ~(C0_EBASE_CORE_MASK),
+				/*
+				 * Preserve core number, and keep the exception
+				 * base in guest KSeg0.
+				 */
+				kvm_change_c0_guest_ebase(cop0, 0x1ffff000,
 							  vcpu->arch.gprs[rt]);
-				kvm_err("MTCz, cop0->reg[EBASE]: %#lx\n",
-					kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
 				u32 nasid =
 					vcpu->arch.gprs[rt] & KVM_ENTRYHI_ASID;
@@ -1917,6 +1916,22 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 	return er;
 }
 
+/**
+ * kvm_mips_guest_exception_base() - Find guest exception vector base address.
+ *
+ * Returns:	The base address of the current guest exception vector, taking
+ *		both Guest.CP0_Status.BEV and Guest.CP0_EBase into account.
+ */
+long kvm_mips_guest_exception_base(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	if (kvm_read_c0_guest_status(cop0) & ST0_BEV)
+		return KVM_GUEST_CKSEG1ADDR(0x1fc00200);
+	else
+		return kvm_read_c0_guest_ebase(cop0) & MIPS_EBASE_BASE;
+}
+
 enum emulation_result kvm_mips_emulate_syscall(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
@@ -1942,7 +1957,7 @@ enum emulation_result kvm_mips_emulate_syscall(u32 cause,
 					  (EXCCODE_SYS << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver SYSCALL when EXL is already set\n");
@@ -1976,13 +1991,13 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(u32 cause,
 			  arch->pc);
 
 		/* set pc to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x0;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x0;
 
 	} else {
 		kvm_debug("[EXL == 1] delivering TLB MISS @ pc %#lx\n",
 			  arch->pc);
 
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -2019,16 +2034,14 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(u32 cause,
 
 		kvm_debug("[EXL == 0] delivering TLB INV @ pc %#lx\n",
 			  arch->pc);
-
-		/* set pc to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
-
 	} else {
 		kvm_debug("[EXL == 1] delivering TLB MISS @ pc %#lx\n",
 			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
+	/* set pc to the exception entry point */
+	arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
+
 	kvm_change_c0_guest_cause(cop0, (0xff),
 				  (EXCCODE_TLBL << CAUSEB_EXCCODE));
 
@@ -2064,11 +2077,11 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(u32 cause,
 			  arch->pc);
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x0;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x0;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MISS @ pc %#lx\n",
 			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -2104,15 +2117,14 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(u32 cause,
 
 		kvm_debug("[EXL == 0] Delivering TLB MISS @ pc %#lx\n",
 			  arch->pc);
-
-		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MISS @ pc %#lx\n",
 			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
+	/* Set PC to the exception entry point */
+	arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
+
 	kvm_change_c0_guest_cause(cop0, (0xff),
 				  (EXCCODE_TLBS << CAUSEB_EXCCODE));
 
@@ -2146,14 +2158,13 @@ enum emulation_result kvm_mips_emulate_tlbmod(u32 cause,
 
 		kvm_debug("[EXL == 0] Delivering TLB MOD @ pc %#lx\n",
 			  arch->pc);
-
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MOD @ pc %#lx\n",
 			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
+	arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
+
 	kvm_change_c0_guest_cause(cop0, (0xff),
 				  (EXCCODE_MOD << CAUSEB_EXCCODE));
 
@@ -2185,7 +2196,7 @@ enum emulation_result kvm_mips_emulate_fpu_exc(u32 cause,
 
 	}
 
-	arch->pc = KVM_GUEST_KSEG0 + 0x180;
+	arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
 				  (EXCCODE_CPU << CAUSEB_EXCCODE));
@@ -2219,7 +2230,7 @@ enum emulation_result kvm_mips_emulate_ri_exc(u32 cause,
 					  (EXCCODE_RI << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver RI when EXL is already set\n");
@@ -2254,7 +2265,7 @@ enum emulation_result kvm_mips_emulate_bp_exc(u32 cause,
 					  (EXCCODE_BP << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver BP when EXL is already set\n");
@@ -2289,7 +2300,7 @@ enum emulation_result kvm_mips_emulate_trap_exc(u32 cause,
 					  (EXCCODE_TR << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver TRAP when EXL is already set\n");
@@ -2324,7 +2335,7 @@ enum emulation_result kvm_mips_emulate_msafpe_exc(u32 cause,
 					  (EXCCODE_MSAFPE << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver MSAFPE when EXL is already set\n");
@@ -2359,7 +2370,7 @@ enum emulation_result kvm_mips_emulate_fpe_exc(u32 cause,
 					  (EXCCODE_FPE << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver FPE when EXL is already set\n");
@@ -2394,7 +2405,7 @@ enum emulation_result kvm_mips_emulate_msadis_exc(u32 cause,
 					  (EXCCODE_MSADIS << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver MSADIS when EXL is already set\n");
@@ -2560,7 +2571,7 @@ static enum emulation_result kvm_mips_emulate_exc(u32 cause,
 					  (exccode << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->pc = kvm_mips_guest_exception_base(vcpu) + 0x180;
 		kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 
 		kvm_debug("Delivering EXC %d @ pc %#lx, badVaddr: %#lx\n",
diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
index e88403b3dcdd..aa0a1a00faf6 100644
--- a/arch/mips/kvm/interrupt.c
+++ b/arch/mips/kvm/interrupt.c
@@ -183,10 +183,11 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 					  (exccode << CAUSEB_EXCCODE));
 
 		/* XXXSL Set PC to the interrupt exception entry point */
+		arch->pc = kvm_mips_guest_exception_base(vcpu);
 		if (kvm_read_c0_guest_cause(cop0) & CAUSEF_IV)
-			arch->pc = KVM_GUEST_KSEG0 + 0x200;
+			arch->pc += 0x200;
 		else
-			arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			arch->pc += 0x180;
 
 		clear_bit(priority, &vcpu->arch.pending_exceptions);
 	}
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 653d03aa7e0b..27082994e07d 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -653,6 +653,7 @@ static u64 kvm_trap_emul_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_CAUSE,
 	KVM_REG_MIPS_CP0_EPC,
 	KVM_REG_MIPS_CP0_PRID,
+	KVM_REG_MIPS_CP0_EBASE,
 	KVM_REG_MIPS_CP0_CONFIG,
 	KVM_REG_MIPS_CP0_CONFIG1,
 	KVM_REG_MIPS_CP0_CONFIG2,
@@ -735,6 +736,9 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_PRID:
 		*v = (long)kvm_read_c0_guest_prid(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_EBASE:
+		*v = (long)kvm_read_c0_guest_ebase(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_CONFIG:
 		*v = (long)kvm_read_c0_guest_config(cop0);
 		break;
@@ -837,6 +841,14 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_PRID:
 		kvm_write_c0_guest_prid(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_EBASE:
+		/*
+		 * Allow core number to be written, but the exception base must
+		 * remain in guest KSeg0.
+		 */
+		kvm_change_c0_guest_ebase(cop0, 0x1ffff000 | MIPS_EBASE_CPUNUM,
+					  v);
+		break;
 	case KVM_REG_MIPS_CP0_COUNT:
 		kvm_mips_write_count(vcpu, v);
 		break;
-- 
git-series 0.8.10
