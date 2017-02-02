Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:17:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1215 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993942AbdBBMFSBN3Jv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:18 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6490155B5C0D9;
        Thu,  2 Feb 2017 12:05:13 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:16 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 29/30] KVM: MIPS/Emulate: Drop redundant TLB flushes on exceptions
Date:   Thu, 2 Feb 2017 12:04:42 +0000
Message-ID: <e201f182f06eba29036973ff79d99715e9f2f8fc.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56617
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

When exceptions are injected into the MIPS KVM guest, the whole host TLB
is flushed (except any entries in the guest KSeg0 range). This is
certainly not mandated by the architecture when exceptions are taken
(userland can't directly change TLB mappings anyway), and is a pretty
heavyweight operation:

 - There may be hundreds of TLB entries especially when a 512 entry FTLB
   is present. These are walked and read and conditionally invalidated,
   so the TLBINV feature can't be used either.

 - It'll indiscriminately wipe out entries belonging to other memory
   spaces. A simple ASID regeneration would be much faster to perform,
   although it'd wipe out the guest KSeg0 mappings too.

My suspicion is that this was simply to plaster over the fact that
kvm_mips_host_tlb_inv() incorrectly only invalidated TLB entries in the
ASID for guest usermode, and not the ASID for guest kernelmode.

Now that the recent commit "KVM: MIPS/TLB: Flush host TLB entry in
kernel ASID" fixes kvm_mips_host_tlb_inv() to flush TLB entries in the
kernelmode ASID when the guest TLB changes, lets drop these calls and
the otherwise unused kvm_mips_flush_host_tlb().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  1 +-
 arch/mips/kvm/emulate.c          | 10 +-------
 arch/mips/kvm/tlb.c              | 49 +---------------------------------
 3 files changed, 0 insertions(+), 60 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 1a83b6f85de2..174857f146b1 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -608,7 +608,6 @@ extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
 
 extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
-extern void kvm_mips_flush_host_tlb(int skip_kseg0);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
 				 bool user, bool kernel);
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 9ac8e45017ce..cd11d787d9dc 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1968,8 +1968,6 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(u32 cause,
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
-	/* Blow away the shadow host TLBs */
-	kvm_mips_flush_host_tlb(1);
 
 	return EMULATE_DONE;
 }
@@ -2014,8 +2012,6 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(u32 cause,
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
-	/* Blow away the shadow host TLBs */
-	kvm_mips_flush_host_tlb(1);
 
 	return EMULATE_DONE;
 }
@@ -2058,8 +2054,6 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(u32 cause,
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
-	/* Blow away the shadow host TLBs */
-	kvm_mips_flush_host_tlb(1);
 
 	return EMULATE_DONE;
 }
@@ -2102,8 +2096,6 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(u32 cause,
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
-	/* Blow away the shadow host TLBs */
-	kvm_mips_flush_host_tlb(1);
 
 	return EMULATE_DONE;
 }
@@ -2176,8 +2168,6 @@ enum emulation_result kvm_mips_emulate_tlbmod(u32 cause,
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
-	/* Blow away the shadow host TLBs */
-	kvm_mips_flush_host_tlb(1);
 
 	return EMULATE_DONE;
 }
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 51f4aee717e7..cee2e9feb942 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -214,55 +214,6 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
 }
 EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_inv);
 
-void kvm_mips_flush_host_tlb(int skip_kseg0)
-{
-	unsigned long flags;
-	unsigned long old_entryhi, entryhi;
-	unsigned long old_pagemask;
-	int entry = 0;
-	int maxentry = current_cpu_data.tlbsize;
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-	old_pagemask = read_c0_pagemask();
-
-	/* Blast 'em all away. */
-	for (entry = 0; entry < maxentry; entry++) {
-		write_c0_index(entry);
-
-		if (skip_kseg0) {
-			mtc0_tlbr_hazard();
-			tlb_read();
-			tlb_read_hazard();
-
-			entryhi = read_c0_entryhi();
-
-			/* Don't blow away guest kernel entries */
-			if (KVM_GUEST_KSEGX(entryhi) == KVM_GUEST_KSEG0)
-				continue;
-
-			write_c0_pagemask(old_pagemask);
-		}
-
-		/* Make sure all entries differ. */
-		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
-		write_c0_entrylo0(0);
-		write_c0_entrylo1(0);
-		mtc0_tlbw_hazard();
-
-		tlb_write_indexed();
-		tlbw_use_hazard();
-	}
-
-	write_c0_entryhi(old_entryhi);
-	write_c0_pagemask(old_pagemask);
-	mtc0_tlbw_hazard();
-
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(kvm_mips_flush_host_tlb);
-
 /**
  * kvm_mips_suspend_mm() - Suspend the active mm.
  * @cpu		The CPU we're running on.
-- 
git-series 0.8.10
