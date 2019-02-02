Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7924AC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93B20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="feBoHz86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfBBBnd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:33 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:47642
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBBnc (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUEeYxYPuAdNu86RAms/S7U3Qn4grV3G67M8j4FhsYQ=;
 b=feBoHz86/1Ny2hZhbOaHAc02rVFokj8+eZErXLkUT6Tz/t8B9+WIROjHBWIzH6aY8GXvHsoD+3vdLPOafyg0n4sBXkP9PdHQY8Nyap8zupcPD3GvAzD4AnDql0ivEACskH1T8XmZM+Dtb2sw+YOeQtImf6chRINO9FZeI5Tpuzg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:19 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 03/14] MIPS: mm: Remove redundant get_new_mmu_context() cpu
 argument
Thread-Topic: [PATCH 03/14] MIPS: mm: Remove redundant get_new_mmu_context()
 cpu argument
Thread-Index: AQHUupirm8zF2D9DNUyMJJ+DDypXHQ==
Date:   Sat, 2 Feb 2019 01:43:17 +0000
Message-ID: <20190202014242.30680-4-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:qi68PoY0bc0LhB5Uf+6Zg9bUq6YID7RLo6AWd8JPfPOFZX0LcIkrnSiEsg/GRZHvN5BER30mWhZSGbPSJPOBCTgboXiggEeRZyPAryIw86NUYnzRLfjJxYNU0NFR7RujIbd1DMw/cORltxwGwTVO0UO7b7uPlmoj24lfYR1OU3UWChGtsJ86Rq0SFseCXQbTLbXAMcBIu21IzSXIhrPD3MYeex91FE7Mfb46WPIQMSDtDyJ9023vN3vlolxcRFCsh6yUmUZPSr2vFxmBDCBf1x0VyltWy0XhCjC4Hl3UTLhVz1snDgLZTqYHiKDK/qMgEZpc8kspD67u303yMwUYTNTbazwhDsV4aXKgkI3v1nB6mv2Czd3Xuscgr67xhafa2KHCXGZeJ6Bh2NHid/DEfp8+yP2qHdBDvm61EL04QXoCi3pGiVtxwkrwyBxv5Jjpj9RX6j+8S82H36DMi1LE4A==;5:Blt2iKGgKkJtZhUM2FGP+jYtWiLpnzKGbtpfHOtpiR9yF0RpWXaw+Qxb6rvnWqhl1v02jC8XnepEJgx5Gj0SUgryREE+bu4ehfN9dO9XefTsVqOeXk8uhh7XWC1ZnW7hHniZMtjCYuENtDiZHcJ9VQIhFERR/fkgDwNx+ZzKswpr0VTbilvunG9Zu0VLa2p52RPA052SMDQSCSr0UpbHsQ==;7:7laJkCwYY47hIgJIBtf7cIIshBIyQNIex3qtt1lVOgyM5DdAfymWPQ+XnOBikWC0hkITcT1Bg8PjRxcFaElKG1wXZ31CimHuhr8KyadNOhvwFYxPc2JYeQCxP2Qrb5euzshDgoKyk4tODEoer1EP0g==
x-ms-office365-filtering-correlation-id: cc8f921b-5606-4a95-876d-08d688afcddf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB14397A6F11F15036225F0C91C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dlNJUIKrbLuSqo9lnn2EpM8qDyji/FzIo6yJiHWYAudV6D4w1T8IbjfKL30ktv1DQNIjcIawd5cwkseuBCQRB0u03UFYrlVQLx4TCnTfWOpx3STuh7OTDqyW+hLkjODZkosc2YAa27kb/leMyFmM2RX1/RGMRHps4bl9hy2tXlCurqw3R1tSHNOq3GcBBzDxfK6wQZQWWbKGaut+kiF6kd2osZYxRPtF+Y5UrbEQiOB2WkPR2EfvkxkrknJzpJ+ihM/WMeNHL9JZPff2oV2IgTdtpSh9Xr35s4MjcwtWM/m5rZw6O4+lUNsRcipJAJ+OAgFLlrpslTFMZbuSKKXOPFP3zcyRv3FDHAfQW18SJSd6HaBRgzEO0whxANzPp8nSXDE3IlaTouEX2ZnuM264Q8qdIYQBcDbO6E8hw+7qOL0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8f921b-5606-4a95-876d-08d688afcddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:17.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

get_new_mmu_context() accepts a cpu argument, but implicitly assumes
that this is always equal to smp_processor_id() by operating on the
local CPU's TLB & icache.

