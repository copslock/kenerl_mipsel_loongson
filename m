Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2018 21:18:18 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:43619
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994662AbeDRTSMKXe9E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2018 21:18:12 +0200
Received: by mail-pg0-x241.google.com with SMTP id f132so1304895pgc.10;
        Wed, 18 Apr 2018 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qPtHleo46erNMBaBUgS9OFeBPEQXjyhU5n1oXAAF5ts=;
        b=ZpEBJfzF1idN+Yin1ff8cicuuq/APHUPCpm/da3gtl5huoLm7WnvJlGOamNNZwroqG
         4VuUO6TdYwc7mK+TzzYw+h2efZ5Ce3QtdSYnqKRkQbg4VPndpj7KMFwGjIhdUGH/doaZ
         karjepdNWzIvw146Vt9UIW39h8ASQLhGPRW2Kw3NtYW8hilpb1pOEsrAN5U3fDOcWgeJ
         hon947d64JeMhh2BNr940N+vLY5+Nl5jtUEr+SP107pmfaqLiUCbgfB357yo+YNgHjAM
         OLEJWBU1EgOgeQZxpayhYVTAvBzcm9aJ/BqlU30cMMQC10I8DNTJYFYDEdoEzEc+bJzJ
         NNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qPtHleo46erNMBaBUgS9OFeBPEQXjyhU5n1oXAAF5ts=;
        b=J6SO0MH6noRnnasy+KCLuWY2vlSm/V7ItwTPYpW4cW1AKHlDPNo/ayYGuXqI9sRe2K
         a10TxvE0RR9sj4rRFTOnjcFNK1N44hAf9PeZRR0xxsT34HTftGGUxflP2t3HFYD6z51k
         W6Esi+xLkTSsEGYUSqiN38TskRnCpWtJYD3rzlL76v61a0jVBqOnmJUYNaOPjaff2QMQ
         OCaNO5sOegF/mt1C0g9fSPCm0SN1S54xAL2+soffqV7Wr/JxEvvY6Vv1Rvc8XFnXLLTA
         qMYNh/wilSJrJry+0TzmaEI+5nfo9P0cWb3zUNcDED5BGiQo+bxv/qjRmaQFLhPb4THg
         eF5g==
X-Gm-Message-State: ALQs6tAbE/qAhhNi/iMynueuOzr26MLBITk4Biae+5DC5XdTLiVvoKqo
        CzAZOFqODNoBN1aXF8PA4R4=
X-Google-Smtp-Source: AIpwx48dX2ZRzHspdQAU2kuOSg1uldhsK0KzPFdqDl3zBQ/GavQwU8frhi+DKsv62gIIrwEgNbZc6A==
X-Received: by 10.99.175.68 with SMTP id s4mr2605197pgo.295.1524079084750;
        Wed, 18 Apr 2018 12:18:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.82])
        by smtp.gmail.com with ESMTPSA id y6sm2998256pgr.44.2018.04.18.12.18.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Apr 2018 12:18:03 -0700 (PDT)
Date:   Thu, 19 Apr 2018 00:49:58 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jhogan@kernel.org, ralf@linux-mips.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com,
        david@redhat.com, cohuck@redhat.com, schwidefsky@de.ibm.com,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        christoffer.dall@linaro.org, marc.zyngier@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        willy@infradead.org
Subject: [PATCH] kvm: Change return type to vm_fault_t
Message-ID: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jrdr.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jrdr.linux@gmail.com
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

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/mips/kvm/mips.c       | 2 +-
 arch/powerpc/kvm/powerpc.c | 2 +-
 arch/s390/kvm/kvm-s390.c   | 2 +-
 arch/x86/kvm/x86.c         | 2 +-
 include/linux/kvm_host.h   | 2 +-
 virt/kvm/arm/arm.c         | 2 +-
 virt/kvm/kvm_main.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2549fdd..03e0e0f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1076,7 +1076,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return -ENOIOCTLCMD;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642..3099dee 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1825,7 +1825,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba4c709..24af487 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3941,7 +3941,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 #ifdef CONFIG_KVM_S390_UCONTROL
 	if ((vmf->pgoff == KVM_S390_SIE_PAGE_OFFSET)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b54..95d8102 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3827,7 +3827,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ac0062b..8eeb062 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -736,7 +736,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg);
-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf);
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf);

 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext);

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 86941f6..6c8cc31 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -163,7 +163,7 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	return 0;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4501e65..45eb54b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2341,7 +2341,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_on_spin);

-static int kvm_vcpu_fault(struct vm_fault *vmf)
+static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 {
 	struct kvm_vcpu *vcpu = vmf->vma->vm_file->private_data;
 	struct page *page;
--
1.9.1
