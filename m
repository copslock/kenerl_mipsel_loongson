Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 11:41:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14104 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026470AbcDVJjisQ5Kz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 11:39:38 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id BE70AC9A69F98;
        Fri, 22 Apr 2016 10:39:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 10:39:32 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 10:39:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 5/5] MIPS: KVM: Add missing disable FPU hazard barriers
Date:   Fri, 22 Apr 2016 10:38:49 +0100
Message-ID: <1461317929-4991-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461317929-4991-1-git-send-email-james.hogan@imgtec.com>
References: <1461317929-4991-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53198
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

Add the necessary hazard barriers after disabling the FPU in
kvm_lose_fpu(), just to be safe.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ec3fe09ef15c..23b209463238 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1556,8 +1556,10 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 
 		/* Disable MSA & FPU */
 		disable_msa();
-		if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+		if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
 			clear_c0_status(ST0_CU1 | ST0_FR);
+			disable_fpu_hazard();
+		}
 		vcpu->arch.fpu_inuse &= ~(KVM_MIPS_FPU_FPU | KVM_MIPS_FPU_MSA);
 	} else if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
 		set_c0_status(ST0_CU1);
@@ -1568,6 +1570,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 
 		/* Disable FPU */
 		clear_c0_status(ST0_CU1 | ST0_FR);
+		disable_fpu_hazard();
 	}
 	preempt_enable();
 }
-- 
2.4.10
