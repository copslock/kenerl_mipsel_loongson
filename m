Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971BC04EB8
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 23:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B79B2081B
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 23:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B79B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLDXYR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:24:17 -0500
Received: from mail-eopbgr810125.outbound.protection.outlook.com ([40.107.81.125]:36581
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbeLDXYQ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 4 Dec 2018 18:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRx7Ntv40TAW+mv+YGLUdIXnFjtSdv2svVyUuXm8b84=;
 b=k+m4ygGxelgdtpJAxBxuU8JR9alFd+VWOqHg8ZC21Knbn9bE+o8B3TlOzR/JzXjHzHpPDtcduZucU2OqwkorsnKpascN/tqr4GyLfn9Hf4x0fEZs/zLSoz0f84kBpam8k3hJbeI4x2PIFUvOuunf5/WdYMfjPU6GcJNFU0Mk7u4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1486.namprd22.prod.outlook.com (10.174.170.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 23:23:21 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 23:23:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        Yu Huabing <yhb@ruijie.com.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Topic: [PATCH] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Index: AQHUjChYskTIQmLSxkmT4w7Kl2LZlg==
Date:   Tue, 4 Dec 2018 23:23:21 +0000
Message-ID: <20181204232302.17519-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:300:81::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1486;6:qDMDt2xu9en7hrM2GxE64Xk6PR526jkhiGQybkhmkT9fu4oik7iwx42m4/rufHkXWz6dtTxrk4kdXIhOIabxG6gnQll0uGOFQUuftEuOvDmtMWlkQwgusCsTIW0snOmo6OGfgoTXWwtrnAZKrvOJmAvspLcS5qag/BXvipOB0+XEZsG3kHY86lLyycziD3VqpdLlWDWjwBlXjbWlFvuj8VUwqklXQoyorHWuI6h37Q8sHGAVfhocE0SgXY+KAUMbC3SrRdA7/SF2s0ftKB4LS/FSQIsniCLBUWqBGcYCQnxtZs3qFRWS+9v/4ybChhnGQHDt5G/f+zEF3TDxx+0rSbVwTZryE+84zfRhF81TgzNY4jhYi26sAlPX85YFF/coq77yaiYcl4gMSa5ZsO/MDOtJ5b3zldUaspgVupavoN7xKsqptkDaqeItqa4wai6iwHSfeC1jv6vch/hQtZEAPw==;5:yBbjUgrdTnEv6HRP4kKJdEksHnmwq7HGhpUwJLydU1PikdB0+x3wJRmVETyX89d/ERo3ZB1JM7HiptqRRDpKeK3jMYO9DE2Imt//jk6OZWDlt4STp8maHi9cfckSPr3L95Hxgy5UQ4MkhAot0YZLKFO2wuTSr0iq9N9kSR04KFo=;7:eefX/dKCJ3EjX1sXei6TAB+W1GCxvZk3qLJH/8sqfT50VxQzaJ4GF6qdhYvKX02/qchnuHr8Kp2EdTDkm3KLPBcXN5j4tdA3Iq6Rx4ja2E4UsjviT1arGHASRdaNGy5o8RCup7RhQAeiJFkEXckYDw==
x-ms-office365-filtering-correlation-id: dd88c5a4-222d-49ec-aec9-08d65a3f7af8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1486;
x-ms-traffictypediagnostic: MWHPR2201MB1486:
x-microsoft-antispam-prvs: <MWHPR2201MB1486CA35AF2477D9210BC64CC1AF0@MWHPR2201MB1486.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501516)(52105112)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1486;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1486;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39840400004)(136003)(376002)(366004)(199004)(189003)(476003)(44832011)(14444005)(256004)(486006)(2616005)(508600001)(25786009)(8936002)(5660300001)(2501003)(105586002)(81156014)(8676002)(81166006)(68736007)(106356001)(2351001)(386003)(186003)(6506007)(42882007)(102836004)(26005)(575784001)(52116002)(99286004)(36756003)(3846002)(6116002)(54906003)(316002)(1076002)(71200400001)(97736004)(2906002)(305945005)(6486002)(71190400001)(6436002)(53936002)(6512007)(6306002)(5640700003)(6916009)(7736002)(4326008)(966005)(66066001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1486;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y429qrAGi1JHggW4WDZnLByoeIES4qs6Tl9+jN8QpR1XNQ/IaCgVBPrlBGTT2BPSV7YFG9HneEmihQOS6Ec5pzazRsBU3STBRZBci5Mjjaqa+T95MlbUc8Fh/dhg8g/nySUr919oATW+g7EYn8yA6OwNd5q9zQ7GFV44iVFVGOKM4Zf1tzmCx4uHCIeti/z0Nr5R2i18gCQqEr5CKc5XEV1rITzotvcQ2fw4z2f+LxdmcdTFiuc+68MG2af0wI9BvFWrEjMerzVpdjRnWPSr/tM39QPkg5i9pRKj+68wL94Kgxtqzh5rxpuuzWWOEb7PzSgF6tt3LeekOtrZ1nEsuL1kcx/PYMO2mZx65Easv6A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd88c5a4-222d-49ec-aec9-08d65a3f7af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 23:23:21.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1486
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

ASIDs have always been stored as unsigned longs, ie. 32 bits on MIPS32
kernels. This is problematic because it is feasible for the ASID version
to overflow & wrap around to zero.

We currently attempt to handle this overflow by simply setting the ASID
version to 1, using asid_first_version(), but we make no attempt to
account for the fact that there may be mm_structs with stale ASIDs that
have versions which we now reuse due to the overflow & wrap around.

Encountering this requires that:

  1) A struct mm_struct X is active on CPU A using ASID (V,n).

  2) That mm is not used on CPU A for the length of time that it takes
     for CPU A's asid_cache to overflow & wrap around to the same
     version V that the mm had in step 1. During this time tasks using
     the mm could either be sleeping or only scheduled on other CPUs.

  3) Some other mm Y becomes active on CPU A and is allocated the same
     ASID (V,n).

  4) mm X now becomes active on CPU A again, and now incorrectly has the
     same ASID as mm Y.

