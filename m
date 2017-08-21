Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 22:40:55 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:49688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995048AbdHUUic4V3B7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 22:38:32 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE24D356F9;
        Mon, 21 Aug 2017 20:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com BE24D356F9
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F4C217C2A;
        Mon, 21 Aug 2017 20:38:21 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 21 Aug 2017 22:38:20 +0200
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
Subject: [PATCH RFC v3 5/9] KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
Date:   Mon, 21 Aug 2017 22:35:26 +0200
Message-Id: <20170821203530.9266-6-rkrcmar@redhat.com>
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 21 Aug 2017 20:38:26 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59746
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

Moving it to generic code will allow us to extend it with ease.
Christian noted that it was only used in the removed ia64.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 include/linux/kvm_host.h | 12 ------------
 virt/kvm/kvm_main.c      | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a8ff956616d2..abd5cb1feb9e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -798,18 +798,6 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 
-#ifndef __KVM_HAVE_ARCH_VM_ALLOC
-static inline struct kvm *kvm_arch_alloc_vm(void)
-{
-	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
-}
-
-static inline void kvm_arch_free_vm(struct kvm *kvm)
-{
-	kfree(kvm);
-}
-#endif
-
 #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
 void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index caf8323f7df7..d89261d0d8c6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -640,10 +640,20 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	return 0;
 }
 
+static inline struct kvm *kvm_alloc_vm(void)
+{
+	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
+}
+
+static inline void kvm_free_vm(struct kvm *kvm)
+{
+	kfree(kvm);
+}
+
 static struct kvm *kvm_create_vm(unsigned long type)
 {
 	int r, i;
-	struct kvm *kvm = kvm_arch_alloc_vm();
+	struct kvm *kvm = kvm_alloc_vm();
 
 	if (!kvm)
 		return ERR_PTR(-ENOMEM);
@@ -720,7 +730,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 		kfree(kvm_get_bus(kvm, i));
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
-	kvm_arch_free_vm(kvm);
+	kvm_free_vm(kvm);
 	mmdrop(current->mm);
 	return ERR_PTR(r);
 }
@@ -771,7 +781,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-	kvm_arch_free_vm(kvm);
+	kvm_free_vm(kvm);
 	preempt_notifier_dec();
 	hardware_disable_all();
 	mmdrop(mm);
-- 
2.13.3
