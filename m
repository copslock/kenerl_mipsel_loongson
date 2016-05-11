Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 16:52:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48063 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029026AbcEKOu5ykGvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 16:50:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 9F2FC670074C5;
        Wed, 11 May 2016 15:50:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:50 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 4/6] MIPS: Add probing & defs for VZ & guest features
Date:   Wed, 11 May 2016 15:50:30 +0100
Message-ID: <1462978232-10670-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
References: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53379
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

Add a few new cpu-features.h definitions for VZ sub-features, namely the
existence of the CP0_GuestCtl0Ext, CP0_GuestCtl1, and CP0_GuestCtl2
registers, and support for GuestID to dialias TLB entries belonging to
different guests.

Also add certain features present in the guest, with the naming scheme
cpu_guest_has_*. These are added separately to the main options bitfield
since they generally parallel similar features in the root context. A
few of these (FPU, MSA, watchpoints, perf counters, CP0_[X]ContextConfig
registers, MAAR registers, and probably others in future) can be
dynamically configured in the guest context, for which the
cpu_guest_has_dyn_* macros are added.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h |  98 +++++++++++++++
 arch/mips/include/asm/cpu-info.h     |  14 +++
 arch/mips/include/asm/cpu.h          |   5 +
 arch/mips/kernel/cpu-probe.c         | 232 +++++++++++++++++++++++++++++++++++
 4 files changed, 349 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 7cf708b52349..e9cf89359012 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -120,6 +120,21 @@
 #ifndef kernel_uses_llsc
 #define kernel_uses_llsc	cpu_has_llsc
 #endif
+#ifndef cpu_has_guestctl0ext
+#define cpu_has_guestctl0ext	(cpu_data[0].options & MIPS_CPU_GUESTCTL0EXT)
+#endif
+#ifndef cpu_has_guestctl1
+#define cpu_has_guestctl1	(cpu_data[0].options & MIPS_CPU_GUESTCTL1)
+#endif
+#ifndef cpu_has_guestctl2
+#define cpu_has_guestctl2	(cpu_data[0].options & MIPS_CPU_GUESTCTL2)
+#endif
+#ifndef cpu_has_guestid
+#define cpu_has_guestid		(cpu_data[0].options & MIPS_CPU_GUESTID)
+#endif
+#ifndef cpu_has_drg
+#define cpu_has_drg		(cpu_data[0].options & MIPS_CPU_DRG)
+#endif
 #ifndef cpu_has_mips16
 #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
 #endif
@@ -452,4 +467,87 @@
 # define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
 #endif
 
