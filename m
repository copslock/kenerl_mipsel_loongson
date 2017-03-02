Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:43:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35620 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993879AbdCBJhaadFct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 88AB6B2BEA1A3;
        Thu,  2 Mar 2017 09:37:25 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:27 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 14/32] KVM: MIPS: Add callback to check extension
Date:   Thu, 2 Mar 2017 09:36:41 +0000
Message-ID: <ab4f5be3925bde03844d9a180030711e0387a6cd.1488447004.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56973
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

Add an implementation callback for checking presence of KVM extensions.
This allows implementation specific extensions to be provided without
ifdefs in mips.c.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 1 +
 arch/mips/kvm/mips.c             | 2 +-
 arch/mips/kvm/trap_emul.c        | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index d92275e8524c..e9248da4e9ed 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -545,6 +545,7 @@ struct kvm_mips_callbacks {
 	int (*handle_msa_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
+	int (*check_extension)(struct kvm *kvm, long ext);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 272c660a6cd3..472cea5efd3a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1076,7 +1076,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = cpu_has_msa && !(boot_cpu_data.msa_id & MSA_IR_WRPF);
 		break;
 	default:
-		r = 0;
+		r = kvm_mips_callbacks->check_extension(kvm, ext);
 		break;
 	}
 	return r;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 0e3d260aafcb..254a641ff913 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -488,6 +488,11 @@ static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_check_extension(struct kvm *kvm, long ext)
+{
+	return 0;
+}
+
 static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
@@ -1238,6 +1243,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
+	.check_extension = kvm_trap_emul_check_extension,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
-- 
git-series 0.8.10
