Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:10:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7924 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993912AbdBBMFHku0dv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 45090B596C029;
        Thu,  2 Feb 2017 12:04:58 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 11/30] KVM: MIPS/T&E: Restore host asid on return to host
Date:   Thu, 2 Feb 2017 12:04:24 +0000
Message-ID: <081bc7401b80f423d78d8113e974c13ffa5582ab.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56601
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

We only need the guest ASID loaded while in guest context, i.e. while
running guest code and while handling guest exits. We load the guest
ASID when entering the guest, however we restore the host ASID later
than necessary, when the VCPU state is saved i.e. vcpu_put() or slightly
earlier if preempted after returning to the host.

This mismatch is both unpleasant and causes redundant host ASID restores
in kvm_trap_emul_vcpu_put(). Lets explicitly restore the host ASID when
returning to the host, and don't bother restoring the host ASID on
context switch in unless we're already in guest context.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 92734d095c94..3e1dbcbcea85 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -680,14 +680,17 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 {
 	kvm_lose_fpu(vcpu);
 
-	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-	     asid_version_mask(cpu))) {
-		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
-			  cpu_context(cpu, current->mm));
-		drop_mmu_context(current->mm, cpu);
+	if (current->flags & PF_VCPU) {
+		/* Restore normal Linux process memory map */
+		if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
+		     asid_version_mask(cpu))) {
+			kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
+				  cpu_context(cpu, current->mm));
+			get_new_mmu_context(current->mm, cpu);
+		}
+		write_c0_entryhi(cpu_asid(cpu, current->mm));
+		ehb();
 	}
-	write_c0_entryhi(cpu_asid(cpu, current->mm));
-	ehb();
 
 	return 0;
 }
@@ -720,6 +723,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
+	int cpu;
 	int r;
 
 	/* Check if we have any exceptions/interrupts pending */
@@ -733,6 +737,15 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	r = vcpu->arch.vcpu_run(run, vcpu);
 
+	/* We may have migrated while handling guest exits */
+	cpu = smp_processor_id();
+
+	/* Restore normal Linux process memory map */
+	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
+	     asid_version_mask(cpu)))
+		get_new_mmu_context(current->mm, cpu);
+	write_c0_entryhi(cpu_asid(cpu, current->mm));
+
 	htw_start();
 
 	return r;
-- 
git-series 0.8.10
