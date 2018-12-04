Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46971C04EB8
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8266206B6
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Zvb5/X79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8266206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDXoW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:44:22 -0500
Received: from mail-eopbgr700129.outbound.protection.outlook.com ([40.107.70.129]:10686
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbeLDXoW (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 4 Dec 2018 18:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPqnQmfyZCaE9XtcBFHH3StuCd1v+44okKtpE7M5BEM=;
 b=Zvb5/X79Xx0+4JQ8P6LVuYtNmOVh/T2D17TpjI2B1CMwvfPd24WgOQ+Zjea04jyeQaE8U8EW9tajC/0MDBnt0+wXF3Ayp4TAjGljlRTa6IjhBJx1hVUi+zyKuxpfw+08n9QNehl3/y8J2GO5bD9pLMsYsrxty23qM78pX1rxrV8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Tue, 4 Dec 2018 23:44:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 23:44:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        Yu Huabing <yhb@ruijie.com.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Topic: [PATCH v2] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Index: AQHUjCtCTMEMRdKza0eGsQC+3qNFjQ==
Date:   Tue, 4 Dec 2018 23:44:12 +0000
Message-ID: <20181204234333.21243-1-paul.burton@mips.com>
References: <20181204232302.17519-1-paul.burton@mips.com>
In-Reply-To: <20181204232302.17519-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:300:103::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:7kf0jzupndQmk17Bo+8GvJ+5w5WJouIa9vAmo/miDjdZ068H+G0hCp3zC1UE4UpuZ+y4s9l7EMO1N7086B2uB8ligxKUSRzCbRJWW+AFw2wRKAjemySRSKcKzhG3ez/9Kpx+V0rMcfkkLDq+8K0sF7YeKwWXnYobRca0HALqTJDmUC+FDXD/EJnYzkxWroj8TNIdiKgQJX71Xvz9nP+q7M5GQ7waxJ1MzlLln4Eh3Ag07+piPFO1O1Fl0clpvH11LPQkVQIar0leczsM1ZShN1sSyxqTPBCxGQ+hpZ5I+JIFKQhlP1UD1qM62tCnAoyA9pSLtbwyK6WIrmCDMOShwS40oU4q1NQlB5n6a78qR0TQpG0QkjtXzA8VWSZ0V/YqeHfprDv8lEdiHX8bcZ7jD9KUkqJa7rQUgZrawRoWjhlfp/fbGpIYjPw1Rb7gUBwOITk/2BrnFwkC8dpVRlugYg==;5:1IeLbzyM5GX+6L/vM8sU6mQ9yVp2jba1ESu/nkRAv58csQzm5ch7YP0hg9BqeIfre8DX8ftY3edKE6Efza8UeRCWpUksvNwJYfLcciF5VRAIRouJ8bm3UPx/kYjD0HBpn0TpnblbDqA16iB8POxd1/omaQqenYPwsaMmw0cm/2k=;7:LX3dnt5vVFKxbYyLrV29NMYGJWg47a9vqO5B9ArVv+2pMdUUK6S8DMPxaIq90D/JtZf5UErCyAJUs7GRlYWb6rGIPWZArzhgCFM7WVfSLQyJFDWM4w1GzsFGVTjVdv+hmiOcorDAs/1+lVG+Wv3DBg==
x-ms-office365-filtering-correlation-id: d23ad327-1f45-442e-b30d-08d65a42645e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB14729E7EC2C5807F48CFAD93C1AF0@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231455)(999002)(944501516)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(54906003)(316002)(97736004)(66066001)(186003)(14454004)(102836004)(966005)(99286004)(386003)(6506007)(2906002)(508600001)(5660300001)(68736007)(44832011)(6916009)(2616005)(486006)(575784001)(476003)(11346002)(446003)(25786009)(256004)(305945005)(7736002)(14444005)(42882007)(26005)(36756003)(71200400001)(71190400001)(2351001)(106356001)(6436002)(4326008)(6486002)(8936002)(81166006)(81156014)(8676002)(53936002)(2501003)(1076002)(5640700003)(52116002)(76176011)(3846002)(6116002)(6512007)(6306002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ghu3evENOHImeQq+EqLBVPDVivbdgfzXUwFAL1x00rE5z0iWxIXr7JLsC2+CtrzFuXMDHTF/gjchi5rEeu3kWkFHwkFetOetIouav9v9TifFgmaWDRggUpy3gj2EEoBNyBQh8K/meWGHSy8GNLpCIYiZon0r9FdNhbSabw+3D7v9R3OnQHLJoY8EGNtRsdNU0WgwMmxsGEacA76wy/uWvZOtDwFPnE+RXIRfLxAg6wEifqRHVN6nDLbo9mzFK7xpnW0kVxQTPJlxT8dhEVX9WxvPBjH+iGjemLPYF2ucESJy+nSXIarKyO9/cX/iXhtvJyR1dFZE5NZ2yU6gQkVNxlKyeORL6Hiy5T+x6wZLrq4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23ad327-1f45-442e-b30d-08d65a42645e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 23:44:12.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
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

Changes in v2:
- Drop the overflow asid_first_version() handling.
- Declare asid_first_version() & asid_version_mask() static inline now
  that they may not be used within the translation unit, in order to
  avoid unused-function warnings.

 arch/mips/include/asm/cpu-info.h    |  2 +-
 arch/mips/include/asm/mmu.h         |  2 +-
 arch/mips/include/asm/mmu_context.h | 10 ++++------
 arch/mips/mm/c-r3k.c                |  2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

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
index 94414561de0e..a589585be21b 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -76,14 +76,14 @@ extern unsigned long pgd_current[];
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
  */
-static unsigned long asid_version_mask(unsigned int cpu)
+static inline u64 asid_version_mask(unsigned int cpu)
 {
 	unsigned long asid_mask =3D cpu_asid_mask(&cpu_data[cpu]);
=20
-	return ~(asid_mask | (asid_mask - 1));
+	return ~(u64)(asid_mask | (asid_mask - 1));
 }
=20
-static unsigned long asid_first_version(unsigned int cpu)
+static inline u64 asid_first_version(unsigned int cpu)
 {
 	return ~asid_version_mask(cpu) + 1;
 }
@@ -102,14 +102,12 @@ static inline void enter_lazy_tlb(struct mm_struct *m=
m, struct task_struct *tsk)
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
-	unsigned long asid =3D asid_cache(cpu);
+	u64 asid =3D asid_cache(cpu);
=20
 	if (!((asid +=3D cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 		local_flush_tlb_all();	/* start new asid cycle */
-		if (!asid)		/* fix version if needed */
-			asid =3D asid_first_version(cpu);
 	}
=20
 	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
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

