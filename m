Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 17:36:12 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55908 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992318AbcHUPgEnLr23 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 17:36:04 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7LFWH3k013313;
        Sun, 21 Aug 2016 17:32:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, stable@vger.kernel.org#3.10.x-,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 058/180] MIPS: KVM: Fix modular KVM under QEMU
Date:   Sun, 21 Aug 2016 17:29:48 +0200
Message-Id: <1471793510-13022-59-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1471793510-13022-1-git-send-email-w@1wt.eu>
References: <1471793510-13022-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: James Hogan <james.hogan@imgtec.com>

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
Cc: <stable@vger.kernel.org> # 3.10.x-
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: backported for stable 3.14]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/kvm/kvm_locore.S       |  1 +
 arch/mips/kvm/kvm_mips.c         | 11 ++++++++++-
 arch/mips/kvm/kvm_mips_int.h     |  2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4d6fa0b..883a162 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -349,6 +349,7 @@ struct kvm_mips_tlb {
 #define KVM_MIPS_GUEST_TLB_SIZE     64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 	unsigned long host_stack;
 	unsigned long host_gp;
 
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index 34c35f0..73553cd 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -227,6 +227,7 @@ FEXPORT(__kvm_mips_load_k0k1)
     /* Jump to guest */
 	eret
 	.set	pop
+EXPORT(__kvm_mips_vcpu_run_end)
 
 VECTOR(MIPSX(exception), unknown)
 /*
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 8aa5f30..97a181a 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -343,6 +343,15 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
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
 
@@ -426,7 +435,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	kvm_guest_enter();
 
-	r = __kvm_mips_vcpu_run(run, vcpu);
+	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	kvm_guest_exit();
 	local_irq_enable();
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
index 20da7d2..bf41ea3 100644
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
2.8.0.rc2.1.gbe9624a
