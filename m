Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 15:03:48 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:37215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014605AbbCYODpr4zoB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 15:03:45 +0100
Received: from [10.172.192.212] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1YaluD-000455-55; Wed, 25 Mar 2015 14:03:37 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Gleb Natapov <gleb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 070/165] KVM: MIPS: Fix trace event to save PC directly
Date:   Wed, 25 Mar 2015 14:00:43 +0000
Message-Id: <1427292138-7021-71-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427292138-7021-1-git-send-email-luis.henriques@canonical.com>
References: <1427292138-7021-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt9 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit b3cffac04eca9af46e1e23560a8ee22b1bd36d43 upstream.

Currently the guest exit trace event saves the VCPU pointer to the
structure, and the guest PC is retrieved by dereferencing it when the
event is printed rather than directly from the trace record. This isn't
safe as the printing may occur long afterwards, after the PC has changed
and potentially after the VCPU has been freed. Usually this results in
the same (wrong) PC being printed for multiple trace events. It also
isn't portable as userland has no way to access the VCPU data structure
when interpreting the trace record itself.

Lets save the actual PC in the structure so that the correct value is
accessible later.

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kvm/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index bc9e0f406c08..e51621e36152 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -26,18 +26,18 @@ TRACE_EVENT(kvm_exit,
 	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
 	    TP_ARGS(vcpu, reason),
 	    TP_STRUCT__entry(
-			__field(struct kvm_vcpu *, vcpu)
+			__field(unsigned long, pc)
 			__field(unsigned int, reason)
 	    ),
 
 	    TP_fast_assign(
-			__entry->vcpu = vcpu;
+			__entry->pc = vcpu->arch.pc;
 			__entry->reason = reason;
 	    ),
 
 	    TP_printk("[%s]PC: 0x%08lx",
 		      kvm_mips_exit_types_str[__entry->reason],
-		      __entry->vcpu->arch.pc)
+		      __entry->pc)
 );
 
 #endif /* _TRACE_KVM_H */
