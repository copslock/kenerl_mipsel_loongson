Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF9EC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DD920857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EwsUMLXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfBBBnf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:35 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfBBBnf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZLQYO7Kna0oOxB9Oxzc0bxgpDu658l7OFUPw7bDHL4=;
 b=EwsUMLXkpBzDZn+n4lmMD/1aajXkMDe6zokIZ3V6lLrgbwmFtEF4vgchakN0A27dtallZyzxVuaOkD/CSKxKV1vAHcEIUjbeVA2zesr4i4SvIjruGtY0WV1C52wKynwDhd9S7UZb6YJ1iCrei7RdtucWWDWconORc0Oo7yVrhWg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:23 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 05/14] MIPS: mm: Consolidate drop_mmu_context() has-ASID
 checks
Thread-Topic: [PATCH 05/14] MIPS: mm: Consolidate drop_mmu_context() has-ASID
 checks
Thread-Index: AQHUupis8W8LOrjv3EuxCruob30+/w==
Date:   Sat, 2 Feb 2019 01:43:19 +0000
Message-ID: <20190202014242.30680-6-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:BtmowXMP4T0SdFmILQeNUmkHASedPq2MmGzspG8Z8UkxbPPKsGGvZDM3rMcA+n+o9NWc25G6kXND7TxbDDrDXSw0/Rw6iSoZd9dIHcyc+R2hZUfegUz5WZ7Fy9M6VGPQIsZ/HA5HfroWtX2Q52yaFeozjZ4e4pG3nXHAGxK+pbbzFcCPmK+p0sZx8GuJSOtCdi/eHJUIzN7vz+qeB4N/Kx+dEAWMaKa8tXIkQYikS/7fMaj4QzPiudGgmq/aNgp7Pg0wpG+q+JDBwq6fBhjsfz43giLdXwxjzZb3STtqBty7jPU+hKSxIBcVwGpbibSCK7SC8gurKzCskwRDwh+hKLWRou6dneRhIDmvBiabdSNF2vzcHaFK7kkhfXF7u0NrOc3JE6whoROc2prv0IwOJcZ67SuDrSQmdz+9cvrN04vxnf1k4weizWFQOexmT8gPqqyNGxLezTbBRjLcTwlCRg==;5:svcnaWmJM1eb5VXhwxSqysKbgamuYSNwbTd+5v+a2CsraRviDVzapEio1QAyTusigF7y+FU79xsWW70X7H/JJSbk34XL/KdY4W16l8ytWguAOxjRx0AWZXUuOFpr1eNa+qO+na4vK4g2p/JovGvrNsOT5GOwHc3pcTedoD1lD43zvlpqFg0L8a/jt1X2kK00TcDaWj/311dw1DzYSHyoZA==;7:Ol9sN3v8WpfWoDpoZPxbWRzPzPwq+nVIRq8F4SZBUttDWzQ+Sa2uWS0zbmp1jd5HJQj0V8A85k6faRTmZjLYvbcGNvHVtpetUjtue4cqx/+CtiwJW7OE8P9WitFaTAi7/kfHQs1LztciSHhucREN3Q==
x-ms-office365-filtering-correlation-id: 662fecae-6b2b-4439-621c-08d688afcef6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439E613E4324360B524ACC3C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(6666004)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1pw5oa+A4C/nDNSgwCgoDqWNSTjhXHCQRX7EfR4PiNtCSktV5HzaYWjAzyKmQ4KL6ga3kHIEb/Fuzn791XXZ96oKVz9H3STcm709AOooXEzVgRtEuD14CJJ4e+CAxEDM7AkJU12EUIqb2wntPD00TtAvjFEMtjgGHg81eqoMUXqpxpc3WBszIaOk+wgss8Qs2zGBKkXcD2EZYspiStmuAxLjzawjOAqp42zzFCLrwBLM9biQC4hhMG0M50VC39QK4NgGqm1A6kP7iQKcwsduaiU88JTR056HQ/vx3e8WfOmikg7PPl2bDk4nevOOw8UF3g5lcP8A2tGd8CPm7Qs9dLyk6ey7moiagpFVYv1dFvijBkHgNrRIhvIuHBF73/fXglJFd+G6ze51wSEztWCOj11wywDvjcUpM3YmLgqFr1M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662fecae-6b2b-4439-621c-08d688afcef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:19.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

If an mm does not have an ASID on the local CPU then drop_mmu_context()
is always redundant, since there's no context to "drop". Various callers
of drop_mmu_context() check whether the mm has been allocated an ASID
before making the call. Move that check into drop_mmu_context() and
remove it from callers to simplify them.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h |  4 +++-
 arch/mips/mm/c-r4k.c                |  5 +----
 arch/mips/mm/tlb-r3k.c              |  8 ++++----
 arch/mips/mm/tlb-r4k.c              | 10 +---------
 arch/mips/mm/tlb-r8k.c              |  5 +----
 5 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 5d0a73a5cf40..1b8392dcd354 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -186,7 +186,9 @@ drop_mmu_context(struct mm_struct *mm)
 	local_irq_save(flags);
=20
 	cpu =3D smp_processor_id();
-	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
+	if (!cpu_context(cpu, mm)) {
+		/* no-op */
+	} else if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
 		htw_stop();
 		get_new_mmu_context(mm);
 		write_c0_entryhi(cpu_asid(cpu, mm));
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1eca2b7e8a28..248d9e8263cf 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -697,10 +697,7 @@ static inline void local_r4k_flush_cache_page(void *ar=
gs)
 	}
 	if (exec) {
 		if (vaddr && cpu_has_vtag_icache && mm =3D=3D current->active_mm) {
-			int cpu =3D smp_processor_id();
-
-			if (cpu_context(cpu, mm) !=3D 0)
-				drop_mmu_context(mm);
+			drop_mmu_context(mm);
 		} else
 			vaddr ? r4k_blast_icache_page(addr) :
 				r4k_blast_icache_user_page(addr);
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 05a5ddccd9da..60eb7a114440 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -69,14 +69,14 @@ void local_flush_tlb_all(void)
=20
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
+#ifdef DEBUG_TLB
 	int cpu =3D smp_processor_id();
=20
-	if (cpu_context(cpu, mm) !=3D 0) {
-#ifdef DEBUG_TLB
+	if (cpu_context(cpu, mm) !=3D 0)
 		printk("[tlbmm<%lu>]", (unsigned long)cpu_context(cpu, mm));
 #endif
-		drop_mmu_context(mm);
-	}
+
+	drop_mmu_context(mm);
 }
=20
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 6c99dfff71b2..ba76b0c11d38 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -108,16 +108,8 @@ EXPORT_SYMBOL(local_flush_tlb_all);
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	int cpu;
-
 	preempt_disable();
-
-	cpu =3D smp_processor_id();
-
-	if (cpu_context(cpu, mm) !=3D 0) {
-		drop_mmu_context(mm);
-	}
-
+	drop_mmu_context(mm);
 	preempt_enable();
 }
=20
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index 20fa35d21776..c938d6b497ef 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -52,10 +52,7 @@ void local_flush_tlb_all(void)
=20
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	int cpu =3D smp_processor_id();
-
-	if (cpu_context(cpu, mm) !=3D 0)
-		drop_mmu_context(mm);
+	drop_mmu_context(mm);
 }
=20
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
--=20
2.20.1

