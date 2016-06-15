Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:35:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40009 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042352AbcFOSaXk3tXW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 125C94F96A1E7;
        Wed, 15 Jun 2016 19:30:13 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 16/17] MIPS: KVM: Report more accurate CP0_Config fields to guest
Date:   Wed, 15 Jun 2016 19:30:00 +0100
Message-ID: <1466015401-24433-17-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54070
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

Initialise the guest's CP0_Config register with a few more bits of
information from the host. The BE bit should be set on big endian
machines, the VI bit should be set on machines with a virtually tagged
instruction cache, and the reported architecture revision should match
that of the host (since we won't support emulating pre-r6 instruction
encodings on r6 or vice versa).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index eb191c4612bb..1dc003ddca91 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -426,7 +426,7 @@ static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	u32 config1;
+	u32 config, config1;
 	int vcpu_id = vcpu->vcpu_id;
 
 	/*
@@ -434,10 +434,20 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	 * guest will come up as expected, for now we simulate a MIPS 24kc
 	 */
 	kvm_write_c0_guest_prid(cop0, 0x00019300);
-	/* Have config1, Cacheable, noncoherent, write-back, write allocate */
-	kvm_write_c0_guest_config(cop0, MIPS_CONF_M | (0x3 << CP0C0_K0) |
-				  (0x1 << CP0C0_AR) |
-				  (MMU_TYPE_R4000 << CP0C0_MT));
+	/*
+	 * Have config1, Cacheable, noncoherent, write-back, write allocate.
+	 * Endianness, arch revision & virtually tagged icache should match
+	 * host.
+	 */
+	config = read_c0_config() & MIPS_CONF_AR;
+	config |= MIPS_CONF_M | (0x3 << CP0C0_K0) |
+		(MMU_TYPE_R4000 << CP0C0_MT);
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	config |= CONF_BE;
+#endif
+	if (cpu_has_vtag_icache)
+		config |= MIPS_CONF_VI;
+	kvm_write_c0_guest_config(cop0, config);
 
 	/* Read the cache characteristics from the host Config1 Register */
 	config1 = (read_c0_config1() & ~0x7f);
-- 
2.4.10
