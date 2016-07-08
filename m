Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:55:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10903 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992773AbcGHKx6ORiSv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:53:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9995880E8137C;
        Fri,  8 Jul 2016 11:53:49 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 06/12] MIPS: KVM: Use 64-bit CP0_EBase when appropriate
Date:   Fri, 8 Jul 2016 11:53:25 +0100
Message-ID: <1467975211-12674-7-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54261
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

Update the KVM entry point to write CP0_EBase as a 64-bit register when
it is 64-bits wide, and to set the WG (write gate) bit if it exists in
order to write bits 63:30 (or 31:30 on MIPS32).

Prior to MIPS64r6 it was UNDEFINED to perform a 64-bit read or write of
a 32-bit COP0 register. Since this is dynamically generated code,
generate the right type of access depending on whether the kernel is
64-bit and cpu_has_ebase_wg.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index c824bfc4daa0..6a02b3a3fa65 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -153,6 +153,25 @@ static void kvm_mips_build_restore_scratch(u32 **p, unsigned int tmp,
 }
 
 /**
+ * build_set_exc_base() - Assemble code to write exception base address.
+ * @p:		Code buffer pointer.
+ * @reg:	Source register (generated code may set WG bit in @reg).
+ *
+ * Assemble code to modify the exception base address in the EBase register,
+ * using the appropriately sized access and setting the WG bit if necessary.
+ */
+static inline void build_set_exc_base(u32 **p, unsigned int reg)
+{
+	if (cpu_has_ebase_wg) {
+		/* Set WG so that all the bits get written */
+		uasm_i_ori(p, reg, reg, MIPS_EBASE_WG);
+		UASM_i_MTC0(p, reg, C0_EBASE);
+	} else {
+		uasm_i_mtc0(p, reg, C0_EBASE);
+	}
+}
+
+/**
  * kvm_mips_build_vcpu_run() - Assemble function to start running a guest VCPU.
  * @addr:	Address to start writing code.
  *
@@ -216,7 +235,7 @@ void *kvm_mips_build_vcpu_run(void *addr)
 
 	/* load up the new EBASE */
 	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
-	uasm_i_mtc0(&p, K0, C0_EBASE);
+	build_set_exc_base(&p, K0);
 
 	/*
 	 * Now that the new EBASE has been loaded, unset BEV, set
@@ -463,7 +482,7 @@ void *kvm_mips_build_exit(void *addr)
 
 	UASM_i_LA_mostly(&p, K0, (long)&ebase);
 	UASM_i_LW(&p, K0, uasm_rel_lo((long)&ebase), K0);
-	uasm_i_mtc0(&p, K0, C0_EBASE);
+	build_set_exc_base(&p, K0);
 
 	if (raw_cpu_has_fpu) {
 		/*
@@ -620,7 +639,7 @@ static void *kvm_mips_build_ret_to_guest(void *addr)
 	uasm_i_or(&p, K0, V1, AT);
 	uasm_i_mtc0(&p, K0, C0_STATUS);
 	uasm_i_ehb(&p);
-	uasm_i_mtc0(&p, T0, C0_EBASE);
+	build_set_exc_base(&p, T0);
 
 	/* Setup status register for running guest in UM */
 	uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
-- 
2.4.10
