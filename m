Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB39C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2FE20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DVHhCS9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfBBBnV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:21 -0500
Received: from mail-eopbgr770128.outbound.protection.outlook.com ([40.107.77.128]:62080
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfBBBnU (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVQNadAPndkRJn/PhE3WqHDIveZZxyuwrIQ7jmtqqfs=;
 b=DVHhCS9FzjvxcrmgjxPIKNwMH9NgGRWkQpMATDhsc6s53V7ASlOh8B6u6tNXKcDT9lpWx/D0suwG2A50RHlYAt2G32Pn09MByATNCeYyCqpRwz+kAyU36liRrauiMMafxkzVupMIZ6FUF4+ePuJbpa9YtnAIxs4JTqTjrJSDeeA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 01/14] MIPS: mm: Define activate_mm() using switch_mm()
Thread-Topic: [PATCH 01/14] MIPS: mm: Define activate_mm() using switch_mm()
Thread-Index: AQHUupiqp1Sra5g7vEKmmfY4jNBCDA==
Date:   Sat, 2 Feb 2019 01:43:15 +0000
Message-ID: <20190202014242.30680-2-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:3JnP0V6y+EyVK4Rqjvzyz96dVN1H7+k/gMuZoymRPmmk7OkbX26MTIPC85ZMiSWmhH4FRu3gFafRjWW8+VKdyqBNbQw3D/rtxifimQu+Vk9VK8NXblwmK+BezIUjzueIOEkdRpbmO3pZzkEh19mkawr0KeZfNgFxV1Nzq7l8y3utmEgMArc8OsYPFfCmRcyBpL0isRjpatNGjoJ46ckv7NLRH6MhEin66F2Ucxrd6of6vMih9qTY2jX+dCgx7ep5qaZWW3vJVMPmN7C5Br+WdNGnRVQ43jNCItOlnAXK2UznlmlCVaOOHMcKM60zHmp39Ho/mc6XKhmjfUt7CBWuMUOt+0JC4g+iAWKTRunM2Wojw+wQXy7AhObWkpfGwsk2drNq4Gq0NkMc8JV3SgUGnqXBy50c+ihBwV1M1md4lrptt0LmUnry4tJKcDFSoYlS2PvwGlyuu3PFFgzoiQC9Rg==;5:eaGCPgVdKAXr/2OkaNe65S4BlYpCAPeEouWTbIJqy1Z5yNfddPjQUlIQe7y/2eHzYXku2vhgsaoyOGDg+BLL0BOA0CSrtVP/K40tF8QS56CPTlpo/JT/UDlSXiZjs9adxqgG1CAKHhXjs80rJq5/OwkCUty0h+oQejf3eAR4Q6sdkfh5obi9zcLySJ6AfMGZaJVes13bPrlXMzXtjRNaWg==;7:gNkG+5GVn+LWRbldK6TXrNnBVOslpwKrvxHxuSL0yCI3GNIrk2pmwUvGkZTwtKxSeTiJe0SAoy27UhzOTj9l6WhEtn27CRKV6t4uG1zLzF0LcmQCu24+zzqQPm4BZ6TJIV4xxNJzij1U+qCKDm6dBQ==
x-ms-office365-filtering-correlation-id: af5bc491-d48e-4ec0-2d52-08d688afccc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439D7C0F14BA0C78D916DA4C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 18V4NFIQRPazZkj2yCStctw8vDWYe54wNNJQj7zOQfsiQAXA1H/W45/vypwXg2+ANzzNOJ3c7rc0SPOpY79jOPwNiAdkRMmx9lAog5QW+BSzMb1zu1M9YN+gGzfdM1L366/PWeruPZDaH4WOKWUOarZI8Hqv3yfOawmo+HMrDBRdfh9DIfhAPWEuzVxKsC8/Ld3v7mv1QLe4qO1MWmizextgL4erHwlKR0QStyIfjOZr6Qr6U2gsSP+NUiOjiaxBsIzx66TYlcnLFN837nEbblA8BMhr557ZojDtuxDqDZS1mzWHU2ndp6gdEwwOBcuLl49yrU//1B/SLZRs6y9eecc8fkLQH+mLDXZ+PI6BS3xP8pGFM6/b0ijJ179G1VXGVvXbLBXsikpkP5akOaa2S/1n/CbusdpfUqgZM3dCxYQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5bc491-d48e-4ec0-2d52-08d688afccc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:15.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

MIPS has separate definitions of activate_mm() & switch_mm() which are
identical apart from switch_mm() checking that the ASID is valid before
acquiring a new one.

We know that when activate_mm() is called cpu_context(X, mm) will be
zero, and this will never be considered a valid ASID because we never
allow the ASID version number to be zero, instead beginning with version
1 using asid_first_version(). Therefore switch_mm() will always allocate
a new ASID when called for a new task, meaning that it will behave
identically to activate_mm().

Take advantage of this to remove the duplication & define activate_mm()
using switch_mm() just like many other architectures do.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index a589585be21b..6731fa5ec4b9 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -166,35 +166,9 @@ static inline void destroy_context(struct mm_struct *m=
m)
 	dsemul_mm_cleanup(mm);
 }
=20
+#define activate_mm(prev, next)	switch_mm(prev, next, current)
 #define deactivate_mm(tsk, mm)	do { } while (0)
=20
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void
-activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	unsigned long flags;
-	unsigned int cpu =3D smp_processor_id();
-
-	local_irq_save(flags);
-
-	htw_stop();
-	/* Unconditionally get a new ASID.  */
-	get_new_mmu_context(next, cpu);
-
-	write_c0_entryhi(cpu_asid(cpu, next));
-	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
-
-	/* mark mmu ownership change */
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
-	cpumask_set_cpu(cpu, mm_cpumask(next));
-	htw_start();
-
-	local_irq_restore(flags);
-}
-
 /*
  * If mm is currently active_mm, we can't really drop it.  Instead,
  * we will get a new one for it.
--=20
2.20.1

