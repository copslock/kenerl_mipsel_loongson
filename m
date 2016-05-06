Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:38:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53779 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028116AbcEFNglM5dHk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 1F500F64C6D6D;
        Fri,  6 May 2016 14:36:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:35 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/7] MIPS: KVM/locore.S: Relax noat
Date:   Fri, 6 May 2016 14:36:22 +0100
Message-ID: <1462541784-22128-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53296
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

Now that the at register ($1) is no longer saved by
__kvm_mips_vcpu_run(), relax the noat assembler directive so that it
only applies around code where at is restored before entering guest, and
saved after exiting guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/locore.S | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 3ea522e4954b..1f2167bc847d 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -48,7 +48,6 @@
  * a1: vcpu
  */
 	.set	noreorder
-	.set	noat
 
 FEXPORT(__kvm_mips_vcpu_run)
 	/* k0/k1 not being used in host kernel context */
@@ -145,6 +144,7 @@ FEXPORT(__kvm_mips_load_asid)
 	/* Disable RDHWR access */
 	mtc0	zero, CP0_HWRENA
 
+	.set	noat
 	/* Now load up the Guest Context from VCPU */
 	LONG_L	$1, VCPU_R1(k1)
 	LONG_L	$2, VCPU_R2(k1)
@@ -256,6 +256,8 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_S	$30, VCPU_R30(k1)
 	LONG_S	$31, VCPU_R31(k1)
 
+	.set at
+
 	/* We need to save hi/lo and restore them on the way out */
 	mfhi	t0
 	LONG_S	t0, VCPU_HI(k1)
@@ -307,9 +309,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	/* load up the host EBASE */
 	mfc0	v0, CP0_STATUS
 
-	.set	at
 	or	k0, v0, ST0_BEV
-	.set	noat
 
 	mtc0	k0, CP0_STATUS
 	ehb
@@ -321,7 +321,6 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	 * If FPU is enabled, save FCR31 and clear it so that later ctc1's don't
 	 * trigger FPE for pending exceptions.
 	 */
-	.set	at
 	and	v1, v0, ST0_CU1
 	beqz	v1, 1f
 	 nop
@@ -331,7 +330,6 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	sw	t0, VCPU_FCR31(k1)
 	ctc1	zero,fcr31
 	.set	pop
-	.set	noat
 1:
 
 #ifdef CONFIG_CPU_HAS_MSA
@@ -354,10 +352,8 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 #endif
 
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
-	.set	at
 	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
 	or	v0, v0, ST0_CU0
-	.set	noat
 	mtc0	v0, CP0_STATUS
 	ehb
 
@@ -424,18 +420,14 @@ __kvm_mips_return_to_guest:
 
 	/* Switch EBASE back to the one used by KVM */
 	mfc0	v1, CP0_STATUS
-	.set	at
 	or	k0, v1, ST0_BEV
-	.set	noat
 	mtc0	k0, CP0_STATUS
 	ehb
 	mtc0	t0, CP0_EBASE
 
 	/* Setup status register for running guest in UM */
-	.set	at
 	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
 	and	v1, v1, ~(ST0_CU0 | ST0_MX)
-	.set	noat
 	mtc0	v1, CP0_STATUS
 	ehb
 
@@ -464,6 +456,7 @@ __kvm_mips_return_to_guest:
 	/* Disable RDHWR access */
 	mtc0	zero, CP0_HWRENA
 
+	.set	noat
 	/* load the guest context from VCPU and return */
 	LONG_L	$0, VCPU_R0(k1)
 	LONG_L	$1, VCPU_R1(k1)
@@ -509,6 +502,7 @@ FEXPORT(__kvm_mips_skip_guest_restore)
 	LONG_L	k1, VCPU_R27(k1)
 
 	eret
+	.set	at
 
 __kvm_mips_return_to_host:
 	/* EBASE is already pointing to Linux */
-- 
2.4.10
