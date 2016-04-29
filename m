Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2016 15:46:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25952 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026771AbcD2NqP3XQ0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Apr 2016 15:46:15 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id BB343101B3052;
        Fri, 29 Apr 2016 14:46:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:46:09 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:46:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/5] MIPS: Define & use CP0_EBase bit definitions
Date:   Fri, 29 Apr 2016 14:45:59 +0100
Message-ID: <1461937563-13199-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461937563-13199-1-git-send-email-james.hogan@imgtec.com>
References: <1461937563-13199-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53255
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

Add definitions for the bits & fields in the CP0_EBase register, and use
them from a few different places in arch/mips which hardcoded these
values.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/mipsregs.h | 10 +++++++++-
 arch/mips/kvm/trap_emul.c        |  3 ++-
 arch/mips/netlogic/xlp/nlm_hal.c |  2 +-
 arch/mips/netlogic/xlr/setup.c   |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 1e9d337fb077..24904f1f6fe1 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -674,6 +674,14 @@
 #define MIPS_MAAR_S		(_ULCAST_(1) << 1)
 #define MIPS_MAAR_V		(_ULCAST_(1) << 0)
 
+/* EBase bit definitions */
+#define MIPS_EBASE_CPUNUM_SHIFT	0
+#define MIPS_EBASE_CPUNUM	(_ULCAST_(0x3ff) << 0)
+#define MIPS_EBASE_WG_SHIFT	11
+#define MIPS_EBASE_WG		(_ULCAST_(1) << 11)
+#define MIPS_EBASE_BASE_SHIFT	12
+#define MIPS_EBASE_BASE		(~_ULCAST_((1 << MIPS_EBASE_BASE_SHIFT) - 1))
+
 /* CMGCRBase bit definitions */
 #define MIPS_CMGCRB_BASE	11
 #define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
@@ -2102,7 +2110,7 @@ __BUILD_SET_C0(brcm_mode)
  */
 static inline unsigned int get_ebase_cpunum(void)
 {
-	return read_c0_ebase() & 0x3ff;
+	return read_c0_ebase() & MIPS_EBASE_CPUNUM;
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index c4038d2a724c..fd43f0afdb9f 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -505,7 +505,8 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_write_c0_guest_intctl(cop0, 0xFC000000);
 
 	/* Put in vcpu id as CPUNum into Ebase Reg to handle SMP Guests */
-	kvm_write_c0_guest_ebase(cop0, KVM_GUEST_KSEG0 | (vcpu_id & 0xFF));
+	kvm_write_c0_guest_ebase(cop0, KVM_GUEST_KSEG0 |
+				       (vcpu_id & MIPS_EBASE_CPUNUM));
 
 	return 0;
 }
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 80ec929747c3..25ee69489e5e 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -58,7 +58,7 @@ void nlm_node_init(int node)
 		nodep->coremask = 1;	/* node 0, boot cpu */
 	nodep->sysbase = nlm_get_sys_regbase(node);
 	nodep->picbase = nlm_get_pic_regbase(node);
-	nodep->ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	nodep->ebase = read_c0_ebase() & MIPS_EBASE_BASE;
 	if (cpu_is_xlp9xx())
 		nodep->socbus = xlp9xx_get_socbus(node);
 	else
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index d118b9aa7647..72ceddc9a03f 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -168,7 +168,7 @@ static void nlm_init_node(void)
 
 	nodep = nlm_current_node();
 	nodep->picbase = nlm_mmio_base(NETLOGIC_IO_PIC_OFFSET);
-	nodep->ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	nodep->ebase = read_c0_ebase() & MIPS_EBASE_BASE;
 	spin_lock_init(&nodep->piclock);
 }
 
-- 
2.4.10
