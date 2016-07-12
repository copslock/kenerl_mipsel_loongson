Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2016 04:57:12 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:47836 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992329AbcGLC5EHrFUM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jul 2016 04:57:04 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6C2upse018274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2016 02:56:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u6C2umLp013054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 12 Jul 2016 02:56:49 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u6C2ukxa024803;
        Tue, 12 Jul 2016 02:56:48 GMT
Received: from lappy.us.oracle.com (/10.154.100.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jul 2016 19:56:46 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: KVM: Fix modular KVM under QEMU
Date:   Mon, 11 Jul 2016 22:52:09 -0400
Message-Id: <1468292170-22812-28-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1468292170-22812-1-git-send-email-sasha.levin@oracle.com>
References: <1468292170-22812-1-git-send-email-sasha.levin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 797179bc4fe06c89e47a9f36f886f68640b423f8 ]

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
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/kvm/interrupt.h        |  1 +
 arch/mips/kvm/locore.S           |  1 +
 arch/mips/kvm/mips.c             | 11 ++++++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3585af0..ab518d1 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -370,6 +370,7 @@ struct kvm_mips_tlb {
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 	unsigned long host_stack;
 	unsigned long host_gp;
 
diff --git a/arch/mips/kvm/interrupt.h b/arch/mips/kvm/interrupt.h
index 4ab4bdf..2143884 100644
--- a/arch/mips/kvm/interrupt.h
+++ b/arch/mips/kvm/interrupt.h
@@ -28,6 +28,7 @@
 #define MIPS_EXC_MAX                12
 /* XXXSL More to follow */
 
+extern char __kvm_mips_vcpu_run_end[];
 extern char mips32_exception[], mips32_exceptionEnd[];
 extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
 
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index d1ee95a..ae01e7f 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -235,6 +235,7 @@ FEXPORT(__kvm_mips_load_k0k1)
 
 	/* Jump to guest */
 	eret
+EXPORT(__kvm_mips_vcpu_run_end)
 
 VECTOR(MIPSX(exception), unknown)
 /* Find out what mode we came from and jump to the proper handler. */
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ace4ed7..485fdc4 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -312,6 +312,15 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
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
@@ -401,7 +410,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
-	r = __kvm_mips_vcpu_run(run, vcpu);
+	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	/* Re-enable HTW before enabling interrupts */
 	htw_start();
-- 
2.5.0
