Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:20:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62801 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041080AbcFINTkcv4Si (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5348ED9279412;
        Thu,  9 Jun 2016 14:19:31 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 03/18] MIPS: KVM: Drop unused kvm_mips_sync_icache()
Date:   Thu, 9 Jun 2016 14:19:06 +0100
Message-ID: <1465478361-7431-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53917
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

The function kvm_mips_sync_icache() is unused, so lets remove it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 2836668d63fc..6c2adcfd7faf 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1529,32 +1529,6 @@ enum emulation_result kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 	return er;
 }
 
-int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
-{
-	unsigned long offset = (va & ~PAGE_MASK);
-	struct kvm *kvm = vcpu->kvm;
-	unsigned long pa;
-	gfn_t gfn;
-	kvm_pfn_t pfn;
-
-	gfn = va >> PAGE_SHIFT;
-
-	if (gfn >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx\n", __func__, gfn);
-		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
-		return -1;
-	}
-	pfn = kvm->arch.guest_pmap[gfn];
-	pa = (pfn << PAGE_SHIFT) | offset;
-
-	kvm_debug("%s: va: %#lx, unmapped: %#x\n", __func__, va,
-		  CKSEG0ADDR(pa));
-
-	local_flush_icache_range(CKSEG0ADDR(pa), 32);
-	return 0;
-}
-
 enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 					     uint32_t cause,
 					     struct kvm_run *run,
-- 
2.4.10
