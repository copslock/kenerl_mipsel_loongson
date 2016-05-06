Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:38:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18221 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028129AbcEFNgobQ21k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id B7820647CC847;
        Fri,  6 May 2016 14:36:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:36 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, James Hogan
        <james.hogan@imgtec.com>, Jayachandran C. <jchandra@broadcom.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=
        <rkrcmar@redhat.com>, <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 7/7] MIPS: Support extended ASIDs
Date:   Fri, 6 May 2016 14:36:24 +0100
Message-ID: <1462541784-22128-8-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53298
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

From: Paul Burton <paul.burton@imgtec.com>

Add support for extended ASIDs as determined by the Config4.AE bit.
Since the only supported CPUs known to implement this are Netlogic XLP
and MIPS I6400, select this variable ASID support based upon
CONFIG_CPU_XLP and CONFIG_CPU_MIPSR6.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jayachandran C. <jchandra@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/Kconfig                |  6 ++++++
 arch/mips/include/asm/cpu-info.h | 14 ++++++++++++++
 arch/mips/kernel/asm-offsets.c   | 10 ++++++++++
 arch/mips/kernel/cpu-probe.c     | 13 +++++++++++++
 arch/mips/kernel/genex.S         |  2 +-
 arch/mips/kvm/locore.S           | 14 ++++++++++++++
 6 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 132d1c68befc..55ca8fab4f4a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1673,6 +1673,7 @@ config CPU_XLP
 	select CPU_HAS_PREFETCH
 	select CPU_MIPSR2
 	select CPU_SUPPORTS_HUGEPAGES
+	select MIPS_ASID_BITS_VARIABLE
 	help
 	  Netlogic Microsystems XLP processors.
 endchoice
@@ -1966,6 +1967,7 @@ config CPU_MIPSR2
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_SPRAM
 
 config EVA
@@ -2409,9 +2411,13 @@ config MIPS_ASID_SHIFT
 
 config MIPS_ASID_BITS
 	int
+	default 0 if MIPS_ASID_BITS_VARIABLE
 	default 6 if CPU_R3000 || CPU_TX39XX
 	default 8
 
+config MIPS_ASID_BITS_VARIABLE
+	bool
+
 #
 # - Highmem only makes sense for the 32-bit kernel.
 # - The current highmem code will only work properly on physically indexed
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 4cb3cdadc41e..ed7fc82ed29f 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -40,6 +40,9 @@ struct cache_desc {
 
 struct cpuinfo_mips {
 	unsigned long		asid_cache;
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	unsigned long		asid_mask;
+#endif
 
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
@@ -138,7 +141,18 @@ static inline unsigned long cpu_asid_inc(void)
 
 static inline unsigned long cpu_asid_mask(struct cpuinfo_mips *cpuinfo)
 {
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	return cpuinfo->asid_mask;
+#endif
 	return ((1 << CONFIG_MIPS_ASID_BITS) - 1) << CONFIG_MIPS_ASID_SHIFT;
 }
 
+static inline void set_cpu_asid_mask(struct cpuinfo_mips *cpuinfo,
+				     unsigned long asid_mask)
+{
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	cpuinfo->asid_mask = asid_mask;
+#endif
+}
+
 #endif /* __ASM_CPU_INFO_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 154e2039ea5e..1ea973b2abb1 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/kbuild.h>
 #include <linux/suspend.h>
+#include <asm/cpu-info.h>
 #include <asm/pm.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -338,6 +339,15 @@ void output_pm_defines(void)
 }
 #endif
 
+void output_cpuinfo_defines(void)
+{
+	COMMENT(" MIPS cpuinfo offsets. ");
+	DEFINE(CPUINFO_SIZE, sizeof(struct cpuinfo_mips));
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	OFFSET(CPUINFO_ASID_MASK, cpuinfo_mips, asid_mask);
+#endif
+}
+
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specfic offsets. ");
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b713b9f8..fb3fd2d3e565 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -715,6 +715,7 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	unsigned int newcf4;
 	unsigned int mmuextdef;
 	unsigned int ftlb_page = MIPS_CONF4_FTLBPAGESIZE;
+	unsigned long asid_mask;
 
 	config4 = read_c0_config4();
 
@@ -775,6 +776,18 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 
 	c->kscratch_mask = (config4 >> 16) & 0xff;
 
+	asid_mask = MIPS_ENTRYHI_ASID;
+	if (config4 & MIPS_CONF4_AE)
+		asid_mask |= MIPS_ENTRYHI_ASIDX;
+	set_cpu_asid_mask(c, asid_mask);
+
+	/*
+	 * Warn if the computed ASID mask doesn't match the mask the kernel
+	 * is built for. This may indicate either a serious problem or an
+	 * easy optimisation opportunity, but either way should be addressed.
+	 */
+	WARN_ON(asid_mask != cpu_asid_mask(c));
+
 	return config4 & MIPS_CONF_M;
 }
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 17374aef6f00..bff9644b9ad1 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -455,7 +455,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	noreorder
 	/* check if TLB contains a entry for EPC */
 	MFC0	k1, CP0_ENTRYHI
-	andi	k1, MIPS_ENTRYHI_ASID
+	andi	k1, MIPS_ENTRYHI_ASID | MIPS_ENTRYHI_ASIDX
 	MFC0	k0, CP0_EPC
 	PTR_SRL k0, _PAGE_SHIFT + 1
 	PTR_SLL k0, _PAGE_SHIFT + 1
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 1f2167bc847d..3ef03009de5f 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -137,7 +137,14 @@ FEXPORT(__kvm_mips_load_asid)
 	INT_SLL	t2, t2, 2                   /* x4 */
 	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	li	t3, CPUINFO_SIZE/4
+	mul	t2, t2, t3		/* x sizeof(struct cpuinfo_mips)/4 */
+	LONG_L	t2, (cpu_data + CPUINFO_ASID_MASK)(t2)
+	and	k0, k0, t2
+#else
 	andi	k0, k0, MIPS_ENTRYHI_ASID
+#endif
 	mtc0	k0, CP0_ENTRYHI
 	ehb
 
@@ -449,7 +456,14 @@ __kvm_mips_return_to_guest:
 	INT_SLL	t2, t2, 2		/* x4 */
 	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
+#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
+	li	t3, CPUINFO_SIZE/4
+	mul	t2, t2, t3		/* x sizeof(struct cpuinfo_mips)/4 */
+	LONG_L	t2, (cpu_data + CPUINFO_ASID_MASK)(t2)
+	and	k0, k0, t2
+#else
 	andi	k0, k0, MIPS_ENTRYHI_ASID
+#endif
 	mtc0	k0, CP0_ENTRYHI
 	ehb
 
-- 
2.4.10
