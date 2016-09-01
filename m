Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:33:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18266 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992309AbcIAQbOhJvY2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:31:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6A0987C56762;
        Thu,  1 Sep 2016 17:30:55 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 8/9] MIPS: KVM: Use __local_flush_icache_user_range()
Date:   Thu, 1 Sep 2016 17:30:14 +0100
Message-ID: <25e235f6fcf7d05fac45ddcbe8d9661624fc8c45.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54936
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

Convert KVM dynamic translation of guest instructions to flush icache
for guest mapped addresses using the new
__local_flush_icache_user_range() API to allow the more generic
flush_icache_range() to be changed to work on kernel addresses only.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index d280894915ed..5317ed2d8909 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -45,8 +45,8 @@ static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&replace, sizeof(u32));
-		local_flush_icache_range((unsigned long)opc,
-					 (unsigned long)opc + 32);
+		__local_flush_icache_user_range((unsigned long)opc,
+						(unsigned long)opc + 32);
 		local_irq_restore(flags);
 	} else {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
-- 
git-series 0.8.10
