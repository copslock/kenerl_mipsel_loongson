Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03287C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE75C20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CmzBtN9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfBBBnk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:40 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:47642
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBBnk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHtdhcYVuxQPedW31QVdTYUEn6EK1br8N8rNOJ7VnQk=;
 b=CmzBtN9GRdk5RLCuLbItbMGOF8/K0UI6s19oCiLfeXseW9o4X9jwErAFIPoLDBmPCXvffiV2U4H0CIzDqJ6hi/Gj35shkSXnO2E2XQNYnmpbunk8uRp4+yrGb8k2ZDoHMk0j0oJ9bWzbG6BLmU6YLJolD6poZ2jHmOmOZBeSZEk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 08/14] MIPS: mm: Remove local_flush_tlb_mm()
Thread-Topic: [PATCH 08/14] MIPS: mm: Remove local_flush_tlb_mm()
Thread-Index: AQHUupiuR2H+RUsJgkiblC7kIOH/bQ==
Date:   Sat, 2 Feb 2019 01:43:22 +0000
Message-ID: <20190202014242.30680-9-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:XeJ0gw0+p4wYUkcWsCYDjquQm3j55YySZtvfRnxa5QGvRWw5QSWlbfocUOvCbzwAbh6VUFGn+ugnxDrkb/Y7azjIa8smc+quZPXWyG/sSz5o7tGYehmI1o80MfnPT/7+vCvB94GwEdRfh18JbKFbYGNXKhZoS5CzLeus4R8XqjV7sswhfJK/V0ulCZjbkxrLj6N0OcHL+AKD1C5a6ZW/kmIvuZraN1xTlxJKYKtFu4xnnKLpYmfAKc5f5dKdyStXV/npIzgbN2EqCCDAq8O1h2EJtfILjjZhHukq4FwA0wpMcxT1a55rZpJlXGq7sJbmzDmOCffvtUiXKWeP64Gw942v6ocGOisUXMGnIih/mq9Xj1eCM0v6Wa7FxZ7hOuDDAyOi1lFlAY8zfhBCel6qNgXECU+g7sF2BspI2QWlPGFDpqvQRRrEhQg3btEYzv2k8GODHbiizZwUXtL4ylu9LA==;5:5L9mbEc2pcg0wvt3tns5MMKobn77+/Msj3vKl5BbTDrOXBwxbZwysnCHk6cqtuPr8+zVHoxJef+8OnPlOSyYjctd7XtQrCSAPdxnZoTfe85HoYLdKCmjLiu/dfmH3OIq2b6KJOfi4wljjbBpQwnqfvYnEQrKw/i3V4HV5m87OyoWapQQk1I86IKb2H6fKRts+NfU/85O4Jksy2Y5w/IzPw==;7:OeniQz9PyWTGNm3d3EhDLidIEXGLzWl++HdkwC4jtjgUfkZH7OfUQKWyCU5qyt65Sm6C+Q/dNuL9Kh1SVp/4mqqBx7lSJCBw20Zo83p+vYuTWHqj57fEfY4UXfB59oAFZh7PuWJM0VLe8G4hzrN0YQ==
x-ms-office365-filtering-correlation-id: 0f665f75-5156-4a4e-9d70-08d688afd08a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439CE79C679EB56EC51C130C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F7C+79pi7dmzBCBrpPT1gHYjVxHBLrWR8WdLGf/Ofs9O9s5WgiL1n1UCpKg1KXzPUL9HS6sBoW/+87BverMvq29uil+3N66GV+5tm8RLr1HjVTelQFhzlwrdmmE3vN2A3Mz6MbfN21ltUPtY60iq3BdKeBA7btJkP45uegtyASRwETqrXBVKPxJzIBOwGoF+ulI7+4u+1GzbO/FqqcUkGMc6SGJ2SMJh450BwwvHV8UbsD2v2xI/KnlEyoHSXko3fojA54f8ecta5LSpS7f7I4PD/PJA5TGO4Cy8C8geegZhN1uy4WUKI1sE1bv8PWi9WtoSlFHqMy6SGnOIsQQmiFkRHNXLy7u5iBNuhN+OCvNZrhl8qq2/TMIHSHYooRAUTwwCzaILhaocaJvJOosYWBQf6riGwXhR+XMphBSDnBM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f665f75-5156-4a4e-9d70-08d688afd08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:21.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

