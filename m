Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:29:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53468 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040999AbcFNK2oFC5KY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E3A4843CEF46;
        Tue, 14 Jun 2016 09:40:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 3/8] MIPS: KVM: Clean up kvm_exit trace event
Date:   Tue, 14 Jun 2016 09:40:12 +0100
Message-ID: <1465893617-5774-4-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54043
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

Clean up the MIPS kvm_exit trace event so that the exit reasons are
specified in a trace friendly way (via __print_symbolic), and so that
the exit reasons that derive straight from Cause.ExcCode values map
directly, allowing a single trace_kvm_exit() call to replace a bunch of
individual ones.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kvm_host.h | 22 --------------------
 arch/mips/kvm/emulate.c          |  4 ++--
 arch/mips/kvm/mips.c             | 17 ++--------------
 arch/mips/kvm/stats.c            | 21 -------------------
 arch/mips/kvm/trace.h            | 44 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index e6273850bab6..b8cb74270746 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -125,28 +125,6 @@ struct kvm_vcpu_stat {
 	u32 halt_wakeup;
 };
 
-enum kvm_mips_exit_types {
-	WAIT_EXITS,
-	CACHE_EXITS,
-	SIGNAL_EXITS,
-	INT_EXITS,
-	COP_UNUSABLE_EXITS,
-	TLBMOD_EXITS,
-	TLBMISS_LD_EXITS,
-	TLBMISS_ST_EXITS,
-	ADDRERR_ST_EXITS,
-	ADDRERR_LD_EXITS,
-	SYSCALL_EXITS,
-	RESVD_INST_EXITS,
-	BREAK_INST_EXITS,
-	TRAP_INST_EXITS,
-	MSA_FPE_EXITS,
-	FPE_EXITS,
-	MSA_DISABLED_EXITS,
-	FLUSH_DCACHE_EXITS,
-	MAX_KVM_MIPS_EXIT_TYPES
-};
-
 struct kvm_arch_memory_slot {
 };
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 8647bd97b934..fce08bda9ebc 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -775,7 +775,7 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 		  vcpu->arch.pending_exceptions);
 
 	++vcpu->stat.wait_exits;
-	trace_kvm_exit(vcpu, WAIT_EXITS);
+	trace_kvm_exit(vcpu, KVM_TRACE_EXIT_WAIT);
 	if (!vcpu->arch.pending_exceptions) {
 		vcpu->arch.wait = 1;
 		kvm_vcpu_block(vcpu);
@@ -1718,7 +1718,7 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 
 	case cache_op:
 		++vcpu->stat.cache_exits;
-		trace_kvm_exit(vcpu, CACHE_EXITS);
+		trace_kvm_exit(vcpu, KVM_TRACE_EXIT_CACHE);
 		er = kvm_mips_emulate_cache(inst, opc, cause, run, vcpu);
 		break;
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c0e8f8640f2b..e9e40b9dd9be 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1257,6 +1257,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
 			cause, opc, run, vcpu);
+	trace_kvm_exit(vcpu, exccode);
 
 	/*
 	 * Do a privilege check, if in UM most of these exit conditions end up
@@ -1276,7 +1277,6 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		kvm_debug("[%d]EXCCODE_INT @ %p\n", vcpu->vcpu_id, opc);
 
 		++vcpu->stat.int_exits;
-		trace_kvm_exit(vcpu, INT_EXITS);
 
 		if (need_resched())
 			cond_resched();
@@ -1288,7 +1288,6 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		kvm_debug("EXCCODE_CPU: @ PC: %p\n", opc);
 
 		++vcpu->stat.cop_unusable_exits;
-		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
 		ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
 		/* XXXKYMA: Might need to return to user space */
 		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN)
@@ -1297,7 +1296,6 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	case EXCCODE_MOD:
 		++vcpu->stat.tlbmod_exits;
-		trace_kvm_exit(vcpu, TLBMOD_EXITS);
 		ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
 		break;
 
@@ -1307,7 +1305,6 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			  badvaddr);
 
 		++vcpu->stat.tlbmiss_st_exits;
-		trace_kvm_exit(vcpu, TLBMISS_ST_EXITS);
 		ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
 		break;
 
@@ -1316,61 +1313,51 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			  cause, opc, badvaddr);
 
 		++vcpu->stat.tlbmiss_ld_exits;
-		trace_kvm_exit(vcpu, TLBMISS_LD_EXITS);
 		ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
 		break;
 
 	case EXCCODE_ADES:
 		++vcpu->stat.addrerr_st_exits;
-		trace_kvm_exit(vcpu, ADDRERR_ST_EXITS);
 		ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
 		break;
 
 	case EXCCODE_ADEL:
 		++vcpu->stat.addrerr_ld_exits;
-		trace_kvm_exit(vcpu, ADDRERR_LD_EXITS);
 		ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
 		break;
 
 	case EXCCODE_SYS:
 		++vcpu->stat.syscall_exits;
-		trace_kvm_exit(vcpu, SYSCALL_EXITS);
 		ret = kvm_mips_callbacks->handle_syscall(vcpu);
 		break;
 
 	case EXCCODE_RI:
 		++vcpu->stat.resvd_inst_exits;
