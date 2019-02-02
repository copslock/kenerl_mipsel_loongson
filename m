Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53202C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 02:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D2120844
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 02:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Cs0pUVtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfBBCBF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:01:05 -0500
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:36109
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfBBCBF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 21:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq9Sj4zm12CD00EspxeP5I0GJbkd1aywKYkaZ2vxbUQ=;
 b=Cs0pUVtSiNnWril/HoMjckvGIFU+DgoQtpj6lHIM2dOjqY06F5FEiPZdd2l8lv1bJl0zKPd7trOfNuYWMBmU55UdgqvOd5AI68QYVdPS3Oyc5/LOmuC8NsMs5IcHOApsnFhu1SoHmMWx18UWFvWV+vF/eejycwumfhdAPXKMgGE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1232.namprd22.prod.outlook.com (10.174.162.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 02:01:02 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 02:01:02 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Remove open-coded cmpxchg() in set_pte()
Thread-Topic: [PATCH] MIPS: Remove open-coded cmpxchg() in set_pte()
Thread-Index: AQHUupsmv09CGozFQkuvge0V6n8JYQ==
Date:   Sat, 2 Feb 2019 02:01:02 +0000
Message-ID: <20190202015957.12404-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1232;6:ibvGDagvjYebk5UIMjTLuzHpL91kIO2svK+VXC6zEp3v65V3SH8j2KnoC1xaxk6VWESDmhDrT85kxWcAN6ni+KsgBwHAgOfNVmN8/r17s+6L2FLJIJfi2UrXHvaQycAi656FMlHwI9uXxKLaedtWF2D7ErsR3hb1+es8IxziztMI46eriyc42CFgIK1ZcBz0zlKuTtLxxAb2w+gMZH4Lh7xQOGe1+07camU2LqYQYmTkpDP/BNYpXRSc3tqTzMj0Cj1T/mufOAXXYacVdEznZwnHE0F4jSAcEeO7lVMl6gTIxToHyOjZKCp5K/oj9w/avKFPUsBh2AaunX9XIkHd2y1j3KkrhwCmrDXt2/d/0GZ2awdHXIZK7/wVHrZBBZYXyCe0q79SMebe30PSQsEDgtlLOD6wOKMCvVTQWyZoopimAljbHopgPjEr+uQVzteiTcUFZO27fArvID7LqKTO2A==;5:UkpW7ktc5yoHKhtsAMDZ4fAvKRk2Pm2aW2J5R7mSd9h/exNQoKOv31uYboY0DSO7TIV6zVkCSgJRhUfrdR+9wxZQkTW3EQzel5nYD+C7G2nYF88gLgGjgy0RFV1yPdTu+oAeqRqlTKhiMET3pu+JXanxtTc5RVJ5zZNp46w5JTZWlLsVeW9232grKLQz0k88ygqT6+q3ir+iqcGn4I97fA==;7:Sdp+UVUJc4uYBA6ED7NPyPWKP5eXfDI1cMn6jRi+dX+4kQrP2PDJFzVtTPxuNx+v8bJD+Jbway7BHcwoLVl1WSoJHF10EZBnaEruxmngt4TzLIZCmdx25d4SNsrGfZOOb7QlTc9nPJYpZyLsgHbA+g==
x-ms-office365-filtering-correlation-id: db38b95d-0245-414c-b77c-08d688b248a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1232;
x-ms-traffictypediagnostic: MWHPR2201MB1232:
x-microsoft-antispam-prvs: <MWHPR2201MB1232CE2F491054538093876EC1930@MWHPR2201MB1232.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39840400004)(189003)(199004)(3846002)(6116002)(52116002)(42882007)(256004)(2616005)(476003)(25786009)(1076003)(6916009)(53936002)(2906002)(107886003)(4326008)(316002)(478600001)(5640700003)(7736002)(305945005)(6512007)(8676002)(81156014)(2351001)(106356001)(50226002)(6436002)(105586002)(6486002)(44832011)(36756003)(81166006)(71190400001)(71200400001)(486006)(68736007)(26005)(186003)(8936002)(14454004)(102836004)(97736004)(99286004)(6506007)(386003)(2501003)(66066001)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1232;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7kJguBlRka6FYR8yPdhvqox9tDqCQem2IJ8y8K6gkYlv3HbT9Zp0WMBiGBP/eDhb5B7jYganQsF8NQ5SVLAhPMCgyQ9i0pdeOTSHuOBJH7pQXTV0p9ZFGB++drtcB9EwJXXAEdN4HsU1SHrHRhZO+HT1l6g7dBdb2tY+gMdub+XFUlDBuUeZ44P0/z+EgkpMlD6Jp+5wKJla6SxJZrQoMBie1pnok6d5MI8X+7miqIlEK6ahhvVwVkYpCoj074d4tXe/UhpqUscUItW8sfD28KP8u2J70ZEP4xylLAzo6DJ6lL8hzqK+wGZ5FHui7ROvKzEWL52Dy+FW9c3g9v1WgOlwBrvDiSkyug9k5si7+bLPzst1z1ziPL0usEJIUgNyxwPF3HHZUdWKXy8Qhu0yUGc4z/lK5hY6Ja9WWnGLEX0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db38b95d-0245-414c-b77c-08d688b248a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 02:01:02.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1232
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

