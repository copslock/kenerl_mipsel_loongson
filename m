Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:24:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4221 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041106AbcFINTqxX8vi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 44602CE15CE8F;
        Thu,  9 Jun 2016 14:19:37 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 11/18] MIPS: KVM: Restore host EBase from ebase variable
Date:   Thu, 9 Jun 2016 14:19:14 +0100
Message-ID: <1465478361-7431-12-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53929
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

The host kernel's exception vector base address is currently saved in
the VCPU structure at creation time, and restored on a guest exit.
However it doesn't change and can already be easily accessed from the
'ebase' variable (arch/mips/kernel/traps.c), so drop the host_ebase
member of kvm_vcpu_arch, export the 'ebase' variable to modules and load
from there instead.

This does result in a single extra instruction (lui) on the guest exit
path, but simplifies the code a bit and removes the redundant storage of
the host exception base address.

Credit for the idea goes to Cavium's VZ KVM implementation.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 arch/mips/kernel/asm-offsets.c   | 1 -
 arch/mips/kernel/traps.c         | 1 +
 arch/mips/kvm/locore.S           | 2 +-
 arch/mips/kvm/mips.c             | 3 ---
 5 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f68293b4a598..24a8e557db88 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -334,7 +334,7 @@ struct kvm_mips_tlb {
 
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
-	void *host_ebase, *guest_ebase;
+	void *guest_ebase;
 	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 	unsigned long host_stack;
 	unsigned long host_gp;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 420808899c70..a1263d188a5a 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -355,7 +355,6 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_RUN, kvm_vcpu, run);
 	OFFSET(VCPU_HOST_ARCH, kvm_vcpu, arch);
 
-	OFFSET(VCPU_HOST_EBASE, kvm_vcpu_arch, host_ebase);
 	OFFSET(VCPU_GUEST_EBASE, kvm_vcpu_arch, guest_ebase);
 
 	OFFSET(VCPU_HOST_STACK, kvm_vcpu_arch, host_stack);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4a1712b5abdf..66e5820bfdae 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1859,6 +1859,7 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 
 unsigned long ebase;
+EXPORT_SYMBOL_GPL(ebase);
 unsigned long exception_handlers[32];
 unsigned long vi_handlers[64];
 
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 43c8ef847efa..f87bec546366 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -319,7 +319,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	mtc0	k0, CP0_STATUS
 	ehb
 
-	LONG_L	k0, VCPU_HOST_EBASE(k1)
+	LONG_L	k0, ebase
 	mtc0	k0,CP0_EBASE
 
 	/*
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c1ab6110ca1d..6e753761b5d6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -273,9 +273,6 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	else
 		size = 0x4000;
 
-	/* Save Linux EBASE */
-	vcpu->arch.host_ebase = (void *)read_c0_ebase();
-
 	gebase = kzalloc(ALIGN(size, PAGE_SIZE), GFP_KERNEL);
 
 	if (!gebase) {
-- 
2.4.10
