Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165BC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3828320857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CY82Coo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfBBBnx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:53 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfBBBnw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqyAvCcAMR5/diJoqIstnpEyK1V1gK4GOlK7nWKXAIM=;
 b=CY82Coo6PsqMGySnQXRflAbk16/Or2qL6bpURqVozEfACOc5Pka+m6m61v81X+KirWI3jPbbnUW2nw9rWBZda7OyR/theVs9boMD8hlm5BNz2NdQH6hiwslT69V6eeyks/Mzx/mlAqFXjAmI3JHHppLYhjEecnqNvx5MP2kzBq0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:27 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:27 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 12/14] MIPS: mm: Add set_cpu_context() for ASID assignments
Thread-Topic: [PATCH 12/14] MIPS: mm: Add set_cpu_context() for ASID
 assignments
Thread-Index: AQHUupiwK95Bfgsi7kSbR+TcZObCBQ==
Date:   Sat, 2 Feb 2019 01:43:25 +0000
Message-ID: <20190202014242.30680-13-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:dTalk/AeOdoFY3a2o9ttFxUYB7h0WNgDEp1ofnlHDkaC8Z9ok6ZlH9yrhe4PYtAc/fX1Jxl9QexI2OHkUHGdrVa3yyszavNKgMGuuBrBJks7xXdAUI6oucx+vlKYaN0QJ/o04Ss/Nlk6H0HMtnRdbu+xvvmlRO+tZ1ZoPQfNix6x2ozS/yXri8L2Tjz1zmXa34nCUcAm8qSn9cSgoZRYwNx5ZL1q/a0baL3YOLrhyT10b5gENgLIcTZFAUihMW1G9JpzKLxo7GXcnkD3ldAdxWoPbglLZTKNGvPy36X8neAhp01X0TatP7+CSoecgMfbdTSsfzd0Dy8g50kpcvKx+37DE1Kj/qFahtPylsM0fEpsZTCX6O1G37vTYeAUjjuyuaz03g8aORenrt5+0m5XG+hOKlCkSt5L3GNYWWbASDHapdRI2+359LA9bLL3EBVdzJVfPHVOE7wnQNfQIKioJA==;5:Yxa30RwHu+MReZx0iurLxP8Vc/jG4TfKXqv4npDv2PuXv4d+k2J9m1jOF86PbdmXiCFC4tyfw9AtsxQJXSaDFIVNaLN48ujFIHetk6zalXi1TFr7wPtdjjbAQplRQuh6cOn5NaLnGBFVQzgHDx6+iGixdHlrhvd9Z/8+EjiJ2TWSmcwdKRhv42vQyw5pIliPSWDTsQmhpnVGVsgXenDCwQ==;7:gL0N/owb7lK2j5g9+wP8xNxRkIZfcV6zQmGc0JjJ5AeWyU7p0AtgU6uxG0Y49Wr3+OscyWJ87oAMR+1mVL+Uvbd+Wb9TP5e4gXN3kaKLU0vM4S8icIOyJlZ1ScBEBO9In14L/unPlHAKfnTb+choEA==
x-ms-office365-filtering-correlation-id: 6093d552-795b-4e7a-f585-08d688afd2bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439A77F2B5EB1EE9B3452F3C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OfVHdEqWsxEEODCxHRuSd+PwNTdntlmnXFNvVJgpyjoZ39dBAMJ8pIZkiukAIDECwEeiVocuIPoq90IyijikkU9vGDRTHGK+TD3aiHkVxovEauGn2+0j2eyeJwMOVCfuALUFPPKDdtIjHzTJNFdZwi4zS7yPhXiRFUgodQt7BptOCh8nHEUWLd54uQo83vrmZWIC+y9UrQrEf3aF2fGlla0gn26SaQHwRzKqp3EjG0apjHCIvfvdj5kNtd0F58fV9IjumySCrjSeAi/LXU/NBTZUyajeJgF9FWEVwCS7X+losxq1LVNzBeyp1o2ccxCudihVWy9FCbzkSI7ObxThVjzR7rtTnabuHKPjAV8BgZZn9dSAF6h0amHmYFoGa5qijhHmbTu1BAxMRJftXVmaEyl92ksXhuVfiG5r9tOifPs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6093d552-795b-4e7a-f585-08d688afd2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:25.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

When we gain MMID support we'll be storing MMIDs as atomic64_t values
and accessing them via atomic64_* functions. This necessitates that we
don't use cpu_context() as the left hand side of an assignment, ie. as a
modifiable lvalue. In preparation for this introduce a new
set_cpu_context() function & replace all assignments with cpu_context()
on their left hand side with an equivalent call to set_cpu_context().

To enforce that cpu_context() should not be used for assignments, we
rewrite it as a static inline function.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 16 +++++++++++++---
 arch/mips/kernel/smp.c              |  6 +++---
 arch/mips/kvm/emulate.c             |  6 +++---
 arch/mips/kvm/trap_emul.c           |  6 +++---
 arch/mips/mm/context.c              |  3 ++-
 5 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 336682fb48de..a0f29df8ced8 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -88,7 +88,17 @@ static inline u64 asid_first_version(unsigned int cpu)
 	return ~asid_version_mask(cpu) + 1;
 }
