Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:32:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38094 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042340AbcFOSaSfs0QW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3817D99C99FFD;
        Wed, 15 Jun 2016 19:30:08 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 09/17] MIPS: KVM: Don't hardcode restored HWREna
Date:   Wed, 15 Jun 2016 19:29:53 +0100
Message-ID: <1466015401-24433-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54062
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

KVM modifies CP0_HWREna during guest execution so it can trap and
emulate RDHWR instructions, however it always restores the hardcoded
value 0x2000000F. This assumes the presence of the UserLocal register,
and the absence of any implementation dependent or future HW registers.

Fix by exporting the value that traps.c write into CP0_HWREna, and
loading from there instead of hard coding.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/setup.h | 1 +
 arch/mips/kernel/traps.c      | 5 ++++-
 arch/mips/kvm/locore.S        | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index d7bfdeba9e84..4f5279a8308d 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -21,6 +21,7 @@ extern void *set_vi_handler(int n, vi_handler_t addr);
 
 extern void *set_except_vector(int n, void *addr);
 extern unsigned long ebase;
+extern unsigned int hwrena;
 extern void per_cpu_trap_init(bool);
 extern void cpu_cache_init(void);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7176a6057e26..6fb4704bd156 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2064,10 +2064,13 @@ static void configure_status(void)
 			 status_set);
 }
 
+unsigned int hwrena;
+EXPORT_SYMBOL_GPL(hwrena);
+
 /* configure HWRENA register */
 static void configure_hwrena(void)
 {
-	unsigned int hwrena = cpu_hwrena_impl_bits;
+	hwrena = cpu_hwrena_impl_bits;
 
 	if (cpu_has_mips_r2_r6)
 		hwrena |= MIPS_HWRENA_CPUNUM |
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index f87bec546366..698286c0f732 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -381,7 +381,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	mtc0	k0, CP0_DDATA_LO
 
 	/* Restore RDHWR access */
-	PTR_LI	k0, 0x2000000F
+	INT_L	k0, hwrena
 	mtc0	k0, CP0_HWRENA
 
 	/* Jump to handler */
@@ -553,7 +553,7 @@ __kvm_mips_return_to_host:
 	mtlo	k0
 
 	/* Restore RDHWR access */
-	PTR_LI	k0, 0x2000000F
+	INT_L	k0, hwrena
 	mtc0	k0, CP0_HWRENA
 
 	/* Restore RA, which is the address we will return to */
-- 
2.4.10
