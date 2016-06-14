Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:29:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51258 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040979AbcFNK2Q0zEkY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B76A3B347BA32;
        Tue, 14 Jun 2016 09:40:42 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 4/8] MIPS: KVM: Add kvm_asid_change trace event
Date:   Tue, 14 Jun 2016 09:40:13 +0100
Message-ID: <1465893617-5774-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54041
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

Add a trace event for guest ASID changes, replacing the existing
kvm_debug call.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/emulate.c |  7 +++----
 arch/mips/kvm/trace.h   | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index fce08bda9ebc..ee0e61d2b6fb 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1082,11 +1082,10 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
 				    ((kvm_read_c0_guest_entryhi(cop0) &
 				      KVM_ENTRYHI_ASID) != nasid)) {
-					kvm_debug("MTCz, change ASID from %#lx to %#lx\n",
+					trace_kvm_asid_change(vcpu,
 						kvm_read_c0_guest_entryhi(cop0)
-						& KVM_ENTRYHI_ASID,
-						vcpu->arch.gprs[rt]
-						& KVM_ENTRYHI_ASID);
+							& KVM_ENTRYHI_ASID,
+						nasid);
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 9a1212e09435..1d67d9e0f340 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -122,6 +122,28 @@ TRACE_EVENT(kvm_aux,
 		      __entry->pc)
 );
 
+TRACE_EVENT(kvm_asid_change,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int old_asid,
+		     unsigned int new_asid),
+	    TP_ARGS(vcpu, old_asid, new_asid),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+			__field(u8, old_asid)
+			__field(u8, new_asid)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+			__entry->old_asid = old_asid;
+			__entry->new_asid = new_asid;
+	    ),
+
+	    TP_printk("PC: 0x%08lx old: 0x%02x new: 0x%02x",
+		      __entry->pc,
+		      __entry->old_asid,
+		      __entry->new_asid)
+);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
2.4.10
