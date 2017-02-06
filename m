Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 11:48:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51089 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdBFKrPOJJql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 11:47:15 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F00B4FA77CD11;
        Mon,  6 Feb 2017 10:47:05 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 6 Feb 2017 10:47:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 4/4] KVM: MIPS: Implement console output hypercall
Date:   Mon, 6 Feb 2017 10:46:49 +0000
Message-ID: <7ae3d49bf9ce153a5460a393bfa513a585930487.1486377433.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
References: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56655
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

Implement console output hypercall by exiting back to userland with
KVM_EXIT_HYPERCALL, and setting the return value on next KVM_RUN.

We also document the hypercall along with the others as the
documentation was never added

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Documentation/virtual/kvm/api.txt seems to suggest that
KVM_EXIT_HYPERCALL is obsolete. When it suggests using KVM_EXIT_MMIO,
does it simply mean the guest should use MMIO to some virtio device of
some sort rather than using hypercalls, or that the hypercall should
somehow be munged into the mmio exit information?
---
 Documentation/virtual/kvm/hypercalls.txt | 10 ++++++++++
 arch/mips/include/asm/kvm_host.h         |  4 ++++
 arch/mips/kvm/hypcall.c                  | 20 ++++++++++++++++++++
 arch/mips/kvm/mips.c                     |  3 +++
 4 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index f8108c84c46b..4e6e57026bfe 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -98,3 +98,13 @@ Purpose: Return the frequency of CP0_Count in HZ.
 Architecture: mips
 Status: active
 Purpose: Shut down the virtual machine.
+
+8. KVM_HC_MIPS_CONSOLE_OUTPUT
+------------------------
+Architecture: mips
+Status: active
+Purpose: Output a string to a console.
+Argument 1 contains the virtual terminal number to write to.
+Argument 2 contains a guest virtual address pointer to the string, which must
+be in an unmapped virtual memory segment (e.g. KSeg0, KSeg1 or XKPhys).
+Argument 3 contains the number of bytes to write.
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 0d308d4f2429..e0f1da0c35e9 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -309,6 +309,9 @@ struct kvm_vcpu_arch {
 	/* GPR used as IO source/target */
 	u32 io_gpr;
 
+	/* Whether a hypercall needs completing */
+	int hypercall_needed;
+
 	struct hrtimer comparecount_timer;
 	/* Count timer control KVM register */
 	u32 count_ctl;
@@ -838,6 +841,7 @@ unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu);
 enum emulation_result kvm_mips_emul_hypcall(struct kvm_vcpu *vcpu,
 					    union mips_instruction inst);
 int kvm_mips_handle_hypcall(struct kvm_vcpu *vcpu);
+void kvm_mips_complete_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 /* Dynamic binary translation */
 extern int kvm_mips_trans_cache_index(union mips_instruction inst,
diff --git a/arch/mips/kvm/hypcall.c b/arch/mips/kvm/hypcall.c
index c3345e5eec02..9cb8f37ca43a 100644
--- a/arch/mips/kvm/hypcall.c
+++ b/arch/mips/kvm/hypcall.c
@@ -33,6 +33,7 @@ static int kvm_mips_hypercall(struct kvm_vcpu *vcpu, unsigned long num,
 			      const unsigned long *args, unsigned long *hret)
 {
 	int ret = RESUME_GUEST;
+	int i;
 
 	switch (num) {
 	case KVM_HC_MIPS_GET_CLOCK_FREQ:
@@ -49,6 +50,19 @@ static int kvm_mips_hypercall(struct kvm_vcpu *vcpu, unsigned long num,
 		ret = RESUME_HOST;
 		break;
 
+	/* Hypercalls passed to userland to handle */
+	case KVM_HC_MIPS_CONSOLE_OUTPUT:
+		/* Pass to userland via KVM_EXIT_HYPERCALL */
+		memset(&vcpu->run->hypercall, 0, sizeof(vcpu->run->hypercall));
+		vcpu->run->hypercall.nr = num;
+		for (i = 0; i < MAX_HYPCALL_ARGS; ++i)
+			vcpu->run->hypercall.args[i] = args[i];
+		vcpu->run->hypercall.ret = -KVM_ENOSYS; /* default */
+		vcpu->run->exit_reason = KVM_EXIT_HYPERCALL;
+		vcpu->arch.hypercall_needed = 1;
+		ret = RESUME_HOST;
+		break;
+
 	default:
 		/* Report unimplemented hypercall to guest */
 		*hret = -KVM_ENOSYS;
@@ -72,3 +86,9 @@ int kvm_mips_handle_hypcall(struct kvm_vcpu *vcpu)
 	return kvm_mips_hypercall(vcpu, num,
 				  args, &vcpu->arch.gprs[2] /* v0 */);
 }
+
+void kvm_mips_complete_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	vcpu->arch.gprs[2] = run->hypercall.ret;	/* v0 */
+	vcpu->arch.hypercall_needed = 0;
+}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 31ee5ee0010b..1c23dc29db5d 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -409,6 +409,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}
 
+	if (vcpu->arch.hypercall_needed)
+		kvm_mips_complete_hypercall(vcpu, run);
+
 	lose_fpu(1);
 
 	local_irq_disable();
-- 
git-series 0.8.10
