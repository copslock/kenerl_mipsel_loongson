Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:39:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11758 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992476AbcGDSfohbgE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 971F3D9D10017;
        Mon,  4 Jul 2016 19:35:34 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 9/9] MIPS: KVM: Emulate generic QEMU machine on r6 T&E
Date:   Mon, 4 Jul 2016 19:35:15 +0100
Message-ID: <1467657315-19975-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54208
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

Default the guest PRId register to represent a generic QEMU machine
instead of a 24kc on MIPSr6. 24kc isn't supported by r6 Linux kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 00e8dc3d36cb..091553942bcb 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -431,9 +431,15 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Arch specific stuff, set up config registers properly so that the
-	 * guest will come up as expected, for now we simulate a MIPS 24kc
+	 * guest will come up as expected
 	 */
+#ifndef CONFIG_CPU_MIPSR6
+	/* r2-r5, simulate a MIPS 24kc */
 	kvm_write_c0_guest_prid(cop0, 0x00019300);
+#else
+	/* r6+, simulate a generic QEMU machine */
+	kvm_write_c0_guest_prid(cop0, 0x00010000);
+#endif
 	/*
 	 * Have config1, Cacheable, noncoherent, write-back, write allocate.
 	 * Endianness, arch revision & virtually tagged icache should match
-- 
2.4.10