set_pte() contains an open coded version of cmpxchg() - it atomically
replaces the buddy pte's value if it is currently zero. Simplify the
code considerably by just using cmpxchg() instead of reinventing it.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/pgtable.h | 45 ++-------------------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtabl=
e.h
index 57933fc8fd98..6c13c1d44045 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -17,6 +17,7 @@
 #include <asm/pgtable-64.h>
 #endif
=20
+#include <asm/cmpxchg.h>
 #include <asm/io.h>
 #include <asm/pgtable-bits.h>
=20
@@ -204,49 +205,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		 * Make sure the buddy is global too (if it's !none,
 		 * it better already be global)
 		 */
-#ifdef CONFIG_SMP
-		/*
-		 * For SMP, multiple CPUs can race, so we need to do
-		 * this atomically.
-		 */
-		unsigned long page_global =3D _PAGE_GLOBAL;
-		unsigned long tmp;
-
-		if (kernel_uses_llsc && R10000_LLSC_WAR) {
-			__asm__ __volatile__ (
-			"	.set	push				\n"
-			"	.set	arch=3Dr4000			\n"
-			"	.set	noreorder			\n"
-			"1:"	__LL	"%[tmp], %[buddy]		\n"
-			"	bnez	%[tmp], 2f			\n"
-			"	 or	%[tmp], %[tmp], %[global]	\n"
-				__SC	"%[tmp], %[buddy]		\n"
-			"	beqzl	%[tmp], 1b			\n"
-			"	nop					\n"
-			"2:						\n"
-			"	.set	pop				\n"
-			: [buddy] "+m" (buddy->pte), [tmp] "=3D&r" (tmp)
-			: [global] "r" (page_global));
-		} else if (kernel_uses_llsc) {
-			__asm__ __volatile__ (
-			"	.set	push				\n"
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	.set	noreorder			\n"
-			"1:"	__LL	"%[tmp], %[buddy]		\n"
-			"	bnez	%[tmp], 2f			\n"
-			"	 or	%[tmp], %[tmp], %[global]	\n"
-				__SC	"%[tmp], %[buddy]		\n"
-			"	beqz	%[tmp], 1b			\n"
-			"	nop					\n"
-			"2:						\n"
-			"	.set	pop				\n"
-			: [buddy] "+m" (buddy->pte), [tmp] "=3D&r" (tmp)
-			: [global] "r" (page_global));
-		}
-#else /* !CONFIG_SMP */
-		if (pte_none(*buddy))
-			pte_val(*buddy) =3D pte_val(*buddy) | _PAGE_GLOBAL;
-#endif /* CONFIG_SMP */
+		cmpxchg(&buddy->pte, 0, _PAGE_GLOBAL);
 	}
 #endif
 }
--=20
2.20.1