All 3 variants of local_flush_tlb_mm() are now effectively simple calls
to drop_mmu_context(). Remove them and use drop_mmu_context() directly.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/tlbflush.h |  5 +++--
 arch/mips/kernel/smp.c           |  4 ++--
 arch/mips/mm/tlb-r3k.c           | 12 ------------
 arch/mips/mm/tlb-r4k.c           |  7 -------
 arch/mips/mm/tlb-r8k.c           |  5 -----
 5 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/tlbflush.h b/arch/mips/include/asm/tlbfl=
ush.h
index 40a361092491..9789e7a32def 100644
--- a/arch/mips/include/asm/tlbflush.h
+++ b/arch/mips/include/asm/tlbflush.h
@@ -14,7 +14,6 @@
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void local_flush_tlb_all(void);
-extern void local_flush_tlb_mm(struct mm_struct *mm);
 extern void local_flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void local_flush_tlb_kernel_range(unsigned long start,
@@ -23,6 +22,8 @@ extern void local_flush_tlb_page(struct vm_area_struct *v=
ma,
 	unsigned long page);
 extern void local_flush_tlb_one(unsigned long vaddr);
=20
+#include <asm/mmu_context.h>
+
 #ifdef CONFIG_SMP
=20
 extern void flush_tlb_all(void);
@@ -36,7 +37,7 @@ extern void flush_tlb_one(unsigned long vaddr);
 #else /* CONFIG_SMP */
=20
 #define flush_tlb_all()			local_flush_tlb_all()
-#define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
+#define flush_tlb_mm(mm)		drop_mmu_context(mm)
 #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma, vmadd=
r, end)
 #define flush_tlb_kernel_range(vmaddr,end) \
 	local_flush_tlb_kernel_range(vmaddr, end)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d84b9066b465..d7088ca31e43 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -487,7 +487,7 @@ void flush_tlb_all(void)
=20
 static void flush_tlb_mm_ipi(void *mm)
 {
-	local_flush_tlb_mm((struct mm_struct *)mm);
+	drop_mmu_context((struct mm_struct *)mm);
 }
=20
 /*
@@ -540,7 +540,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 				cpu_context(cpu, mm) =3D 0;
 		}
 	}
-	local_flush_tlb_mm(mm);
+	drop_mmu_context(mm);
=20
 	preempt_enable();
 }
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 60eb7a114440..50f207591b6d 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -67,18 +67,6 @@ void local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
=20
-void local_flush_tlb_mm(struct mm_struct *mm)
-{
-#ifdef DEBUG_TLB
-	int cpu =3D smp_processor_id();
-
-	if (cpu_context(cpu, mm) !=3D 0)
-		printk("[tlbmm<%lu>]", (unsigned long)cpu_context(cpu, mm));
-#endif
-
-	drop_mmu_context(mm);
-}
-
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
 			   unsigned long end)
 {
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 9fff08eabe8f..0114c43398f3 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -104,13 +104,6 @@ void local_flush_tlb_all(void)
 }
 EXPORT_SYMBOL(local_flush_tlb_all);
=20
-/* All entries common to a mm share an asid.  To effectively flush
-   these entries, we just bump the asid. */
-void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	drop_mmu_context(mm);
-}
-
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
 	unsigned long end)
 {
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index c938d6b497ef..c1e9e144007e 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -50,11 +50,6 @@ void local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
=20
-void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	drop_mmu_context(mm);
-}
-
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
 	unsigned long end)
 {
--=20
2.20.1

