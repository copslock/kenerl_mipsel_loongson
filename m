Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:30:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49082 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042322AbcFOSaNAaHAW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3FDC86CCCC638;
        Wed, 15 Jun 2016 19:30:02 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 01/17] MIPS: KVM: Fix translation of MFC0 ErrCtl
Date:   Wed, 15 Jun 2016 19:29:45 +0100
Message-ID: <1466015401-24433-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54054
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

The MIPS KVM dynamic translation is meant to translate "MFC0 rt, ErrCtl"
instructions into "ADD rt, zero, zero" to zero the destination register,
however the rt register number was copied into rt of the ADD instruction
encoding, which is the 2nd source operand. This results in "ADD zero,
zero, rt" which is a no-op, so only the first execution of each such
MFC0 from ErrCtl will actually read 0.

Fix the shift to put the rt from the MFC0 encoding into the rd field of
the ADD.

Fixes: 50c8308538dc ("KVM/MIPS32: Binary patching of select privileged instructions.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index d4a86fb239cd..79b134c91333 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -82,7 +82,7 @@ int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 
 	if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
 		mfc0_inst = CLEAR_TEMPLATE;
-		mfc0_inst |= ((rt & 0x1f) << 16);
+		mfc0_inst |= ((rt & 0x1f) << 11);
 	} else {
 		mfc0_inst = LW_TEMPLATE;
 		mfc0_inst |= ((rt & 0x1f) << 16);
-- 
2.4.10