-		trace_kvm_exit(vcpu, RESVD_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_res_inst(vcpu);
 		break;
 
 	case EXCCODE_BP:
 		++vcpu->stat.break_inst_exits;
-		trace_kvm_exit(vcpu, BREAK_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;
 
 	case EXCCODE_TR:
 		++vcpu->stat.trap_inst_exits;
-		trace_kvm_exit(vcpu, TRAP_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_trap(vcpu);
 		break;
 
 	case EXCCODE_MSAFPE:
 		++vcpu->stat.msa_fpe_exits;
-		trace_kvm_exit(vcpu, MSA_FPE_EXITS);
 		ret = kvm_mips_callbacks->handle_msa_fpe(vcpu);
 		break;
 
 	case EXCCODE_FPE:
 		++vcpu->stat.fpe_exits;
-		trace_kvm_exit(vcpu, FPE_EXITS);
 		ret = kvm_mips_callbacks->handle_fpe(vcpu);
 		break;
 
 	case EXCCODE_MSADIS:
 		++vcpu->stat.msa_disabled_exits;
-		trace_kvm_exit(vcpu, MSA_DISABLED_EXITS);
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
 		break;
 
@@ -1397,7 +1384,7 @@ skip_emul:
 			run->exit_reason = KVM_EXIT_INTR;
 			ret = (-EINTR << 2) | RESUME_HOST;
 			++vcpu->stat.signal_exits;
-			trace_kvm_exit(vcpu, SIGNAL_EXITS);
+			trace_kvm_exit(vcpu, KVM_TRACE_EXIT_SIGNAL);
 		}
 	}
 
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index 888bb67070ac..53f851a61554 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -11,27 +11,6 @@
 
 #include <linux/kvm_host.h>
 
-char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
-	"WAIT",
-	"CACHE",
-	"Signal",
-	"Interrupt",
-	"COP0/1 Unusable",
-	"TLB Mod",
-	"TLB Miss (LD)",
-	"TLB Miss (ST)",
-	"Address Err (ST)",
-	"Address Error (LD)",
-	"System Call",
-	"Reserved Inst",
-	"Break Inst",
-	"Trap Inst",
-	"MSA FPE",
-	"FPE",
-	"MSA Disabled",
-	"D-Cache Flushes",
-};
-
 char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
 	"Index",
 	"Random",
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 32ac7cc82e13..9a1212e09435 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -17,8 +17,45 @@
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE trace
 
-/* Tracepoints for VM eists */
-extern char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES];
+/* The first 32 exit reasons correspond to Cause.ExcCode */
+#define KVM_TRACE_EXIT_INT		 0
+#define KVM_TRACE_EXIT_TLBMOD		 1
+#define KVM_TRACE_EXIT_TLBMISS_LD	 2
+#define KVM_TRACE_EXIT_TLBMISS_ST	 3
+#define KVM_TRACE_EXIT_ADDRERR_LD	 4
+#define KVM_TRACE_EXIT_ADDRERR_ST	 5
+#define KVM_TRACE_EXIT_SYSCALL		 8
+#define KVM_TRACE_EXIT_BREAK_INST	 9
+#define KVM_TRACE_EXIT_RESVD_INST	10
+#define KVM_TRACE_EXIT_COP_UNUSABLE	11
+#define KVM_TRACE_EXIT_TRAP_INST	13
+#define KVM_TRACE_EXIT_MSA_FPE		14
+#define KVM_TRACE_EXIT_FPE		15
+#define KVM_TRACE_EXIT_MSA_DISABLED	21
+/* Further exit reasons */
+#define KVM_TRACE_EXIT_WAIT		32
+#define KVM_TRACE_EXIT_CACHE		33
+#define KVM_TRACE_EXIT_SIGNAL		34
+
+/* Tracepoints for VM exits */
+#define kvm_trace_symbol_exit_types				\
+	{ KVM_TRACE_EXIT_INT,		"Interrupt" },		\
+	{ KVM_TRACE_EXIT_TLBMOD,	"TLB Mod" },		\
+	{ KVM_TRACE_EXIT_TLBMISS_LD,	"TLB Miss (LD)" },	\
+	{ KVM_TRACE_EXIT_TLBMISS_ST,	"TLB Miss (ST)" },	\
+	{ KVM_TRACE_EXIT_ADDRERR_LD,	"Address Error (LD)" },	\
+	{ KVM_TRACE_EXIT_ADDRERR_ST,	"Address Err (ST)" },	\
+	{ KVM_TRACE_EXIT_SYSCALL,	"System Call" },	\
+	{ KVM_TRACE_EXIT_BREAK_INST,	"Break Inst" },		\
+	{ KVM_TRACE_EXIT_RESVD_INST,	"Reserved Inst" },	\
+	{ KVM_TRACE_EXIT_COP_UNUSABLE,	"COP0/1 Unusable" },	\
+	{ KVM_TRACE_EXIT_TRAP_INST,	"Trap Inst" },		\
+	{ KVM_TRACE_EXIT_MSA_FPE,	"MSA FPE" },		\
+	{ KVM_TRACE_EXIT_FPE,		"FPE" },		\
+	{ KVM_TRACE_EXIT_MSA_DISABLED,	"MSA Disabled" },	\
+	{ KVM_TRACE_EXIT_WAIT,		"WAIT" },		\
+	{ KVM_TRACE_EXIT_CACHE,		"CACHE" },		\
+	{ KVM_TRACE_EXIT_SIGNAL,	"Signal" }
 
 TRACE_EVENT(kvm_exit,
 	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
@@ -34,7 +71,8 @@ TRACE_EVENT(kvm_exit,
 	    ),
 
 	    TP_printk("[%s]PC: 0x%08lx",
-		      kvm_mips_exit_types_str[__entry->reason],
+		      __print_symbolic(__entry->reason,
+				       kvm_trace_symbol_exit_types),
 		      __entry->pc)
 );
 
-- 
2.4.10
