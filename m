Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Mar 2015 00:01:17 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:29293 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006959AbbCNXBNYGmr3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Mar 2015 00:01:13 +0100
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t2EN0vId026112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 14 Mar 2015 23:01:00 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t2EN0t8W006940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Mar 2015 23:00:56 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id t2EN0sWY022080;
        Sat, 14 Mar 2015 23:00:55 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.154.165.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Mar 2015 16:00:54 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Gleb Natapov <gleb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] KVM: MIPS: Fix trace event to save PC directly
Date:   Sat, 14 Mar 2015 18:59:16 -0400
Message-Id: <1426373999-22564-66-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kvm/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index c1388d4..bd6437f 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -24,18 +24,18 @@ TRACE_EVENT(kvm_exit,
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
-- 
2.1.0
