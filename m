Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EEFC282DA
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75320857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="q5I/kVWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfBBBn6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:58 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfBBBn6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OopQOQBwU/7u5iSF4jJ9D5u7ubrPA2J7vBsy102Ejoc=;
 b=q5I/kVWZS1Q3DSNMjzjJwT4qcs/NiSHXWPzFf7bSmUKp89F5PFMP0usk6vg31oQ0Ev1HJ+7KdcKXtQXbfvQRFovbNWM49XTUotKN8xPr6r1Gr2GbMAUfil0BHyIvVoDQ0hu5VhtMGVC20PeFIhN0w8RmV2/pM0far1jX837RqW0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 14/14] MIPS: MemoryMapID (MMID) Support
Thread-Topic: [PATCH 14/14] MIPS: MemoryMapID (MMID) Support
Thread-Index: AQHUupiywx4/gueQGUC4WTD4p7yoZg==
Date:   Sat, 2 Feb 2019 01:43:28 +0000
Message-ID: <20190202014242.30680-15-paul.burton@mips.com>
References: <20190202014242.30680-1-paul.burton@mips.com>
In-Reply-To: <20190202014242.30680-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:X+XKIBg46xHoj5K6LlnrhYu7SEyKUz0heihnmgPmy+45bFEL1x1FIani7aZZaDHmOsv+P4+C9dG77sGMEsffIuVadwpx/NCxhciSdCdN7s93DfO97WozMuRQf5Lt2UG/gCJbqIOCbawikp4lqrPkH0SgK0oVVsjwfeI2+0Bf3kPlzU9rCpcyIeRHw81S8DrDoT5jjmM+k3J/gHk8SGDLlAymQ6ZqWb073xT6Evt+UtLOsLGEyRicEASIn6fOO7TgoYhCaFsVS4wptAmdauM4lqoO9+gpbaV50E7r9YnN0lwXOATpCMDHqAQ91flWorU5tVY028vqXFBCWNcEPKf1KN+mf47ClABjowYwpWV0C+3GVX9xrbOr1/385P7LRMUA8hxHj06PQuY4rQR5N4zyol5aOi9CfmeiuGh8EPxk31+dDwZWChfMMGzeSo+yYRPH3dPJlMDTQqZIACkRYfnqNA==;5:vfxQxuwifdo27xssks6C2Lz+8B71Sb2KSQIuiZzxNULYaJDkGW3jToXP5+x/Pq3HewrisEdk+e0zfnABtaJ9tYCwuHqRX8pnf8NOHAOJ+8td3QSBd5zt0tfF+P3ylLTSBCH4WAml3jWSa/nPdkJ/LPqPZP6M1M3M2tGPTf2DaxNMg64T4WCoBOCFoyN1FtfZaWnUF9KFDtuQn9EzbwgZ5w==;7:x05S9LYWjr+dVUqjFAeIPrf8vD28b/bUFcP2WpGIUi8d4cUP9cHV74k4bsfFbqO7HrOtQq05QQYP/GtKvUbGldYVwhXh/FZvr5saopFHJ5v0bok20ryJ/ZfuOIpdFjJTNvro6cUsDEYcfj4ueAzZYA==
x-ms-office365-filtering-correlation-id: 7827f1c9-b8f1-49f6-bc92-08d688afd429
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB14390CEA022C9C8A465A708EC1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(30864003)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(53946003)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002)(87944003)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ipuTyS6hw8qN5s+ftzHIL/mAaMq03vKAU9fuhQ+nkDYrmirH1srEUz6QpRslrKoV592Ml7L4FYfrW5iq++GODhuAmTu+lrAPt9xwCGgwRmNmXbQ3WLu1VukhsJbA51Tmrp7KGM1fluAlOWtIC2weCpiZYelkuEsXQZDVNhVB1vFvT5O/sKTH03KL7lMmHQqfz9nAvMTboX+HOqzF11DX2GoRF19G14oQWchHPvv591JfLC2Y8viyiAgy8ltYO4yGNa9fLrLaBCs4kTUJTSMS8jOWlM6aKxlI+obDRLDiIlya6l8C7lr+x/idXBnLyzNfSOMk5V2wb7Bmw6xdnQYAhyeYSmY2KuG3vcecbmYSYNktezgcO30r4KYZE5BxzOnmQKEh7gkoZxOtCHO7lj43kBmIVjrO9hVlLKcL1KQXM4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7827f1c9-b8f1-49f6-bc92-08d688afd429
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:27.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Introduce support for using MemoryMapIDs (MMIDs) as an alternative to
Address Space IDs (ASIDs). The major difference between the two is that
MMIDs are global - ie. an MMID uniquely identifies an address space
across all coherent CPUs. In contrast ASIDs are non-global per-CPU IDs,
wherein each address space is allocated a separate ASID for each CPU
upon which it is used. This global namespace allows a new GINVT
instruction be used to globally invalidate TLB entries associated with a
particular MMID across all coherent CPUs in the system, removing the
need for IPIs to invalidate entries with separate ASIDs on each CPU.

The allocation scheme used here is largely borrowed from arm64 (see
arch/arm64/mm/context.c). In essence we maintain a bitmap to track
available MMIDs, and MMIDs in active use at the time of a rollover to a
new MMID version are preserved in the new version. The allocation scheme
requires efficient 64 bit atomics in order to perform reasonably, so
this support depends upon CONFIG_GENERIC_ATOMIC64=3Dn (ie. currently it
will only be included in MIPS64 kernels).

