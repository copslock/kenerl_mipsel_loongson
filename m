Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:06:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39875 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcITMGCXbQl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 14:06:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AE1A1C05861FA;
        Tue, 20 Sep 2016 13:05:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 13:05:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/4] KVM: MIPS: Split kernel/user ASID regeneration
Date:   Tue, 20 Sep 2016 13:05:38 +0100
Message-ID: <cc2428bec559fc4bd94f831c968b3671c6da4b22.1474372617.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
In-Reply-To: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
References: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55210
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

The host ASIDs for guest kernel and user mode are regenerated together
if the ASID for guest kernel mode is out of date. That is fine as the
ASID for guest kernel mode is always generated first, however it doesn't
allow the ASIDs to be regenerated or invalidated individually instead of
linearly flushing the entire host TLB.

Therefore separate the regeneration code so that the ASIDs are checked
and regenerated separately.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 121008c0fcc9..3b677c851be0 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -250,6 +250,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
 		vcpu->arch.guest_kernel_asid[cpu] =
 		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
+		newasid++;
+
+		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
+			  cpu_context(cpu, current->mm));
+		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
+			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
+	}
+
+	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
+						asid_version_mask(cpu)) {
 		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
 		vcpu->arch.guest_user_asid[cpu] =
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
@@ -257,8 +267,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
 			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
 		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
 			  vcpu->arch.guest_user_asid[cpu]);
 	}
-- 
git-series 0.8.10