=20
-#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
+static inline u64 cpu_context(unsigned int cpu, const struct mm_struct *mm=
)
+{
+	return mm->context.asid[cpu];
+}
+
+static inline void set_cpu_context(unsigned int cpu,
+				   struct mm_struct *mm, u64 ctx)
+{
+	mm->context.asid[cpu] =3D ctx;
+}
+
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 #define cpu_asid(cpu, mm) \
 	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
@@ -111,7 +121,7 @@ init_new_context(struct task_struct *tsk, struct mm_str=
uct *mm)
 	int i;
=20
 	for_each_possible_cpu(i)
-		cpu_context(i, mm) =3D 0;
+		set_cpu_context(i, mm, 0);
=20
 	mm->context.bd_emupage_allocmap =3D NULL;
 	spin_lock_init(&mm->context.bd_emupage_lock);
@@ -175,7 +185,7 @@ drop_mmu_context(struct mm_struct *mm)
 		htw_start();
 	} else {
 		/* will get a new context next time */
-		cpu_context(cpu, mm) =3D 0;
+		set_cpu_context(cpu, mm, 0);
 	}
=20
 	local_irq_restore(flags);
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d7088ca31e43..f9dbd95e1d68 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -537,7 +537,7 @@ void flush_tlb_mm(struct mm_struct *mm)
=20
 		for_each_online_cpu(cpu) {
 			if (cpu !=3D smp_processor_id() && cpu_context(cpu, mm))
-				cpu_context(cpu, mm) =3D 0;
+				set_cpu_context(cpu, mm, 0);
 		}
 	}
 	drop_mmu_context(mm);
@@ -583,7 +583,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsign=
ed long start, unsigned l
 			 * mm has been completely unused by that CPU.
 			 */
 			if (cpu !=3D smp_processor_id() && cpu_context(cpu, mm))
-				cpu_context(cpu, mm) =3D !exec;
+				set_cpu_context(cpu, mm, !exec);
 		}
 	}
 	local_flush_tlb_range(vma, start, end);
@@ -635,7 +635,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigne=
d long page)
 			 * by that CPU.
 			 */
 			if (cpu !=3D smp_processor_id() && cpu_context(cpu, vma->vm_mm))
-				cpu_context(cpu, vma->vm_mm) =3D 1;
+				set_cpu_context(cpu, vma->vm_mm, 1);
 		}
 	}
 	local_flush_tlb_page(vma, page);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index ca8347372427..0074427b04fb 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1019,7 +1019,7 @@ static void kvm_mips_change_entryhi(struct kvm_vcpu *=
vcpu,
 		get_new_mmu_context(kern_mm);
 		for_each_possible_cpu(i)
 			if (i !=3D cpu)
-				cpu_context(i, kern_mm) =3D 0;
+				set_cpu_context(i, kern_mm, 0);
 		preempt_enable();
 	}
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
@@ -1090,8 +1090,8 @@ static void kvm_mips_invalidate_guest_tlb(struct kvm_=
vcpu *vcpu,
 		if (i =3D=3D cpu)
 			continue;
 		if (user)
-			cpu_context(i, user_mm) =3D 0;
-		cpu_context(i, kern_mm) =3D 0;
+			set_cpu_context(i, user_mm, 0);
+		set_cpu_context(i, kern_mm, 0);
 	}
=20
 	preempt_enable();
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 22ffe72a9e4b..73daa6ad33af 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -1098,8 +1098,8 @@ static void kvm_trap_emul_check_requests(struct kvm_v=
cpu *vcpu, int cpu,
 		kvm_mips_flush_gva_pt(kern_mm->pgd, KMF_GPA | KMF_KERN);
 		kvm_mips_flush_gva_pt(user_mm->pgd, KMF_GPA | KMF_USER);
 		for_each_possible_cpu(i) {
-			cpu_context(i, kern_mm) =3D 0;
-			cpu_context(i, user_mm) =3D 0;
+			set_cpu_context(i, kern_mm, 0);
+			set_cpu_context(i, user_mm, 0);
 		}
=20
 		/* Generate new ASID for current mode */
@@ -1211,7 +1211,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run=
 *run,
 		if (gasid !=3D vcpu->arch.last_user_gasid) {
 			kvm_mips_flush_gva_pt(user_mm->pgd, KMF_USER);
 			for_each_possible_cpu(i)
-				cpu_context(i, user_mm) =3D 0;
+				set_cpu_context(i, user_mm, 0);
 			vcpu->arch.last_user_gasid =3D gasid;
 		}
 	}
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index 4dd976acf41d..dcaceee179f7 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -15,7 +15,8 @@ void get_new_mmu_context(struct mm_struct *mm)
 		local_flush_tlb_all();	/* start new asid cycle */
 	}
=20
-	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;
+	set_cpu_context(cpu, mm, asid);
+	asid_cache(cpu) =3D asid;
 }
=20
 void check_mmu_context(struct mm_struct *mm)
--=20
2.20.1

