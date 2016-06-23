Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:38:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7589 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043854AbcFWQfE3qyZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8BF62386307EB;
        Thu, 23 Jun 2016 17:34:54 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 10/14] MIPS: KVM: Check MSA presence at uasm time
Date:   Thu, 23 Jun 2016 17:34:43 +0100
Message-ID: <1466699687-24791-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54147
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

Check for presence of MSA at uasm assembly time rather than at runtime
in the generated KVM host entry code. This optimises the guest exit path
by eliminating the MSA code entirely if not present, and eliminating the
read of Config3.MSAP and conditional branch if MSA is present.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index c0d9f551c1c1..53e1e576d18a 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -55,7 +55,6 @@
 #define C0_CAUSE	13, 0
 #define C0_EPC		14, 0
 #define C0_EBASE	15, 1
-#define C0_CONFIG3	16, 3
 #define C0_CONFIG5	16, 5
 #define C0_DDATA_LO	28, 3
 #define C0_ERROREPC	30, 0
@@ -409,25 +408,21 @@ void *kvm_mips_build_exit(void *addr)
 		uasm_l_fpu_1(&l, p);
 	}
 
-#ifdef CONFIG_CPU_HAS_MSA
-	/*
-	 * If MSA is enabled, save MSACSR and clear it so that later
-	 * instructions don't trigger MSAFPE for pending exceptions.
-	 */
-	uasm_i_mfc0(&p, T0, C0_CONFIG3);
-	uasm_i_ext(&p, T0, T0, 28, 1); /* MIPS_CONF3_MSAP */
-	uasm_il_beqz(&p, &r, T0, label_msa_1);
-	 uasm_i_nop(&p);
-	uasm_i_mfc0(&p, T0, C0_CONFIG5);
-	uasm_i_ext(&p, T0, T0, 27, 1); /* MIPS_CONF5_MSAEN */
-	uasm_il_beqz(&p, &r, T0, label_msa_1);
-	 uasm_i_nop(&p);
-	uasm_i_cfcmsa(&p, T0, MSA_CSR);
-	uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.msacsr),
-		  K1);
-	uasm_i_ctcmsa(&p, MSA_CSR, ZERO);
-	uasm_l_msa_1(&l, p);
-#endif
+	if (cpu_has_msa) {
+		/*
+		 * If MSA is enabled, save MSACSR and clear it so that later
+		 * instructions don't trigger MSAFPE for pending exceptions.
+		 */
+		uasm_i_mfc0(&p, T0, C0_CONFIG5);
+		uasm_i_ext(&p, T0, T0, 27, 1); /* MIPS_CONF5_MSAEN */
+		uasm_il_beqz(&p, &r, T0, label_msa_1);
+		 uasm_i_nop(&p);
+		uasm_i_cfcmsa(&p, T0, MSA_CSR);
+		uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.msacsr),
+			  K1);
+		uasm_i_ctcmsa(&p, MSA_CSR, ZERO);
+		uasm_l_msa_1(&l, p);
+	}
 
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
 	uasm_i_addiu(&p, AT, ZERO, ~(ST0_EXL | KSU_USER | ST0_IE));
-- 
2.4.10