The first, and currently only, available CPU with support for MMIDs is
the MIPS I6500. This CPU supports 16 bit MMIDs, and so for now we cap
our MMIDs to 16 bits wide in order to prevent the bitmap growing to
absurd sizes if any future CPU does implement 32 bit MMIDs as the
architecture manuals suggest is recommended.

When MMIDs are in use we also make use of GINVT instruction which is
available due to the global nature of MMIDs. By executing a sequence of
GINVT & SYNC 0x14 instructions we can avoid the overhead of an IPI to
each remote CPU in many cases. One complication is that GINVT will
invalidate wired entries (in all cases apart from type 0, which targets
the entire TLB). In order to avoid GINVT invalidating any wired TLB
entries we set up, we make sure to create those entries using a reserved
MMID (0) that we never associate with any address space.

Also of note is that KVM will require further work in order to support
MMIDs & GINVT, since KVM is involved in allocating IDs for guests & in
configuring the MMU. That work is not part of this patch, so for now
when MMIDs are in use KVM is disabled.

Signed-off-by: Paul Burton <paul.burton@mips.com>

---

 arch/mips/include/asm/cpu-features.h |  13 ++
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mipsregs.h     |   4 +
 arch/mips/include/asm/mmu.h          |   6 +-
 arch/mips/include/asm/mmu_context.h  |  54 +++++-
 arch/mips/kernel/cpu-probe.c         |  55 +++++-
 arch/mips/kernel/smp.c               |  57 +++++-
 arch/mips/kernel/traps.c             |   4 +-
 arch/mips/kernel/unaligned.c         |   1 +
 arch/mips/kvm/mips.c                 |   5 +
 arch/mips/lib/dump_tlb.c             |  22 ++-
 arch/mips/mm/c-r4k.c                 |   3 +
 arch/mips/mm/context.c               | 256 ++++++++++++++++++++++++++-
 arch/mips/mm/init.c                  |   7 +
 arch/mips/mm/tlb-r4k.c               |  52 ++++--
 15 files changed, 509 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/c=
pu-features.h
index 701e525641b8..6998a9796499 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -590,6 +590,19 @@
 # define cpu_has_mipsmt_pertccounters 0
 #endif /* CONFIG_MIPS_MT_SMP */
