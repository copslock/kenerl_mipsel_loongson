Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13883C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB99B20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="oxaCWQpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbfBBBpd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:45:33 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:47642
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBBpd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2//c+d9bRIkmx50EhvH7NYfrqdgGwJzOCOtwF3CduQ=;
 b=oxaCWQpCi1m4ECCKGWvpuxLvN/s8vElbp55Vg2A7Pxw4XS6eUvvN+eXUEtAS9aROC4BlKD47zYBYX0Cxni0+80LovLV1oJLeIQ9F01Ta3HMXYOHLxZpPv4sYMXoaKFvmmSwrrFXZuR6XzZKW9P8u1wnZ3zJd9uOeAsJVqyfoei0=
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
Subject: [PATCH 11/14] MIPS: mm: Unify ASID version checks
Thread-Topic: [PATCH 11/14] MIPS: mm: Unify ASID version checks
Thread-Index: AQHUupivZZWNvn16E0eR7VwgBTrhdg==
Date:   Sat, 2 Feb 2019 01:43:25 +0000
Message-ID: <20190202014242.30680-12-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:1IfP8XZcfCrMiqL+WkkyYz3++pRaLyUOKjC74ViaeKJvdBRSN6WVIzp1AXkU45tK/YxXOsDzWS0AKDmTgnseN1mVxIMrXjiTzR4p7RBeaYkJzoJs/0FQbp4W2nDNxKt1z4w4K5np/nhfTMv0u+zKgAHEGF0qTpbaxJBvgbEn7VwKAHwazmOooO/1CINIgl4qAIN5rzVkZkAZW2MH7yQpg6sQ134FuEY1CvH0qIl/SWPBPksIkz5UN9vg1BEgIhAH99vbfdedAgjpIES6e9AbLHR/RWWFSJ5Aw1+mgXdO6aBvsA1cr4/dM7zrx8Ms+jPifhAc+xeOue1txP0rFoJi+sayzzdRPy97LTe8ZYVI9uwD6vCTOPOCQ/o99suduEnHFAmRcXRRZQK7503ckerBHjXAxIfY+WuxLKvhDNNT6JRhxVc76Ab509qWGFH2ft84LJAI6iJ54jzNjcvfKe0dXw==;5:G/AQtQaftFvDz2c3DtVTSEVkcbzYPLK0XqNlwUDO0l4l6ybzI9YWXI3Ckei3S+XoRWwpciWiF066yEDZ/+cguA2nnPyooe+5X00atFBYVTyHFzYAtX0+8Cgt5wYNZDFmSJRTBMHBWjBsJJzw7r0ztEnTaXiVUe73sDD5Qw8mUFiDRTck/PmFrusMVmootXviIE2oeaoxeKpjuEZrI0YIsQ==;7:rucf92skUyMltnHSkVjIHoe1TG54WQy/BAuASxJNJ4G6111nfWcE90Ut6klJAmQNqcXLMS/XBgyElPegGHEWJC1deHmjqk3e5qzmdtfvnC1C0nCakr+vyirf58fs6UUYfMO2aWykS4Bouv4zn3bs5A==
x-ms-office365-filtering-correlation-id: 05d28b07-cbfb-4f0b-b076-08d688afd229
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439DD3ACEDD48EEA8D0E59DC1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5RSVf9uE4jN+pKO6vY0c6RhCzcyUhU1tzMA7O9kOITyz5rpRDZxmHuEmkaOpmfeiSGMkJtOXsdHpcND84Ffk/VG6OY6w99P86WiECXj6zOI7WqpEvrzO4SlA4RSuB4Zfvqkps1V2TFk756JDKreH1B0ak8mQhtJfIAif+2M2zP958HXOCgCWhPEfhTiwHnZfoE72sdaZQ1F/uhZkmPaC129KRzG1vWC+qlSMQMJoY2hUHM+AH+m14DXB0TfZJqljdPGhCiu20nEkIo75CZpufRvDON8zxIenPpJSoB4F8KoJSN9b/LsGQJ+c+e4iPGUABZtalkdQ9hXwBxhXwPW4oM4tQa64wRp7I8gG6P8lBY+tpQ1wg7K11pE5NYqMbaMGp625waIhh54/X5U8g3Csi0KdmfrTOF1h6N2SDc7jK0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d28b07-cbfb-4f0b-b076-08d688afd229
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:24.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Introduce a new check_mmu_context() function to check an mm's ASID
version & get a new one if it's outdated, and a
check_switch_mmu_context() function which additionally sets up the new
ASID & page directory. Simplify switch_mm() & various
get_new_mmu_context() callsites in MIPS KVM by making use of the new
functions, which will help reduce the amount of code that requires
modification to gain MMID support.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h |  8 +++-----
 arch/mips/kvm/trap_emul.c           | 22 ++++------------------
 arch/mips/kvm/vz.c                  |  6 +++---
 arch/mips/mm/context.c              | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index cb39a39d02f6..336682fb48de 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -98,6 +98,8 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, s=
