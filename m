Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:33:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18272 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042344AbcFOSaTQ0t9W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E1C4AA9E2284C;
        Wed, 15 Jun 2016 19:30:08 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/17] MIPS: KVM: Allow ULRI to restrict UserLocal register
Date:   Wed, 15 Jun 2016 19:29:54 +0100
Message-ID: <1466015401-24433-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54064
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

The ULRI bit in Config3 specifies whether the UserLocal register is
implemented, but it is assumed to always be set. Now that the Config
registers can be modified by userland, allow Config3.ULRI to be cleared
and check ULRI before allowing the corresponding bit to be set in
HWREna.

In fact any HWREna bits corresponding to unimplemented RDHWR registers
should read as zero and be ignored on write, so we actually prevent
other unimplemented bits being set too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 892f36f56d32..84f435bf74bd 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -921,8 +921,8 @@ unsigned int kvm_mips_config1_wrmask(struct kvm_vcpu *vcpu)
  */
 unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu)
 {
-	/* Config4 is optional */
-	unsigned int mask = MIPS_CONF_M;
+	/* Config4 and ULRI are optional */
+	unsigned int mask = MIPS_CONF_M | MIPS_CONF3_ULRI;
 
 	/* Permit MSA to be present if MSA is supported */
 	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
@@ -1229,6 +1229,16 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 					else
 						kvm_mips_count_enable_cause(vcpu);
 				}
+			} else if ((rd == MIPS_CP0_HWRENA) && (sel == 0)) {
+				u32 mask = MIPS_HWRENA_CPUNUM |
+					   MIPS_HWRENA_SYNCISTEP |
+					   MIPS_HWRENA_CC |
+					   MIPS_HWRENA_CCRES;
+
+				if (kvm_read_c0_guest_config3(cop0) &
+				    MIPS_CONF3_ULRI)
+					mask |= MIPS_HWRENA_ULR;
+				cop0->reg[rd][sel] = vcpu->arch.gprs[rt] & mask;
 			} else {
 				cop0->reg[rd][sel] = vcpu->arch.gprs[rt];
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
-- 
2.4.10