=20
+/*
+ * We only enable MMID support for configurations which natively support 6=
4 bit
+ * atomics because getting good performance from the allocator relies upon
+ * efficient atomic64_*() functions.
+ */
+#ifndef cpu_has_mmid
+# ifdef CONFIG_GENERIC_ATOMIC64
+#  define cpu_has_mmid		0
+# else
+#  define cpu_has_mmid		__isa_ge_and_opt(6, MIPS_CPU_MMID)
+# endif
+#endif
+
 /*
  * Guest capabilities
  */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 532b49b1dbb3..6ad7d3cabd91 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -422,6 +422,7 @@ enum cpu_type_enum {
 				MBIT_ULL(55)	/* CPU shares FTLB entries with another */
 #define MIPS_CPU_MT_PER_TC_PERF_COUNTERS \
 				MBIT_ULL(56)	/* CPU has perf counters implemented per TC (MIPSMT ASE) =
*/
+#define MIPS_CPU_MMID		MBIT_ULL(57)	/* CPU supports MemoryMapIDs */
=20
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsr=
egs.h
index 900a47581dd1..1e6966e8527e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -667,6 +667,7 @@
 #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
 #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
 #define MIPS_CONF5_CA2		(_ULCAST_(1) << 14)
+#define MIPS_CONF5_MI		(_ULCAST_(1) << 17)
 #define MIPS_CONF5_CRCP		(_ULCAST_(1) << 18)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
 #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
@@ -1610,6 +1611,9 @@ do {									\
 #define read_c0_xcontextconfig()	__read_ulong_c0_register($4, 3)
 #define write_c0_xcontextconfig(val)	__write_ulong_c0_register($4, 3, val)
=20
+#define read_c0_memorymapid()		__read_32bit_c0_register($4, 5)
+#define write_c0_memorymapid(val)	__write_32bit_c0_register($4, 5, val)
+
 #define read_c0_pagemask()	__read_32bit_c0_register($5, 0)
 #define write_c0_pagemask(val)	__write_32bit_c0_register($5, 0, val)
=20
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index 88a108ce62c1..5df0238f639b 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -7,7 +7,11 @@
 #include <linux/wait.h>
=20
 typedef struct {
-	u64 asid[NR_CPUS];
+	union {
+		u64 asid[NR_CPUS];
+		atomic64_t mmid;
+	};
+
 	void *vdso;
=20
 	/* lock to be held whilst modifying fp_bd_emupage_allocmap */
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index a0f29df8ced8..cddead91acd4 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -17,8 +17,10 @@
 #include <linux/smp.h>
 #include <linux/slab.h>
=20
+#include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/dsemul.h>
+#include <asm/ginvt.h>
 #include <asm/hazards.h>
 #include <asm/tlbflush.h>
 #include <asm-generic/mm_hooks.h>
@@ -72,6 +74,19 @@ extern unsigned long pgd_current[];
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
=20
+/*
+ * The ginvt instruction will invalidate wired entries when its type field
+ * targets anything other than the entire TLB. That means that if we were =
to
+ * allow the kernel to create wired entries with the MMID of current->acti=
ve_mm
+ * then those wired entries could be invalidated when we later use ginvt t=
o
+ * invalidate TLB entries with that MMID.
+ *
+ * In order to prevent ginvt from trashing wired entries, we reserve one M=
MID
+ * for use by the kernel when creating wired entries. This MMID will never=
 be
+ * assigned to a struct mm, and we'll never target it with a ginvt instruc=
tion.
+ */
+#define MMID_KERNEL_WIRED	0
+
 /*
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
@@ -90,13 +105,19 @@ static inline u64 asid_first_version(unsigned int cpu)
=20
 static inline u64 cpu_context(unsigned int cpu, const struct mm_struct *mm=
)
 {
+	if (cpu_has_mmid)
+		return atomic64_read(&mm->context.mmid);
+
 	return mm->context.asid[cpu];
 }
=20
 static inline void set_cpu_context(unsigned int cpu,
 				   struct mm_struct *mm, u64 ctx)
 {
-	mm->context.asid[cpu] =3D ctx;
+	if (cpu_has_mmid)
+		atomic64_set(&mm->context.mmid, ctx);
+	else
+		mm->context.asid[cpu] =3D ctx;
 }
=20
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
@@ -120,8 +141,12 @@ init_new_context(struct task_struct *tsk, struct mm_st=
ruct *mm)
 {
 	int i;
=20
-	for_each_possible_cpu(i)
-		set_cpu_context(i, mm, 0);
+	if (cpu_has_mmid) {
+		set_cpu_context(0, mm, 0);
+	} else {
+		for_each_possible_cpu(i)
+			set_cpu_context(i, mm, 0);
+	}
=20
 	mm->context.bd_emupage_allocmap =3D NULL;
 	spin_lock_init(&mm->context.bd_emupage_lock);
@@ -168,12 +193,33 @@ drop_mmu_context(struct mm_struct *mm)
 {
 	unsigned long flags;
 	unsigned int cpu;
+	u32 old_mmid;
+	u64 ctx;
=20
 	local_irq_save(flags);
=20
 	cpu =3D smp_processor_id();
-	if (!cpu_context(cpu, mm)) {
+	ctx =3D cpu_context(cpu, mm);
+
+	if (!ctx) {
 		/* no-op */
+	} else if (cpu_has_mmid) {
+		/*
+		 * Globally invalidating TLB entries associated with the MMID
+		 * is pretty cheap using the GINVT instruction, so we'll do
+		 * that rather than incur the overhead of allocating a new
+		 * MMID. The latter would be especially difficult since MMIDs
+		 * are global & other CPUs may be actively using ctx.
+		 */
+		htw_stop();
+		old_mmid =3D read_c0_memorymapid();
+		write_c0_memorymapid(ctx & cpu_asid_mask(&cpu_data[cpu]));
+		mtc0_tlbw_hazard();
+		ginvt_mmid();
+		sync_ginv();
+		write_c0_memorymapid(old_mmid);
+		instruction_hazard();
+		htw_start();
 	} else if (cpumask_test_cpu(cpu, mm_cpumask(mm))) {
 		/*
 		 * mm is currently active, so we can't really drop it.
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 95b18a194f53..d5e335e6846a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -872,10 +872,19 @@ static inline unsigned int decode_config4(struct cpui=
nfo_mips *c)
=20
 static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 {
-	unsigned int config5;
+	unsigned int config5, max_mmid_width;
+	unsigned long asid_mask;
=20
 	config5 =3D read_c0_config5();
 	config5 &=3D ~(MIPS_CONF5_UFR | MIPS_CONF5_UFE);
+
+	if (cpu_has_mips_r6) {
+		if (!__builtin_constant_p(cpu_has_mmid) || cpu_has_mmid)
+			config5 |=3D MIPS_CONF5_MI;
+		else
+			config5 &=3D ~MIPS_CONF5_MI;
+	}
+
 	write_c0_config5(config5);
=20
 	if (config5 & MIPS_CONF5_EVA)
@@ -894,6 +903,50 @@ static inline unsigned int decode_config5(struct cpuin=
fo_mips *c)
 	if (config5 & MIPS_CONF5_CRCP)
 		elf_hwcap |=3D HWCAP_MIPS_CRC32;
=20
+	if (cpu_has_mips_r6) {
+		/* Ensure the write to config5 above takes effect */
+		back_to_back_c0_hazard();
+
+		/* Check whether we successfully enabled MMID support */
+		config5 =3D read_c0_config5();
+		if (config5 & MIPS_CONF5_MI)
+			c->options |=3D MIPS_CPU_MMID;
+
+		/*
+		 * Warn if we've hardcoded cpu_has_mmid to a value unsuitable
+		 * for the CPU we're running on, or if CPUs in an SMP system
+		 * have inconsistent MMID support.
+		 */
+		WARN_ON(!!cpu_has_mmid !=3D !!(config5 & MIPS_CONF5_MI));
+
+		if (cpu_has_mmid) {
+			write_c0_memorymapid(~0ul);
+			back_to_back_c0_hazard();
+			asid_mask =3D read_c0_memorymapid();
+
+			/*
+			 * We maintain a bitmap to track MMID allocation, and
+			 * need a sensible upper bound on the size of that
+			 * bitmap. The initial CPU with MMID support (I6500)
+			 * supports 16 bit MMIDs, which gives us an 8KiB
+			 * bitmap. The architecture recommends that hardware
+			 * support 32 bit MMIDs, which would give us a 512MiB
+			 * bitmap - that's too big in most cases.
+			 *
+			 * Cap MMID width at 16 bits for now & we can revisit
+			 * this if & when hardware supports anything wider.
+			 */
+			max_mmid_width =3D 16;
+			if (asid_mask > GENMASK(max_mmid_width - 1, 0)) {
+				pr_info("Capping MMID width at %d bits",
+					max_mmid_width);
+				asid_mask =3D GENMASK(max_mmid_width - 1, 0);
+			}
+
+			set_cpu_asid_mask(c, asid_mask);
+		}
+	}
+
 	return config5 & MIPS_CONF_M;
 }
=20
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f9dbd95e1d68..6fd9e94fc87e 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -39,6 +39,7 @@
=20
 #include <linux/atomic.h>
 #include <asm/cpu.h>
+#include <asm/ginvt.h>
 #include <asm/processor.h>
 #include <asm/idle.h>
 #include <asm/r4k-timer.h>
@@ -482,6 +483,15 @@ static void flush_tlb_all_ipi(void *info)
=20
 void flush_tlb_all(void)
 {
+	if (cpu_has_mmid) {
+		htw_stop();
+		ginvt_full();
+		sync_ginv();
+		instruction_hazard();
+		htw_start();
+		return;
+	}
+
 	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
 }
=20
@@ -530,7 +540,12 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	preempt_disable();
=20
-	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
+	if (cpu_has_mmid) {
+		/*
+		 * No need to worry about other CPUs - the ginvt in
+		 * drop_mmu_context() will be globalized.
+		 */
+	} else if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) =
{
 		smp_on_other_tlbs(flush_tlb_mm_ipi, mm);
 	} else {
 		unsigned int cpu;
@@ -561,9 +576,26 @@ static void flush_tlb_range_ipi(void *info)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsi=
gned long end)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long addr;
+	u32 old_mmid;
=20
 	preempt_disable();
