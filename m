Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:38:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34584 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027443AbcEFNgkSFZWk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4B80262F82716;
        Fri,  6 May 2016 14:36:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:34 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 4/7] MIPS: KVM/locore.S: Only preserve callee saved registers
Date:   Fri, 6 May 2016 14:36:21 +0100
Message-ID: <1462541784-22128-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53295
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

Update __kvm_mips_vcpu_run() to only save and restore callee saved
registers. It is always called using the standard ABIs, so the caller
will preserve any other registers that need preserving.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/locore.S | 48 +-----------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 308706493fd5..3ea522e4954b 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -53,40 +53,14 @@
 FEXPORT(__kvm_mips_vcpu_run)
 	/* k0/k1 not being used in host kernel context */
 	INT_ADDIU k1, sp, -PT_SIZE
-	LONG_S	$0, PT_R0(k1)
-	LONG_S	$1, PT_R1(k1)
-	LONG_S	$2, PT_R2(k1)
-	LONG_S	$3, PT_R3(k1)
-
-	LONG_S	$4, PT_R4(k1)
-	LONG_S	$5, PT_R5(k1)
-	LONG_S	$6, PT_R6(k1)
-	LONG_S	$7, PT_R7(k1)
-
-	LONG_S	$8,  PT_R8(k1)
-	LONG_S	$9,  PT_R9(k1)
-	LONG_S	$10, PT_R10(k1)
-	LONG_S	$11, PT_R11(k1)
-	LONG_S	$12, PT_R12(k1)
-	LONG_S	$13, PT_R13(k1)
-	LONG_S	$14, PT_R14(k1)
-	LONG_S	$15, PT_R15(k1)
 	LONG_S	$16, PT_R16(k1)
 	LONG_S	$17, PT_R17(k1)
-
 	LONG_S	$18, PT_R18(k1)
 	LONG_S	$19, PT_R19(k1)
 	LONG_S	$20, PT_R20(k1)
 	LONG_S	$21, PT_R21(k1)
 	LONG_S	$22, PT_R22(k1)
 	LONG_S	$23, PT_R23(k1)
-	LONG_S	$24, PT_R24(k1)
-	LONG_S	$25, PT_R25(k1)
-
-	/*
-	 * XXXKYMA k0/k1 not saved, not being used if we got here through
-	 * an ioctl()
-	 */
 
 	LONG_S	$28, PT_R28(k1)
 	LONG_S	$29, PT_R29(k1)
@@ -545,10 +519,6 @@ __kvm_mips_return_to_host:
 	LONG_L	k0, PT_HOST_USERLOCAL(k1)
 	mtc0	k0, CP0_DDATA_LO
 
-	/* Load context saved on the host stack */
-	LONG_L	$0, PT_R0(k1)
-	LONG_L	$1, PT_R1(k1)
-
 	/*
 	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
 	 * to recover the err code
@@ -556,19 +526,7 @@ __kvm_mips_return_to_host:
 	INT_SRA	k0, v0, 2
 	move	$2, k0
 
-	LONG_L	$3, PT_R3(k1)
-	LONG_L	$4, PT_R4(k1)
-	LONG_L	$5, PT_R5(k1)
-	LONG_L	$6, PT_R6(k1)
-	LONG_L	$7, PT_R7(k1)
-	LONG_L	$8, PT_R8(k1)
-	LONG_L	$9, PT_R9(k1)
-	LONG_L	$10, PT_R10(k1)
-	LONG_L	$11, PT_R11(k1)
-	LONG_L	$12, PT_R12(k1)
-	LONG_L	$13, PT_R13(k1)
-	LONG_L	$14, PT_R14(k1)
-	LONG_L	$15, PT_R15(k1)
+	/* Load context saved on the host stack */
 	LONG_L	$16, PT_R16(k1)
 	LONG_L	$17, PT_R17(k1)
 	LONG_L	$18, PT_R18(k1)
@@ -577,10 +535,6 @@ __kvm_mips_return_to_host:
 	LONG_L	$21, PT_R21(k1)
 	LONG_L	$22, PT_R22(k1)
 	LONG_L	$23, PT_R23(k1)
-	LONG_L	$24, PT_R24(k1)
-	LONG_L	$25, PT_R25(k1)
-
-	/* Host k0/k1 were not saved */
 
 	LONG_L	$28, PT_R28(k1)
 	LONG_L	$29, PT_R29(k1)
-- 
2.4.10
