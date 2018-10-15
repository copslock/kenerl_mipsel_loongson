Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 20:34:29 +0200 (CEST)
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:56666
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992153AbeJOSdc1zMu2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 20:33:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IytP7L8CSE6/Kk6i89t7F3O+PGPxrZTn4LeSucUC2GE=;
 b=psv/QkkVlljdFFwa8xPdgUhmxFuz9fe4oUwFuP7fHfngX6bvqT4M5r3OOXYAXLmO6i+ho+mx6GN3YwZ1ZbkyzqiawpdblGrxIxUZwQb5aWXC71L/yWxQQepLo+NW5+ITn3O7GCYriwgjdbXSvxYeMIQpTER/7aV29TMmwFleuwU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 18:33:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 18:33:23 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 6/7] MIPS: lib: Use kernel_pref & user_pref in memcpy()
Thread-Topic: [PATCH 6/7] MIPS: lib: Use kernel_pref & user_pref in memcpy()
Thread-Index: AQHUZLWNs7TgbNED6EuzLQsx1ZioiQ==
Date:   Mon, 15 Oct 2018 18:33:22 +0000
Message-ID: <20181015183304.16782-7-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:1nku9WIMLXhqwDyYuuw6QSH+oXIH11q/ierV3BaCBf7O4E7qze4MuUTglXkv1QTAsbuuGn6bcINDMWVILv2NE9EtRUXzbBoBfpFm4neC4v2N9+qCXZF5V/Cl3eEiYgiszIYpgYASi8UKm0rFu5LedjlM4IWi2h8+cz8+G5EDW8ndHGlgyYFGc6zWsSmSQwN8sEvQfVHLji4btoVHx5S4bhvSUouGEPybUuzNNlbU3H3ytQ1gXlM8DdT0ADHwVMuhh0MqunlutRJhWt1lAuVf10SdJEfM3JnLQQ/umpnlE3ipTx8AFgCZ01axN8F20rNqCrvbc1wwZKU6zQlZxVLnXBX1C+ikuzc75Cm7Z/WK/6xK3OU6yuWs/Xt1hoVHRnXSFU7f8FeddLzwTV0hC2qFaAR3Yz/jViGCsAYuHKON2hikc/yq3y1okaYfGT5+4a9vrq6dQ3IpKiSZJ+4eJAUCJA==;5:t3wv7RIsPcDumB3fxxQhx0A3YeioWUMAE3tSkl5WpFgh9yEBsXLE+O7e1C6JD0ZopwtDqAldNK4FLkeuTf1+soRS6dlDqfAiWHFkMZxxjtDuAwaeL5nfLcdYY5M83cCdVIyWo1/ZJf3P0uzfzN2o4w/oRHY0Br4w3R5hMiMMrbs=;7:wU63CdZOuuJZGvOaJjlJmd1Wg3qlmJeyCerBfE3c8G26b07K+eDQyQEQ4nfm5h/KQTEHj22d1JFN71Q+Ok4a1iIv877POhshnpYPKa4/n5v9f3kqWUFVVXCz4H45jxsNYA8SGL4iDlVC/IjiId4GZg8KVBrIcV7yZdomQ+S4+faLugwyziamXMH43gLqY9H1QFF7PtK47UjkeIWU1oAbkn4SrHJruwdBZnX1hlq7fPJYghQTDobqFerFNavyeMNr
x-ms-office365-filtering-correlation-id: 137206f9-300f-4ec5-9b6b-08d632ccafb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17102E63BF61761E13967FC6C1FD0@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(189003)(199004)(107886003)(5660300001)(14454004)(97736004)(81156014)(81166006)(1076002)(8676002)(106356001)(26005)(71190400001)(71200400001)(186003)(8936002)(3846002)(76176011)(25786009)(102836004)(66066001)(6486002)(6116002)(105586002)(4326008)(2351001)(5640700003)(508600001)(52116002)(486006)(6436002)(2900100001)(386003)(44832011)(6506007)(99286004)(5250100002)(476003)(36756003)(2906002)(7736002)(305945005)(2616005)(42882007)(6512007)(316002)(446003)(256004)(6916009)(2501003)(53936002)(11346002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XHx/xyeeu7tDMt/8GZhTKZTU6Z9GAlMqNU57++nxOBQ/NsOELzfoj9s48/z+IXYcJ6MT4hqOOjoGxkJwOTKjHR97Kti4DFdZOqv7D9649D6/s4MAkVwZkOABvHsT4sK+1fN7Rb9qIQt5kjX3j2kz8kAEtsa9ibdMbs5fR9gxTn5A7+3y4mY2dHVxOuixShQYFc8WNHfLbW1b/UZwV4mf66AaZsobUbXguHeoyceTPitFAY2UGk8H9z3m1bUSvTx9e/x6St4Fx6kjqbqjLXf8Xg07eCcUUzG+eF8Gd3jeQgIurNYhPJ2/uEupELYX/C1Bj0uXGjFGCDIZ/8bjXbbtz+et3jTya17BKQuvD2bljpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137206f9-300f-4ec5-9b6b-08d632ccafb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 18:33:22.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66853
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

memcpy() is the only user of the PREF() & PREFE() macros from asm/asm.h.
Switch to using the kernel_pref() & user_pref() macros from
asm/asm-eva.h which fit more consistently with other abstractions of EVA
vs non-EVA instructions.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/lib/memcpy.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 207b320aa81d..cdd19d8561e8 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -204,9 +204,10 @@
 #define LOADB(reg, addr, handler)	EXC(lb, LD_INSN, reg, addr, handler)
 #define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
 
-#define _PREF(hint, addr, type)						\
+#ifdef CONFIG_CPU_HAS_PREFETCH
+# define _PREF(hint, addr, type)					\
 	.if \mode == LEGACY_MODE;					\
-		PREF(hint, addr);					\
+		kernel_pref(hint, addr);				\
 	.else;								\
 		.if ((\from == USEROP) && (type == SRC_PREFETCH)) ||	\
 		    ((\to == USEROP) && (type == DST_PREFETCH));	\
@@ -218,12 +219,15 @@
 			 * used later on. Therefore use $v1.		\
 			 */						\
 			.set at=v1;					\
-			PREFE(hint, addr);				\
+			user_pref(hint, addr);				\
 			.set noat;					\
 		.else;							\
-			PREF(hint, addr);				\
+			kernel_pref(hint, addr);			\
 		.endif;							\
 	.endif
+#else
+# define _PREF(hint, addr, type)
+#endif
 
 #define PREFS(hint, addr) _PREF(hint, addr, SRC_PREFETCH)
 #define PREFD(hint, addr) _PREF(hint, addr, DST_PREFETCH)
-- 
2.19.1
