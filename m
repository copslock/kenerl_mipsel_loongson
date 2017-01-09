Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:56:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21930 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdAIUxd2PVUP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1C81DA0D5693B;
        Mon,  9 Jan 2017 20:53:23 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:26 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 8/10] KVM: MIPS/MMU: Use lockless GVA helpers for get_inst()
Date:   Mon, 9 Jan 2017 20:52:00 +0000
Message-ID: <a20751d7e05c4291f3f5a6ea81ceba16bbc53827.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56243
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

Use the lockless GVA helpers to implement the reading of guest
instructions for emulation. This will allow it to handle asynchronous
TLB flushes when they are implemented.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 32c317de6c0a..b3da473e1569 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -787,11 +787,26 @@ int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
 {
 	int err;
 
+retry:
+	kvm_trap_emul_gva_lockless_begin(vcpu);
 	err = get_user(*out, opc);
+	kvm_trap_emul_gva_lockless_end(vcpu);
+
 	if (unlikely(err)) {
-		kvm_err("%s: illegal address: %p\n", __func__, opc);
-		return -EFAULT;
-	}
+		/*
+		 * Try to handle the fault, maybe we just raced with a GVA
+		 * invalidation.
+		 */
+		err = kvm_trap_emul_gva_fault(vcpu, (unsigned long)opc,
+					      false);
+		if (unlikely(err)) {
+			kvm_err("%s: illegal address: %p\n",
+				__func__, opc);
+			return -EFAULT;
+		}
 
+		/* Hopefully it'll work now */
+		goto retry;
+	}
 	return 0;
 }
-- 
git-series 0.8.10
