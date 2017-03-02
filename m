Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:50:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43127 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993903AbdCBJhqrRBBt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8E07E782D0B09;
        Thu,  2 Mar 2017 09:37:38 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 29/32] KVM: MIPS/VZ: Support guest load-linked bit
Date:   Thu, 2 Mar 2017 09:36:56 +0000
Message-ID: <95f095c915e9b7cd6778fef83a2091189ade5460.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56991
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

When restoring guest state after another VCPU has run, be sure to clear
CP0_LLAddr.LLB in order to break any interrupted atomic critical
section. Without this SMP guest atomics don't work when LLB is present
as one guest can complete the atomic section started by another guest.

MIPS VZ guest read of CP0_LLAddr causes Guest Privileged Sensitive
Instruction (GPSI) exception due to the address being root physical.
Handle this by reporting only the LLB bit, which contains the bit for
whether a ll/sc atomic is in progress without any reason for failure.

Similarly on P5600 a guest write to CP0_LLAddr also causes a GPSI
exception. Handle this also by clearing the guest LLB bit from root
mode.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/vz.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index c7d15aa69259..1a7f15222d6f 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -730,6 +730,13 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 			} else if (rd == MIPS_CP0_COMPARE &&
 				   sel == 0) {		/* Compare */
 				val = read_gc0_compare();
+			} else if (rd == MIPS_CP0_LLADDR &&
+				   sel == 0) {		/* LLAddr */
+				if (cpu_guest_has_rw_llb)
+					val = read_gc0_lladdr() &
+						MIPS_LLADDR_LLB;
+				else
+					val = 0;
 			} else if ((rd == MIPS_CP0_PRID &&
 				    (sel == 0 ||	/* PRid */
 				     sel == 2 ||	/* CDMMBase */
@@ -777,6 +784,15 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				kvm_mips_write_compare(vcpu,
 						       vcpu->arch.gprs[rt],
 						       true);
+			} else if (rd == MIPS_CP0_LLADDR &&
+				   sel == 0) {		/* LLAddr */
+				/*
+				 * P5600 generates GPSI on guest MTC0 LLAddr.
+				 * Only allow the guest to clear LLB.
+				 */
+				if (cpu_guest_has_rw_llb &&
+				    !(val & MIPS_LLADDR_LLB))
+					write_gc0_lladdr(0);
 			} else if (rd == MIPS_CP0_ERRCTL &&
 				   (sel == 0)) {	/* ErrCtl */
 				/* ignore the written value */
@@ -2246,6 +2262,14 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		write_c0_guestctl2(
 			cop0->reg[MIPS_CP0_GUESTCTL2][MIPS_CP0_GUESTCTL2_SEL]);
 
+	/*
+	 * We should clear linked load bit to break interrupted atomics. This
+	 * prevents a SC on the next VCPU from succeeding by matching a LL on
+	 * the previous VCPU.
+	 */
+	if (cpu_guest_has_rw_llb)
+		write_gc0_lladdr(0);
+
 	return 0;
 }
 
-- 
git-series 0.8.10
