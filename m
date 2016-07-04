Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:37:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64855 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992461AbcGDSfndvDW7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6AA105179AB78;
        Mon,  4 Jul 2016 19:35:31 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/9] MIPS: KVM: Don't save/restore lo/hi for r6
Date:   Mon, 4 Jul 2016 19:35:11 +0100
Message-ID: <1467657315-19975-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54204
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

MIPSr6 doesn't have lo/hi registers, so don't bother saving or
restoring them, and don't expose them to userland with the KVM ioctl
interface either.

In fact the lo/hi registers aren't callee saved in the MIPS ABIs anyway,
so there is no need to preserve the host lo/hi values at all when
transitioning to and from the guest (which happens via a function call).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 16 ++++------------
 arch/mips/kvm/mips.c  |  6 ++++++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index de8b6ec5573f..75ba7c2ecb3d 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -178,12 +178,6 @@ void *kvm_mips_build_vcpu_run(void *addr)
 		UASM_i_SW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
 	}
 
-	/* Save hi/lo */
-	uasm_i_mflo(&p, V0);
-	UASM_i_SW(&p, V0, offsetof(struct pt_regs, lo), K1);
-	uasm_i_mfhi(&p, V1);
-	UASM_i_SW(&p, V1, offsetof(struct pt_regs, hi), K1);
-
 	/* Save host status */
 	uasm_i_mfc0(&p, V0, C0_STATUS);
 	UASM_i_SW(&p, V0, offsetof(struct pt_regs, cp0_status), K1);
@@ -307,12 +301,14 @@ static void *kvm_mips_build_enter_guest(void *addr)
 		UASM_i_LW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
 	}
 
+#ifndef CONFIG_CPU_MIPSR6
 	/* Restore hi/lo */
 	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, hi), K1);
 	uasm_i_mthi(&p, K0);
 
 	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, lo), K1);
 	uasm_i_mtlo(&p, K0);
+#endif
 
 	/* Restore the guest's k0/k1 registers */
 	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
@@ -408,12 +404,14 @@ void *kvm_mips_build_exit(void *addr)
 		UASM_i_SW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
 	}
 
+#ifndef CONFIG_CPU_MIPSR6
 	/* We need to save hi/lo and restore them on the way out */
 	uasm_i_mfhi(&p, T0);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, hi), K1);
 
 	uasm_i_mflo(&p, T0);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, lo), K1);
+#endif
 
 	/* Finally save guest k1 to VCPU */
 	uasm_i_ehb(&p);
@@ -663,12 +661,6 @@ static void *kvm_mips_build_ret_to_host(void *addr)
 		UASM_i_LW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
 	}
 
-	UASM_i_LW(&p, K0, offsetof(struct pt_regs, hi), K1);
-	uasm_i_mthi(&p, K0);
-
-	UASM_i_LW(&p, K0, offsetof(struct pt_regs, lo), K1);
-	uasm_i_mtlo(&p, K0);
-
 	/* Restore RDHWR access */
 	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
 	uasm_i_lw(&p, K0, uasm_rel_lo((long)&hwrena), K0);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a62267f6fb07..0d11d9595600 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -521,8 +521,10 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_R30,
 	KVM_REG_MIPS_R31,
 
+#ifndef CONFIG_CPU_MIPSR6
 	KVM_REG_MIPS_HI,
 	KVM_REG_MIPS_LO,
+#endif
 	KVM_REG_MIPS_PC,
 
 	KVM_REG_MIPS_CP0_INDEX,
@@ -666,12 +668,14 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_R0 ... KVM_REG_MIPS_R31:
 		v = (long)vcpu->arch.gprs[reg->id - KVM_REG_MIPS_R0];
 		break;
+#ifndef CONFIG_CPU_MIPSR6
 	case KVM_REG_MIPS_HI:
 		v = (long)vcpu->arch.hi;
 		break;
 	case KVM_REG_MIPS_LO:
 		v = (long)vcpu->arch.lo;
 		break;
+#endif
 	case KVM_REG_MIPS_PC:
 		v = (long)vcpu->arch.pc;
 		break;
@@ -887,12 +891,14 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_R1 ... KVM_REG_MIPS_R31:
 		vcpu->arch.gprs[reg->id - KVM_REG_MIPS_R0] = v;
 		break;
+#ifndef CONFIG_CPU_MIPSR6
 	case KVM_REG_MIPS_HI:
 		vcpu->arch.hi = v;
 		break;
 	case KVM_REG_MIPS_LO:
 		vcpu->arch.lo = v;
 		break;
+#endif
 	case KVM_REG_MIPS_PC:
 		vcpu->arch.pc = v;
 		break;
-- 
2.4.10
