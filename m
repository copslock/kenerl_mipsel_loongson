Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:34:20 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992087AbeJOSdbx1pH2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1DZp0xhsmBEa8cjB/wVK6LCFhXPSKv0CKVLvQN8lFg=;
 b=Y5jVzq93A32PfYHFn5ZnWR1FtwBH12WWiVg9FI8IJvuk69PqlAoPIEdTEPrwNV9w7s/7j3VofHOsd+cN94Kds5rxur7vZhUCZDIt8GAo7Fw3EHwyCt/JC3ZhVvZHiaOrakd/l0Z2+M8kAyoIinGM6RlfLjNnZZG/Y8tWlKr9zEs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:22 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 5/7] MIPS: Add kernel_pref & user_pref helpers
Thread-Topic: [PATCH 5/7] MIPS: Add kernel_pref & user_pref helpers
Thread-Index: AQHUZLWNYdOUO9ltqkWCq/d4aX/d4Q==
Date:   Mon, 15 Oct 2018 18:33:21 +0000
Message-ID: <20181015183304.16782-6-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:mMEJ6AczY1P3W7Z9HCwxl6e4pOfNXgNZ+/1ZRHYslXXQVhPlEncjrAYc9SO7ZUFsuAz/fe6NbmkuxRqnA2c3MmXeYfzhXR19wrQGnDCxxLrfs4XaVu7gip9i+jm99vkZFyb2M97YuBmXnsf5q/J0vRH+Q2GahEFJttCz7oBqbPN2XlN3IepBmj00IWbIJgIi/WCUN51fOfbnmIvrlUSbqtjIMik7atGtdzHgxDtqQw1d4AzHLNN/ApZI6mB2VEwPs3rP7Ku5yu2US2xvMFYPqWHUl1EI+wyMN6rSk5Nb5hvwh5LrBqjhGeyDSCGON+l1IIYC7s5WwQRw7CPD4tkFSrpk/sTi2FdLmQpeTPQlh5J+hQScxPmBcBuLZhVOzyyOmM6mMitfRRnzhQ+YxPAJzpPrdOjVITpQSEytTM9qZ9Ham0pNFGS22snB0mubOHvKs2d/qbFrrtIlOE6EEIZN1w==;5:k1ko5Xs1TFOE3DhB8tZ5D9S+GIPLsiFEx8VNSOMHALxsR4YV6IEHqeacxO3LbYEJdCbqhxuikXmweuRoKXw9/BPDg2bGL4LbpuQvotJ9IX3MuHQ88gYjcetcokDLwuQqS3/mz0ELh03GbT0/fYryG8RWeDl7D7D/3xcDLjbMUIA=;7:cMWL0YZN4zP3WegoO4H8Pke8H8wrdVIFN8VaS+Li4w+6X2cIwLJvXroLkopd4yuX1rw5Lv9Fa03jUZO6bLcAnceLj4eoxqc4U4pqEP9aNiqY/OU1dS+oI2ZzsnPu4aE1oQDaa4wYD7CtNK+bIdpRAn8l87eFfljJ3uadFwLmEaRHuDy89eK5UcbMPiXpl+G13bPmgBc0NDBUO5RApmMITn0m2Sb8y1jCHXolEp+mkR6AJrKhqG1ieK7oErPDu64V
x-ms-office365-filtering-correlation-id: ce7a3365-6be7-471a-00d1-08d632ccaf5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17103488CEB65E2411B7534DC1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(575784001)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O+ldCegY7JYyWM3MqdKyKIkvrwi5eFZ15UScD8lVxrrHALbJM91fowMqoiKLtuybp2Ysy/KHdDh/dYgjlWTw8GdEbDULwl0rOlqCp+iQDqL/s8+DLPB3QfxwfKe8rEI6C8F34d13MctJTUzMSY4L07rLBiFn/a+nerwG9AF91Fb35xRyZpl7kWfdoAF3J6Qxaar3lE443dRf7mLUTh0DnfYwhnf0XMsYA8G3WubhBmbVa6s5u2nD2yXqN98IixKuZk5L7jFcMX6Ah5x6Kk5e9NzotzSmzBlc67voNgz026W97zR2DrEXfcXt8v2FYw5t27FN9h32eJF25s7hZBVEwcKJmRDxf9N/1l7TPUquJNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7a3365-6be7-471a-00d1-08d632ccaf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:21.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66852
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

Add kernel_pref & user_pref macros to asm/asm-eva.h, providing an
abstraction around EVA & non-EVA pref instructions consistent with the
existing macros we have for cache & load/store instructions.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/asm-eva.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/asm-eva.h b/arch/mips/include/asm/asm-eva.h
index 1e38f0e1ea3e..d80be38c4144 100644
--- a/arch/mips/include/asm/asm-eva.h
+++ b/arch/mips/include/asm/asm-eva.h
@@ -15,6 +15,7 @@
 /* Kernel variants */
 
 #define kernel_cache(op, base)		"cache " op ", " base "\n"
+#define kernel_pref(hint, base)		"pref " hint ", " base "\n"
 #define kernel_ll(reg, addr)		"ll " reg ", " addr "\n"
 #define kernel_sc(reg, addr)		"sc " reg ", " addr "\n"
 #define kernel_lw(reg, addr)		"lw " reg ", " addr "\n"
@@ -51,6 +52,7 @@
 				"	.set	pop\n"
 
 #define user_cache(op, base)		__BUILD_EVA_INSN("cachee", op, base)
+#define user_pref(hint, base)		__BUILD_EVA_INSN("prefe", hint, base)
 #define user_ll(reg, addr)		__BUILD_EVA_INSN("lle", reg, addr)
 #define user_sc(reg, addr)		__BUILD_EVA_INSN("sce", reg, addr)
 #define user_lw(reg, addr)		__BUILD_EVA_INSN("lwe", reg, addr)
@@ -72,6 +74,7 @@
 #else
 
 #define user_cache(op, base)		kernel_cache(op, base)
+#define user_pref(hint, base)		kernel_pref(hint, base)
 #define user_ll(reg, addr)		kernel_ll(reg, addr)
 #define user_sc(reg, addr)		kernel_sc(reg, addr)
 #define user_lw(reg, addr)		kernel_lw(reg, addr)
@@ -99,6 +102,7 @@
 #else /* __ASSEMBLY__ */
 
 #define kernel_cache(op, base)		cache op, base
+#define kernel_pref(hint, base)		pref hint, base
 #define kernel_ll(reg, addr)		ll reg, addr
 #define kernel_sc(reg, addr)		sc reg, addr
 #define kernel_lw(reg, addr)		lw reg, addr
@@ -135,6 +139,7 @@
 				.set	pop;
 
 #define user_cache(op, base)		__BUILD_EVA_INSN(cachee, op, base)
+#define user_pref(hint, base)		__BUILD_EVA_INSN(prefe, hint, base)
 #define user_ll(reg, addr)		__BUILD_EVA_INSN(lle, reg, addr)
 #define user_sc(reg, addr)		__BUILD_EVA_INSN(sce, reg, addr)
 #define user_lw(reg, addr)		__BUILD_EVA_INSN(lwe, reg, addr)
@@ -155,6 +160,7 @@
 #else
 
 #define user_cache(op, base)		kernel_cache(op, base)
+#define user_pref(hint, base)		kernel_pref(hint, base)
 #define user_ll(reg, addr)		kernel_ll(reg, addr)
 #define user_sc(reg, addr)		kernel_sc(reg, addr)
 #define user_lw(reg, addr)		kernel_lw(reg, addr)
-- 
2.19.1
