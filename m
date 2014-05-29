Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:19:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63718 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822191AbaE2JRFA5hDc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 368068731AD9;
        Thu, 29 May 2014 10:16:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:16:58 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:16:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 05/23] MIPS: KVM: Add CP0_EPC KVM register access
Date:   Thu, 29 May 2014 10:16:27 +0100
Message-ID: <1401355005-20370-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40326
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

Contrary to the comment, the guest CP0_EPC register cannot be set via
kvm_regs, since it is distinct from the guest PC. Add the EPC register
to the KVM_{GET,SET}_ONE_REG ioctl interface.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 14511138f187..85d5552f0a47 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -512,6 +512,7 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
 #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
 #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
+#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
 #define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_64(15, 1)
 #define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
 #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
@@ -567,7 +568,7 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_ENTRYHI,
 	KVM_REG_MIPS_CP0_STATUS,
 	KVM_REG_MIPS_CP0_CAUSE,
-	/* EPC set via kvm_regs, et al. */
+	KVM_REG_MIPS_CP0_EPC,
 	KVM_REG_MIPS_CP0_CONFIG,
 	KVM_REG_MIPS_CP0_CONFIG1,
 	KVM_REG_MIPS_CP0_CONFIG2,
@@ -620,6 +621,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CAUSE:
 		v = (long)kvm_read_c0_guest_cause(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_EPC:
+		v = (long)kvm_read_c0_guest_epc(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		v = (long)kvm_read_c0_guest_errorepc(cop0);
 		break;
@@ -716,6 +720,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CAUSE:
 		kvm_write_c0_guest_cause(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_EPC:
+		kvm_write_c0_guest_epc(cop0, v);
+		break;
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		kvm_write_c0_guest_errorepc(cop0, v);
 		break;
-- 
1.9.3
