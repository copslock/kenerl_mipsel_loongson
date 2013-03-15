Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Mar 2013 03:09:27 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:34377 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6834842Ab3COCJ0U0NmB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Mar 2013 03:09:26 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 14 Mar 2013 19:09:18 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 0B5526300A6; Thu, 14 Mar 2013 19:09:18 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH] KVM/MIPS32: Sync up with latest KVM API changes
Date:   Thu, 14 Mar 2013 19:09:16 -0700
Message-Id: <1363313356-32435-1-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
X-archive-position: 35893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

- Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
- Fix kvm_arch_{prepare,commit}_memory_region()
- Also remove kvm_arch_set_memory_region which was unused.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/kvm_mips.c         | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c8cddd1..143875c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -21,7 +21,7 @@
 
 
 #define KVM_MAX_VCPUS		1
-#define KVM_MEMORY_SLOTS	8
+#define KVM_USER_MEM_SLOTS	8
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 	0
 
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 15ee558..2e60b1c 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -198,14 +198,6 @@ kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return -EINVAL;
 }
 
-int
-kvm_arch_set_memory_region(struct kvm *kvm,
-			   struct kvm_userspace_memory_region *mem,
-			   struct kvm_memory_slot old, int user_alloc)
-{
-	return 0;
-}
-
 void kvm_arch_free_memslot(struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
@@ -220,14 +212,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *memslot,
 				   struct kvm_memory_slot old,
 				   struct kvm_userspace_memory_region *mem,
-				   int user_alloc)
+				   bool user_alloc)
 {
 	return 0;
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
-				   struct kvm_memory_slot old, int user_alloc)
+				   struct kvm_memory_slot old, bool user_alloc)
 {
 	unsigned long npages = 0;
 	int i, err = 0;
-- 
1.7.11.3
