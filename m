Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:33:44 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990947AbeJOSdad4a-2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+UBtBUWg8dhX+hYhq7wWvLtHS0g0+MlWe41cUKEPBw=;
 b=MK9uqHbiVIoQo3/e1YpkFu5VxbWTMjzB561htbQ73KWQnxTLiXD0lkWDaXe2huuB1DrTl6RgKui3rsgKYV1IXCB5m2I38JUrESl5c+sjMPDRnhKodWS/WkfY++UW1Opxo6D83Xk5NdwBQUQrBcxWMpuuAnWPoxisY+xhoFQ5p/U=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 2/7] MIPS: Remove unused PIC macros
Thread-Topic: [PATCH 2/7] MIPS: Remove unused PIC macros
Thread-Index: AQHUZLWLq8uo3tAHiE2f79JEYFipPw==
Date:   Mon, 15 Oct 2018 18:33:19 +0000
Message-ID: <20181015183304.16782-3-paul.burton@mips.com>
References: <20181015183304.16782-1-paul.burton@mips.com>
In-Reply-To: <20181015183304.16782-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:Jgf3f8heqR1316qyNZwVIahsxeCq92nNYrd2eEbAxQPC1boT7Mestpl5MBdcvwTIKSj5MLy07ECcFKdqQtjOJk0M/XAdtzCuCh2bfQ8yc7BvLFW2n6oPEc+H4JNTyrr8VkDtE6ISZvwBkWURyAP5yiTZ0z8dEYZae2Lz6fQAHIaqHzdK7iqrSlGG0whU4MueJjvzT5SWmsMqCysBxj73L/WIWZgAF/H3XpVu/70WhSqwdZ6lAK7eGq64HJRSch/iCR3F/VjFA9LWh+djWPDnqETdEFwYwIsVx2GWq3Vg5u+gu4fAQZTZ0zH06okrZbVlykFPac2ENXkUyqjztiWfNESdCcQjkSqTj+OJdBwrJzQF0JJ9b1d6i0VPqTwIYu7m9oq2g8HB2yXitpLhrvmrJqH2YSfckEEo1A/Si25I0DILrfATiGPfUdZOKBn6+xlynyxy+G3bpqZ53hDBkrELag==;5:Hm52m8WTOuyjM9T7pedvBKTKz7yda/jFkrrRMG8CPJ6HSxlMACZB7nWH32F8NNVBZnB05ebeE+rodyNEXg7IkxOQT92lzU5EOOg4dKSHh4CbRWJgnCnZ6Ura61MC/N+D5uEDg/9hLXO7iVzFR91PLkHnLj1TcFtVoDkLSf6wOkY=;7:NQc2LaIPr/m//vtcQ6arfpX8S1dujuXr4IfSiiOXKkT4sMk0uhfU1wMpV97BOQsbk4Rkvj3ihVahFR1AO2Qg9ucgIdhu1cl4FfU2iHIk3wGMuE1fQYY/s+qkdaR/zdSA7dXhcUnbidWG8/n1aB5uCrNkzeoy+YpS3wqpymc4zrmdmvmTjAhKqss/DOx2DktWV+ZLUq5gu7JEQwjvQ7gMYhMvsyREFoz/DatZ5e3QptQMILvAdsK98fmawFuLL0m8
x-ms-office365-filtering-correlation-id: c8bd4884-aae5-4f7f-f6e9-08d632ccae32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17108E8245B89A63CC570DE6C1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: okULG84YO5bxMGsg20CqEbJVL0/gzoiU0zIxeJmxbmbfUmZ3ql53gUI4ja83Jt/y6zJ7JeZ8CZc/0bJpxLYUrcsfh3C1F7fWaM/axukcMM9VabwNWTx36SHYg2GfRZDsc7pLeh2VvmtWpn8EkKbKqxgvdIRNfc8D1Ku7Qe43iv5inKnG0ESfsyIE6jMera1ERmSEBwo9tDH25Q7b5IwRPu5WC6pKg+FT/eH1RzOa2ZwQUm76B9r986vM7GLcmbgD9+GLGPAYsVW/vFaLx9QAXZ/p8jO6zVy6vc5eCCW0US0AdOwJygczHB2JHO6kIsOPqXy9X6dTYNcXqVfwOgUDkpUPK9+c96cAeJCKiQgUbRE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd4884-aae5-4f7f-f6e9-08d632ccae32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:20.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

asm/asm.h contains CPRESTORE, CPADD & CPLOAD macros that are intended
for use with position independent code, but are not used anywhere in the
kernel - along with a comment to that effect. Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/asm.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 4e4f60597c72..03711771d51f 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -29,23 +29,6 @@
 #define CAT(str1, str2) __CAT(str1, str2)
 #endif
 
-/*
- * PIC specific declarations
- * Not used for the kernel but here seems to be the right place.
- */
-#ifdef __PIC__
-#define CPRESTORE(register)				\
-		.cprestore register
-#define CPADD(register)					\
-		.cpadd	register
-#define CPLOAD(register)				\
-		.cpload register
-#else
-#define CPRESTORE(register)
-#define CPADD(register)
-#define CPLOAD(register)
-#endif
-
 /*
  * LEAF - declare leaf routine
  */
-- 
2.19.1
