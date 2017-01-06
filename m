Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:41:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53127 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993107AbdAFBdoy0YIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E283C238FD86A;
        Fri,  6 Jan 2017 01:33:37 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:38 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 13/30] KVM: MIPS: Wire up vcpu uninit
Date:   Fri, 6 Jan 2017 01:32:45 +0000
Message-ID: <4fc8414664b81ac45fbdea2d4a5a96e4a541e40e.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56192
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

Wire up a vcpu uninit implementation callback. This will be used for the
clean up of GVA->HPA page tables.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 arch/mips/kvm/mips.c             | 5 +++++
 arch/mips/kvm/trap_emul.c        | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9f319375835a..8c4a33e9687d 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -519,6 +519,7 @@ struct kvm_mips_callbacks {
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
+	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	gpa_t (*gva_to_gpa)(gva_t gva);
 	void (*queue_timer_int)(struct kvm_vcpu *vcpu);
@@ -761,7 +762,6 @@ static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslot
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *slot) {}
-static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 982fe31a952e..c3f2207a37a0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1350,6 +1350,11 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+	kvm_mips_callbacks->vcpu_uninit(vcpu);
+}
+
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 				  struct kvm_translation *tr)
 {
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index ab3750f6a768..f3c3afd57738 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -440,6 +440,10 @@ static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void kvm_trap_emul_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+}
+
 static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
@@ -783,6 +787,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 
 	.vm_init = kvm_trap_emul_vm_init,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
+	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
 	.gva_to_gpa = kvm_trap_emul_gva_to_gpa_cb,
 	.queue_timer_int = kvm_mips_queue_timer_int_cb,
-- 
git-series 0.8.10
