Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:50:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013389AbbCKOsOpO5U- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3D416CC8587CA;
        Wed, 11 Mar 2015 14:48:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:09 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 08/20] MIPS: KVM: Simplify default guest Config registers
Date:   Wed, 11 Mar 2015 14:44:44 +0000
Message-ID: <1426085096-12932-9-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46322
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

Various semi-used definitions exist in kvm_host.h for the default guest
config registers. Remove them and use the appropriate values directly
when initialising the Config registers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 25 -------------------------
 arch/mips/kvm/trap_emul.c        | 15 +++++++++------
 2 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 1bd392d3a35b..6996447fd2a7 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -265,31 +265,6 @@ struct mips_coproc {
 #define CP0C3_SM		1
 #define CP0C3_TL		0
 
-/* Have config1, Cacheable, noncoherent, write-back, write allocate*/
-#define MIPS_CONFIG0						\
-  ((1 << CP0C0_M) | (0x3 << CP0C0_K0))
-
-/* Have config2, no coprocessor2 attached, no MDMX support attached,
-   no performance counters, watch registers present,
-   no code compression, EJTAG present, no FPU, no watch registers */
-#define MIPS_CONFIG1						\
-((1 << CP0C1_M) |						\
- (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |		\
- (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |		\
- (0 << CP0C1_FP))
-
-/* Have config3, no tertiary/secondary caches implemented */
-#define MIPS_CONFIG2						\
-((1 << CP0C2_M))
-
-/* No config4, no DSP ASE, no large physaddr (PABITS),
-   no external interrupt controller, no vectored interrupts,
-   no 1kb pages, no SmartMIPS ASE, no trace logic */
-#define MIPS_CONFIG3						\
-((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |	\
- (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |	\
- (0 << CP0C3_SM) | (0 << CP0C3_TL))
-
 /* MMU types, the first four entries have the same layout as the
    CP0C0_MT field.  */
 enum mips_mmu_types {
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index dc019950e243..bffba002d1a4 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -396,8 +396,9 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	 * guest will come up as expected, for now we simulate a MIPS 24kc
 	 */
 	kvm_write_c0_guest_prid(cop0, 0x00019300);
-	kvm_write_c0_guest_config(cop0,
-				  MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
+	/* Have config1, Cacheable, noncoherent, write-back, write allocate */
+	kvm_write_c0_guest_config(cop0, MIPS_CONF_M | (0x3 << CP0C0_K0) |
+				  (0x1 << CP0C0_AR) |
 				  (MMU_TYPE_R4000 << CP0C0_MT));
 
 	/* Read the cache characteristics from the host Config1 Register */
@@ -413,10 +414,12 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	      (1 << CP0C1_WR) | (1 << CP0C1_CA));
 	kvm_write_c0_guest_config1(cop0, config1);
 
-	kvm_write_c0_guest_config2(cop0, MIPS_CONFIG2);
-	/* MIPS_CONFIG2 | (read_c0_config2() & 0xfff) */
-	kvm_write_c0_guest_config3(cop0, MIPS_CONFIG3 | (0 << CP0C3_VInt) |
-					 (1 << CP0C3_ULRI));
+	/* Have config3, no tertiary/secondary caches implemented */
+	kvm_write_c0_guest_config2(cop0, MIPS_CONF_M);
+	/* MIPS_CONF_M | (read_c0_config2() & 0xfff) */
+
+	/* No config4, UserLocal */
+	kvm_write_c0_guest_config3(cop0, MIPS_CONF3_ULRI);
 
 	/* Set Wait IE/IXMT Ignore in Config7, IAR, AR */
 	kvm_write_c0_guest_config7(cop0, (MIPS_CONF7_WII) | (1 << 10));
-- 
2.0.5
