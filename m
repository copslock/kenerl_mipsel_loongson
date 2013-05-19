Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:50:05 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:46448 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835025Ab3ESFsQVUi5o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:16 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:07 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 3313C63005F; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 07/18] KVM/MIPS32: VZ-ASE related CPU feature flags and options.
Date:   Sat, 18 May 2013 22:47:29 -0700
Message-Id: <1368942460-15577-8-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

- GuestIDs and Virtual IRQs are optional
- New TLBINV instruction is also optional

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/cpu-features.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-info.h     | 21 +++++++++++++++++++++
 arch/mips/include/asm/cpu.h          |  5 +++++
 3 files changed, 62 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e5ec8fc..11c8fb8 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -83,6 +83,17 @@
 #ifndef kernel_uses_llsc
 #define kernel_uses_llsc	cpu_has_llsc
 #endif
+#ifdef CONFIG_KVM_MIPS_VZ
+#ifndef cpu_has_vzguestid
+#define cpu_has_vzguestid	(cpu_data[0].options & MIPS_CPU_VZGUESTID)
+#endif
+#ifndef cpu_has_vzvirtirq
+#define cpu_has_vzvirtirq	(cpu_data[0].options & MIPS_CPU_VZVIRTIRQ)
+#endif
+#ifndef cpu_has_tlbinv
+#define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
+#endif
+#endif /* CONFIG_KVM_MIPS_VZ */
 #ifndef cpu_has_mips16
 #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
 #endif
@@ -198,6 +209,31 @@
 #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
 #endif
 
+#ifndef cpu_has_vz
+#ifdef CONFIG_KVM_MIPS_VZ
+#define cpu_has_vz  		(cpu_data[0].ases & MIPS_ASE_VZ)
+#else
+#define cpu_has_vz		(0)
+#endif
+#define cpu_vz_config0		(cpu_data[0].vz.config0)
+#define cpu_vz_config1		(cpu_data[0].vz.config1)
+#define cpu_vz_config2		(cpu_data[0].vz.config2)
+#define cpu_vz_config3		(cpu_data[0].vz.config3)
+#define cpu_vz_config4		(cpu_data[0].vz.config4)
+#define cpu_vz_config5		(cpu_data[0].vz.config5)
+#define cpu_vz_config6		(cpu_data[0].vz.config6)
+#define cpu_vz_config7		(cpu_data[0].vz.config7)
+
+#define cpu_vz_has_tlb		(cpu_data[0].vz.options & MIPS_CPU_TLB)
+#define cpu_vz_has_config1	(cpu_data[0].vz.config0 & MIPS_CONF_M)
+#define cpu_vz_has_config2	(cpu_data[0].vz.config1 & MIPS_CONF_M)
+#define cpu_vz_has_config3	(cpu_data[0].vz.config2 & MIPS_CONF_M)
+#define cpu_vz_has_config4	(cpu_data[0].vz.config3 & MIPS_CONF_M)
+#define cpu_vz_has_config5	(cpu_data[0].vz.config4 & MIPS_CONF_M)
+#define cpu_vz_has_config6	(0)
+#define cpu_vz_has_config7	(1)
+#endif
+
 #ifndef cpu_has_userlocal
 #define cpu_has_userlocal	(cpu_data[0].options & MIPS_CPU_ULRI)
 #endif
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 41401d8..70d104c 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -28,6 +28,24 @@ struct cache_desc {
 	unsigned char flags;	/* Flags describing cache properties */
 };
 
+#ifdef CONFIG_KVM_MIPS_VZ
+/*
+ * initial VZ ASE configuration
+ */
+struct vzase_info {
+	unsigned long		options;
+	int			tlbsize;
+	unsigned long		config0;
+	unsigned long		config1;
+	unsigned long		config2;
+	unsigned long		config3;
+	unsigned long		config4;
+	unsigned long		config5;
+	unsigned long		config6;
+	unsigned long		config7;
+};
+#endif
+
 /*
  * Flag definitions
  */
@@ -79,6 +97,9 @@ struct cpuinfo_mips {
 #define NUM_WATCH_REGS 4
 	u16			watch_reg_masks[NUM_WATCH_REGS];
 	unsigned int		kscratch_mask; /* Usable KScratch mask. */
+#ifdef CONFIG_KVM_MIPS_VZ
+	struct vzase_info	vz;
+#endif
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dd86ab2..6836320 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -325,6 +325,11 @@ enum cpu_type_enum {
 #define MIPS_CPU_PCI		0x00400000 /* CPU has Perf Ctr Int indicator */
 #define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
+#ifdef CONFIG_KVM_MIPS_VZ
+#define MIPS_CPU_VZGUESTID	0x02000000 /* CPU uses VZ ASE GuestID feature */
+#define MIPS_CPU_VZVIRTIRQ	0x04000000 /* CPU has VZ ASE virtual interrupt feature */
+#define MIPS_CPU_TLBINV		0x08000000 /* CPU has TLB invalidate instruction */
+#endif
 
 /*
  * CPU ASE encodings
-- 
1.7.11.3