truct task_struct *tsk)
 }
=20
 extern void get_new_mmu_context(struct mm_struct *mm);
+extern void check_mmu_context(struct mm_struct *mm);
+extern void check_switch_mmu_context(struct mm_struct *mm);
=20
 /*
  * Initialize the context related info for a new mm_struct
@@ -126,11 +128,7 @@ static inline void switch_mm(struct mm_struct *prev, s=
truct mm_struct *next,
 	local_irq_save(flags);
=20
 	htw_stop();
-	/* Check if our ASID is of an older version and thus invalid */
-	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & asid_version_mask(cpu))
-		get_new_mmu_context(next);
-	write_c0_entryhi(cpu_asid(cpu, next));
-	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	check_switch_mmu_context(next);
=20
 	/*
 	 * Mark current->active_mm as not "active" anymore.
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 503c2fb7e4da..22ffe72a9e4b 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -1056,11 +1056,7 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *=
vcpu, int cpu)
 	 */
 	if (current->flags & PF_VCPU) {
 		mm =3D KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
-		if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
-		    asid_version_mask(cpu))
-			get_new_mmu_context(mm);
-		write_c0_entryhi(cpu_asid(cpu, mm));
-		TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
+		check_switch_mmu_context(mm);
 		kvm_mips_suspend_mm(cpu);
 		ehb();
 	}
@@ -1074,11 +1070,7 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *v=
cpu, int cpu)
=20
 	if (current->flags & PF_VCPU) {
 		/* Restore normal Linux process memory map */
-		if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-		     asid_version_mask(cpu)))
-			get_new_mmu_context(current->mm);
-		write_c0_entryhi(cpu_asid(cpu, current->mm));
-		TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
+		check_switch_mmu_context(current->mm);
 		kvm_mips_resume_mm(cpu);
 		ehb();
 	}
@@ -1228,9 +1220,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run=
 *run,
 	 * Check if ASID is stale. This may happen due to a TLB flush request or
 	 * a lazy user MM invalidation.
 	 */
-	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
-	    asid_version_mask(cpu))
-		get_new_mmu_context(mm);
+	check_mmu_context(mm);
 }
=20
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vc=
pu)
@@ -1266,11 +1256,7 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *ru=
n, struct kvm_vcpu *vcpu)
 	cpu =3D smp_processor_id();
=20
 	/* Restore normal Linux process memory map */
-	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-	     asid_version_mask(cpu)))
-		get_new_mmu_context(current->mm);
-	write_c0_entryhi(cpu_asid(cpu, current->mm));
-	TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
+	check_switch_mmu_context(current->mm);
 	kvm_mips_resume_mm(cpu);
=20
 	htw_start();
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index d98c12a22eac..dde20887a70d 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2454,10 +2454,10 @@ static void kvm_vz_vcpu_load_tlb(struct kvm_vcpu *v=
cpu, int cpu)
 		 * Root ASID dealiases guest GPA mappings in the root TLB.
 		 * Allocate new root ASID if needed.
 		 */
-		if (cpumask_test_and_clear_cpu(cpu, &kvm->arch.asid_flush_mask)
-		    || (cpu_context(cpu, gpa_mm) ^ asid_cache(cpu)) &
-						asid_version_mask(cpu))
+		if (cpumask_test_and_clear_cpu(cpu, &kvm->arch.asid_flush_mask))
 			get_new_mmu_context(gpa_mm);
+		else
+			check_mmu_context(gpa_mm);
 	}
 }
=20
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index b5af471006f0..4dd976acf41d 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -17,3 +17,21 @@ void get_new_mmu_context(struct mm_struct *mm)
=20
 	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
 }
+
+void check_mmu_context(struct mm_struct *mm)
+{
+	unsigned int cpu =3D smp_processor_id();
+
+	/* Check if our ASID is of an older version and thus invalid */
+	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) & asid_version_mask(cpu))
+		get_new_mmu_context(mm);
+}
+
+void check_switch_mmu_context(struct mm_struct *mm)
+{
+	unsigned int cpu =3D smp_processor_id();
+
+	check_mmu_context(mm);
+	write_c0_entryhi(cpu_asid(cpu, mm));
+	TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
+}
--=20
2.20.1

