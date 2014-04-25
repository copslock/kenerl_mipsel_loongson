Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:24:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:8926 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842930AbaDYPUnx41wg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 55EE8BDE219;
        Fri, 25 Apr 2014 16:20:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:36 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 09/21] MIPS: KVM: Fix timer race modifying guest CP0_Cause
Date:   Fri, 25 Apr 2014 16:19:52 +0100
Message-ID: <1398439204-26171-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39935
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

The hrtimer callback for guest timer timeouts sets the guest's
CP0_Cause.TI bit to indicate to the guest that a timer interrupt is
pending, however there is no mutual exclusion implemented to prevent
this occurring while the guest's CP0_Cause register is being
read-modify-written elsewhere.

When this occurs the setting of the CP0_Cause.TI bit is undone and the
guest misses the timer interrupt and doesn't reprogram the CP0_Compare
register for the next timeout. Currently another timer interrupt will be
triggered again in another 10ms anyway due to the way timers are
emulated, but after the MIPS timer emulation is fixed this would result
in Linux guest time standing still and the guest scheduler not being
invoked until the guest CP0_Count has looped around again, which at
100MHz takes just under 43 seconds.

Currently this is the only asynchronous modification of guest registers,
therefore it is fixed by adjusting the implementations of the
kvm_set_c0_guest_cause(), kvm_clear_c0_guest_cause(), and
kvm_change_c0_guest_cause() macros which are used for modifying the
guest CP0_Cause register to use ll/sc to ensure atomic modification.
This should work in both UP and SMP cases without requiring interrupts
to be disabled.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h | 71 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3eedcb3015e5..90e1c0005ff4 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -481,15 +481,74 @@ struct kvm_vcpu_arch {
 #define kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
 #define kvm_write_c0_guest_errorepc(cop0, val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
 
+/*
+ * Some of the guest registers may be modified asynchronously (e.g. from a
+ * hrtimer callback in hard irq context) and therefore need stronger atomicity
+ * guarantees than other registers.
+ */
+
+static inline void _kvm_atomic_set_c0_guest_reg(unsigned long *reg,
+						unsigned long val)
+{
+	unsigned long temp;
+	do {
+		__asm__ __volatile__(
+		"	.set	mips3				\n"
+		"	" __LL "%0, %1				\n"
+		"	or	%0, %2				\n"
+		"	" __SC	"%0, %1				\n"
+		"	.set	mips0				\n"
+		: "=&r" (temp), "+m" (*reg)
+		: "r" (val));
+	} while (unlikely(!temp));
+}
+
+static inline void _kvm_atomic_clear_c0_guest_reg(unsigned long *reg,
+						  unsigned long val)
+{
+	unsigned long temp;
+	do {
+		__asm__ __volatile__(
+		"	.set	mips3				\n"
+		"	" __LL "%0, %1				\n"
+		"	and	%0, %2				\n"
+		"	" __SC	"%0, %1				\n"
+		"	.set	mips0				\n"
+		: "=&r" (temp), "+m" (*reg)
+		: "r" (~val));
+	} while (unlikely(!temp));
+}
+
+static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
+						   unsigned long change,
+						   unsigned long val)
+{
+	unsigned long temp;
+	do {
+		__asm__ __volatile__(
+		"	.set	mips3				\n"
+		"	" __LL "%0, %1				\n"
+		"	and	%0, %2				\n"
+		"	or	%0, %3				\n"
+		"	" __SC	"%0, %1				\n"
+		"	.set	mips0				\n"
+		: "=&r" (temp), "+m" (*reg)
+		: "r" (~change), "r" (val & change));
+	} while (unlikely(!temp));
+}
+
 #define kvm_set_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] |= (val))
 #define kvm_clear_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] &= ~(val))
-#define kvm_set_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] |= (val))
-#define kvm_clear_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val))
+
+/* Cause can be modified asynchronously from hardirq hrtimer callback */
+#define kvm_set_c0_guest_cause(cop0, val)				\
+	_kvm_atomic_set_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
+#define kvm_clear_c0_guest_cause(cop0, val)				\
+	_kvm_atomic_clear_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
 #define kvm_change_c0_guest_cause(cop0, change, val)			\
-{									\
-	kvm_clear_c0_guest_cause(cop0, change);				\
-	kvm_set_c0_guest_cause(cop0, ((val) & (change)));		\
-}
+	_kvm_atomic_change_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0],	\
+					change, val)
+
 #define kvm_set_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] |= (val))
 #define kvm_clear_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
 #define kvm_change_c0_guest_ebase(cop0, change, val)			\
-- 
1.8.1.2
