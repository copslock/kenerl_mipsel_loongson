Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:44:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45985 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993887AbdCBJhbqMWbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 244CAA2869692;
        Thu,  2 Mar 2017 09:37:23 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 11/32] KVM: MIPS: Add VZ capability
Date:   Thu, 2 Mar 2017 09:36:38 +0000
Message-ID: <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56975
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

Add a new KVM_CAP_MIPS_VZ capability, and in order to allow MIPS KVM to
support VZ without confusing old users (which expect the trap & emulate
implementation), define and start checking KVM_CREATE_VM type codes.

The codes available are:

 - KVM_VM_MIPS_TE = 0

   This is the current value expected from the user, and will create a
   VM using trap & emulate in user mode, confined to the user mode
   address space. This may in future become unavailable if the kernel is
   only configured to support VZ, in which case the EINVAL error will be
   returned.

 - KVM_VM_MIPS_VZ = 1

   This can be provided when the KVM_CAP_MIPS_VZ capability is available
   to create a VM using VZ, with a fully virtualized guest virtual
   address space. If VZ support is unavailable in the kernel, the EINVAL
   error will be returned (although old kernels without the
   KVM_CAP_MIPS_VZ capability may well succeed and create a trap &
   emulate VM).

 - KVM_VM_MIPS_DEFAULT = 2

   This will provide the best available KVM implementation (even on
   older kernels), preferring hardware assisted virtualization over trap
   & emulate. The KVM_CAP_MIPS_VZ capability should always be checked
   against known values to determine what type of implementation was
   chosen.

This is designed to allow the desired implementation (T&E vs VZ) to be
potentially chosen at runtime rather than being fixed in the kernel
configuration.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt | 38 +++++++++++++++++++++++++++++++-
 arch/mips/kvm/mips.c              |  9 ++++++++-
 include/uapi/linux/kvm.h          |  6 +++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 069450938b79..bd54d7a30e37 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -115,12 +115,21 @@ will access the virtual machine's physical address space; offset zero
 corresponds to guest physical address zero.  Use of mmap() on a VM fd
 is discouraged if userspace memory allocation (KVM_CAP_USER_MEMORY) is
 available.
-You most certainly want to use 0 as machine type.
+You probably want to use 0 as machine type.
 
 In order to create user controlled virtual machines on S390, check
 KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL as
 privileged user (CAP_SYS_ADMIN).
 
+To use hardware assisted virtualization on MIPS (VZ ASE) rather than
+the default trap & emulate implementation (which changes the virtual
+memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
+flag KVM_VM_MIPS_VZ.
+
+To use the best available virtualization type on MIPS, use the flag
+KVM_VM_MIPS_DEFAULT and check KVM_CAP_MIPS_VZ on the VM after creation
+to determine exactly which type was chosen.
+
 
 4.3 KVM_GET_MSR_INDEX_LIST
 
@@ -4143,3 +4152,30 @@ This capability, if KVM_CHECK_EXTENSION indicates that it is
 available, means that that the kernel can support guests using the
 hashed page table MMU defined in Power ISA V3.00 (as implemented in
 the POWER9 processor), including in-memory segment tables.
+
+8.5 KVM_CAP_MIPS_VZ
+
+Architectures: mips
+
+This capability, if KVM_CHECK_EXTENSION on the main kvm handle indicates that
+it is available, means that full hardware assisted virtualization capabilities
+of the hardware are available for use through KVM. An appropriate
+KVM_VM_MIPS_* type must be passed to KVM_CREATE_VM to create a VM which
+utilises it.
+
+If KVM_CHECK_EXTENSION on a kvm VM handle indicates that this capability is
+available, it means that the VM is using full hardware assisted virtualization
+capabilities of the hardware. This is useful to check after creating a VM with
+KVM_VM_MIPS_DEFAULT.
+
+The value returned by KVM_CHECK_EXTENSION should be compared against known
+values (see below). All other values are reserved. This is to allow for the
+possibility of other hardware assisted virtualization implementations which
+may be incompatible with the MIPS VZ ASE.
+
+ 0: The trap & emulate implementation is in use to run guest code in user
+    mode. Guest virtual memory segments are rearranged to fit the guest in the
+    user mode address space.
+
+ 1: The MIPS VZ ASE is in use, providing full hardware assisted
+    virtualization, including standard guest virtual memory segments.
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2a06015930eb..cd07ea27f336 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -105,6 +105,15 @@ void kvm_arch_check_processor_compat(void *rtn)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	switch (type) {
+	case KVM_VM_MIPS_DEFAULT:
+	case KVM_VM_MIPS_TE:
+		break;
+	default:
+		/* Unsupported KVM type */
+		return -EINVAL;
+	};
+
 	/* Allocate page table to map GPA -> RPA */
 	kvm->arch.gpa_mm.pgd = kvm_pgd_alloc();
 	if (!kvm->arch.gpa_mm.pgd)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f51d5082a377..f4b450d3c14b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -702,6 +702,11 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
+/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE, 2 uses the default/best */
+#define KVM_VM_MIPS_TE		0
+#define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_DEFAULT	2
+
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
@@ -883,6 +888,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_MIPS_VZ 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
git-series 0.8.10
