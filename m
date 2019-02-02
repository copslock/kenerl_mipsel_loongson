Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22590C4151A
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A62148D
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IV23nV/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfBBBnf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:35 -0500
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:47642
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBBnf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW2ksCaE5mDikXhXOclHUNVcxX09ADbu4/m9+lJaOUo=;
 b=IV23nV/GGqtgcUj0jzQsjMq6k6QfwIGgZsFmRPylao6RjYOafLn9gfdEnrY0Zm0k8md9lRI0dWhar8K9w/13dNho4mKQhW4+f/I2uoHObQ0wWMKjUDRkGpaYkqByoAuoUaCUztUWyCtgc+7E2InEu6jfItBvUzT1+zXnUj3kdrU=
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
Subject: [PATCH 06/14] MIPS: mm: Move drop_mmu_context() comment into
 appropriate block
Thread-Topic: [PATCH 06/14] MIPS: mm: Move drop_mmu_context() comment into
 appropriate block
Thread-Index: AQHUupitw3ETzl0Kikumtfk/uytlWQ==
Date:   Sat, 2 Feb 2019 01:43:20 +0000
Message-ID: <20190202014242.30680-7-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:uSsbiElbHzLrwWAfxcnXi8lSVFNWAUOIy203knd/AIAqWYdMTQ4dJktjk1mkbUjIGHh4njLIdRyHieQpUJRdkzvUpYe3tzi+4OwzPVni2mAJLskiUQz/1cqnXCmgDmPP8pp5vZgRu6NG44dw3gTDTANpiUPJoGY7JWMrRuKT72m0Ld88CRii+jrk9alll/ZRtluWQKh672vxrUFIvqrHuZau8sxwxVPRX0cp3yOuU+A/l9OSCwTwkeY6IBH8JjqN28S9GR6YwJHC8wU9ojdKn8+SZuzDOAqArRNG0u1H0ZDg5IcKibBQUNwqXVMx2/aw4hD1ncPUVRZXjLRB2wJqo4YJ4n6ISNKoiUSSkvZufh6aDHTaqqr0OTZyZUDjLoAhwXR81RyVpjoz9BIIuqm/UKL+lxkKtJYVUv0jJ6sknKzHEg0UTit2qUmntkPfo7ZXsIjuWLoYsAWSi4yqo8KGug==;5:ZgWZ7sFAVsMUuS5bVicBu3tJia/WY+nVYHwV3MSVkmLo6CVkQqQVLhwQQ+U5A0FYJ4GdoMHzGW41taqValZ2fPXAHd3Gi8i1cARCdjIgBGxh1kYXsRYy9gQjUhLIXYogD0YDxPMYhbiSJk/0xdbcf3hosMHZ6O4JMFTZGBplGq95/oT9IbMC/nVhm3L4imxcwEpKpJ9HXQK0Z1ANQ7Oonw==;7:PQxo7ofmnXN52Rv3b207q9J+tjqpB6aRT/WpODE4r/48Z39RSRjbK9SyDkCDqlUlo/s9ZBAbBHimpV08FT62bbrMdwpQxrl0eh7IB2S4/oZ/2tObhyUl683R1RdfheW3Pr9lOpkSqqRAo+yhuS6a/w==
x-ms-office365-filtering-correlation-id: cb42c04a-165d-4796-657b-08d688afcf7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439FFE7479EED1F56A8FB0CC1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EWGkCNiUmVOzqvPriDKJoNTNyEcoqfvvA1XbBeUDEBdBXy3+k4xMMgeJz/0jNnPtEzAknOPEt3WDb1UcbfW/7wfKpuoUPb65d3LnC2jWz/7DJxKXXmRJkOw1MFXhqC3tDQXYFYo+tmFki0epwOEKVFJJ2YxGBw3JBCT+JvRTOpVpk8+vS5/ecMYevaFXLX/Hx9Z2/lYe1SGBo1UCbTcHxlJ4UNlmsbmyJ0vMHYm9e3vmpY0V3PDLKv/D8sqjFpWo+r6oTgK/y5ejd9fUwGuTLhJxQN6xgKwAaryO127VzIiH5itZaJyH16qGEKgecE5kS9xEZXelMTQqShaiTgEEc+nFLpdLWfg7sgllDi8ojzXu7MJJvM/TSmLXYG/VOGAsGcRiO44XqFmAR5lq1E+hOBfJDuznRCHphpl2pvPb21s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb42c04a-165d-4796-657b-08d688afcf7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:20.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

drop_mmu_context() is preceded by a comment indicating what happens if
the mm provided is currently active on the local CPU. Move that comment
into the block that executes in this case, adjusting slightly to reflect
its new location.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/mmu_context.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mm=
u_context.h
index 1b8392dcd354..752ebda82cdd 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -173,10 +173,6 @@ static inline void destroy_context(struct mm_struct *m=
m)
 #define activate_mm(prev, next)	switch_mm(prev, next, current)
 #define deactivate_mm(tsk, mm)	do { } while (0)
=20
-/*
- * If mm is currently active_mm, we can't really drop it.  Instead,
- * we will get a new one for it.
- */
 static inline void
 drop_mmu_context(struct mm_struct *mm)
 {
@@ -188,7 +184,11 @@ drop_mmu_context(struct mm_struct *mm)
 	cpu =3D smp_processor_id();
 	if (!cpu_context(cpu, mm)) {
 		/* no-op */
-	} else if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
+	} else if (cpumask_test_cpu(cpu, mm_cpumask(mm))) {
+		/*
+		 * mm is currently active, so we can't really drop it.
+		 * Instead we bump the ASID.
+		 */
 		htw_stop();
 		get_new_mmu_context(mm);
 		write_c0_entryhi(cpu_asid(cpu, mm));
--=20
2.20.1

