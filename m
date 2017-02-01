Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 15:20:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42912 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992236AbdBAOTnPsr5g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 15:19:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8F6CD54D303D0;
        Wed,  1 Feb 2017 14:19:32 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Feb 2017 14:19:35 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/5] KVM: MIPS/T&E: Default to reset vector
Date:   Wed, 1 Feb 2017 14:19:25 +0000
Message-ID: <d403f824532f5ec3872c084277095be6ff957e0d.1485958267.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
References: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56574
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

Set the default VCPU state closer to the architectural reset state, with
PC pointing at the reset vector (uncached PA 0x1fc00000, which for KVM
T&E is VA 0x5fc00000), and with CP0_Status.BEV and CP0_Status.ERL to 1.

Although QEMU at least will overwrite this state, it makes sense to do
this now that CP0_EBase is properly implemented to check BEV, and now
that we support a sparse GPA layout potentially with a boot ROM at GPA
0x1fc00000.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 6 ++++++
 1 file changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 27082994e07d..86a104947e4d 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -614,6 +614,9 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	/* Set Wait IE/IXMT Ignore in Config7, IAR, AR */
 	kvm_write_c0_guest_config7(cop0, (MIPS_CONF7_WII) | (1 << 10));
 
+	/* Status */
+	kvm_write_c0_guest_status(cop0, ST0_BEV | ST0_ERL);
+
 	/*
 	 * Setup IntCtl defaults, compatibility mode for timer interrupts (HW5)
 	 */
@@ -623,6 +626,9 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_write_c0_guest_ebase(cop0, KVM_GUEST_KSEG0 |
 				       (vcpu_id & MIPS_EBASE_CPUNUM));
 
+	/* Put PC at guest reset vector */
+	vcpu->arch.pc = KVM_GUEST_CKSEG1ADDR(0x1fc00000);
+
 	return 0;
 }
 
-- 
git-series 0.8.10
