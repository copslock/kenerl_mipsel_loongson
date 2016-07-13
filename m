Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 19:14:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65171 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992742AbcGMROlQ574I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 19:14:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 910B076A1A4B7;
        Wed, 13 Jul 2016 18:14:20 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 18:14:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [BACKPORT 3.14.y] MIPS: KVM: Fix modular KVM under QEMU
Date:   Wed, 13 Jul 2016 18:14:19 +0100
Message-ID: <1468430059-7958-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <146827994122156@kroah.com>
References: <146827994122156@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54326
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

commit 797179bc4fe06c89e47a9f36f886f68640b423f8 upstream.

Copy __kvm_mips_vcpu_run() into unmapped memory, so that we can never
get a TLB refill exception in it when KVM is built as a module.

This was observed to happen with the host MIPS kernel running under
QEMU, due to a not entirely transparent optimisation in the QEMU TLB
handling where TLB entries replaced with TLBWR are copied to a separate
part of the TLB array. Code in those pages continue to be executable,
but those mappings persist only until the next ASID switch, even if they
are marked global.

An ASID switch happens in __kvm_mips_vcpu_run() at exception level after
switching to the guest exception base. Subsequent TLB mapped kernel
instructions just prior to switching to the guest trigger a TLB refill
exception, which enters the guest exception handlers without updating
EPC. This appears as a guest triggered TLB refill on a host kernel
mapped (host KSeg2) address, which is not handled correctly as user
(guest) mode accesses to kernel (host) segments always generate address
error exceptions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: backported for stable 3.14]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/kvm/kvm_locore.S       |  1 +
 arch/mips/kvm/kvm_mips.c         | 11 ++++++++++-
 arch/mips/kvm/kvm_mips_int.h     |  2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a995fce87791..3ff5b4921b76 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -342,6 +342,7 @@ struct kvm_mips_tlb {
 #define KVM_MIPS_GUEST_TLB_SIZE     64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 	unsigned long host_stack;
 	unsigned long host_gp;
 
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index ba5ce99c021d..d1fa2a57218b 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -229,6 +229,7 @@ FEXPORT(__kvm_mips_load_k0k1)
 
 	/* Jump to guest */
 	eret
+EXPORT(__kvm_mips_vcpu_run_end)
 
 VECTOR(MIPSX(exception), unknown)
 /*
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 12d850b68763..2b2dd4ec03fb 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -348,6 +348,15 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	memcpy(gebase + offset, mips32_GuestException,
 	       mips32_GuestExceptionEnd - mips32_GuestException);
 
+#ifdef MODULE
+	offset += mips32_GuestExceptionEnd - mips32_GuestException;
+	memcpy(gebase + offset, (char *)__kvm_mips_vcpu_run,
+	       __kvm_mips_vcpu_run_end - (char *)__kvm_mips_vcpu_run);
+	vcpu->arch.vcpu_run = gebase + offset;
+#else
+	vcpu->arch.vcpu_run = __kvm_mips_vcpu_run;
+#endif
+
 	/* Invalidate the icache for these ranges */
 	mips32_SyncICache((unsigned long) gebase, ALIGN(size, PAGE_SIZE));
 
@@ -431,7 +440,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	kvm_guest_enter();
 
-	r = __kvm_mips_vcpu_run(run, vcpu);
+	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	kvm_guest_exit();
 	local_irq_enable();
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
index 20da7d29eede..bf41ea36210e 100644
--- a/arch/mips/kvm/kvm_mips_int.h
+++ b/arch/mips/kvm/kvm_mips_int.h
@@ -27,6 +27,8 @@
 #define MIPS_EXC_MAX                12
 /* XXXSL More to follow */
 
+extern char __kvm_mips_vcpu_run_end[];
+
 #define C_TI        (_ULCAST_(1) << 30)
 
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
-- 
2.4.10
