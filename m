Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:31:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27657 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042330AbcFOSaOwBwlW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A2E0479DA5D88;
        Wed, 15 Jun 2016 19:30:04 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 04/17] MIPS: KVM: Pass all unknown registers to callbacks
Date:   Wed, 15 Jun 2016 19:29:48 +0100
Message-ID: <1466015401-24433-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54056
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

Pass all unrecognised register IDs through to the set_one_reg() and
get_one_reg() callbacks, not just select ones. This allows
implementation specific registers to be more easily added without having
to modify arch/mips/kvm/mips.c.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b5ad2ba1847a..fe82f3354c23 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -688,16 +688,11 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 		v = (long)kvm_read_c0_guest_errorepc(cop0);
 		break;
 	/* registers to be handled specially */
-	case KVM_REG_MIPS_CP0_COUNT:
-	case KVM_REG_MIPS_COUNT_CTL:
-	case KVM_REG_MIPS_COUNT_RESUME:
-	case KVM_REG_MIPS_COUNT_HZ:
+	default:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
 		if (ret)
 			return ret;
 		break;
-	default:
-		return -EINVAL;
 	}
 	if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64) {
 		u64 __user *uaddr64 = (u64 __user *)(long)reg->addr;
@@ -859,21 +854,8 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 		kvm_write_c0_guest_errorepc(cop0, v);
 		break;
 	/* registers to be handled specially */
-	case KVM_REG_MIPS_CP0_COUNT:
-	case KVM_REG_MIPS_CP0_COMPARE:
-	case KVM_REG_MIPS_CP0_CAUSE:
-	case KVM_REG_MIPS_CP0_CONFIG:
-	case KVM_REG_MIPS_CP0_CONFIG1:
-	case KVM_REG_MIPS_CP0_CONFIG2:
-	case KVM_REG_MIPS_CP0_CONFIG3:
-	case KVM_REG_MIPS_CP0_CONFIG4:
-	case KVM_REG_MIPS_CP0_CONFIG5:
-	case KVM_REG_MIPS_COUNT_CTL:
-	case KVM_REG_MIPS_COUNT_RESUME:
-	case KVM_REG_MIPS_COUNT_HZ:
+	default:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
-	default:
-		return -EINVAL;
 	}
 	return 0;
 }
-- 
2.4.10
