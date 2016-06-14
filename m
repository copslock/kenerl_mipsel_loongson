Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:28:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40965 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040984AbcFNK2Q1wG4Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 54A0578B460DE;
        Tue, 14 Jun 2016 09:40:44 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 6/8] MIPS: KVM: Trace guest register access emulation
Date:   Tue, 14 Jun 2016 09:40:15 +0100
Message-ID: <1465893617-5774-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54039
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

Trace emulation of guest access to various registers via
MFC0/MTC0/DMFC0/DMTC0 instructions (coprocessor 0) and the RDHWR
instruction (hardware registers exposed to userland), replacing some
existing kvm_debug calls. Trace events are much more practical for this
kind of debug output.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 31 ++++++++++-------
 arch/mips/kvm/trace.h   | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index ee0e61d2b6fb..2004e35288d0 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -979,7 +979,6 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, copz, sel, co_bit, op;
-	unsigned long pc = vcpu->arch.pc;
 	unsigned long curr_pc;
 
 	/*
@@ -1046,20 +1045,27 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 #endif
 			}
 
-			kvm_debug
-			    ("[%#lx] MFCz[%d][%d], vcpu->arch.gprs[%d]: %#lx\n",
-			     pc, rd, sel, rt, vcpu->arch.gprs[rt]);
-
+			trace_kvm_hwr(vcpu, KVM_TRACE_MFC0,
+				      KVM_TRACE_COP0(rd, sel),
+				      vcpu->arch.gprs[rt]);
 			break;
 
 		case dmfc_op:
 			vcpu->arch.gprs[rt] = cop0->reg[rd][sel];
+
+			trace_kvm_hwr(vcpu, KVM_TRACE_DMFC0,
+				      KVM_TRACE_COP0(rd, sel),
+				      vcpu->arch.gprs[rt]);
 			break;
 
 		case mtc_op:
 #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
 			cop0->stat[rd][sel]++;
 #endif
+			trace_kvm_hwr(vcpu, KVM_TRACE_MTC0,
+				      KVM_TRACE_COP0(rd, sel),
+				      vcpu->arch.gprs[rt]);
+
 			if ((rd == MIPS_CP0_TLB_INDEX)
 			    && (vcpu->arch.gprs[rt] >=
 				KVM_MIPS_GUEST_TLB_SIZE)) {
@@ -1098,10 +1104,6 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				kvm_mips_write_count(vcpu, vcpu->arch.gprs[rt]);
 				goto done;
 			} else if ((rd == MIPS_CP0_COMPARE) && (sel == 0)) {
-				kvm_debug("[%#lx] MTCz, COMPARE %#lx <- %#lx\n",
-					  pc, kvm_read_c0_guest_compare(cop0),
-					  vcpu->arch.gprs[rt]);
-
 				/* If we are writing to COMPARE */
 				/* Clear pending timer interrupt, if any */
 				kvm_mips_write_compare(vcpu,
@@ -1237,14 +1239,14 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				kvm_mips_trans_mtc0(inst, opc, vcpu);
 #endif
 			}
-
-			kvm_debug("[%#lx] MTCz, cop0->reg[%d][%d]: %#lx\n", pc,
-				  rd, sel, cop0->reg[rd][sel]);
 			break;
 
 		case dmtc_op:
 			kvm_err("!!!!!!![%#lx]dmtc_op: rt: %d, rd: %d, sel: %d!!!!!!\n",
 				vcpu->arch.pc, rt, rd, sel);
+			trace_kvm_hwr(vcpu, KVM_TRACE_DMTC0,
+				      KVM_TRACE_COP0(rd, sel),
+				      vcpu->arch.gprs[rt]);
 			er = EMULATE_FAIL;
 			break;
 
@@ -2307,6 +2309,8 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 		int usermode = !KVM_GUEST_KERNEL_MODE(vcpu);
 		int rd = (inst & RD) >> 11;
 		int rt = (inst & RT) >> 16;
+		int sel = (inst >> 6) & 0x7;
+
 		/* If usermode, check RDHWR rd is allowed by guest HWREna */
 		if (usermode && !(kvm_read_c0_guest_hwrena(cop0) & BIT(rd))) {
 			kvm_debug("RDHWR %#x disallowed by HWREna @ %p\n",
@@ -2342,6 +2346,9 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 			kvm_debug("RDHWR %#x not supported @ %p\n", rd, opc);
 			goto emulate_ri;
 		}
+
+		trace_kvm_hwr(vcpu, KVM_TRACE_RDHWR, KVM_TRACE_HWR(rd, sel),
+			      vcpu->arch.gprs[rt]);
 	} else {
 		kvm_debug("Emulate RI not supported @ %p: %#x\n", opc, inst);
 		goto emulate_ri;
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 5b5dbd8eacb0..90941a33e5ed 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -124,6 +124,94 @@ TRACE_EVENT(kvm_exit,
 		      __entry->pc)
 );
 