-	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
+	if (cpu_has_mmid) {
+		htw_stop();
+		old_mmid =3D read_c0_memorymapid();
+		write_c0_memorymapid(cpu_asid(0, mm));
+		mtc0_tlbw_hazard();
+		addr =3D round_down(start, PAGE_SIZE * 2);
+		end =3D round_up(end, PAGE_SIZE * 2);
+		do {
+			ginvt_va_mmid(addr);
+			sync_ginv();
+			addr +=3D PAGE_SIZE * 2;
+		} while (addr < end);
+		write_c0_memorymapid(old_mmid);
+		instruction_hazard();
+		htw_start();
+	} else if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) =
{
 		struct flush_tlb_data fd =3D {
 			.vma =3D vma,
 			.addr1 =3D start,
@@ -571,6 +603,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsign=
ed long start, unsigned l
 		};
=20
 		smp_on_other_tlbs(flush_tlb_range_ipi, &fd);
+		local_flush_tlb_range(vma, start, end);
 	} else {
 		unsigned int cpu;
 		int exec =3D vma->vm_flags & VM_EXEC;
@@ -585,8 +618,8 @@ void flush_tlb_range(struct vm_area_struct *vma, unsign=
ed long start, unsigned l
 			if (cpu !=3D smp_processor_id() && cpu_context(cpu, mm))
 				set_cpu_context(cpu, mm, !exec);
 		}
+		local_flush_tlb_range(vma, start, end);
 	}
-	local_flush_tlb_range(vma, start, end);
 	preempt_enable();
 }
=20
@@ -616,14 +649,28 @@ static void flush_tlb_page_ipi(void *info)
=20
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
+	u32 old_mmid;
+
 	preempt_disable();
-	if ((atomic_read(&vma->vm_mm->mm_users) !=3D 1) || (current->mm !=3D vma-=
>vm_mm)) {
+	if (cpu_has_mmid) {
+		htw_stop();
+		old_mmid =3D read_c0_memorymapid();
+		write_c0_memorymapid(cpu_asid(0, vma->vm_mm));
+		mtc0_tlbw_hazard();
+		ginvt_va_mmid(page);
+		sync_ginv();
+		write_c0_memorymapid(old_mmid);
+		instruction_hazard();
+		htw_start();
+	} else if ((atomic_read(&vma->vm_mm->mm_users) !=3D 1) ||
+		   (current->mm !=3D vma->vm_mm)) {
 		struct flush_tlb_data fd =3D {
 			.vma =3D vma,
 			.addr1 =3D page,
 		};
=20
 		smp_on_other_tlbs(flush_tlb_page_ipi, &fd);
+		local_flush_tlb_page(vma, page);
 	} else {
 		unsigned int cpu;
=20
@@ -637,8 +684,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigne=
d long page)
 			if (cpu !=3D smp_processor_id() && cpu_context(cpu, vma->vm_mm))
 				set_cpu_context(cpu, vma->vm_mm, 1);
 		}
+		local_flush_tlb_page(vma, page);
 	}
-	local_flush_tlb_page(vma, page);
 	preempt_enable();
 }
