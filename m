Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 19:19:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32300 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042884AbcFQRT5NFs37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 19:19:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BD6D23C2D2357;
        Fri, 17 Jun 2016 18:19:46 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 17 Jun 2016 18:19:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH] MIPS: KVM: Combine entry trace events into class
Date:   Fri, 17 Jun 2016 18:19:40 +0100
Message-ID: <1466183980-11264-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54109
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

Combine the kvm_enter, kvm_reenter and kvm_out trace events into a
single kvm_transition event class to reduce duplication and bloat.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 93258604ab6d ("MIPS: KVM: Add guest mode switch trace events")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trace.h | 62 ++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 75f1fda08f70..e7d140fc574e 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -20,50 +20,32 @@
 /*
  * Tracepoints for VM enters
  */
-TRACE_EVENT(kvm_enter,
-	    TP_PROTO(struct kvm_vcpu *vcpu),
-	    TP_ARGS(vcpu),
-	    TP_STRUCT__entry(
-			__field(unsigned long, pc)
-	    ),
-
-	    TP_fast_assign(
-			__entry->pc = vcpu->arch.pc;
-	    ),
-
-	    TP_printk("PC: 0x%08lx",
-		      __entry->pc)
+DECLARE_EVENT_CLASS(kvm_transition,
+	TP_PROTO(struct kvm_vcpu *vcpu),
+	TP_ARGS(vcpu),
+	TP_STRUCT__entry(
+		__field(unsigned long, pc)
+	),
+
+	TP_fast_assign(
+		__entry->pc = vcpu->arch.pc;
+	),
+
+	TP_printk("PC: 0x%08lx",
+		  __entry->pc)
 );
 
-TRACE_EVENT(kvm_reenter,
-	    TP_PROTO(struct kvm_vcpu *vcpu),
-	    TP_ARGS(vcpu),
-	    TP_STRUCT__entry(
-			__field(unsigned long, pc)
-	    ),
+DEFINE_EVENT(kvm_transition, kvm_enter,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
 
-	    TP_fast_assign(
-			__entry->pc = vcpu->arch.pc;
-	    ),
-
-	    TP_printk("PC: 0x%08lx",
-		      __entry->pc)
-);
+DEFINE_EVENT(kvm_transition, kvm_reenter,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
 
-TRACE_EVENT(kvm_out,
-	    TP_PROTO(struct kvm_vcpu *vcpu),
-	    TP_ARGS(vcpu),
-	    TP_STRUCT__entry(
-			__field(unsigned long, pc)
-	    ),
-
-	    TP_fast_assign(
-			__entry->pc = vcpu->arch.pc;
-	    ),
-
-	    TP_printk("PC: 0x%08lx",
-		      __entry->pc)
-);
+DEFINE_EVENT(kvm_transition, kvm_out,
+	     TP_PROTO(struct kvm_vcpu *vcpu),
+	     TP_ARGS(vcpu));
 
 /* The first 32 exit reasons correspond to Cause.ExcCode */
 #define KVM_TRACE_EXIT_INT		 0
-- 
2.4.10