+#define KVM_TRACE_MFC0		0
+#define KVM_TRACE_MTC0		1
+#define KVM_TRACE_DMFC0		2
+#define KVM_TRACE_DMTC0		3
+#define KVM_TRACE_RDHWR		4
+
+#define KVM_TRACE_HWR_COP0	0
+#define KVM_TRACE_HWR_HWR	1
+
+#define KVM_TRACE_COP0(REG, SEL)	((KVM_TRACE_HWR_COP0 << 8) |	\
+					 ((REG) << 3) | (SEL))
+#define KVM_TRACE_HWR(REG, SEL)		((KVM_TRACE_HWR_HWR  << 8) |	\
+					 ((REG) << 3) | (SEL))
+
+#define kvm_trace_symbol_hwr_ops				\
+	{ KVM_TRACE_MFC0,		"MFC0" },		\
+	{ KVM_TRACE_MTC0,		"MTC0" },		\
+	{ KVM_TRACE_DMFC0,		"DMFC0" },		\
+	{ KVM_TRACE_DMTC0,		"DMTC0" },		\
+	{ KVM_TRACE_RDHWR,		"RDHWR" }
+
+#define kvm_trace_symbol_hwr_cop				\
+	{ KVM_TRACE_HWR_COP0,		"COP0" },		\
+	{ KVM_TRACE_HWR_HWR,		"HWR" }
+
+#define kvm_trace_symbol_hwr_regs				\
+	{ KVM_TRACE_COP0( 0, 0),	"Index" },		\
+	{ KVM_TRACE_COP0( 2, 0),	"EntryLo0" },		\
+	{ KVM_TRACE_COP0( 3, 0),	"EntryLo1" },		\
+	{ KVM_TRACE_COP0( 4, 0),	"Context" },		\
+	{ KVM_TRACE_COP0( 4, 2),	"UserLocal" },		\
+	{ KVM_TRACE_COP0( 5, 0),	"PageMask" },		\
+	{ KVM_TRACE_COP0( 6, 0),	"Wired" },		\
+	{ KVM_TRACE_COP0( 7, 0),	"HWREna" },		\
+	{ KVM_TRACE_COP0( 8, 0),	"BadVAddr" },		\
+	{ KVM_TRACE_COP0( 9, 0),	"Count" },		\
+	{ KVM_TRACE_COP0(10, 0),	"EntryHi" },		\
+	{ KVM_TRACE_COP0(11, 0),	"Compare" },		\
+	{ KVM_TRACE_COP0(12, 0),	"Status" },		\
+	{ KVM_TRACE_COP0(12, 1),	"IntCtl" },		\
+	{ KVM_TRACE_COP0(12, 2),	"SRSCtl" },		\
+	{ KVM_TRACE_COP0(13, 0),	"Cause" },		\
+	{ KVM_TRACE_COP0(14, 0),	"EPC" },		\
+	{ KVM_TRACE_COP0(15, 0),	"PRId" },		\
+	{ KVM_TRACE_COP0(15, 1),	"EBase" },		\
+	{ KVM_TRACE_COP0(16, 0),	"Config" },		\
+	{ KVM_TRACE_COP0(16, 1),	"Config1" },		\
+	{ KVM_TRACE_COP0(16, 2),	"Config2" },		\
+	{ KVM_TRACE_COP0(16, 3),	"Config3" },		\
+	{ KVM_TRACE_COP0(16, 4),	"Config4" },		\
+	{ KVM_TRACE_COP0(16, 5),	"Config5" },		\
+	{ KVM_TRACE_COP0(16, 7),	"Config7" },		\
+	{ KVM_TRACE_COP0(26, 0),	"ECC" },		\
+	{ KVM_TRACE_COP0(30, 0),	"ErrorEPC" },		\
+	{ KVM_TRACE_HWR( 0, 0),		"CPUNum" },		\
+	{ KVM_TRACE_HWR( 1, 0),		"SYNCI_Step" },		\
+	{ KVM_TRACE_HWR( 2, 0),		"CC" },			\
+	{ KVM_TRACE_HWR( 3, 0),		"CCRes" },		\
+	{ KVM_TRACE_HWR(29, 0),		"ULR" }
+
+TRACE_EVENT(kvm_hwr,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int op, unsigned int reg,
+		     unsigned long val),
+	    TP_ARGS(vcpu, op, reg, val),
+	    TP_STRUCT__entry(
+			__field(unsigned long, val)
+			__field(u16, reg)
+			__field(u8, op)
+	    ),
+
+	    TP_fast_assign(
+			__entry->val = val;
+			__entry->reg = reg;
+			__entry->op = op;
+	    ),
+
+	    TP_printk("%s %s (%s:%u:%u) 0x%08lx",
+		      __print_symbolic(__entry->op,
+				       kvm_trace_symbol_hwr_ops),
+		      __print_symbolic(__entry->reg,
+				       kvm_trace_symbol_hwr_regs),
+		      __print_symbolic(__entry->reg >> 8,
+				       kvm_trace_symbol_hwr_cop),
+		      (__entry->reg >> 3) & 0x1f,
+		      __entry->reg & 0x7,
+		      __entry->val)
+);
+
 #define KVM_TRACE_AUX_RESTORE		0
 #define KVM_TRACE_AUX_SAVE		1
 #define KVM_TRACE_AUX_ENABLE		2
-- 
2.4.10