+/*
+ * Guest capabilities
+ */
+#ifndef cpu_guest_has_conf1
+#define cpu_guest_has_conf1	(cpu_data[0].guest.conf & (1 << 1))
+#endif
+#ifndef cpu_guest_has_conf2
+#define cpu_guest_has_conf2	(cpu_data[0].guest.conf & (1 << 2))
+#endif
+#ifndef cpu_guest_has_conf3
+#define cpu_guest_has_conf3	(cpu_data[0].guest.conf & (1 << 3))
+#endif
+#ifndef cpu_guest_has_conf4
+#define cpu_guest_has_conf4	(cpu_data[0].guest.conf & (1 << 4))
+#endif
+#ifndef cpu_guest_has_conf5
+#define cpu_guest_has_conf5	(cpu_data[0].guest.conf & (1 << 5))
+#endif
+#ifndef cpu_guest_has_conf6
+#define cpu_guest_has_conf6	(cpu_data[0].guest.conf & (1 << 6))
+#endif
+#ifndef cpu_guest_has_conf7
+#define cpu_guest_has_conf7	(cpu_data[0].guest.conf & (1 << 7))
+#endif
+#ifndef cpu_guest_has_fpu
+#define cpu_guest_has_fpu	(cpu_data[0].guest.options & MIPS_CPU_FPU)
+#endif
+#ifndef cpu_guest_has_watch
+#define cpu_guest_has_watch	(cpu_data[0].guest.options & MIPS_CPU_WATCH)
+#endif
+#ifndef cpu_guest_has_contextconfig
+#define cpu_guest_has_contextconfig (cpu_data[0].guest.options & MIPS_CPU_CTXTC)
+#endif
+#ifndef cpu_guest_has_segments
+#define cpu_guest_has_segments	(cpu_data[0].guest.options & MIPS_CPU_SEGMENTS)
+#endif
+#ifndef cpu_guest_has_badinstr
+#define cpu_guest_has_badinstr	(cpu_data[0].guest.options & MIPS_CPU_BADINSTR)
+#endif
+#ifndef cpu_guest_has_badinstrp
+#define cpu_guest_has_badinstrp	(cpu_data[0].guest.options & MIPS_CPU_BADINSTRP)
+#endif
+#ifndef cpu_guest_has_htw
+#define cpu_guest_has_htw	(cpu_data[0].guest.options & MIPS_CPU_HTW)
+#endif
+#ifndef cpu_guest_has_msa
+#define cpu_guest_has_msa	(cpu_data[0].guest.ases & MIPS_ASE_MSA)
+#endif
+#ifndef cpu_guest_has_kscr
+#define cpu_guest_has_kscr(n)	(cpu_data[0].guest.kscratch_mask & (1u << (n)))
+#endif
+#ifndef cpu_guest_has_rw_llb
+#define cpu_guest_has_rw_llb	(cpu_has_mips_r6 || (cpu_data[0].guest.options & MIPS_CPU_RW_LLB))
+#endif
+#ifndef cpu_guest_has_perf
+#define cpu_guest_has_perf	(cpu_data[0].guest.options & MIPS_CPU_PERF)
+#endif
+#ifndef cpu_guest_has_maar
+#define cpu_guest_has_maar	(cpu_data[0].guest.options & MIPS_CPU_MAAR)
+#endif
+
+/*
+ * Guest dynamic capabilities
+ */
+#ifndef cpu_guest_has_dyn_fpu
+#define cpu_guest_has_dyn_fpu	(cpu_data[0].guest.options_dyn & MIPS_CPU_FPU)
+#endif
+#ifndef cpu_guest_has_dyn_watch
+#define cpu_guest_has_dyn_watch	(cpu_data[0].guest.options_dyn & MIPS_CPU_WATCH)
+#endif
+#ifndef cpu_guest_has_dyn_contextconfig
+#define cpu_guest_has_dyn_contextconfig (cpu_data[0].guest.options_dyn & MIPS_CPU_CTXTC)
+#endif
+#ifndef cpu_guest_has_dyn_perf
+#define cpu_guest_has_dyn_perf	(cpu_data[0].guest.options_dyn & MIPS_CPU_PERF)
+#endif
+#ifndef cpu_guest_has_dyn_msa
+#define cpu_guest_has_dyn_msa	(cpu_data[0].guest.ases_dyn & MIPS_ASE_MSA)
+#endif
+#ifndef cpu_guest_has_dyn_maar
+#define cpu_guest_has_dyn_maar	(cpu_data[0].guest.options_dyn & MIPS_CPU_MAAR)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 392da7e6fc72..edbe2734a1bf 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -28,6 +28,15 @@ struct cache_desc {
 	unsigned char flags;	/* Flags describing cache properties */
 };
 
+struct guest_info {
+	unsigned long		ases;
+	unsigned long		ases_dyn;
+	unsigned long long	options;
+	unsigned long long	options_dyn;
+	u8			conf;
+	u8			kscratch_mask;
+};
+
 /*
  * Flag definitions
  */
