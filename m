Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:35:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55252 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992835AbdAFBdilBrOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:38 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C86A8F71C986C;
        Fri,  6 Jan 2017 01:33:31 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/30] KVM: MIPS: Drop partial KVM_NMI implementation
Date:   Fri, 6 Jan 2017 01:32:37 +0000
Message-ID: <ecb6bdf14d7f58822d0e5e9d621e0b396c064c36.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56178
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

MIPS incompletely implements the KVM_NMI ioctl to supposedly perform a
CPU reset, but all it actually does is invalidate the ASIDs. It doesn't
expose the KVM_CAP_USER_NMI capability which is supposed to indicate the
presence of the KVM_NMI ioctl, and no user software actually uses it on
MIPS.

Since this is dead code that would technically need updating for GVA
page table handling in upcoming patches, remove it now. If we wanted to
implement NMI injection later it can always be done properly along with
the KVM_CAP_USER_NMI capability, and if we wanted to implement a proper
CPU reset it would be better done with a separate ioctl.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 16 ----------------
 1 file changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 29ec9ab3fd55..de32ce30c78c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -63,18 +63,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{NULL}
 };
 
-static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		vcpu->arch.guest_kernel_asid[i] = 0;
-		vcpu->arch.guest_user_asid[i] = 0;
-	}
-
-	return 0;
-}
-
 /*
  * XXXKYMA: We are simulatoring a processor that has the WII bit set in
  * Config7, so we are "runnable" if interrupts are pending
@@ -1144,10 +1132,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 			return -E2BIG;
 		return kvm_mips_copy_reg_indices(vcpu, user_list->reg);
 	}
-	case KVM_NMI:
-		/* Treat the NMI as a CPU reset */
-		r = kvm_mips_reset_vcpu(vcpu);
-		break;
 	case KVM_INTERRUPT:
 		{
 			struct kvm_mips_interrupt irq;
-- 
git-series 0.8.10
