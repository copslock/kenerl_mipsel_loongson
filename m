Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:56:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31800 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993874AbdAIUxc41nxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5C0886DD0ABEC;
        Mon,  9 Jan 2017 20:53:22 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:26 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 7/10] KVM: MIPS/T&E: Use lockless GVA helpers for dyntrans
Date:   Mon, 9 Jan 2017 20:51:59 +0000
Message-ID: <8b8b6c1d2c495d1d5caf53c3386de34d19980576.1483993967.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56241
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

Use the lockless GVA helpers to implement the dynamic translation of
guest instructions. This will allow it to handle asynchronous TLB
flushes when they are implemented.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 60ebf5862d2b..f8e772564d74 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -33,10 +33,32 @@ static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
 	unsigned long vaddr = (unsigned long)opc;
 	int err;
 
+retry:
+	/* The GVA page table is still active so use the Linux TLB handlers */
+	kvm_trap_emul_gva_lockless_begin(vcpu);
 	err = put_user(replace.word, opc);
+	kvm_trap_emul_gva_lockless_end(vcpu);
+
 	if (unlikely(err)) {
-		kvm_err("%s: Invalid address: %p\n", __func__, opc);
-		return err;
+		/*
+		 * We write protect clean pages in GVA page table so normal
+		 * Linux TLB mod handler doesn't silently dirty the page.
+		 * Its also possible we raced with a GVA invalidation.
+		 * Try to force the page to become dirty.
+		 */
+		err = kvm_trap_emul_gva_fault(vcpu, vaddr, true);
+		if (unlikely(err)) {
+			kvm_info("%s: Address unwriteable: %p\n",
+				 __func__, opc);
+			return -EFAULT;
+		}
+
+		/*
+		 * Try again. This will likely trigger a TLB refill, which will
+		 * fetch the new dirty entry from the GVA page table, which
+		 * should then succeed.
+		 */
+		goto retry;
 	}
 	__local_flush_icache_user_range(vaddr, vaddr + 4);
 
-- 
git-series 0.8.10
