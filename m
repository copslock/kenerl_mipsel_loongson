Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:50:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10349 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013393AbbCKOsOuLci0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C32FC723AC944;
        Wed, 11 Mar 2015 14:48:05 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:08 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 07/20] MIPS: KVM: Clean up register definitions a little
Date:   Wed, 11 Mar 2015 14:44:43 +0000
Message-ID: <1426085096-12932-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46323
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

Clean up KVM_GET_ONE_REG / KVM_SET_ONE_REG register definitions for
MIPS, to prepare for adding a new group for FPU & MSA vector registers.

Definitions are added for common bits in each group of registers, e.g.
KVM_REG_MIPS_CP0 = KVM_REG_MIPS | 0x10000, for the coprocessor 0
registers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   4 +-
 arch/mips/include/uapi/asm/kvm.h | 115 ++++++++++++++++++++++-----------------
 2 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 26d91b0f3c3c..1bd392d3a35b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -21,10 +21,10 @@
 
 /* MIPS KVM register ids */
 #define MIPS_CP0_32(_R, _S)					\
-	(KVM_REG_MIPS | KVM_REG_SIZE_U32 | 0x10000 | (8 * (_R) + (_S)))
+	(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
 
 #define MIPS_CP0_64(_R, _S)					\
-	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | 0x10000 | (8 * (_R) + (_S)))
+	(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
 
 #define KVM_REG_MIPS_CP0_INDEX		MIPS_CP0_32(0, 0)
 #define KVM_REG_MIPS_CP0_ENTRYLO0	MIPS_CP0_64(2, 0)
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index 2c04b6d9ff85..75d6d8557e57 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -52,61 +52,76 @@ struct kvm_fpu {
 
 
 /*
- * For MIPS, we use KVM_SET_ONE_REG and KVM_GET_ONE_REG to access CP0
+ * For MIPS, we use KVM_SET_ONE_REG and KVM_GET_ONE_REG to access various
  * registers.  The id field is broken down as follows:
  *
- *  bits[2..0]   - Register 'sel' index.
- *  bits[7..3]   - Register 'rd'  index.
- *  bits[15..8]  - Must be zero.
- *  bits[31..16] - 1 -> CP0 registers.
- *  bits[51..32] - Must be zero.
  *  bits[63..52] - As per linux/kvm.h
+ *  bits[51..32] - Must be zero.
+ *  bits[31..16] - Register set.
+ *
+ * Register set = 0: GP registers from kvm_regs (see definitions below).
+ *
+ * Register set = 1: CP0 registers.
+ *  bits[15..8]  - Must be zero.
+ *  bits[7..3]   - Register 'rd'  index.
+ *  bits[2..0]   - Register 'sel' index.
+ *
+ * Register set = 2: KVM specific registers (see definitions below).
  *
  * Other sets registers may be added in the future.  Each set would
  * have its own identifier in bits[31..16].
- *
- * The registers defined in struct kvm_regs are also accessible, the
- * id values for these are below.
  */
 
-#define KVM_REG_MIPS_R0 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 0)
-#define KVM_REG_MIPS_R1 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 1)
-#define KVM_REG_MIPS_R2 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 2)
-#define KVM_REG_MIPS_R3 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 3)
-#define KVM_REG_MIPS_R4 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 4)
-#define KVM_REG_MIPS_R5 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 5)
-#define KVM_REG_MIPS_R6 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 6)
-#define KVM_REG_MIPS_R7 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 7)
-#define KVM_REG_MIPS_R8 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 8)
-#define KVM_REG_MIPS_R9 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 9)
-#define KVM_REG_MIPS_R10 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 10)
-#define KVM_REG_MIPS_R11 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 11)
-#define KVM_REG_MIPS_R12 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 12)
-#define KVM_REG_MIPS_R13 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 13)
-#define KVM_REG_MIPS_R14 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 14)
-#define KVM_REG_MIPS_R15 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 15)
-#define KVM_REG_MIPS_R16 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 16)
-#define KVM_REG_MIPS_R17 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 17)
-#define KVM_REG_MIPS_R18 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 18)
-#define KVM_REG_MIPS_R19 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 19)
-#define KVM_REG_MIPS_R20 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 20)
-#define KVM_REG_MIPS_R21 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 21)
-#define KVM_REG_MIPS_R22 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 22)
-#define KVM_REG_MIPS_R23 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 23)
-#define KVM_REG_MIPS_R24 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 24)
-#define KVM_REG_MIPS_R25 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 25)
-#define KVM_REG_MIPS_R26 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 26)
-#define KVM_REG_MIPS_R27 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 27)
-#define KVM_REG_MIPS_R28 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 28)
-#define KVM_REG_MIPS_R29 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 29)
-#define KVM_REG_MIPS_R30 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 30)
-#define KVM_REG_MIPS_R31 (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 31)
+#define KVM_REG_MIPS_GP		(KVM_REG_MIPS | 0x0000000000000000ULL)
+#define KVM_REG_MIPS_CP0	(KVM_REG_MIPS | 0x0000000000010000ULL)
+#define KVM_REG_MIPS_KVM	(KVM_REG_MIPS | 0x0000000000020000ULL)
 
-#define KVM_REG_MIPS_HI (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 32)
-#define KVM_REG_MIPS_LO (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 33)
-#define KVM_REG_MIPS_PC (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 34)
 
-/* KVM specific control registers */
+/*
+ * KVM_REG_MIPS_GP - General purpose registers from kvm_regs.
+ */
+
+#define KVM_REG_MIPS_R0		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  0)
+#define KVM_REG_MIPS_R1		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  1)
+#define KVM_REG_MIPS_R2		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  2)
+#define KVM_REG_MIPS_R3		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  3)
+#define KVM_REG_MIPS_R4		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  4)
+#define KVM_REG_MIPS_R5		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  5)
+#define KVM_REG_MIPS_R6		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  6)
+#define KVM_REG_MIPS_R7		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  7)
+#define KVM_REG_MIPS_R8		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  8)
+#define KVM_REG_MIPS_R9		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 |  9)
+#define KVM_REG_MIPS_R10	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 10)
+#define KVM_REG_MIPS_R11	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 11)
+#define KVM_REG_MIPS_R12	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 12)
+#define KVM_REG_MIPS_R13	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 13)
+#define KVM_REG_MIPS_R14	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 14)
+#define KVM_REG_MIPS_R15	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 15)
+#define KVM_REG_MIPS_R16	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 16)
+#define KVM_REG_MIPS_R17	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 17)
+#define KVM_REG_MIPS_R18	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 18)
+#define KVM_REG_MIPS_R19	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 19)
+#define KVM_REG_MIPS_R20	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 20)
+#define KVM_REG_MIPS_R21	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 21)
+#define KVM_REG_MIPS_R22	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 22)
+#define KVM_REG_MIPS_R23	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 23)
+#define KVM_REG_MIPS_R24	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 24)
+#define KVM_REG_MIPS_R25	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 25)
+#define KVM_REG_MIPS_R26	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 26)
+#define KVM_REG_MIPS_R27	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 27)
+#define KVM_REG_MIPS_R28	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 28)
+#define KVM_REG_MIPS_R29	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 29)
+#define KVM_REG_MIPS_R30	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 30)
+#define KVM_REG_MIPS_R31	(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 31)
+
+#define KVM_REG_MIPS_HI		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 32)
+#define KVM_REG_MIPS_LO		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 33)
+#define KVM_REG_MIPS_PC		(KVM_REG_MIPS_GP | KVM_REG_SIZE_U64 | 34)
+
+
+/*
+ * KVM_REG_MIPS_KVM - KVM specific control registers.
+ */
 
 /*
  * CP0_Count control
@@ -118,8 +133,7 @@ struct kvm_fpu {
  *        safely without losing time or guest timer interrupts.
  * Other: Reserved, do not change.
  */
-#define KVM_REG_MIPS_COUNT_CTL		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
-					 0x20000 | 0)
+#define KVM_REG_MIPS_COUNT_CTL	    (KVM_REG_MIPS_KVM | KVM_REG_SIZE_U64 | 0)
 #define KVM_REG_MIPS_COUNT_CTL_DC	0x00000001
 
 /*
@@ -131,15 +145,14 @@ struct kvm_fpu {
  * emulated.
  * Modifications to times in the future are rejected.
  */
-#define KVM_REG_MIPS_COUNT_RESUME	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
-					 0x20000 | 1)
+#define KVM_REG_MIPS_COUNT_RESUME   (KVM_REG_MIPS_KVM | KVM_REG_SIZE_U64 | 1)
 /*
  * CP0_Count rate in Hz
  * Specifies the rate of the CP0_Count timer in Hz. Modifications occur without
  * discontinuities in CP0_Count.
  */
-#define KVM_REG_MIPS_COUNT_HZ		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
-					 0x20000 | 2)
+#define KVM_REG_MIPS_COUNT_HZ	    (KVM_REG_MIPS_KVM | KVM_REG_SIZE_U64 | 2)
+
 
 /*
  * KVM MIPS specific structures and definitions
-- 
2.0.5
