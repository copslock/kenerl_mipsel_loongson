Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 17:09:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52774 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992800AbcJYPIlBDplh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 17:08:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DD55134BC3CD1;
        Tue, 25 Oct 2016 16:08:27 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 25 Oct 2016 16:08:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/3] KVM: MIPS: Fix lazy user ASID regenerate for SMP
Date:   Tue, 25 Oct 2016 16:08:19 +0100
Message-ID: <26798303b5e56962d2afcdbf878fc7a85f99ba98.1477320903.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
In-Reply-To: <cover.c0ced53ae71e1272ec1aaa16007e9eebb1c0eac6.1477320903.git-series.james.hogan@imgtec.com>
References: <cover.c0ced53ae71e1272ec1aaa16007e9eebb1c0eac6.1477320903.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55575
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

kvm_mips_check_asids() runs before entering the guest and performs lazy
regeneration of host ASID for guest usermode, using last_user_gasid to
track the last guest ASID in the VCPU that was used by guest usermode on
any host CPU.

last_user_gasid is reset after performing the lazy ASID regeneration on
the current CPU, and by kvm_arch_vcpu_load() if the host ASID for guest
usermode is regenerated due to staleness (to cancel outstanding lazy
ASID regenerations). Unfortunately neither case handles SMP hosts
correctly:

 - When the lazy ASID regeneration is performed it should apply to all
   CPUs (as last_user_gasid does), so reset the ASID on other CPUs to
   zero to trigger regeneration when the VCPU is next loaded on those
   CPUs.

 - When the ASID is found to be stale on the current CPU, we should not
   cancel lazy ASID regenerations globally, so drop the reset of
   last_user_gasid altogether here.

Both cases would require a guest ASID change and two host CPU migrations
(and in the latter case one of the CPUs to start a new ASID cycle)
before guest usermode could potentially access stale user pages from a
previously running ASID in the same VCPU.

Fixes: 25b08c7fb0e4 ("KVM: MIPS: Invalidate TLB by regenerating ASIDs")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 5 ++++-
 arch/mips/kvm/mmu.c  | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 622037d851a3..06a60b19acfb 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -426,7 +426,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	int cpu = smp_processor_id();
+	int i, cpu = smp_processor_id();
 	unsigned int gasid;
 
 	/*
@@ -442,6 +442,9 @@ static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
 						vcpu);
 			vcpu->arch.guest_user_asid[cpu] =
 				vcpu->arch.guest_user_mm.context.asid[cpu];
+			for_each_possible_cpu(i)
+				if (i != cpu)
+					vcpu->arch.guest_user_asid[cpu] = 0;
 			vcpu->arch.last_user_gasid = gasid;
 		}
 	}
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 03883ba806e2..3b677c851be0 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -260,13 +260,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
 						asid_version_mask(cpu)) {
-		u32 gasid = kvm_read_c0_guest_entryhi(vcpu->arch.cop0) &
-				KVM_ENTRYHI_ASID;
-
 		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
 		vcpu->arch.guest_user_asid[cpu] =
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
-		vcpu->arch.last_user_gasid = gasid;
 		newasid++;
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-- 
git-series 0.8.10