=20
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c91097f7b32f..995249be64f1 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2223,7 +2223,9 @@ void per_cpu_trap_init(bool is_boot_cpu)
 		cp0_fdc_irq =3D -1;
 	}
=20
-	if (!cpu_data[cpu].asid_cache)
+	if (cpu_has_mmid)
+		cpu_data[cpu].asid_cache =3D 0;
+	else if (!cpu_data[cpu].asid_cache)
 		cpu_data[cpu].asid_cache =3D asid_first_version(cpu);
=20
 	mmgrab(&init_mm);
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 595ca9c85111..22485f26b10a 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -89,6 +89,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
+#include <asm/mmu_context.h>
 #include <linux/uaccess.h>
=20
 #define STR(x)	__STR(x)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3734cd58895e..6d0517ac18e5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1723,6 +1723,11 @@ static int __init kvm_mips_init(void)
 {
 	int ret;
=20
+	if (cpu_has_mmid) {
+		pr_warn("KVM does not yet support MMIDs. KVM Disabled\n");
+		return -EOPNOTSUPP;
+	}
+
 	ret =3D kvm_mips_entry_setup();
 	if (ret)
 		return ret;
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 781ad96b78c4..83ed37298e66 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -10,6 +10,7 @@
=20
 #include <asm/hazards.h>
 #include <asm/mipsregs.h>
+#include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
@@ -73,12 +74,13 @@ static inline const char *msk2str(unsigned int mask)
=20
 static void dump_tlb(int first, int last)
 {
-	unsigned long s_entryhi, entryhi, asid;
+	unsigned long s_entryhi, entryhi, asid, mmid;
 	unsigned long long entrylo0, entrylo1, pa;
 	unsigned int s_index, s_pagemask, s_guestctl1 =3D 0;
 	unsigned int pagemask, guestctl1 =3D 0, c0, c1, i;
 	unsigned long asidmask =3D cpu_asid_mask(&current_cpu_data);
 	int asidwidth =3D DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
+	unsigned long uninitialized_var(s_mmid);
 #ifdef CONFIG_32BIT
 	bool xpa =3D cpu_has_xpa && (read_c0_pagegrain() & PG_ELPA);
 	int pwidth =3D xpa ? 11 : 8;
@@ -92,7 +94,12 @@ static void dump_tlb(int first, int last)
 	s_pagemask =3D read_c0_pagemask();
 	s_entryhi =3D read_c0_entryhi();
 	s_index =3D read_c0_index();
-	asid =3D s_entryhi & asidmask;
+
+	if (cpu_has_mmid)
+		asid =3D s_mmid =3D read_c0_memorymapid();
+	else
+		asid =3D s_entryhi & asidmask;
+
 	if (cpu_has_guestid)
 		s_guestctl1 =3D read_c0_guestctl1();
=20
@@ -105,6 +112,12 @@ static void dump_tlb(int first, int last)
 		entryhi	 =3D read_c0_entryhi();
 		entrylo0 =3D read_c0_entrylo0();
 		entrylo1 =3D read_c0_entrylo1();
+
+		if (cpu_has_mmid)
+			mmid =3D read_c0_memorymapid();
+		else
+			mmid =3D entryhi & asidmask;
+
 		if (cpu_has_guestid)
 			guestctl1 =3D read_c0_guestctl1();
=20
@@ -124,8 +137,7 @@ static void dump_tlb(int first, int last)
 		 * leave only a single G bit set after a machine check exception
 		 * due to duplicate TLB entry.
 		 */
-		if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
-		    (entryhi & asidmask) !=3D asid)
+		if (!((entrylo0 | entrylo1) & ENTRYLO_G) && (mmid !=3D asid))
 			continue;
=20
 		/*
@@ -138,7 +150,7 @@ static void dump_tlb(int first, int last)
=20
 		pr_cont("va=3D%0*lx asid=3D%0*lx",
 			vwidth, (entryhi & ~0x1fffUL),
-			asidwidth, entryhi & asidmask);
+			asidwidth, mmid);
 		if (cpu_has_guestid)
 			pr_cont(" gid=3D%02lx",
 				(guestctl1 & MIPS_GCTL1_RID)
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 248d9e8263cf..cc4e17caeb26 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -540,6 +540,9 @@ static inline int has_valid_asid(const struct mm_struct=
 *mm, unsigned int type)
 	unsigned int i;
 	const cpumask_t *mask =3D cpu_present_mask;
=20
+	if (cpu_has_mmid)
+		return cpu_context(0, mm) !=3D 0;
+
 	/* cpu_sibling_map[] undeclared when !CONFIG_SMP */
 #ifdef CONFIG_SMP
 	/*
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index dcaceee179f7..a6adae550788 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -1,11 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/atomic.h>
 #include <linux/mmu_context.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+
+static DEFINE_RAW_SPINLOCK(cpu_mmid_lock);
+
+static atomic64_t mmid_version;
+static unsigned int num_mmids;
+static unsigned long *mmid_map;
+
+static DEFINE_PER_CPU(u64, reserved_mmids);
+static cpumask_t tlb_flush_pending;
+
+static bool asid_versions_eq(int cpu, u64 a, u64 b)
+{
+	return ((a ^ b) & asid_version_mask(cpu)) =3D=3D 0;
+}
=20
 void get_new_mmu_context(struct mm_struct *mm)
 {
 	unsigned int cpu;
 	u64 asid;
=20
+	/*
+	 * This function is specific to ASIDs, and should not be called when
+	 * MMIDs are in use.
+	 */
+	if (WARN_ON(IS_ENABLED(CONFIG_DEBUG_VM) && cpu_has_mmid))
+		return;
+
 	cpu =3D smp_processor_id();
 	asid =3D asid_cache(cpu);
=20
@@ -23,16 +47,242 @@ void check_mmu_context(struct mm_struct *mm)
 {
 	unsigned int cpu =3D smp_processor_id();
=20
+	/*
+	 * This function is specific to ASIDs, and should not be called when
+	 * MMIDs are in use.
+	 */
+	if (WARN_ON(IS_ENABLED(CONFIG_DEBUG_VM) && cpu_has_mmid))
+		return;
+
 	/* Check if our ASID is of an older version and thus invalid */
-	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) & asid_version_mask(cpu))
+	if (!asid_versions_eq(cpu, cpu_context(cpu, mm), asid_cache(cpu)))
 		get_new_mmu_context(mm);
 }