Remove the cpu argument and have get_new_mmu_context() call
smp_processor_id() instead.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 12 ++++++++----
 arch/mips/kvm/emulate.c             |  2 +-
 arch/mips/kvm/trap_emul.c           | 10 +++++-----
 arch/mips/kvm/vz.c                  |  2 +-
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index dc45690cbbf5..0d050d781737 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -100,9 +100,13 @@ static inline void enter_lazy_tlb(struct mm_struct *mm=
, struct task_struct *tsk)
=20
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
-get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+get_new_mmu_context(struct mm_struct *mm)
 {
-	u64 asid =3D asid_cache(cpu);
+	unsigned int cpu;
+	u64 asid;
+
+	cpu =3D smp_processor_id();
+	asid =3D asid_cache(cpu);
=20
 	if (!((asid +=3D cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
@@ -142,7 +146,7 @@ static inline void switch_mm(struct mm_struct *prev, st=
ruct mm_struct *next,
 	htw_stop();
 	/* Check if our ASID is of an older version and thus invalid */
 	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & asid_version_mask(cpu))
-		get_new_mmu_context(next, cpu);
+		get_new_mmu_context(next);
 	write_c0_entryhi(cpu_asid(cpu, next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
=20
@@ -184,7 +188,7 @@ drop_mmu_context(struct mm_struct *mm)
=20
 	cpu =3D smp_processor_id();
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
-		get_new_mmu_context(mm, cpu);
+		get_new_mmu_context(mm);
 		write_c0_entryhi(cpu_asid(cpu, mm));
 	} else {
 		/* will get a new context next time */
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index ec9ed23bca7f..ca8347372427 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1016,7 +1016,7 @@ static void kvm_mips_change_entryhi(struct kvm_vcpu *=
vcpu,
 		 */
 		preempt_disable();
 		cpu =3D smp_processor_id();
-		get_new_mmu_context(kern_mm, cpu);
+		get_new_mmu_context(kern_mm);
 		for_each_possible_cpu(i)
 			if (i !=3D cpu)
 				cpu_context(i, kern_mm) =3D 0;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 6a0d7040d882..503c2fb7e4da 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -1058,7 +1058,7 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *v=
cpu, int cpu)
 		mm =3D KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
 		if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
 		    asid_version_mask(cpu))
-			get_new_mmu_context(mm, cpu);
+			get_new_mmu_context(mm);
 		write_c0_entryhi(cpu_asid(cpu, mm));
 		TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
 		kvm_mips_suspend_mm(cpu);
@@ -1076,7 +1076,7 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vc=
pu, int cpu)
 		/* Restore normal Linux process memory map */
 		if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
 		     asid_version_mask(cpu)))
-			get_new_mmu_context(current->mm, cpu);
+			get_new_mmu_context(current->mm);
 		write_c0_entryhi(cpu_asid(cpu, current->mm));
 		TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
 		kvm_mips_resume_mm(cpu);
@@ -1113,7 +1113,7 @@ static void kvm_trap_emul_check_requests(struct kvm_v=
cpu *vcpu, int cpu,
 		/* Generate new ASID for current mode */
 		if (reload_asid) {
 			mm =3D KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
-			get_new_mmu_context(mm, cpu);
+			get_new_mmu_context(mm);
 			htw_stop();
 			write_c0_entryhi(cpu_asid(cpu, mm));
 			TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
@@ -1230,7 +1230,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run=
 *run,
 	 */
 	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
 	    asid_version_mask(cpu))
-		get_new_mmu_context(mm, cpu);
+		get_new_mmu_context(mm);
 }
=20
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vc=
pu)
@@ -1268,7 +1268,7 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run=
, struct kvm_vcpu *vcpu)
 	/* Restore normal Linux process memory map */
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
 	     asid_version_mask(cpu)))
-		get_new_mmu_context(current->mm, cpu);
+		get_new_mmu_context(current->mm);
 	write_c0_entryhi(cpu_asid(cpu, current->mm));
 	TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
 	kvm_mips_resume_mm(cpu);
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 74805035edc8..d98c12a22eac 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2457,7 +2457,7 @@ static void kvm_vz_vcpu_load_tlb(struct kvm_vcpu *vcp=
u, int cpu)
 		if (cpumask_test_and_clear_cpu(cpu, &kvm->arch.asid_flush_mask)
 		    || (cpu_context(cpu, gpa_mm) ^ asid_cache(cpu)) &
 						asid_version_mask(cpu))
-			get_new_mmu_context(gpa_mm, cpu);
+			get_new_mmu_context(gpa_mm);
 	}
 }
=20
--=20
2.20.1

