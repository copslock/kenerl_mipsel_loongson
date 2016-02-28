From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 28 Feb 2016 17:35:59 +0200
Subject: MIPS: kvm: Fix ioctl error handling.
Message-ID: <20160228153559.KWKFA48vSswzV_J8GDBwW3AlREhhFut7Igx_RxiVPIw@z>

commit 887349f69f37e71e2a8bfbd743831625a0b2ff51 upstream.

Calling return copy_to_user(...) or return copy_from_user in an ioctl
will not do the right thing if there's a pagefault:
copy_to_user/copy_from_user return the number of bytes not copied in
this case.

Fix up kvm on mips to do
	return copy_to_user(...)) ?  -EFAULT : 0;
and
	return copy_from_user(...)) ?  -EFAULT : 0;

everywhere.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12709/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index bafb32b..216dba8 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -701,7 +701,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;

-		return copy_to_user(uaddr, vs, 16);
+		return copy_to_user(uaddr, vs, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
@@ -731,7 +731,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;

-		return copy_from_user(vs, uaddr, 16);
+		return copy_from_user(vs, uaddr, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
--
2.7.0
