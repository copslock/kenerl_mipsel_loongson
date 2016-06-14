Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:28:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47723 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027952AbcFNK1oebWkY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:27:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BC1541AEFC6B0;
        Tue, 14 Jun 2016 09:40:43 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 5/8] MIPS: KVM: Add guest mode switch trace events
Date:   Tue, 14 Jun 2016 09:40:14 +0100
Message-ID: <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54037
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

Add a few trace events for entering and coming out of guest mode, as well
as re-entering it from a guest exit exception.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/mips.c  |  4 ++++
 arch/mips/kvm/trace.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e9e40b9dd9be..b5ad2ba1847a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -410,7 +410,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
+	trace_kvm_enter(vcpu);
 	r = vcpu->arch.vcpu_run(run, vcpu);
+	trace_kvm_out(vcpu);
 
 	/* Re-enable HTW before enabling interrupts */
 	htw_start();
@@ -1389,6 +1391,8 @@ skip_emul:
 	}
 
 	if (ret == RESUME_GUEST) {
+		trace_kvm_reenter(vcpu);
+
 		/*
 		 * If FPU / MSA are enabled (i.e. the guest's FPU / MSA context
 		 * is live), restore FCR31 / MSACSR.
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 1d67d9e0f340..5b5dbd8eacb0 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -17,6 +17,54 @@
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE trace
 
+/*
+ * Tracepoints for VM enters
+ */
+TRACE_EVENT(kvm_enter,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+	    ),
+
+	    TP_printk("PC: 0x%08lx",
+		      __entry->pc)
+);
+
+TRACE_EVENT(kvm_reenter,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+	    ),
+
+	    TP_printk("PC: 0x%08lx",
+		      __entry->pc)
+);
+
+TRACE_EVENT(kvm_out,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+	    ),
+
+	    TP_printk("PC: 0x%08lx",
+		      __entry->pc)
+);
+
 /* The first 32 exit reasons correspond to Cause.ExcCode */
 #define KVM_TRACE_EXIT_INT		 0
 #define KVM_TRACE_EXIT_TLBMOD		 1
-- 
2.4.10
