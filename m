Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF72C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360AF20857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nCE/35C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfBBBoC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:44:02 -0500
Received: from mail-eopbgr770128.outbound.protection.outlook.com ([40.107.77.128]:62080
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfBBBoB (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1OhJwsXPaMNHk7z2LFnSceXj0JvYFm20w4IaA87+oY=;
 b=nCE/35C/JlqJJ4G+kt+KOfm9qRe9CzFnv01fUhALPosHYlaZY80CgTlhNgy5fMKh0ZwqipnyFt/vRIjwEbVbVe4+zG+dh/nvL7Vna2SJ6jHyalDSeNyTTPFhITYJTkhFxyy3f+jw4XfPOS5W2oO2FcIT5P63E8e5fZ7YAXiLvYw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 02/14] MIPS: mm: Remove redundant drop_mmu_context() cpu
 argument
Thread-Topic: [PATCH 02/14] MIPS: mm: Remove redundant drop_mmu_context() cpu
 argument
Thread-Index: AQHUupirPniLJJJn5kmqKYKosWoo8Q==
Date:   Sat, 2 Feb 2019 01:43:16 +0000
Message-ID: <20190202014242.30680-3-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:9sOOrncfE+SY+Wb7mNLTm5ZPY24bN//ixCZIkO2GNDfdc5TCxiRMEDNz60Q+svKy5r6K+FxolZVwLPe44znjhcvSOWWUmGIujo+SKEBkKx1fdiSMZrZZ3DkT3oeiLkrXds5PyfV0TfTOr7brwLz32UUTaYprPBf7wqYZrbke0rSCYPakY/27ZDqvXz8Znr7+cEOx++A4jrzlfEPUKCYUhnXdq9A6qk/7JMBPXK9o58OpBmnlYwESzcwJcAhZScUHl0Cq/ZWo4UMim4K1ttnVRulOD2+1ZMPURg7vBsbPEiveSKCa5BMczY9x/fju6zC47W/gmuls2mYvZd2pyffLVyScbVfBSJx1vYl6uLPuHMN/Q+ekJ0LhY9+wOLdYqo5+P2LU9JA0Adyr6/rPxbpUk8dPS4xhTMcSw3GKNUWmG+9P7yIoUPpIt5rHHMqsaSyHknxXbTb8z6j4NBeW5u3IZA==;5:oudhNnuo+d+EDOqsSvNxB+vFUU6+DYf8L4iI6ivi2INOjB5yVSTzd8icYgsH/9SdmB1MPmHzInE/39lMhNQQuGQkma5RrPXUneCihKcFObDZ2HGOla9ZJ+FJabDBnsA6a/R3kdZSzDQF0jcscLDskkAxPhsey1GXs/4xIH/9OLjcCgtDXHb4x88WV9OhnGMZKp2Wew4GZ/u8Kog6eXvEhQ==;7:ErtEPKHnWjLjVdcACnuKlJazsWqubzjhutNgzrF3kvkhpQaXIHCdCe0Qvy8Q6HCC2zbCOKxLyVgg0yKl1SM4N7lC2KTbpkBTeRzIjIkBGE7z9k6gItQ2ook3x6DQZjhg9At7gz+9Dj78I9XccoqFEw==
x-ms-office365-filtering-correlation-id: e7a73901-ef0d-4768-96e4-08d688afcd50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439D737C9F28997A3E3FF87C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hPJo4ePgLawPE8C92ybi2DIMNawBfbglz1+XJIh/0i+lriw2cZ7f6NZQmCnb4qnUM/ufUQHLZ1L0XeFL3tWwExtCSuKfb5sseERdVwNfH+SdUVtzKl5AXReCHJO0OAv4xZwKy+Bak/7fgXmHczqyqeMOpb4I9GC+kf+S7hFLz2f8kKueXpZmv+JH8zOCfXBjtzqzSkrUKtBZ1DM67X6C0FTlpU+iEHP+LBR0/oRK2CBCaofi89Qj09YOaGIABUXwhmAPHp2zIUUmLIGf2/IlPQ4PeiZbOswKxs6vCoIeL83ANjwtM/DrC/wYza2//eP+whUJFe8e/aJV2XUjSYwgnNZCMJARoUhGGRvkT1VqnSaoWqd2ua1EboBxMtPvDguQ5g/GnOAJhlVv035G2GVniIldtQstMKepbgA6JpZnN9o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a73901-ef0d-4768-96e4-08d688afcd50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:16.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The drop_mmu_context() function accepts a cpu argument, but it
implicitly expects that this is always equal to smp_processor_id() by
allocating & configuring an ASID on the local CPU when the mm is active
on the CPU indicated by the cpu argument.

All callers do provide the value of smp_processor_id() to the cpu
argument.

Remove the redundant argument and have drop_mmu_context() call
smp_processor_id() itself, making it clearer that the cpu variable
always represents the local CPU.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 4 +++-
 arch/mips/mm/c-r4k.c                | 2 +-
 arch/mips/mm/tlb-r3k.c              | 4 ++--
 arch/mips/mm/tlb-r4k.c              | 4 ++--
 arch/mips/mm/tlb-r8k.c              | 4 ++--
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 6731fa5ec4b9..dc45690cbbf5 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -174,13 +174,15 @@ static inline void destroy_context(struct mm_struct *=
mm)
  * we will get a new one for it.
  */
 static inline void
-drop_mmu_context(struct mm_struct *mm, unsigned cpu)
+drop_mmu_context(struct mm_struct *mm)
 {
 	unsigned long flags;
+	unsigned int cpu;
=20
 	local_irq_save(flags);
 	htw_stop();
=20
+	cpu =3D smp_processor_id();
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
 		get_new_mmu_context(mm, cpu);
 		write_c0_entryhi(cpu_asid(cpu, mm));
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d0b64df51eb2..1eca2b7e8a28 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -700,7 +700,7 @@ static inline void local_r4k_flush_cache_page(void *arg=
s)
 			int cpu =3D smp_processor_id();
=20
 			if (cpu_context(cpu, mm) !=3D 0)
-				drop_mmu_context(mm, cpu);
+				drop_mmu_context(mm);
 		} else
 			vaddr ? r4k_blast_icache_page(addr) :
 				r4k_blast_icache_user_page(addr);
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 6f589e0112ce..05a5ddccd9da 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -75,7 +75,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%lu>]", (unsigned long)cpu_context(cpu, mm));
 #endif
