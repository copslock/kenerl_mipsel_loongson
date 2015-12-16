Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:55:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24588 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014080AbbLPXuT2kYn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id EE8616146228C;
        Wed, 16 Dec 2015 23:50:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:13 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:13 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 15/16] MIPS: KVM: Consistent use of uint*_t in MMIO handling
Date:   Wed, 16 Dec 2015 23:49:40 +0000
Message-ID: <1450309781-28030-16-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50663
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

Make consistent use of uint8_t in MMIO handling code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 845fd0d91040..912b39bb7f86 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2401,7 +2401,7 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int8_t *) run->mmio.data;
 		else
-			*gpr = *(u8 *) run->mmio.data;
+			*gpr = *(uint8_t *)run->mmio.data;
 		break;
 	}
 
-- 
2.4.10
