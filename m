Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 22:42:42 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:43204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995081AbdHUUjCeVxI7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 22:39:02 +0200
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 629BE61467;
        Mon, 21 Aug 2017 20:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 629BE61467
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7E4F5C460;
        Mon, 21 Aug 2017 20:38:46 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 21 Aug 2017 22:38:46 +0200
From:   =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: [PATCH RFC v3 9/9] KVM: split kvm->vcpus into chunks
Date:   Mon, 21 Aug 2017 22:35:30 +0200
Message-Id: <20170821203530.9266-10-rkrcmar@redhat.com>
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 21 Aug 2017 20:38:56 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

This allows us to have high KVM_VCPU_MAX without wasting too much space
with small guests.  RCU is a viable alternative now that we do not have
to protect the kvm_for_each_vcpu() loop.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/mips/kvm/mips.c     |  2 +-
 arch/x86/kvm/vmx.c       |  2 +-
 include/linux/kvm_host.h | 27 ++++++++++++++++++++-------
 virt/kvm/kvm_main.c      | 27 +++++++++++++++++++++++----
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c841cb434486..7d452163dcef 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -488,7 +488,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 	if (irq->cpu == -1)
 		dvcpu = vcpu;
 	else
-		dvcpu = vcpu->kvm->vcpus[irq->cpu];
+		dvcpu = kvm_get_vcpu(vcpu->kvm, irq->cpu);
 
 	if (intr == 2 || intr == 3 || intr == 4) {
 		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ae0f04e26fec..2b92c2de2b3a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11741,7 +11741,7 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
 		!irq_remapping_cap(IRQ_POSTING_CAP) ||
-		!kvm_vcpu_apicv_active(kvm->vcpus[0]))
+		!kvm_vcpu_apicv_active(kvm_get_vcpu(kvm, 0)))
 		return 0;
 
 	idx = srcu_read_lock(&kvm->irq_srcu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5417dac55272..5cc3ca8b92b3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -388,12 +388,16 @@ struct kvm_memslots {
 	int used_slots;
 };
 
+#define KVM_VCPUS_CHUNK_SIZE 128
+#define KVM_VCPUS_CHUNKS_NUM \
+	(round_up(KVM_MAX_VCPUS, KVM_VCPUS_CHUNK_SIZE) / KVM_VCPUS_CHUNK_SIZE)
+
 struct kvm {
 	spinlock_t mmu_lock;
 	struct mutex slots_lock;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
-	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	struct kvm_vcpu **vcpus[KVM_VCPUS_CHUNKS_NUM];
 	struct list_head vcpu_list;
 
 	/*
@@ -484,14 +488,23 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 				      !refcount_read(&kvm->users_count));
 }
 
-static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
+static inline struct kvm_vcpu *__kvm_get_vcpu(struct kvm *kvm, int id)
 {
-	/* Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu, in case
-	 * the caller has read kvm->online_vcpus before (as is the case
-	 * for kvm_for_each_vcpu, for example).
+	return kvm->vcpus[id / KVM_VCPUS_CHUNK_SIZE][id % KVM_VCPUS_CHUNK_SIZE];
+}
+
+static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int id)
+{
+	if (id >= atomic_read(&kvm->online_vcpus))
+		return NULL;
+
+	/*
+	 * Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu.  Ensures that the
+	 * pointers leading to an online vcpu are valid.
 	 */
 	smp_rmb();
-	return kvm->vcpus[i];
+
+	return __kvm_get_vcpu(kvm, id);
 }
 
 #define kvm_for_each_vcpu(vcpup, kvm) \
@@ -514,7 +527,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 
 	if (id < 0)
 		return NULL;
-	if (id < KVM_MAX_VCPUS)
+	if (id < atomic_read(&kvm->online_vcpus))
 		vcpu = kvm_get_vcpu(kvm, id);
 	if (vcpu && vcpu->vcpu_id == id)
 		return vcpu;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6cec58cad6c7..f9d68ec332c6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -759,11 +759,14 @@ void kvm_free_vcpus(struct kvm *kvm)
 
 	mutex_lock(&kvm->lock);
 
-	i = atomic_read(&kvm->online_vcpus);
+	i = round_up(atomic_read(&kvm->online_vcpus), KVM_VCPUS_CHUNK_SIZE) /
+		KVM_VCPUS_CHUNK_SIZE;
 	atomic_set(&kvm->online_vcpus, 0);
 
-	while (i--)
+	while (i--) {
+		kfree(kvm->vcpus[i]);
 		kvm->vcpus[i] = NULL;
+	}
 
 	mutex_unlock(&kvm->lock);
 }
@@ -2480,6 +2483,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 {
 	int r;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu **vcpusp;
+	unsigned chunk, offset;
 
 	if (id >= KVM_MAX_VCPU_ID)
 		return -EINVAL;
@@ -2517,8 +2522,22 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 
 	vcpu->vcpus_idx = atomic_read(&kvm->online_vcpus);
 
-	BUG_ON(kvm->vcpus[vcpu->vcpus_idx]);
+	chunk  = vcpu->vcpus_idx / KVM_VCPUS_CHUNK_SIZE;
+	offset = vcpu->vcpus_idx % KVM_VCPUS_CHUNK_SIZE;
 
+	if (!kvm->vcpus[chunk]) {
+		kvm->vcpus[chunk] = kzalloc(KVM_VCPUS_CHUNK_SIZE * sizeof(**kvm->vcpus),
+		                            GFP_KERNEL);
+		if (!kvm->vcpus[chunk]) {
+			r = -ENOMEM;
+			goto unlock_vcpu_destroy;
+		}
+
+		BUG_ON(offset != 0);
+	}
+
+	vcpusp = &kvm->vcpus[chunk][offset];
+	BUG_ON(*vcpusp);
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
@@ -2528,7 +2547,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 		goto unlock_vcpu_destroy;
 	}
 
-	kvm->vcpus[atomic_read(&kvm->online_vcpus)] = vcpu;
+	*vcpusp = vcpu;
 	list_add_tail_rcu(&vcpu->vcpu_list, &kvm->vcpu_list);
 
 	/*
-- 
2.13.3
