Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:30:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17932 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041615AbcFNK2oHEh8Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1D4D180572099;
        Tue, 14 Jun 2016 09:40:45 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:47 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 7/8] MIPS: KVM: Dump guest tlbs if kvm_get_inst() fails
Date:   Tue, 14 Jun 2016 09:40:16 +0100
Message-ID: <1465893617-5774-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54044
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

If kvm_get_inst() fails to find a guest TLB mapping for the guest PC
then dump the guest TLB entries. The contents of the guest TLB is likely
to be more interesting than the host TLB entries.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 208f70409ccb..2f494ec5c939 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -346,6 +346,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
 					__func__, opc, vcpu, read_c0_entryhi());
 				kvm_mips_dump_host_tlbs();
+				kvm_mips_dump_guest_tlbs(vcpu);
 				local_irq_restore(flags);
 				return KVM_INVALID_INST;
 			}
-- 
2.4.10
