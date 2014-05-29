Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:20:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13255 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825074AbaE2JRILgd76 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 667B18C6ACFAF;
        Thu, 29 May 2014 10:16:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:01 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:17:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 09/23] MIPS: KVM: Add CP0_HWREna KVM register access
Date:   Thu, 29 May 2014 10:16:31 +0100
Message-ID: <1401355005-20370-10-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 40330
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

Implement KVM_{GET,SET}_ONE_REG ioctl based access to the guest CP0
HWREna register. This is so that userland can save and restore its
value so that RDHWR instructions don't have to be emulated by the guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
v2:
 - New patch.
---
 arch/mips/kvm/kvm_mips.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 153c1e17afb1..73f67fc92b7a 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -534,6 +534,7 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_USERLOCAL,
 	KVM_REG_MIPS_CP0_PAGEMASK,
 	KVM_REG_MIPS_CP0_WIRED,
+	KVM_REG_MIPS_CP0_HWRENA,
 	KVM_REG_MIPS_CP0_BADVADDR,
 	KVM_REG_MIPS_CP0_COUNT,
 	KVM_REG_MIPS_CP0_ENTRYHI,
@@ -585,6 +586,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_WIRED:
 		v = (long)kvm_read_c0_guest_wired(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		v = (long)kvm_read_c0_guest_hwrena(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_BADVADDR:
 		v = (long)kvm_read_c0_guest_badvaddr(cop0);
 		break;
@@ -696,6 +700,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_WIRED:
 		kvm_write_c0_guest_wired(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		kvm_write_c0_guest_hwrena(cop0, v);
+		break;
 	case KVM_REG_MIPS_CP0_BADVADDR:
 		kvm_write_c0_guest_badvaddr(cop0, v);
 		break;
-- 
1.9.3
