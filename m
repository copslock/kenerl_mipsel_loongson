Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:07:04 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37188 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835152Ab3FGXDzTVxo4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:55 +0200
Received: by mail-ie0-f172.google.com with SMTP id 17so12309770iea.3
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SS9HVEJpu6oJyxXa8TqtN+YxjVQtwLQxGAuHl7kEt/g=;
        b=ellrQtkMmJFN51GyFI7DfCHspod60cgs8edyfQmkp8cARonjR27GcVOL01l2hUNjoo
         K0ySWnGP3V7u4sLFkMB9mQtBan2+y30MIqsfUY7tL6kA3CgY/TzYffiz+960eOxoox3C
         YLSqpDly7dvvLMXsNI2qJMEQ4dqXh4sOb5AxP7Sa8YUloIs2+NqDAgTG2hkIJYh2G/sO
         05AeAWnGRegHffO0fQUCgtHAgUEVMmTRc7XLa3eW65LQlpG8YEFxnh7Dk7zFU2NQYWoX
         +pJrkMeWtCI46z0ZOzSMyS098HRpIYCTyPkejGA104Pe6S7qRtf9JEZkJE4LdkvVENKZ
         M0KQ==
X-Received: by 10.50.67.10 with SMTP id j10mr405658igt.70.1370646229159;
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id it3sm235136igb.0.2013.06.07.16.03.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3kUw006650;
        Fri, 7 Jun 2013 16:03:46 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3kWI006649;
        Fri, 7 Jun 2013 16:03:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 10/31] mips/kvm: Implement ioctls to get and set FPU registers.
Date:   Fri,  7 Jun 2013 16:03:14 -0700
Message-Id: <1370646215-6543-11-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The current implementation does nothing with them, but future MIPSVZ
work need them.  Also add the asm-offsets accessors for the fields.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_host.h |  8 ++++++++
 arch/mips/kernel/asm-offsets.c   |  8 ++++++++
 arch/mips/kvm/kvm_mips.c         | 26 ++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 16013c7..505b804 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -102,6 +102,14 @@ struct kvm_vcpu_arch {
 	unsigned long lo;
 	unsigned long epc;
 
+	/* FPU state */
+	u64 fpr[32];
+	u32 fir;
+	u32 fccr;
+	u32 fexr;
+	u32 fenr;
+	u32 fcsr;
+
 	void *impl;
 };
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 5a9222e..03bf363 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -377,6 +377,14 @@ void output_kvm_defines(void)
 	OFFSET(KVM_VCPU_ARCH_HI, kvm_vcpu, arch.hi);
 	OFFSET(KVM_VCPU_ARCH_EPC, kvm_vcpu, arch.epc);
 	OFFSET(KVM_VCPU_ARCH_IMPL, kvm_vcpu, arch.impl);
+	BLANK();
+	OFFSET(KVM_VCPU_ARCH_FPR,	kvm_vcpu, arch.fpr);
+	OFFSET(KVM_VCPU_ARCH_FIR,	kvm_vcpu, arch.fir);
+	OFFSET(KVM_VCPU_ARCH_FCCR,	kvm_vcpu, arch.fccr);
+	OFFSET(KVM_VCPU_ARCH_FEXR,	kvm_vcpu, arch.fexr);
+	OFFSET(KVM_VCPU_ARCH_FENR,	kvm_vcpu, arch.fenr);
+	OFFSET(KVM_VCPU_ARCH_FCSR,	kvm_vcpu, arch.fcsr);
+	BLANK();
 
 	OFFSET(KVM_MIPS_VCPU_TE_HOST_EBASE, kvm_mips_vcpu_te, host_ebase);
 	OFFSET(KVM_MIPS_VCPU_TE_GUEST_EBASE, kvm_mips_vcpu_te, guest_ebase);
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 041caad..18c8dc8 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -465,12 +465,34 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	return -ENOIOCTLCMD;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++)
+		fpu->fpr[i] = vcpu->arch.fpr[i];
+
+	fpu->fir = vcpu->arch.fir;
+	fpu->fccr = vcpu->arch.fccr;
+	fpu->fexr = vcpu->arch.fexr;
+	fpu->fenr = vcpu->arch.fenr;
+	fpu->fcsr = vcpu->arch.fcsr;
+
+	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	return -ENOIOCTLCMD;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++)
+		vcpu->arch.fpr[i] = fpu->fpr[i];
+
+	vcpu->arch.fir = fpu->fir;
+	vcpu->arch.fccr = fpu->fccr;
+	vcpu->arch.fexr = fpu->fexr;
+	vcpu->arch.fenr = fpu->fenr;
+	vcpu->arch.fcsr = fpu->fcsr;
+
+	return 0;
 }
 
 int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
-- 
1.7.11.7
