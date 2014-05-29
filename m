Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:22:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41232 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833152AbaE2JRKRh5PA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73D077E944479;
        Thu, 29 May 2014 10:17:06 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 10:17:08 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:08 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:17:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 18/23] MIPS: KVM: Whitespace fixes in kvm_mips_callbacks
Date:   Thu, 29 May 2014 10:16:40 +0100
Message-ID: <1401355005-20370-19-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40336
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

Fix whitespace in struct kvm_mips_callbacks function pointers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f9c672f729ea..b0aa95565752 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -569,29 +569,29 @@ static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
 
 
 struct kvm_mips_callbacks {
-	int (*handle_cop_unusable) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_mod) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_ld_miss) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_st_miss) (struct kvm_vcpu *vcpu);
-	int (*handle_addr_err_st) (struct kvm_vcpu *vcpu);
-	int (*handle_addr_err_ld) (struct kvm_vcpu *vcpu);
-	int (*handle_syscall) (struct kvm_vcpu *vcpu);
-	int (*handle_res_inst) (struct kvm_vcpu *vcpu);
-	int (*handle_break) (struct kvm_vcpu *vcpu);
-	int (*vm_init) (struct kvm *kvm);
-	int (*vcpu_init) (struct kvm_vcpu *vcpu);
-	int (*vcpu_setup) (struct kvm_vcpu *vcpu);
-	 gpa_t(*gva_to_gpa) (gva_t gva);
-	void (*queue_timer_int) (struct kvm_vcpu *vcpu);
-	void (*dequeue_timer_int) (struct kvm_vcpu *vcpu);
-	void (*queue_io_int) (struct kvm_vcpu *vcpu,
-			      struct kvm_mips_interrupt *irq);
-	void (*dequeue_io_int) (struct kvm_vcpu *vcpu,
-				struct kvm_mips_interrupt *irq);
-	int (*irq_deliver) (struct kvm_vcpu *vcpu, unsigned int priority,
-			    uint32_t cause);
-	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
-			  uint32_t cause);
+	int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
+	int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
+	int (*handle_tlb_ld_miss)(struct kvm_vcpu *vcpu);
+	int (*handle_tlb_st_miss)(struct kvm_vcpu *vcpu);
+	int (*handle_addr_err_st)(struct kvm_vcpu *vcpu);
+	int (*handle_addr_err_ld)(struct kvm_vcpu *vcpu);
+	int (*handle_syscall)(struct kvm_vcpu *vcpu);
+	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
+	int (*handle_break)(struct kvm_vcpu *vcpu);
+	int (*vm_init)(struct kvm *kvm);
+	int (*vcpu_init)(struct kvm_vcpu *vcpu);
+	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
+	gpa_t (*gva_to_gpa)(gva_t gva);
+	void (*queue_timer_int)(struct kvm_vcpu *vcpu);
+	void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
+	void (*queue_io_int)(struct kvm_vcpu *vcpu,
+			     struct kvm_mips_interrupt *irq);
+	void (*dequeue_io_int)(struct kvm_vcpu *vcpu,
+			       struct kvm_mips_interrupt *irq);
+	int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority,
+			   uint32_t cause);
+	int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority,
+			 uint32_t cause);
 	int (*get_one_reg)(struct kvm_vcpu *vcpu,
 			   const struct kvm_one_reg *reg, s64 *v);
 	int (*set_one_reg)(struct kvm_vcpu *vcpu,
-- 
1.9.3
