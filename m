Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:06:00 +0100 (CET)
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:44066
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992869AbeKGXF5WJKMU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:05:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwXyZd4MHu3KBQR1Km8v78qzIzW3HGTxuO5ZMDJdi8w=;
 b=qnzlSbn0G1mjAEoSb2JKzjdX2DhJLGRna9vcqKIMZal9dIgggi9pPP0lYSbYo/cFiMi24MIOq4z1Sj81EQY3S2+qnl/cpXsKVExhFCJLg8RcQfDgcjiBpoQ7kKGwX+AJyxER2IvfZbYaIACjH3JTrdBxOiygqa7eCDsqnZdGamE=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1055.namprd22.prod.outlook.com (10.174.169.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:05:46 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:05:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Simplify GCC_OFF_SMALL_ASM definition
Thread-Topic: [PATCH] MIPS: Simplify GCC_OFF_SMALL_ASM definition
Thread-Index: AQHUdu5q3GyLMhBWSUW7VMR+ZHZNpg==
Date:   Wed, 7 Nov 2018 23:05:46 +0000
Message-ID: <20181107230524.3370-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0070.namprd21.prod.outlook.com
 (2603:10b6:300:db::32) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1055;6:49fhP3/Oicf3k2wxEkTyJWAU39DOG3lFUoRw5S1J5OEiUipQ0dHdHrox+Z6bENCokNVmNgkzKXI/hzSrjU0dHQJyiYqqgwgsuPSjkWZxMLXBFLinY2cjwnUAZhs5gUxeGnIo8IA624RID8wNqiTMcc1FmCokFqdscF0EVMHcQXMNjPxwgUSS90G+b9/SGz2+7+DDYMEQd4KjyBwtZhwVOfWEWpPogCSIcTlxhR1LTJ70LwPwWEY6LvjccNJutDmbGTLfD5aQjGxFERTU6DlWtPmrqVl7Jl9VN2I4iD86wPQybVxjiZEmlOlvRiYGeKaKn33SgXjkwFHVWwpKa1T9VvxFIDgm2fMrm+GBFdmGevM8m6E8shG+4cMbxvSQkrBDK7g/JwBFNttEeDquew6M4GY3U0A2p7KVMQ2QRhGaHeHyc0cU0VHUan0X2kTbvwigHw7bvI8/z1BvFVGAmO414Q==;5:A5T9EtJaHJBKkOo3HSBI+g8/U76U6DmqPwIKhs2eDiL/sFVsmHWP5udjt3A3AzpkxL/FbmeeP3LAkI2VMPDTcrziXspxu7tp24AYNS2W8pgbjOXPSX+fo5rYG/HNZ12lwPdg1IJM6d+rRXtXHcwr9uq/29FjJmlI6sjXNsEWnJc=;7:RDxwCEtHmg9NTkUTJAPtou7V/RXxgIUMT6kf+qlRn/b1wJ+36AmREwmkfOMkZSbbeE5ppQeqY1EBKVeGEhHxy9mBkaCsF57+hd9paawr/1pNzcLhh5KWfcRdMj/EdpPjQcUn3FT7+HfzFfpVRB2vGA==
x-ms-office365-filtering-correlation-id: cfb15f90-cd4a-46bb-8bda-08d645058cc2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1055;
x-ms-traffictypediagnostic: MWHPR2201MB1055:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB10550D325E47449B0C590370C1C40@MWHPR2201MB1055.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1055;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1055;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39840400004)(366004)(199004)(189003)(256004)(81156014)(14444005)(4326008)(81166006)(8936002)(6116002)(71190400001)(305945005)(14454004)(36756003)(3846002)(5660300001)(1076002)(106356001)(105586002)(6506007)(102836004)(2906002)(316002)(26005)(186003)(52116002)(99286004)(44832011)(71200400001)(7736002)(486006)(508600001)(1857600001)(2351001)(386003)(42882007)(476003)(107886003)(25786009)(97736004)(6436002)(5640700003)(2616005)(2900100001)(53936002)(2501003)(6512007)(6916009)(68736007)(8676002)(6486002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1055;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gqNsTs1VhAEPIp4SpiqIO6iszqsEJZJ2sCLh/1qaxxB6rMf++twTsai+usuf0F6gtsv7mIegXZjjmJsy0Vp9UonuExIno7DueKI+b36A6FuuaOGxCF0uEjxxIVsgfjuO9vifVettTecnb0R6azrWI/u4tsrOpo1iK0n9/HLyAriLMnnhNaUGsB5bTzZ0JiumcO4QXJyo3wNCHmq5nEPEUp9UEBDcAV+zS1GVUhrrGZfJRYV/kqXKZ6CIa134feVO1BBb4AZtwlB4iNTraVXlmCJ1sqOIt9ufZEOY2NVfBniPbsBrI0+4hLXIvAWJPOMUVYP6T/9OOkG9LA3I1r4L6E153r0QbNtXLU8R0y4B3aI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb15f90-cd4a-46bb-8bda-08d645058cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:05:46.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1055
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67134
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

The GCC_OFF_SMALL_ASM macro defines the constraint to use for
instructions needing "small offsets", typically the LL or SC
instructions. Historically these had 16 bit offsets, but microMIPS &
MIPS32/MIPS64r6 onwards reduced the width of the offset field.

GCC 4.9 & higher supports a ZC constraint which matches the offset
requirements of the LL & SC instructions. Where supported we can use
the ZC constraint regardless of ISA, and it will handle the requirements
of the ISA correctly. As such we require 3 cases:

  - GCC 4.9 & higher can use ZC.

  - GCC older than 4.9 must use the older R constraint, which does not
    take into account microMIPS or MIPSr6.

  - microMIPS builds therefore require GCC 4.9 or higher. MIPSr6 support
    was only introduced in newer compilers anyway so it can be ignored
    here.

The current code complicates this a little by specifically having MIPSr6
bypass the GCC version check, and using the R constraint for pre-MIPSr6
builds even if the compiler supports ZC which would be equivalent.

Simplify this such that the code straightforwardly implements the 3
cases outlined above.

For non-GCC compilers we presume that ZC is safe to use. In practice the
only non-GCC compiler of interest is clang and it has supported the ZC
constraint since version 3.7.0. It seems safe enough to presume that
nobody will expect to built a working kernel using a clang version older
than that, and if they do then they'll have bigger problems. As such we
don't check the clang version number & just presume ZC is usable when
the compiler is not GCC.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/compiler.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index 9196fca4335d..f77e99f1722e 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -43,18 +43,14 @@
 #undef barrier_before_unreachable
 #define barrier_before_unreachable() asm volatile(".insn")
 
-#ifdef CONFIG_CPU_MIPSR6
-/* All MIPS R6 toolchains support the ZC constrain */
-#define GCC_OFF_SMALL_ASM() "ZC"
-#else
-#ifndef CONFIG_CPU_MICROMIPS
-#define GCC_OFF_SMALL_ASM() "R"
-#elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
-#define GCC_OFF_SMALL_ASM() "ZC"
+#if !defined(CONFIG_CC_IS_GCC) || \
+    (__GNUC__ > 4) || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
+# define GCC_OFF_SMALL_ASM() "ZC"
+#elif defined(CONFIG_CPU_MICROMIPS)
+# error "microMIPS compilation unsupported with GCC older than 4.9"
 #else
-#error "microMIPS compilation unsupported with GCC older than 4.9"
-#endif /* CONFIG_CPU_MICROMIPS */
-#endif /* CONFIG_CPU_MIPSR6 */
+# define GCC_OFF_SMALL_ASM() "R"
+#endif
 
 #ifdef CONFIG_CPU_MIPSR6
 #define MIPS_ISA_LEVEL "mips64r6"
-- 
2.19.1