=20
+static void flush_context(void)
+{
+	u64 mmid;
+	int cpu;
+
+	/* Update the list of reserved MMIDs and the MMID bitmap */
+	bitmap_clear(mmid_map, 0, num_mmids);
+
+	/* Reserve an MMID for kmap/wired entries */
+	__set_bit(MMID_KERNEL_WIRED, mmid_map);
+
+	for_each_possible_cpu(cpu) {
+		mmid =3D xchg_relaxed(&cpu_data[cpu].asid_cache, 0);
+
+		/*
+		 * If this CPU has already been through a
+		 * rollover, but hasn't run another task in
+		 * the meantime, we must preserve its reserved
+		 * MMID, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (mmid =3D=3D 0)
+			mmid =3D per_cpu(reserved_mmids, cpu);
+
+		__set_bit(mmid & cpu_asid_mask(&cpu_data[cpu]), mmid_map);
+		per_cpu(reserved_mmids, cpu) =3D mmid;
+	}
+
+	/*
+	 * Queue a TLB invalidation for each CPU to perform on next
+	 * context-switch
+	 */
+	cpumask_setall(&tlb_flush_pending);
+}
+
+static bool check_update_reserved_mmid(u64 mmid, u64 newmmid)
+{
+	bool hit;
+	int cpu;
+
+	/*
+	 * Iterate over the set of reserved MMIDs looking for a match.
+	 * If we find one, then we can update our mm to use newmmid
+	 * (i.e. the same MMID in the current generation) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old MMID are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved MMID in a future
+	 * generation.
+	 */
+	hit =3D false;
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_mmids, cpu) =3D=3D mmid) {
+			hit =3D true;
+			per_cpu(reserved_mmids, cpu) =3D newmmid;
+		}
+	}
+
+	return hit;
+}
+
+static u64 get_new_mmid(struct mm_struct *mm)
+{
+	static u32 cur_idx =3D MMID_KERNEL_WIRED + 1;
+	u64 mmid, version, mmid_mask;
+
+	mmid =3D cpu_context(0, mm);
+	version =3D atomic64_read(&mmid_version);
+	mmid_mask =3D cpu_asid_mask(&boot_cpu_data);
+
+	if (!asid_versions_eq(0, mmid, 0)) {
+		u64 newmmid =3D version | (mmid & mmid_mask);
+
+		/*
+		 * If our current MMID was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_mmid(mmid, newmmid)) {
+			mmid =3D newmmid;
+			goto set_context;
+		}
+
+		/*
+		 * We had a valid MMID in a previous life, so try to re-use
+		 * it if possible.
+		 */
+		if (!__test_and_set_bit(mmid & mmid_mask, mmid_map)) {
+			mmid =3D newmmid;
+			goto set_context;
+		}
+	}
+
+	/* Allocate a free MMID */
+	mmid =3D find_next_zero_bit(mmid_map, num_mmids, cur_idx);
+	if (mmid !=3D num_mmids)
+		goto reserve_mmid;
+
+	/* We're out of MMIDs, so increment the global version */
+	version =3D atomic64_add_return_relaxed(asid_first_version(0),
+					      &mmid_version);
+
+	/* Note currently active MMIDs & mark TLBs as requiring flushes */
+	flush_context();
+
+	/* We have more MMIDs than CPUs, so this will always succeed */
+	mmid =3D find_first_zero_bit(mmid_map, num_mmids);
+
+reserve_mmid:
+	__set_bit(mmid, mmid_map);
+	cur_idx =3D mmid;
+	mmid |=3D version;
+set_context:
+	set_cpu_context(0, mm, mmid);
+	return mmid;
+}
+
 void check_switch_mmu_context(struct mm_struct *mm)
 {
 	unsigned int cpu =3D smp_processor_id();
+	u64 ctx, old_active_mmid;
+	unsigned long flags;
=20
-	check_mmu_context(mm);
-	write_c0_entryhi(cpu_asid(cpu, mm));
+	if (!cpu_has_mmid) {
+		check_mmu_context(mm);
+		write_c0_entryhi(cpu_asid(cpu, mm));
+		goto setup_pgd;
+	}
+
+	/*
+	 * MMID switch fast-path, to avoid acquiring cpu_mmid_lock when it's
+	 * unnecessary.
+	 *
+	 * The memory ordering here is subtle. If our active_mmids is non-zero
+	 * and the MMID matches the current version, then we update the CPU's
+	 * asid_cache with a relaxed cmpxchg. Racing with a concurrent rollover
+	 * means that either:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on
+	 *   cpu_mmid_lock in check_mmu_context(). Taking the lock synchronises
+	 *   with the rollover and so we are forced to see the updated
+	 *   generation.
+	 *
+	 * - We get a valid MMID back from the cmpxchg, which means the
+	 *   relaxed xchg in flush_context will treat us as reserved
+	 *   because atomic RmWs are totally ordered for a given location.
+	 */
+	ctx =3D cpu_context(cpu, mm);
+	old_active_mmid =3D READ_ONCE(cpu_data[cpu].asid_cache);
+	if (!old_active_mmid ||
+	    !asid_versions_eq(cpu, ctx, atomic64_read(&mmid_version)) ||
+	    !cmpxchg_relaxed(&cpu_data[cpu].asid_cache, old_active_mmid, ctx)) {
+		raw_spin_lock_irqsave(&cpu_mmid_lock, flags);
+
+		ctx =3D cpu_context(cpu, mm);
+		if (!asid_versions_eq(cpu, ctx, atomic64_read(&mmid_version)))
+			ctx =3D get_new_mmid(mm);
+
+		WRITE_ONCE(cpu_data[cpu].asid_cache, ctx);
+		raw_spin_unlock_irqrestore(&cpu_mmid_lock, flags);
+	}
+
+	/*
+	 * Invalidate the local TLB if needed. Note that we must only clear our
+	 * bit in tlb_flush_pending after this is complete, so that the
+	 * cpu_has_shared_ftlb_entries case below isn't misled.
+	 */
+	if (cpumask_test_cpu(cpu, &tlb_flush_pending)) {
+		if (cpu_has_vtag_icache)
+			flush_icache_all();
+		local_flush_tlb_all();
+		cpumask_clear_cpu(cpu, &tlb_flush_pending);
+	}
+
+	write_c0_memorymapid(ctx & cpu_asid_mask(&boot_cpu_data));
+
+	/*
+	 * If this CPU shares FTLB entries with its siblings and one or more of
+	 * those siblings hasn't yet invalidated its TLB following a version
+	 * increase then we need to invalidate any TLB entries for our MMID
+	 * that we might otherwise pick up from a sibling.
+	 *
+	 * We ifdef on CONFIG_SMP because cpu_sibling_map isn't defined in
+	 * CONFIG_SMP=3Dn kernels.
+	 */
+#ifdef CONFIG_SMP
+	if (cpu_has_shared_ftlb_entries &&
+	    cpumask_intersects(&tlb_flush_pending, &cpu_sibling_map[cpu])) {
+		/* Ensure we operate on the new MMID */
+		mtc0_tlbw_hazard();
+
+		/*
+		 * Invalidate all TLB entries associated with the new
+		 * MMID, and wait for the invalidation to complete.
+		 */
+		ginvt_mmid();
+		sync_ginv();
+	}
+#endif
+
+setup_pgd:
 	TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
 }
