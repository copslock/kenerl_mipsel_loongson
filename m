Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:48:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46371 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993898AbdCBJhoV7tQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E3676E8B90;
        Thu,  2 Mar 2017 09:37:40 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:42 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 32/32] KVM: MIPS/VZ: Trace guest mode changes
Date:   Thu, 2 Mar 2017 09:36:59 +0000
Message-ID: <82ea06d15bb74f157dc7e5b2ba22cc6dca423d6f.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56986
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

Create a trace event for guest mode changes, and enable VZ's
GuestCtl0.MC bit after the trace event is enabled to trap all guest mode
changes.

The MC bit causes Guest Hardware Field Change (GHFC) exceptions whenever
a guest mode change occurs (such as an exception entry or return from
exception), so we need to handle this exception now. The MC bit is only
enabled when restoring register state, so enabling the trace event won't
take immediate effect.

Tracing guest mode changes can be particularly handy when trying to work
out what a guest OS gets up to before something goes wrong, especially
if the problem occurs as a result of some previous guest userland
exception which would otherwise be invisible in the trace.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c  | 13 +++++++++++++
 arch/mips/kvm/trace.h | 37 +++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/vz.c    | 21 +++++++++++++++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 05b4714b25c2..df7a5d63b09e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -74,6 +74,19 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{NULL}
 };
 
+bool kvm_trace_guest_mode_change;
+
+int kvm_guest_mode_change_trace_reg(void)
+{
+	kvm_trace_guest_mode_change = 1;
+	return 0;
+}
+
+void kvm_guest_mode_change_trace_unreg(void)
+{
+	kvm_trace_guest_mode_change = 0;
+}
+
 /*
  * XXXKYMA: We are simulatoring a processor that has the WII bit set in
  * Config7, so we are "runnable" if interrupts are pending
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index affde8a2c584..a8c7fd7bf6d2 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -18,6 +18,13 @@
 #define TRACE_INCLUDE_FILE trace
 
 /*
+ * arch/mips/kvm/mips.c
+ */
+extern bool kvm_trace_guest_mode_change;
+int kvm_guest_mode_change_trace_reg(void);
+void kvm_guest_mode_change_trace_unreg(void);
+
+/*
  * Tracepoints for VM enters
  */
 DECLARE_EVENT_CLASS(kvm_transition,
@@ -303,6 +310,36 @@ TRACE_EVENT(kvm_guestid_change,
 		      __entry->guestid)
 );
 
+TRACE_EVENT_FN(kvm_guest_mode_change,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+	    TP_STRUCT__entry(
+			__field(unsigned long, epc)
+			__field(unsigned long, pc)
+			__field(unsigned long, badvaddr)
+			__field(unsigned int, status)
+			__field(unsigned int, cause)
+	    ),
+
+	    TP_fast_assign(
+			__entry->epc = kvm_read_c0_guest_epc(vcpu->arch.cop0);
+			__entry->pc = vcpu->arch.pc;
+			__entry->badvaddr = kvm_read_c0_guest_badvaddr(vcpu->arch.cop0);
+			__entry->status = kvm_read_c0_guest_status(vcpu->arch.cop0);
+			__entry->cause = kvm_read_c0_guest_cause(vcpu->arch.cop0);
+	    ),
+
+	    TP_printk("EPC: 0x%08lx PC: 0x%08lx Status: 0x%08x Cause: 0x%08x BadVAddr: 0x%08lx",
+		      __entry->epc,
+		      __entry->pc,
+		      __entry->status,
+		      __entry->cause,
+		      __entry->badvaddr),
+
+	    kvm_guest_mode_change_trace_reg,
+	    kvm_guest_mode_change_trace_unreg
+);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index cfb3ad5d25d6..d1747a165ac3 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -1322,6 +1322,18 @@ enum emulation_result kvm_trap_vz_handle_gsfc(u32 cause, u32 *opc,
 	return er;
 }
 
+static enum emulation_result kvm_trap_vz_handle_ghfc(u32 cause, u32 *opc,
+						     struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Presumably this is due to MC (guest mode change), so lets trace some
+	 * relevant info.
+	 */
+	trace_kvm_guest_mode_change(vcpu);
+
+	return EMULATE_DONE;
+}
+
 enum emulation_result kvm_trap_vz_handle_hc(u32 cause, u32 *opc,
 					    struct kvm_vcpu *vcpu)
 {
@@ -1406,8 +1418,7 @@ static int kvm_trap_vz_handle_guest_exit(struct kvm_vcpu *vcpu)
 		break;
 	case MIPS_GCTL0_GEXC_GHFC:
 		++vcpu->stat.vz_ghfc_exits;
-		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
-						       vcpu);
+		er = kvm_trap_vz_handle_ghfc(cause, opc, vcpu);
 		break;
 	case MIPS_GCTL0_GEXC_GPA:
 		++vcpu->stat.vz_gpa_exits;
@@ -2458,6 +2469,12 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 */
 	kvm_vz_restore_timer(vcpu);
 
+	/* Set MC bit if we want to trace guest mode changes */
+	if (kvm_trace_guest_mode_change)
+		set_c0_guestctl0(MIPS_GCTL0_MC);
+	else
+		clear_c0_guestctl0(MIPS_GCTL0_MC);
+
 	/* Don't bother restoring registers multiple times unless necessary */
 	if (!all)
 		return 0;
-- 
git-series 0.8.10