-		drop_mmu_context(mm, cpu);
+		drop_mmu_context(mm);
 	}
 }
=20
@@ -117,7 +117,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, =
unsigned long start,
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			drop_mmu_context(mm, cpu);
+			drop_mmu_context(mm);
 		}
 		local_irq_restore(flags);
 	}
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 0596505770db..6c99dfff71b2 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -115,7 +115,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 	cpu =3D smp_processor_id();
=20
 	if (cpu_context(cpu, mm) !=3D 0) {
-		drop_mmu_context(mm, cpu);
+		drop_mmu_context(mm);
 	}
=20
 	preempt_enable();
@@ -163,7 +163,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, =
unsigned long start,
 			write_c0_entryhi(oldpid);
 			htw_start();
 		} else {
-			drop_mmu_context(mm, cpu);
+			drop_mmu_context(mm);
 		}
 		flush_micro_tlb();
 		local_irq_restore(flags);
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index e86e2e55ad3e..20fa35d21776 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -55,7 +55,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 	int cpu =3D smp_processor_id();
=20
 	if (cpu_context(cpu, mm) !=3D 0)
-		drop_mmu_context(mm, cpu);
+		drop_mmu_context(mm);
 }
=20
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
@@ -75,7 +75,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, un=
signed long start,
 	local_irq_save(flags);
=20
 	if (size > TFP_TLB_SIZE / 2) {
-		drop_mmu_context(mm, cpu);
+		drop_mmu_context(mm);
 		goto out_restore;
 	}
=20
--=20
2.20.1

