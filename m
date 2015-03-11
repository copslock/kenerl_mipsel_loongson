Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:52:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013414AbbCKOsSFWjgC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8DDA414A28450;
        Wed, 11 Mar 2015 14:48:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:17 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 20/20] MIPS: KVM: Wire up MSA capability
Date:   Wed, 11 Mar 2015 14:44:56 +0000
Message-ID: <1426085096-12932-21-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46329
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

Now that the code is in place for KVM to support MIPS SIMD Architecutre
(MSA) in MIPS guests, wire up the new KVM_CAP_MIPS_MSA capability.

For backwards compatibility, the capability must be explicitly enabled
in order to detect or make use of MSA from the guest.

The capability is not supported if the hardware supports MSA vector
partitioning, since the extra support cannot be tested yet and it
extends the state that the userland program would have to save.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 Documentation/virtual/kvm/api.txt | 12 ++++++++++++
 arch/mips/kvm/mips.c              | 24 ++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 3 files changed, 37 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 47ddf0475211..97dd9ee69ca8 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3224,6 +3224,18 @@ done the KVM_REG_MIPS_FPR_* and KVM_REG_MIPS_FCR_* registers can be accessed
 Config5.FRE bits are accessible via the KVM API and also from the guest,
 depending on them being supported by the FPU.
 
+6.10 KVM_CAP_MIPS_MSA
+
+Architectures: mips
+Target: vcpu
+Parameters: args[0] is reserved for future use (should be 0).
+
+This capability allows the use of the MIPS SIMD Architecture (MSA) by the guest.
+It allows the Config3.MSAP bit to be set to enable the use of MSA by the guest.
+Once this is done the KVM_REG_MIPS_VEC_* and KVM_REG_MIPS_MSA_* registers can be
+accessed, and the Config5.MSAEn bit is accessible via the KVM API and also from
+the guest.
+
 7. Capabilities that can be enabled on VMs
 ------------------------------------------
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 9319c4360285..3b3530f493eb 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -880,6 +880,15 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		vcpu->arch.fpu_enabled = true;
 		break;
+	case KVM_CAP_MIPS_MSA:
+		/*
+		 * MSA vector partitioning not supported,
+		 * see kvm_vm_ioctl_check_extension().
+		 */
+		if (!cpu_has_msa || boot_cpu_data.msa_id & MSA_IR_WRPF)
+			return -EINVAL;
+		vcpu->arch.msa_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1071,6 +1080,21 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MIPS_FPU:
 		r = !!cpu_has_fpu;
 		break;
+	case KVM_CAP_MIPS_MSA:
+		/*
+		 * We don't support MSA vector partitioning yet:
+		 * 1) It would require explicit support which can't be tested
+		 *    yet due to lack of support in current hardware.
+		 * 2) It extends the state that would need to be saved/restored
+		 *    by e.g. QEMU for migration.
+		 *
+		 * When vector partitioning hardware becomes available, support
+		 * could be added by requiring a flag when enabling
+		 * KVM_CAP_MIPS_MSA capability to indicate that userland knows
+		 * to save/restore the appropriate extra state.
+		 */
+		r = cpu_has_msa && !(boot_cpu_data.msa_id & MSA_IR_WRPF);
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 98f6e5c653ff..5f859888e3ad 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -761,6 +761,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_CHECK_EXTENSION_VM 105
 #define KVM_CAP_S390_USER_SIGP 106
 #define KVM_CAP_MIPS_FPU 107
+#define KVM_CAP_MIPS_MSA 108
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.0.5
