Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:37:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38959 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043853AbcFWQfDiqzkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C869CBD1EAFBE;
        Thu, 23 Jun 2016 17:34:53 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 09/14] MIPS: KVM: Omit FPU handling entry code if possible
Date:   Thu, 23 Jun 2016 17:34:42 +0100
Message-ID: <1466699687-24791-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54146
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

The FPU handling code on entry from guest is unnecessary if no FPU is
present, so allow it to be dropped at uasm assembly time.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 9a18b4939b35..c0d9f551c1c1 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -393,18 +393,21 @@ void *kvm_mips_build_exit(void *addr)
 	UASM_i_LW(&p, K0, uasm_rel_lo((long)&ebase), K0);
 	uasm_i_mtc0(&p, K0, C0_EBASE);
 
-	/*
-	 * If FPU is enabled, save FCR31 and clear it so that later ctc1's don't
-	 * trigger FPE for pending exceptions.
-	 */
-	uasm_i_lui(&p, AT, ST0_CU1 >> 16);
-	uasm_i_and(&p, V1, V0, AT);
-	uasm_il_beqz(&p, &r, V1, label_fpu_1);
-	 uasm_i_nop(&p);
-	uasm_i_cfc1(&p, T0, 31);
-	uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.fcr31), K1);
-	uasm_i_ctc1(&p, ZERO, 31);
-	uasm_l_fpu_1(&l, p);
+	if (raw_cpu_has_fpu) {
+		/*
+		 * If FPU is enabled, save FCR31 and clear it so that later
+		 * ctc1's don't trigger FPE for pending exceptions.
+		 */
+		uasm_i_lui(&p, AT, ST0_CU1 >> 16);
+		uasm_i_and(&p, V1, V0, AT);
+		uasm_il_beqz(&p, &r, V1, label_fpu_1);
+		 uasm_i_nop(&p);
+		uasm_i_cfc1(&p, T0, 31);
+		uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.fcr31),
+			  K1);
+		uasm_i_ctc1(&p, ZERO, 31);
+		uasm_l_fpu_1(&l, p);
+	}
 
 #ifdef CONFIG_CPU_HAS_MSA
 	/*
-- 
2.4.10
