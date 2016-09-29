Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2016 14:15:23 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:45385 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992279AbcI2MOuWMH9i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Sep 2016 14:14:50 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 4FEC681ABA394;
        Thu, 29 Sep 2016 13:14:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL03.hh.imgtec.org (10.44.0.22) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Sep 2016 13:14:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [GIT PULL 4/6] KVM: MIPS: Split kernel/user ASID regeneration
Date:   Thu, 29 Sep 2016 13:14:24 +0100
Message-ID: <1475151266-28660-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
References: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55295
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
index 6cfdcf55572d..c1f8758f5323 100644
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
2.7.3
