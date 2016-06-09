Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:20:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58429 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041063AbcFINTkMbEVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ECD04B29BA1F;
        Thu,  9 Jun 2016 14:19:30 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 02/18] MIPS: KVM: Drop unused host_cp0_entryhi
Date:   Thu, 9 Jun 2016 14:19:05 +0100
Message-ID: <1465478361-7431-3-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53916
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

The host EntryHi in the KVM VCPU context is virtually unused. It gets
stored on exceptions, but only ever used in a kvm_debug() when a TLB
miss occurs.

Drop it entirely, removing that information from the kvm_debug output.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 1 -
 arch/mips/kernel/asm-offsets.c   | 1 -
 arch/mips/kvm/emulate.c          | 5 ++---
 arch/mips/kvm/locore.S           | 3 ---
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b310bb348443..cbcedd7a684b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -346,7 +346,6 @@ struct kvm_vcpu_arch {
 	unsigned long host_cp0_badvaddr;
 	unsigned long host_cp0_cause;
 	unsigned long host_cp0_epc;
-	unsigned long host_cp0_entryhi;
 
 	/* GPRS */
 	unsigned long gprs[32];
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 4d96a9033f46..420808899c70 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -364,7 +364,6 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_HOST_CP0_BADVADDR, kvm_vcpu_arch, host_cp0_badvaddr);
 	OFFSET(VCPU_HOST_CP0_CAUSE, kvm_vcpu_arch, host_cp0_cause);
 	OFFSET(VCPU_HOST_EPC, kvm_vcpu_arch, host_cp0_epc);
-	OFFSET(VCPU_HOST_ENTRYHI, kvm_vcpu_arch, host_cp0_entryhi);
 
 	OFFSET(VCPU_R0, kvm_vcpu_arch, gprs[0]);
 	OFFSET(VCPU_R1, kvm_vcpu_arch, gprs[1]);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 645c8a1982a7..2836668d63fc 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1634,7 +1634,6 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 						   (cop0) & KVM_ENTRYHI_ASID));
 
 		if (index < 0) {
-			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
 			vcpu->arch.host_cp0_badvaddr = va;
 			vcpu->arch.pc = curr_pc;
 			er = kvm_mips_emulate_tlbmiss_ld(cause, NULL, run,
@@ -2576,8 +2575,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 	unsigned long va = vcpu->arch.host_cp0_badvaddr;
 	int index;
 
-	kvm_debug("kvm_mips_handle_tlbmiss: badvaddr: %#lx, entryhi: %#lx\n",
-		  vcpu->arch.host_cp0_badvaddr, vcpu->arch.host_cp0_entryhi);
+	kvm_debug("kvm_mips_handle_tlbmiss: badvaddr: %#lx\n",
+		  vcpu->arch.host_cp0_badvaddr);
 
 	/*
 	 * KVM would not have got the exception if this entry was valid in the
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 828fcfc1cd7f..5ad2d507b125 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -308,9 +308,6 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	mfc0	k0, CP0_CAUSE
 	LONG_S	k0, VCPU_HOST_CP0_CAUSE(k1)
 
-	mfc0	k0, CP0_ENTRYHI
-	LONG_S	k0, VCPU_HOST_ENTRYHI(k1)
-
 	/* Now restore the host state just enough to run the handlers */
 
 	/* Switch EBASE to the one used by Linux */
-- 
2.4.10