@@ -95,6 +104,11 @@ struct cpuinfo_mips {
 	 * htw_start/htw_stop calls
 	 */
 	unsigned int		htw_seq;
+
+	/* VZ & Guest features */
+	struct guest_info	guest;
+	unsigned int		gtoffset_mask;
+	unsigned int		guestid_mask;
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3a4499660416..3a2ef95ca16a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -408,6 +408,11 @@ enum cpu_type_enum {
 #define MIPS_CPU_BADINSTRP	MBIT_ULL(44)	/* CPU has BadInstrP register */
 #define MIPS_CPU_CTXTC		MBIT_ULL(45)	/* CPU has [X]ConfigContext registers */
 #define MIPS_CPU_PERF		MBIT_ULL(46)	/* CPU has MIPS performance counters */
+#define MIPS_CPU_GUESTCTL0EXT	MBIT_ULL(47)	/* CPU has VZ GuestCtl0Ext register */
+#define MIPS_CPU_GUESTCTL1	MBIT_ULL(48)	/* CPU has VZ GuestCtl1 register */
+#define MIPS_CPU_GUESTCTL2	MBIT_ULL(49)	/* CPU has VZ GuestCtl2 register */
+#define MIPS_CPU_GUESTID	MBIT_ULL(50)	/* CPU uses VZ ASE GuestID feature */
+#define MIPS_CPU_DRG		MBIT_ULL(51)	/* CPU has VZ Direct Root to Guest (DRG) */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6a9a55444f38..e9d14f0deac3 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -913,6 +913,235 @@ static void decode_configs(struct cpuinfo_mips *c)
 #endif
 }
 
+/*
+ * Probe for certain guest capabilities by writing config bits and reading back.
+ * Finally write back the original value.
+ */
+#define probe_gc0_config(name, maxconf, bits)				\
+do {									\
+	unsigned int tmp;						\
+	tmp = read_gc0_##name();					\
+	write_gc0_##name(tmp | (bits));					\
+	back_to_back_c0_hazard();					\
+	maxconf = read_gc0_##name();					\
+	write_gc0_##name(tmp);						\
+} while (0)
+
+/*
+ * Probe for dynamic guest capabilities by changing certain config bits and
+ * reading back to see if they change. Finally write back the original value.
+ */
+#define probe_gc0_config_dyn(name, maxconf, dynconf, bits)		\
+do {									\
+	maxconf = read_gc0_##name();					\
+	write_gc0_##name(maxconf ^ (bits));				\
+	back_to_back_c0_hazard();					\
+	dynconf = maxconf ^ read_gc0_##name();				\
+	write_gc0_##name(maxconf);					\
+	maxconf |= dynconf;						\
+} while (0)
+
+static inline unsigned int decode_guest_config0(struct cpuinfo_mips *c)
+{
+	unsigned int config0;
+
+	probe_gc0_config(config, config0, MIPS_CONF_M);
+
+	if (config0 & MIPS_CONF_M)
+		c->guest.conf |= BIT(1);
+	return config0 & MIPS_CONF_M;
+}
+
+static inline unsigned int decode_guest_config1(struct cpuinfo_mips *c)
+{
+	unsigned int config1, config1_dyn;
+
+	probe_gc0_config_dyn(config1, config1, config1_dyn,
+			     MIPS_CONF_M | MIPS_CONF1_PC | MIPS_CONF1_WR |
+			     MIPS_CONF1_FP);
+
+	if (config1 & MIPS_CONF1_FP)
+		c->guest.options |= MIPS_CPU_FPU;
+	if (config1_dyn & MIPS_CONF1_FP)
+		c->guest.options_dyn |= MIPS_CPU_FPU;
+
+	if (config1 & MIPS_CONF1_WR)
+		c->guest.options |= MIPS_CPU_WATCH;
+	if (config1_dyn & MIPS_CONF1_WR)
+		c->guest.options_dyn |= MIPS_CPU_WATCH;
+
+	if (config1 & MIPS_CONF1_PC)
+		c->guest.options |= MIPS_CPU_PERF;
+	if (config1_dyn & MIPS_CONF1_PC)
+		c->guest.options_dyn |= MIPS_CPU_PERF;
+
+	if (config1 & MIPS_CONF_M)
+		c->guest.conf |= BIT(2);
+	return config1 & MIPS_CONF_M;
+}
+
+static inline unsigned int decode_guest_config2(struct cpuinfo_mips *c)
+{
+	unsigned int config2;
+
+	probe_gc0_config(config2, config2, MIPS_CONF_M);
+
+	if (config2 & MIPS_CONF_M)
+		c->guest.conf |= BIT(3);
+	return config2 & MIPS_CONF_M;
+}
+
+static inline unsigned int decode_guest_config3(struct cpuinfo_mips *c)
+{
+	unsigned int config3, config3_dyn;
+
+	probe_gc0_config_dyn(config3, config3, config3_dyn,
+			     MIPS_CONF_M | MIPS_CONF3_MSA | MIPS_CONF3_CTXTC);
+
+	if (config3 & MIPS_CONF3_CTXTC)
+		c->guest.options |= MIPS_CPU_CTXTC;
+	if (config3_dyn & MIPS_CONF3_CTXTC)
+		c->guest.options_dyn |= MIPS_CPU_CTXTC;
+
+	if (config3 & MIPS_CONF3_PW)
+		c->guest.options |= MIPS_CPU_HTW;
+
+	if (config3 & MIPS_CONF3_SC)
+		c->guest.options |= MIPS_CPU_SEGMENTS;
+
+	if (config3 & MIPS_CONF3_BI)
+		c->guest.options |= MIPS_CPU_BADINSTR;
+	if (config3 & MIPS_CONF3_BP)
+		c->guest.options |= MIPS_CPU_BADINSTRP;
+
+	if (config3 & MIPS_CONF3_MSA)
+		c->guest.ases |= MIPS_ASE_MSA;
+	if (config3_dyn & MIPS_CONF3_MSA)
+		c->guest.ases_dyn |= MIPS_ASE_MSA;
+
+	if (config3 & MIPS_CONF_M)
+		c->guest.conf |= BIT(4);
+	return config3 & MIPS_CONF_M;
+}
+
+static inline unsigned int decode_guest_config4(struct cpuinfo_mips *c)
+{
+	unsigned int config4;
+
+	probe_gc0_config(config4, config4,
+			 MIPS_CONF_M | MIPS_CONF4_KSCREXIST);
+
+	c->guest.kscratch_mask = (config4 & MIPS_CONF4_KSCREXIST)
+				>> MIPS_CONF4_KSCREXIST_SHIFT;
+
+	if (config4 & MIPS_CONF_M)
+		c->guest.conf |= BIT(5);
+	return config4 & MIPS_CONF_M;
+}
+
+static inline unsigned int decode_guest_config5(struct cpuinfo_mips *c)
+{
+	unsigned int config5, config5_dyn;
+
+	probe_gc0_config_dyn(config5, config5, config5_dyn,
+			 MIPS_CONF_M | MIPS_CONF5_MRP);
+
+	if (config5 & MIPS_CONF5_MRP)
+		c->guest.options |= MIPS_CPU_MAAR;
+	if (config5_dyn & MIPS_CONF5_MRP)
+		c->guest.options_dyn |= MIPS_CPU_MAAR;
+
+	if (config5 & MIPS_CONF5_LLB)
+		c->guest.options |= MIPS_CPU_RW_LLB;
+
+	if (config5 & MIPS_CONF_M)
+		c->guest.conf |= BIT(6);
+	return config5 & MIPS_CONF_M;
+}
+
+static inline void decode_guest_configs(struct cpuinfo_mips *c)
+{
+	unsigned int ok;
+
+	ok = decode_guest_config0(c);
+	if (ok)
+		ok = decode_guest_config1(c);
+	if (ok)
+		ok = decode_guest_config2(c);
+	if (ok)
+		ok = decode_guest_config3(c);
+	if (ok)
+		ok = decode_guest_config4(c);
+	if (ok)
+		decode_guest_config5(c);
+}
+
+static inline void cpu_probe_guestctl0(struct cpuinfo_mips *c)
+{
+	unsigned int guestctl0, temp;
+
+	guestctl0 = read_c0_guestctl0();
+
+	if (guestctl0 & MIPS_GCTL0_G0E)
+		c->options |= MIPS_CPU_GUESTCTL0EXT;
+	if (guestctl0 & MIPS_GCTL0_G1)
+		c->options |= MIPS_CPU_GUESTCTL1;
+	if (guestctl0 & MIPS_GCTL0_G2)
+		c->options |= MIPS_CPU_GUESTCTL2;
+	if (!(guestctl0 & MIPS_GCTL0_RAD)) {
+		c->options |= MIPS_CPU_GUESTID;
+
+		/*
+		 * Probe for Direct Root to Guest (DRG). Set GuestCtl1.RID = 0
+		 * first, otherwise all data accesses will be fully virtualised
+		 * as if they were performed by guest mode.
+		 */
+		write_c0_guestctl1(0);
+		tlbw_use_hazard();
+
+		write_c0_guestctl0(guestctl0 | MIPS_GCTL0_DRG);
+		back_to_back_c0_hazard();
+		temp = read_c0_guestctl0();
+
+		if (temp & MIPS_GCTL0_DRG) {
+			write_c0_guestctl0(guestctl0);
+			c->options |= MIPS_CPU_DRG;
+		}
+	}
+}
+
+static inline void cpu_probe_guestctl1(struct cpuinfo_mips *c)
+{
+	if (cpu_has_guestid) {
+		/* determine the number of bits of GuestID available */
+		write_c0_guestctl1(MIPS_GCTL1_ID);
+		back_to_back_c0_hazard();
+		c->guestid_mask = (read_c0_guestctl1() & MIPS_GCTL1_ID)
+						>> MIPS_GCTL1_ID_SHIFT;
+		write_c0_guestctl1(0);
+	}
+}
+
+static inline void cpu_probe_gtoffset(struct cpuinfo_mips *c)
+{
+	/* determine the number of bits of GTOffset available */
+	write_c0_gtoffset(0xffffffff);
+	back_to_back_c0_hazard();
+	c->gtoffset_mask = read_c0_gtoffset();
+	write_c0_gtoffset(0);
+}
+
+static inline void cpu_probe_vz(struct cpuinfo_mips *c)
+{
+	cpu_probe_guestctl0(c);
+	if (cpu_has_guestctl1)
+		cpu_probe_guestctl1(c);
+
+	cpu_probe_gtoffset(c);
+
+	decode_guest_configs(c);
+}
+
 #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
 		| MIPS_CPU_COUNTER)
 
@@ -1815,6 +2044,9 @@ void cpu_probe(void)
 		elf_hwcap |= HWCAP_MIPS_MSA;
 	}
 
+	if (cpu_has_vz)
+		cpu_probe_vz(c);
+
 	cpu_probe_vmbits(c);
 
 #ifdef CONFIG_64BIT
-- 
2.4.10
