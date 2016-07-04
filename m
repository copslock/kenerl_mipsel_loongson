Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:38:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11671 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992398AbcGDSfndvDW7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BA191C97C0915;
        Mon,  4 Jul 2016 19:35:32 +0100 (IST)
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
Subject: [PATCH 6/9] MIPS: KVM: Support r6 compact branch emulation
Date:   Mon, 4 Jul 2016 19:35:12 +0100
Message-ID: <1467657315-19975-7-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54205
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

Add support in KVM for emulation of instructions in the forbidden slot
of MIPSr6 compact branches. If we hit an exception on the forbidden
slot, then the branch must not have been taken, which makes calculation
of the resume PC trivial.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 52 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 5f0354c80c8e..f0fa9e956056 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -161,9 +161,12 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		nextpc = epc;
 		break;
 
-	case blez_op:		/* not really i_format */
-	case blezl_op:
-		/* rt field assumed to be zero */
+	case blez_op:	/* POP06 */
+#ifndef CONFIG_CPU_MIPSR6
+	case blezl_op:	/* removed in R6 */
+#endif
+		if (insn.i_format.rt != 0)
+			goto compact_branch;
 		if ((long)arch->gprs[insn.i_format.rs] <= 0)
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
 		else
@@ -171,9 +174,12 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		nextpc = epc;
 		break;
 
-	case bgtz_op:
-	case bgtzl_op:
-		/* rt field assumed to be zero */
+	case bgtz_op:	/* POP07 */
+#ifndef CONFIG_CPU_MIPSR6
+	case bgtzl_op:	/* removed in R6 */
+#endif
+		if (insn.i_format.rt != 0)
+			goto compact_branch;
 		if ((long)arch->gprs[insn.i_format.rs] > 0)
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
 		else
@@ -185,6 +191,40 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 	case cop1_op:
 		kvm_err("%s: unsupported cop1_op\n", __func__);
 		break;
+
+#ifdef CONFIG_CPU_MIPSR6
+	/* R6 added the following compact branches with forbidden slots */
+	case blezl_op:	/* POP26 */
+	case bgtzl_op:	/* POP27 */
+		/* only rt == 0 isn't compact branch */
+		if (insn.i_format.rt != 0)
+			goto compact_branch;
+		break;
+	case pop10_op:
+	case pop30_op:
+		/* only rs == rt == 0 is reserved, rest are compact branches */
+		if (insn.i_format.rs != 0 || insn.i_format.rt != 0)
+			goto compact_branch;
+		break;
+	case pop66_op:
+	case pop76_op:
+		/* only rs == 0 isn't compact branch */
+		if (insn.i_format.rs != 0)
+			goto compact_branch;
+		break;
+compact_branch:
+		/*
+		 * If we've hit an exception on the forbidden slot, then
+		 * the branch must not have been taken.
+		 */
+		epc += 8;
+		nextpc = epc;
+		break;
+#else
+compact_branch:
+		/* Compact branches not supported before R6 */
+		break;
+#endif
 	}
 
 	return nextpc;
-- 
2.4.10
