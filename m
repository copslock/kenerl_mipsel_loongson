Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:33:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38094 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042342AbcFOSaTHQ-CW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B9F4BFD1B0A49;
        Wed, 15 Jun 2016 19:30:13 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 17/17] MIPS: KVM: Use mipsregs.h defs for config registers
Date:   Wed, 15 Jun 2016 19:30:01 +0100
Message-ID: <1466015401-24433-18-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54063
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

Convert MIPS KVM guest register state initialisation to use the standard
<asm/mipsregs.h> register field definitions for Config registers, and
drop the custom definitions in kvm_host.h which it was using before.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 67 ----------------------------------------
 arch/mips/kvm/trap_emul.c        |  8 ++---
 2 files changed, 3 insertions(+), 72 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 6c43c782bdfa..b0773c6d622f 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -205,73 +205,6 @@ struct mips_coproc {
 #define MIPS_CP0_CONFIG4_SEL	4
 #define MIPS_CP0_CONFIG5_SEL	5
 
-/* Config0 register bits */
-#define CP0C0_M			31
-#define CP0C0_K23		28
-#define CP0C0_KU		25
-#define CP0C0_MDU		20
-#define CP0C0_MM		17
-#define CP0C0_BM		16
-#define CP0C0_BE		15
-#define CP0C0_AT		13
-#define CP0C0_AR		10
-#define CP0C0_MT		7
-#define CP0C0_VI		3
-#define CP0C0_K0		0
-
-/* Config1 register bits */
-#define CP0C1_M			31
-#define CP0C1_MMU		25
-#define CP0C1_IS		22
-#define CP0C1_IL		19
-#define CP0C1_IA		16
-#define CP0C1_DS		13
-#define CP0C1_DL		10
-#define CP0C1_DA		7
-#define CP0C1_C2		6
-#define CP0C1_MD		5
-#define CP0C1_PC		4
-#define CP0C1_WR		3
-#define CP0C1_CA		2
-#define CP0C1_EP		1
-#define CP0C1_FP		0
-
-/* Config2 Register bits */
-#define CP0C2_M			31
-#define CP0C2_TU		28
-#define CP0C2_TS		24
-#define CP0C2_TL		20
-#define CP0C2_TA		16
-#define CP0C2_SU		12
-#define CP0C2_SS		8
-#define CP0C2_SL		4
-#define CP0C2_SA		0
-
-/* Config3 Register bits */
-#define CP0C3_M			31
-#define CP0C3_ISA_ON_EXC	16
-#define CP0C3_ULRI		13
-#define CP0C3_DSPP		10
-#define CP0C3_LPA		7
-#define CP0C3_VEIC		6
-#define CP0C3_VInt		5
-#define CP0C3_SP		4
-#define CP0C3_MT		2
-#define CP0C3_SM		1
-#define CP0C3_TL		0
-
-/* MMU types, the first four entries have the same layout as the
-   CP0C0_MT field.  */
-enum mips_mmu_types {
-	MMU_TYPE_NONE,
-	MMU_TYPE_R4000,
-	MMU_TYPE_RESERVED,
-	MMU_TYPE_FMT,
-	MMU_TYPE_R3000,
-	MMU_TYPE_R6000,
-	MMU_TYPE_R8000
-};
-
 /* Resume Flags */
 #define RESUME_FLAG_DR		(1<<0)	/* Reload guest nonvolatile state? */
 #define RESUME_FLAG_HOST	(1<<1)	/* Resume host? */
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 1dc003ddca91..00e8dc3d36cb 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -440,8 +440,7 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	 * host.
 	 */
 	config = read_c0_config() & MIPS_CONF_AR;
-	config |= MIPS_CONF_M | (0x3 << CP0C0_K0) |
-		(MMU_TYPE_R4000 << CP0C0_MT);
+	config |= MIPS_CONF_M | CONF_CM_CACHABLE_NONCOHERENT | MIPS_CONF_MT_TLB;
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	config |= CONF_BE;
 #endif
@@ -457,9 +456,8 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	config1 |= ((KVM_MIPS_GUEST_TLB_SIZE - 1) << 25);
 
 	/* We unset some bits that we aren't emulating */
-	config1 &=
-	    ~((1 << CP0C1_C2) | (1 << CP0C1_MD) | (1 << CP0C1_PC) |
-	      (1 << CP0C1_WR) | (1 << CP0C1_CA));
+	config1 &= ~(MIPS_CONF1_C2 | MIPS_CONF1_MD | MIPS_CONF1_PC |
+		     MIPS_CONF1_WR | MIPS_CONF1_CA);
 	kvm_write_c0_guest_config1(cop0, config1);
 
 	/* Have config3, no tertiary/secondary caches implemented */
-- 
2.4.10
