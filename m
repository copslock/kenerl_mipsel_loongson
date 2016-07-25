Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 23:31:48 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36003 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbcGYVblr6RQk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 23:31:41 +0200
Received: from localhost (unknown [104.132.1.103])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9788C726;
        Mon, 25 Jul 2016 21:31:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 4.6 065/203] MIPS: KVM: Fix modular KVM under QEMU
Date:   Mon, 25 Jul 2016 13:54:40 -0700
Message-Id: <20160725203431.951329001@linuxfoundation.org>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160725203429.221747288@linuxfoundation.org>
References: <20160725203429.221747288@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/kvm_host.h |    1 +
 arch/mips/kvm/interrupt.h        |    1 +
 arch/mips/kvm/locore.S           |    1 +
 arch/mips/kvm/mips.c             |   11 ++++++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -336,6 +336,7 @@ struct kvm_mips_tlb {
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 	unsigned long host_stack;
 	unsigned long host_gp;
 
--- a/arch/mips/kvm/interrupt.h
+++ b/arch/mips/kvm/interrupt.h
@@ -28,6 +28,7 @@
 #define MIPS_EXC_MAX                12
 /* XXXSL More to follow */
 
+extern char __kvm_mips_vcpu_run_end[];
 extern char mips32_exception[], mips32_exceptionEnd[];
 extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
 
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -227,6 +227,7 @@ FEXPORT(__kvm_mips_load_k0k1)
 
 	/* Jump to guest */
 	eret
+EXPORT(__kvm_mips_vcpu_run_end)
 
 VECTOR(MIPSX(exception), unknown)
 /* Find out what mode we came from and jump to the proper handler. */
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -314,6 +314,15 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
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
 	local_flush_icache_range((unsigned long)gebase,
 				(unsigned long)gebase + ALIGN(size, PAGE_SIZE));
@@ -403,7 +412,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
-	r = __kvm_mips_vcpu_run(run, vcpu);
+	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	/* Re-enable HTW before enabling interrupts */
 	htw_start();