+
+static int mmid_init(void)
+{
+	if (!cpu_has_mmid)
+		return 0;
+
+	/*
+	 * Expect allocation after rollover to fail if we don't have at least
+	 * one more MMID than CPUs.
+	 */
+	num_mmids =3D asid_first_version(0);
+	WARN_ON(num_mmids <=3D num_possible_cpus());
+
+	atomic64_set(&mmid_version, asid_first_version(0));
+	mmid_map =3D kcalloc(BITS_TO_LONGS(num_mmids), sizeof(*mmid_map),
+			   GFP_KERNEL);
+	if (!mmid_map)
+		panic("Failed to allocate bitmap for %u MMIDs\n", num_mmids);
+
+	/* Reserve an MMID for kmap/wired entries */
+	__set_bit(MMID_KERNEL_WIRED, mmid_map);
+
+	pr_info("MMID allocator initialised with %u entries\n", num_mmids);
+	return 0;
+}
+early_initcall(mmid_init);
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index b521d8e2d359..c3b45e248806 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -84,6 +84,7 @@ void setup_zero_pages(void)
 static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t=
 prot)
 {
 	enum fixed_addresses idx;
+	unsigned int uninitialized_var(old_mmid);
 	unsigned long vaddr, flags, entrylo;
 	unsigned long old_ctx;
 	pte_t pte;
@@ -110,6 +111,10 @@ static void *__kmap_pgprot(struct page *page, unsigned=
 long addr, pgprot_t prot)
 	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
 	write_c0_entrylo0(entrylo);
 	write_c0_entrylo1(entrylo);
+	if (cpu_has_mmid) {
+		old_mmid =3D read_c0_memorymapid();
+		write_c0_memorymapid(MMID_KERNEL_WIRED);
+	}
 #ifdef CONFIG_XPA
 	if (cpu_has_xpa) {
 		entrylo =3D (pte.pte_low & _PFNX_MASK);
@@ -124,6 +129,8 @@ static void *__kmap_pgprot(struct page *page, unsigned =
long addr, pgprot_t prot)
 	tlb_write_indexed();
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
+	if (cpu_has_mmid)
+		write_c0_memorymapid(old_mmid);
 	local_irq_restore(flags);
=20
 	return (void*) vaddr;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 0114c43398f3..c13e46ced425 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -120,14 +120,23 @@ void local_flush_tlb_range(struct vm_area_struct *vma=
, unsigned long start,
 		if (size <=3D (current_cpu_data.tlbsizeftlbsets ?
 			     current_cpu_data.tlbsize / 8 :
 			     current_cpu_data.tlbsize / 2)) {
-			int oldpid =3D read_c0_entryhi();
+			unsigned long old_entryhi, uninitialized_var(old_mmid);
 			int newpid =3D cpu_asid(cpu, mm);
=20
+			old_entryhi =3D read_c0_entryhi();
+			if (cpu_has_mmid) {
+				old_mmid =3D read_c0_memorymapid();
+				write_c0_memorymapid(newpid);
+			}
+
 			htw_stop();
 			while (start < end) {
 				int idx;
=20
-				write_c0_entryhi(start | newpid);
+				if (cpu_has_mmid)
+					write_c0_entryhi(start);
+				else
+					write_c0_entryhi(start | newpid);
 				start +=3D (PAGE_SIZE << 1);
 				mtc0_tlbw_hazard();
 				tlb_probe();
@@ -143,7 +152,9 @@ void local_flush_tlb_range(struct vm_area_struct *vma, =
unsigned long start,
 				tlb_write_indexed();
 			}
 			tlbw_use_hazard();
-			write_c0_entryhi(oldpid);
+			write_c0_entryhi(old_entryhi);
+			if (cpu_has_mmid)
+				write_c0_memorymapid(old_mmid);
 			htw_start();
 		} else {
 			drop_mmu_context(mm);
@@ -203,15 +214,21 @@ void local_flush_tlb_page(struct vm_area_struct *vma,=
 unsigned long page)
 	int cpu =3D smp_processor_id();
=20
 	if (cpu_context(cpu, vma->vm_mm) !=3D 0) {
-		unsigned long flags;
-		int oldpid, newpid, idx;
+		unsigned long uninitialized_var(old_mmid);
+		unsigned long flags, old_entryhi;
+		int idx;
=20
-		newpid =3D cpu_asid(cpu, vma->vm_mm);
 		page &=3D (PAGE_MASK << 1);
 		local_irq_save(flags);
-		oldpid =3D read_c0_entryhi();
+		old_entryhi =3D read_c0_entryhi();
 		htw_stop();
-		write_c0_entryhi(page | newpid);
+		if (cpu_has_mmid) {
+			old_mmid =3D read_c0_memorymapid();
+			write_c0_entryhi(page);
+			write_c0_memorymapid(cpu_asid(cpu, vma->vm_mm));
+		} else {
+			write_c0_entryhi(page | cpu_asid(cpu, vma->vm_mm));
+		}
 		mtc0_tlbw_hazard();
 		tlb_probe();
 		tlb_probe_hazard();
@@ -227,7 +244,9 @@ void local_flush_tlb_page(struct vm_area_struct *vma, u=
nsigned long page)
 		tlbw_use_hazard();
=20
 	finish:
-		write_c0_entryhi(oldpid);
+		write_c0_entryhi(old_entryhi);
+		if (cpu_has_mmid)
+			write_c0_memorymapid(old_mmid);
 		htw_start();
 		flush_micro_tlb_vm(vma);
 		local_irq_restore(flags);
@@ -290,9 +309,13 @@ void __update_tlb(struct vm_area_struct * vma, unsigne=
d long address, pte_t pte)
 	local_irq_save(flags);
=20
 	htw_stop();
-	pid =3D read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
 	address &=3D (PAGE_MASK << 1);
-	write_c0_entryhi(address | pid);
+	if (cpu_has_mmid) {
+		write_c0_entryhi(address);
+	} else {
+		pid =3D read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
+		write_c0_entryhi(address | pid);
+	}
 	pgdp =3D pgd_offset(vma->vm_mm, address);
 	mtc0_tlbw_hazard();
 	tlb_probe();
@@ -358,12 +381,17 @@ void add_wired_entry(unsigned long entrylo0, unsigned=
 long entrylo1,
 #ifdef CONFIG_XPA
 	panic("Broken for XPA kernels");
 #else
+	unsigned int uninitialized_var(old_mmid);
 	unsigned long flags;
 	unsigned long wired;
 	unsigned long old_pagemask;
 	unsigned long old_ctx;
=20
 	local_irq_save(flags);
+	if (cpu_has_mmid) {
+		old_mmid =3D read_c0_memorymapid();
+		write_c0_memorymapid(MMID_KERNEL_WIRED);
+	}
 	/* Save old context and create impossible VPN2 value */
 	old_ctx =3D read_c0_entryhi();
 	htw_stop();
@@ -381,6 +409,8 @@ void add_wired_entry(unsigned long entrylo0, unsigned l=
ong entrylo1,
 	tlbw_use_hazard();
=20
 	write_c0_entryhi(old_ctx);
+	if (cpu_has_mmid)
+		write_c0_memorymapid(old_mmid);
 	tlbw_use_hazard();	/* What is the hazard here? */
 	htw_start();
 	write_c0_pagemask(old_pagemask);
--=20
2.20.1

