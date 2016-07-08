Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:57:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30127 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992861AbcGHKyHRumhv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DFC2F63DDE14B;
        Fri,  8 Jul 2016 11:53:48 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 05/12] MIPS: KVM: Set CP0_Status.KX on MIPS64
Date:   Fri, 8 Jul 2016 11:53:24 +0100
Message-ID: <1467975211-12674-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54267
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

Update the KVM entry code to set the CP0_Entry.KX bit on 64-bit kernels.
This is important to allow the entry code, running in kernel mode, to
access the full 64-bit address space right up to the point of entering
the guest, and immediately after exiting the guest, so it can safely
restore & save the guest context from 64-bit segments.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index f4556d0279c6..c824bfc4daa0 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -61,6 +61,12 @@
 
 #define CALLFRAME_SIZ   32
 
+#ifdef CONFIG_64BIT
+#define ST0_KX_IF_64	ST0_KX
+#else
+#define ST0_KX_IF_64	0
+#endif
+
 static unsigned int scratch_vcpu[2] = { C0_DDATA_LO };
 static unsigned int scratch_tmp[2] = { C0_ERROREPC };
 
@@ -204,7 +210,7 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	 * Setup status register for running the guest in UM, interrupts
 	 * are disabled
 	 */
-	UASM_i_LA(&p, K0, ST0_EXL | KSU_USER | ST0_BEV);
+	UASM_i_LA(&p, K0, ST0_EXL | KSU_USER | ST0_BEV | ST0_KX_IF_64);
 	uasm_i_mtc0(&p, K0, C0_STATUS);
 	uasm_i_ehb(&p);
 
@@ -217,7 +223,7 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	 * interrupt mask as it was but make sure that timer interrupts
 	 * are enabled
 	 */
-	uasm_i_addiu(&p, K0, ZERO, ST0_EXL | KSU_USER | ST0_IE);
+	uasm_i_addiu(&p, K0, ZERO, ST0_EXL | KSU_USER | ST0_IE | ST0_KX_IF_64);
 	uasm_i_andi(&p, V0, V0, ST0_IM);
 	uasm_i_or(&p, K0, K0, V0);
 	uasm_i_mtc0(&p, K0, C0_STATUS);
-- 
2.4.10
