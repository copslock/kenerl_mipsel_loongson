Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:57:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13966 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992879AbcGHKyKj1Zkv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 463113E82F4A6;
        Fri,  8 Jul 2016 11:53:52 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 09/12] MIPS: KVM: Sign extend MFC0/RDHWR results
Date:   Fri, 8 Jul 2016 11:53:28 +0100
Message-ID: <1467975211-12674-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54269
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

When emulating MFC0 instructions to load 32-bit values from guest COP0
registers and the RDHWR instruction to read the CC (Count) register,
sign extend the result to comply with the MIPS64 architecture. The
result must be in canonical 32-bit form or the guest may malfunction.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index be18dfe9ecaa..6eb52b9c9818 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1072,14 +1072,15 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 #endif
 			/* Get reg */
 			if ((rd == MIPS_CP0_COUNT) && (sel == 0)) {
-				vcpu->arch.gprs[rt] = kvm_mips_read_count(vcpu);
+				vcpu->arch.gprs[rt] =
+				    (s32)kvm_mips_read_count(vcpu);
 			} else if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
 				vcpu->arch.gprs[rt] = 0x0;
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mfc0(inst, opc, vcpu);
 #endif
 			} else {
-				vcpu->arch.gprs[rt] = cop0->reg[rd][sel];
+				vcpu->arch.gprs[rt] = (s32)cop0->reg[rd][sel];
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mfc0(inst, opc, vcpu);
@@ -2380,7 +2381,7 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 					     current_cpu_data.icache.linesz);
 			break;
 		case MIPS_HWR_CC:		/* Read count register */
-			arch->gprs[rt] = kvm_mips_read_count(vcpu);
+			arch->gprs[rt] = (s32)kvm_mips_read_count(vcpu);
 			break;
 		case MIPS_HWR_CCRES:		/* Count register resolution */
 			switch (current_cpu_data.cputype) {
-- 
2.4.10
