Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:55:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30432 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992777AbcGHKx7tndwv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:53:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E3FDE2D505EA;
        Fri,  8 Jul 2016 11:53:51 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 08/12] MIPS: KVM: Fix 64-bit big endian dynamic translation
Date:   Fri, 8 Jul 2016 11:53:27 +0100
Message-ID: <1467975211-12674-9-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54262
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

The MFC0 and MTC0 instructions in the guest which cause traps can be
replaced with 32-bit loads and stores to the commpage, however on big
endian 64-bit builds the offset needs to have 4 added so as to
load/store the least significant half of the long instead of the most
significant half.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 9a16ba2cb487..c793ff19a8a8 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -103,6 +103,10 @@ int kvm_mips_trans_mfc0(union mips_instruction inst, u32 *opc,
 		mfc0_inst.i_format.rt = inst.c0r_format.rt;
 		mfc0_inst.i_format.simmediate = KVM_GUEST_COMMPAGE_ADDR |
 			offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		if (sizeof(vcpu->arch.cop0->reg[0][0]) == 8)
+			mfc0_inst.i_format.simmediate |= 4;
+#endif
 	}
 
 	return kvm_mips_trans_replace(vcpu, opc, mfc0_inst);
@@ -121,6 +125,10 @@ int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
 	mtc0_inst.i_format.rt = inst.c0r_format.rt;
 	mtc0_inst.i_format.simmediate = KVM_GUEST_COMMPAGE_ADDR |
 		offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	if (sizeof(vcpu->arch.cop0->reg[0][0]) == 8)
+		mtc0_inst.i_format.simmediate |= 4;
+#endif
 
 	return kvm_mips_trans_replace(vcpu, opc, mtc0_inst);
 }
-- 
2.4.10
