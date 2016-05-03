Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2016 06:52:17 +0200 (CEST)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:47557 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027900AbcECEwMdj59b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 May 2016 06:52:12 +0200
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Tue, 3 May 2016 05:52:07 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 3 May 2016 05:52:05 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 12E4D1B0805F
        for <linux-mips@linux-mips.org>; Tue,  3 May 2016 05:52:55 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u434q5mu5570832
        for <linux-mips@linux-mips.org>; Tue, 3 May 2016 04:52:05 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u434q4b6001771
        for <linux-mips@linux-mips.org>; Mon, 2 May 2016 22:52:04 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u434q3ZE001766;
        Mon, 2 May 2016 22:52:04 -0600
Received: from bahia.huguette.org (sig-9-83-39-223.evts.uk.ibm.com [9.83.39.223])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id AF9E0220520;
        Tue,  3 May 2016 06:52:02 +0200 (CEST)
Subject: [PATCH v5 2/2] kvm: introduce KVM_MAX_VCPU_ID
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Tue, 03 May 2016 06:52:02 +0200
Message-ID: <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
In-Reply-To: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
References: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16050304-0009-0000-0000-000016B71C45
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

The KVM_MAX_VCPUS define provides the maximum number of vCPUs per guest, and
also the upper limit for vCPU ids. This is okay for all archs except PowerPC
which can have higher ids, depending on the cpu/core/thread topology. In the
worst case (single threaded guest, host with 8 threads per core), it limits
the maximum number of vCPUS to KVM_MAX_VCPUS / 8.

This patch separates the vCPU numbering from the total number of vCPUs, with
the introduction of KVM_MAX_VCPU_ID, as the maximal valid value for vCPU ids
plus one.

The corresponding KVM_CAP_MAX_VCPU_ID allows userspace to validate vCPU ids
before passing them to KVM_CREATE_VCPU.

Only PowerPC gets unlimited vCPU ids for the moment. This patch doesn't
change anything for other archs.

Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 Documentation/virtual/kvm/api.txt   |   10 ++++++++--
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/kvm/powerpc.c          |    3 +++
 include/linux/kvm_host.h            |    4 ++++
 include/uapi/linux/kvm.h            |    1 +
 virt/kvm/kvm_main.c                 |    2 +-
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4d0542c5206b..2da127f21ffc 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -199,8 +199,8 @@ Type: vm ioctl
 Parameters: vcpu id (apic id on x86)
 Returns: vcpu fd on success, -1 on error
 
-This API adds a vcpu to a virtual machine.  The vcpu id is a small integer
-in the range [0, max_vcpus).
+This API adds a vcpu to a virtual machine. No more than max_vcpus may be added.
+The vcpu id is an integer in the range [0, max_vcpu_id).
 
 The recommended max_vcpus value can be retrieved using the KVM_CAP_NR_VCPUS of
 the KVM_CHECK_EXTENSION ioctl() at run-time.
@@ -212,6 +212,12 @@ cpus max.
 If the KVM_CAP_MAX_VCPUS does not exist, you should assume that max_vcpus is
 same as the value returned from KVM_CAP_NR_VCPUS.
 
+The maximum possible value for max_vcpu_id can be retrieved using the
+KVM_CAP_MAX_VCPU_ID of the KVM_CHECK_EXTENSION ioctl() at run-time.
+
+If the KVM_CAP_MAX_VCPU_ID does not exist, you should assume that max_vcpu_id
+is the same as the value returned from KVM_CAP_MAX_VCPUS.
+
 On powerpc using book3s_hv mode, the vcpus are mapped onto virtual
 threads in one or more virtual CPU cores.  (This is because the
 hardware requires all the hardware threads in a CPU core to be in the
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index d7b343170453..6b4b78d6131b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -39,6 +39,8 @@
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
 #define KVM_USER_MEM_SLOTS	512
+#define KVM_MAX_VCPU_ID		INT_MAX
+
 
 #ifdef CONFIG_KVM_MMIO
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6a68730774ee..bef0e6e5e8d0 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -580,6 +580,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
 		break;
+	case KVM_CAP_MAX_VCPU_ID:
+		r = KVM_MAX_VCPU_ID;
+		break;
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_PPC_GET_SMMU_INFO:
 		r = 1;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 23bfe1bd159c..3b4efa1c088c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -35,6 +35,10 @@
 
 #include <asm/kvm_host.h>
 
+#ifndef KVM_MAX_VCPU_ID
+#define KVM_MAX_VCPU_ID KVM_MAX_VCPUS
+#endif
+
 /*
  * The bit 16 ~ bit 31 of kvm_memory_region::flags are internally used
  * in kvm, other bits are visible for userspace which are defined in
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a7f1f8032ec1..05ebf475104c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -865,6 +865,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_SPAPR_TCE_64 125
 #define KVM_CAP_ARM_PMU_V3 126
 #define KVM_CAP_VCPU_ATTRIBUTES 127
+#define KVM_CAP_MAX_VCPU_ID 128
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4fd482fb9260..210ab88466fd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2272,7 +2272,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	int r;
 	struct kvm_vcpu *vcpu;
 
-	if (id >= KVM_MAX_VCPUS)
+	if (id >= KVM_MAX_VCPU_ID)
 		return -EINVAL;
 
 	vcpu = kvm_arch_vcpu_create(kvm, id);
