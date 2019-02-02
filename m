Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAAEC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D64820857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GsReWy12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfBBBnh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:37 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfBBBnh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s513NnosSwvNZ8i3tyf0SYbVNOfmMQpnCdeTulAUK3w=;
 b=GsReWy12EkxPmg5yhkiDofymKbEKPL7W9X5Xn7RYv0Pv6eDyQRzmZ2gRUM00SC0bI1kmqEU/HET4LkYjiBGyHC+aWBOS9nbGAkubzawWji99NNNRc3a0Pj1fuhq7xnDFwogj7W93YS2KRcenGvpnhjpE/gQoqYOPW82p7OasZGs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 09/14] MIPS: mm: Split obj-y to a file per line
Thread-Topic: [PATCH 09/14] MIPS: mm: Split obj-y to a file per line
Thread-Index: AQHUupiufaQEj55dJUi+bYUfDGVfDA==
Date:   Sat, 2 Feb 2019 01:43:23 +0000
Message-ID: <20190202014242.30680-10-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:r3pYdUzAj5J6Vqh6/IIAurauB+5ib6iwPi/62Xvjov4EEu+j03no0dR13NvOtlIu6U6iJwmC1OV9pAiq+6+Rhcu+09PjfeIvYT8q+2a6ViJZZfZDkqWNg5Nv/UwrqapP9YElM6Trz6R6l+BG+aGBtCppXX0QZStNeyjF7uqPTUZerSe/3dT+IAgYVztB4kJSj4EvID2Do/ylyUIqcUPlsogTtI9kftzY9Nz1M9R8N2wVHyZ73h5QVpwL81I6YXmhhlhcIuaM5avi/z5+a+sVN7ZOW8BsSPJQG1n6pvPjdj/4ugyC13UVyODPAW+rFQ1gwrC198fDtyTcGofWC08IM/lviIZRqcDGoLYepiTTkVOppqT4ZgYAzwFUFnTe/rDzYJwMVPhYgz/4q4wKq8SoRqnsOl3K6F/bKhnqHkvapTCyJWOH2yTx12Ow4pe+VPe+mL60RMYk2eLU/qNRbkZGoQ==;5:AZzk0yIpnGgfocKkkTIU5fE4l2rYhnxEjfPO5l8QmQhlJdJ+inri5fXLFsGiDB5wxpqXwm4MBV7ZLDsjW2JfWpS3a8OzUGSGNv6GbgS7pGm7IVtqN/pgbJ124L3YVGVNKDWiRHolXvWSWrp3bvEpm3dRR/Pbo+2Pi6yQGmlGUMW/REPEAIJjuvwjFYwHCWIpHq0B4SBkl3H8nSk9fxf5jg==;7:eME7TN0m5OcuIA5jhBXN3H062mPJVsICfBkADQP7+Xyk9bcQOdR5JeqNHuTIVyN37oKBXrO/C7vA+gwYSji8kRu1Fz+qC7Y+ZZX5NeiUg8wbyaxvCoHSF7MjOj99CdEsaWUN645rZSnzpFacJC7o9g==
x-ms-office365-filtering-correlation-id: f794e5cd-e5fa-4524-a1ff-08d688afd104
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB14394AF63028AACD409293E8C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(4744005)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14444005)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MWl8Bi+boRLOj+V/7aEtAWzvb87LZ2IZZsJq9Tt2Vz8brTgmRxjyhnLrfBKE2pdYEGHwLxhQYr0OpzqoZZyfhpGNMQaSsyWkq8yxzLT8fQ4Rgafg9Gcr7GDfHyJlp/CCVjS8uoV31k708GkPiCyF818SA3nSoRI1TQcwrwwXEAamo3/XggILYSvnR+JV0sYLC9OmkHnUiRX8+oerkqwdseNtdW9W5uGpZ4vIJcWLC4d4DEM/prICK9uJoNLPWgM/2uvwHy459cVcLROTszbyB/tE8rg5DwK9vRBS4EABID7NvlFICNSQK/XbVGplxQI8tyRBuqiAtYaYbMYY0CVYQU2jJzDbEEDlkPp2OMFk0aUh6S3gd1o/IpSpjBClxdqGVC9rXheTi1QjgvRxiZRWFrnLwIPJseTHFhVZIHIBL7E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f794e5cd-e5fa-4524-a1ff-08d688afd104
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:22.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Split always-included objects to one per line in order to make it easier
to modify the list of included objects.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/mm/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 3e5bb203c95a..25d492736848 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -3,9 +3,18 @@
 # Makefile for the Linux/MIPS-specific parts of the memory manager.
 #
=20
-obj-y				+=3D cache.o extable.o fault.o \
-				   gup.o init.o mmap.o page.o page-funcs.o \
-				   pgtable.o tlbex.o tlbex-fault.o tlb-funcs.o
+obj-y				+=3D cache.o
+obj-y				+=3D extable.o
+obj-y				+=3D fault.o
+obj-y				+=3D gup.o
+obj-y				+=3D init.o
+obj-y				+=3D mmap.o
+obj-y				+=3D page.o
+obj-y				+=3D page-funcs.o
+obj-y				+=3D pgtable.o
+obj-y				+=3D tlbex.o
+obj-y				+=3D tlbex-fault.o
+obj-y				+=3D tlb-funcs.o
=20
 ifdef CONFIG_CPU_MICROMIPS
 obj-y				+=3D uasm-micromips.o
--=20
2.20.1

