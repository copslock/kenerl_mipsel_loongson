Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:36:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15808 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992319AbcGDSfjswWu7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CC80BA4C59753;
        Mon,  4 Jul 2016 19:35:29 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/9] MIPS: KVM: Fix fpu.S misassembly with r6
Date:   Mon, 4 Jul 2016 19:35:09 +0100
Message-ID: <1467657315-19975-4-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54202
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

__kvm_save_fpu and __kvm_restore_fpu use .set mips64r2 so that they can
access the odd FPU registers as well as the even, however this causes
misassembly of the return instruction on MIPSr6.

Fix by replacing .set mips64r2 with .set fp=64, which doesn't change the
architecture revision.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/fpu.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/fpu.S b/arch/mips/kvm/fpu.S
index 531fbf5131c0..16f17c6390dd 100644
--- a/arch/mips/kvm/fpu.S
+++ b/arch/mips/kvm/fpu.S
@@ -14,13 +14,16 @@
 #include <asm/mipsregs.h>
 #include <asm/regdef.h>
 
+/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#undef fp
+
 	.set	noreorder
 	.set	noat
 
 LEAF(__kvm_save_fpu)
 	.set	push
-	.set	mips64r2
 	SET_HARDFLOAT
+	.set	fp=64
 	mfc0	t0, CP0_STATUS
 	sll     t0, t0, 5			# is Status.FR set?
 	bgez    t0, 1f				# no: skip odd doubles
@@ -63,8 +66,8 @@ LEAF(__kvm_save_fpu)
 
 LEAF(__kvm_restore_fpu)
 	.set	push
-	.set	mips64r2
 	SET_HARDFLOAT
+	.set	fp=64
 	mfc0	t0, CP0_STATUS
 	sll     t0, t0, 5			# is Status.FR set?
 	bgez    t0, 1f				# no: skip odd doubles
-- 
2.4.10
