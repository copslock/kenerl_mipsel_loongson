Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F5C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628D204EC
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fHvQTDkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfBBBnu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:50 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfBBBnu (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qT4TukQ7c+l9mSECXE/tgVQKuX9CpKeSCAY34obhQ=;
 b=fHvQTDkFGYMEeZ08GV6yope3H36tKTITse2LXmuSj/urCfnBSDXOCyoppnnWsRzLNBJ9eJWObZ6uBeTlz0vCVksGsL1//p/Smw8y0Fo3I0gIwpLrqfkJMk5/iCNG04eGRlmQd0rMPGd48xq731IbWt3PVxurkKPnm0N7HNEmYJ0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:26 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:26 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 10/14] MIPS: mm: Un-inline get_new_mmu_context
Thread-Topic: [PATCH 10/14] MIPS: mm: Un-inline get_new_mmu_context
Thread-Index: AQHUupiv++FjsF0VgEqyhVD8T1+nsQ==
Date:   Sat, 2 Feb 2019 01:43:24 +0000
Message-ID: <20190202014242.30680-11-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:5CFFcX8Tjjazzv0KxQjWAr6dllsG+FhF0PoEI0G2M2LZZN4H6YDglZ40X+t1Qs75NLjHKjqp3PymR2f7ijwjOAF0b+13W6IeFMNAnAGl9G2IzehGIhtJLjCniKzAbm5lhLa6kaOVP23NwZvuet75pI5/fiH9qoKbQ917KMNlUhMChXVV1KmA7AE4nZVz/gsQ0I6JXBLGkaypb+dbSjUQ5PqDlXblPm8+dmWRT47gVv60xbyJiMqohRZGn7fr/9Z91R5x0AANP5XMDWu6FV47E/0MwjZDTalkuHxuYCQ5NP1tIUHJo0D9NLjL0vsV/AubFJUyROHqIKus8XnoG8Gl5y3YdCnACX1XyskgnnJ/XLBuv9bHzsGGL21cZqQ4QMsIVSzmOfYYgGTFV8BY1EXrk6Z7Alv/AXSXw57PLAyF3teAaTJcBMKQALe8xxbXSELIhEE+BwW3pUgnSHCkH3vahA==;5:9yWgywL2+N8NesMJ8RYvZN2NOv3nQ/NyDZsPLcs5gDB2L8dLm7Rqnm5wRCZ84QGvNSw0vFAU4Ny3IGSpy4magzZssdJ/yM3o2KgOuoYKzZto2kmmvaKbQ4UbVzN0NcTb2PWAL6MZ7ivxyuBWo14NveyBucIkihumJTmVuc90fycsd6Bxeqbl5jvNqKMPe1PEcoLaHfGfR+pyjfn8oDrqnQ==;7:0PpVERJQnqa7R4+Ho2G3wZSQqWc4XTNeoUwU0d0fId+mdS6PR2OxDD3eY5c+oizgXQ6gcsejZWGN6mEHnHlhp4FLLk+B7fhMJ7LR9Zpnl4KtotD2nBZFOdIgpfXVzZbGLXMnOdVA3xHnXm3zPCr3Sw==
x-ms-office365-filtering-correlation-id: cb9d976f-a606-4856-80d6-08d688afd192
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB143972376976FF51DFBDD5BBC1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pn8kNcdf8DqTRIwtKrFceA+a/Z8i3ZGIWAKpnWaDasMc92Ti5eimGFR75zIE+KSttHgFl78SEJSByvQ2t5RFtT82eTN6GCE3sgNMvk+zdifDIJZMUDR/0/x27PRwZFS5uQsZt0cXSQG6dmcNSe0A/spa6kOfjZfPu68lZGvUmQUmsJRhH8njzrpXOK3EveHBnjSycWaCK0qxPklX8IG4wrCEkOmN/M6ccuIBZ21D0VkEBYifN7sDzxCOh2GVPSFrLbK335Zov3V9gwGchvo+AiNFfuF35oawPxxVUQKL7WruYEdSM4LoMhxGM3fMQ7YxG8l6L42RcYxEz7G3XSmFILga4HfRKzku6LAXMELkXwZDWCLLjW9s35npq41c18ffRI4AP3XyiLBHLbN2Ls4YMDmVTmm7dXk12+lYPQtb6Kk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9d976f-a606-4856-80d6-08d688afd192
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:23.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

In preparation for adding MMID support to get_new_mmu_context() which
will increase the size of the function somewhat, move it from
asm/mmu_context.h into a C file.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 20 +-------------------
 arch/mips/mm/Makefile               |  1 +
 arch/mips/mm/context.c              | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/mm/context.c

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 752ebda82cdd..cb39a39d02f6 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -97,25 +97,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, =
struct task_struct *tsk)
 {
 }
=20
-
-/* Normal, classic MIPS get_new_mmu_context */
-static inline void
-get_new_mmu_context(struct mm_struct *mm)
-{
-	unsigned int cpu;
-	u64 asid;
-
-	cpu =3D smp_processor_id();
-	asid =3D asid_cache(cpu);
-
-	if (!((asid +=3D cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
-		if (cpu_has_vtag_icache)
-			flush_icache_all();
-		local_flush_tlb_all();	/* start new asid cycle */
-	}
-
-	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
-}
+extern void get_new_mmu_context(struct mm_struct *mm);
=20
 /*
  * Initialize the context related info for a new mm_struct
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 25d492736848..f34d7ff5eb60 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -4,6 +4,7 @@
 #
=20
 obj-y				+=3D cache.o
+obj-y				+=3D context.o
 obj-y				+=3D extable.o
 obj-y				+=3D fault.o
 obj-y				+=3D gup.o
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
new file mode 100644
index 000000000000..b5af471006f0
--- /dev/null
+++ b/arch/mips/mm/context.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mmu_context.h>
+
+void get_new_mmu_context(struct mm_struct *mm)
+{
+	unsigned int cpu;
+	u64 asid;
+
+	cpu =3D smp_processor_id();
+	asid =3D asid_cache(cpu);
+
+	if (!((asid +=3D cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
+		if (cpu_has_vtag_icache)
+			flush_icache_all();
+		local_flush_tlb_all();	/* start new asid cycle */
+	}
+
+	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
+}
--=20
2.20.1