Where struct mm_struct ASIDs are represented above in the format
(version, EntryHi.ASID), and on a typical MIPS32 system version will be
24 bits wide & EntryHi.ASID will be 8 bits wide.

The length of time required in step 2 is highly dependent upon the CPU &
workload, but for a hypothetical 2GHz CPU running a workload which
generates a new ASID every 10000 cycles this period is around 248 days.
Due to this long period of time & the fact that tasks need to be
scheduled in just the right (or wrong, depending upon your inclination)
way, this is obviously a difficult bug to encounter but it's entirely
possible as evidenced by reports.

In order to fix this, simply extend ASIDs to 64 bits even on MIPS32
builds. This will extend the period of time required for the
hypothetical system above to encounter the problem from 28 days to
around 3 trillion years, which feels safely outside of the realms of
possibility.

The cost of this is slightly more generated code in some commonly
executed paths, but this is pretty minimal:

                         | Code Size Gain | Percentage
  -----------------------|----------------|-------------
    decstation_defconfig |           +270 | +0.00%
        32r2el_defconfig |           +652 | +0.01%
        32r6el_defconfig |          +1000 | +0.01%

I have been unable to measure any change in performance of the LMbench
lat_ctx or lat_proc tests resulting from the 64b ASIDs on either
32r2el_defconfig+interAptiv or 32r6el_defconfig+I6500 systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: James Hogan <jhogan@kernel.org>
References: https://lore.kernel.org/linux-mips/80B78A8B8FEE6145A87579E8435D=
78C30205D5F3@fzex.ruijie.com.cn/
References: https://lore.kernel.org/linux-mips/1488684260-18867-1-git-send-=
email-jiwei.sun@windriver.com/
Cc: Jiwei Sun <jiwei.sun@windriver.com>
Cc: Yu Huabing <yhb@ruijie.com.cn>
Cc: stable@vger.kernel.org # 2.6.12+
---

 arch/mips/include/asm/cpu-info.h    | 2 +-
 arch/mips/include/asm/mmu.h         | 2 +-
 arch/mips/include/asm/mmu_context.h | 8 ++++----
 arch/mips/mm/c-r3k.c                | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-i=
nfo.h
index a41059d47d31..ed7ffe4e63a3 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -50,7 +50,7 @@ struct guest_info {
 #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
=20
 struct cpuinfo_mips {
-	unsigned long		asid_cache;
+	u64			asid_cache;
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
 	unsigned long		asid_mask;
 #endif
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index 0740be7d5d4a..24d6b42345fb 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -7,7 +7,7 @@
 #include <linux/wait.h>
=20
 typedef struct {
-	unsigned long asid[NR_CPUS];
+	u64 asid[NR_CPUS];
 	void *vdso;
 	atomic_t fp_mode_switching;
=20
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 94414561de0e..fd869d538a3c 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -76,14 +76,14 @@ extern unsigned long pgd_current[];
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
  */
-static unsigned long asid_version_mask(unsigned int cpu)
+static u64 asid_version_mask(unsigned int cpu)
 {
 	unsigned long asid_mask =3D cpu_asid_mask(&cpu_data[cpu]);
=20
-	return ~(asid_mask | (asid_mask - 1));
+	return ~(u64)(asid_mask | (asid_mask - 1));
 }
=20
-static unsigned long asid_first_version(unsigned int cpu)
+static u64 asid_first_version(unsigned int cpu)
 {
 	return ~asid_version_mask(cpu) + 1;
 }
@@ -102,7 +102,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,=
 struct task_struct *tsk)
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
-	unsigned long asid =3D asid_cache(cpu);
+	u64 asid =3D asid_cache(cpu);
=20
 	if (!((asid +=3D cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 3466fcdae0ca..01848cdf2074 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -245,7 +245,7 @@ static void r3k_flush_cache_page(struct vm_area_struct =
*vma,
 	pmd_t *pmdp;
 	pte_t *ptep;
=20
-	pr_debug("cpage[%08lx,%08lx]\n",
+	pr_debug("cpage[%08llx,%08lx]\n",
 		 cpu_context(smp_processor_id(), mm), addr);
=20
 	/* No ASID =3D> no such page in the cache.  */
--=20
2.19.1

