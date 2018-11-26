Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 20:00:10 +0100 (CET)
Received: from mail-eopbgr700099.outbound.protection.outlook.com ([40.107.70.99]:38816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993032AbeKZS6mjtyQH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 19:58:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL2k05V45bogJp9J8rN13fmAa4Da4z4o3cy5YkqPbtA=;
 b=pL5SU+ivJGbCp5QAURqeBDFjmlPi0/EM7pU277Dhq1Pa53fro7fanvz5c1259YGNCgvV9in1JzLDCXj/BDQmcQ9VYx+nucveAOxklm9gqBRjsqKZRvx+ksgxDuj75l9+EpbZV8Z9v6KJaC9qaUgw5wGthbj15xY8DYh+aWulC+s=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1357.namprd22.prod.outlook.com (10.172.61.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 18:58:40 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 18:58:40 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Hardcode cpu_has_mips* where target ISA allows
Thread-Topic: [PATCH] MIPS: Hardcode cpu_has_mips* where target ISA allows
Thread-Index: AQHUhboLqFn8o3nj6kWJZ/YNi5uxYw==
Date:   Mon, 26 Nov 2018 18:58:40 +0000
Message-ID: <20181126185829.11551-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:301:1::12) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1357;6:v9fAVJXCMAZyvMGGhkLDqxvX7b8FI2UsqwqUGoZccx74A8ja1xowzUja7r6bMXm68OiuqzpYGxjmSjsCT3Lgli9pwX2R9ojNVw9FvKlyc6ITjCiOAJU1MIpeTZJrWwIIDq0tVplCn/5qcF+6I8ta45q25GB3XK2vYNbi6IV4I8WKIZQ1NEzdGKZfkJnUNCGbeFX7xrLwVWdGIlnCLxTSpoTjvfDYHeJdApvqum5z3cWGoUnrpK6K4ktt+j/pZI5q/7H5w/oqBkr60mIA9TVm72xfYKa0nHYgQxCEJamgMOwUdBEwzttRnxmla/vRKYifMdUr4jyr1WTB46U4Ua0xUrr7E9HtU6/PbJ5pois7T9Rw1o9O9xqRL5bvRl/RFetzT7dIEtX5xW9/LglNNGOS3xN8BU/MmkMjqMjlLh/AdXPaHzlQ3qgBXF1IDuM4HnI897Tw0pMkzWF/bnOJetVXjw==;5:2AXsTtKvEnLFfBF0AktlLjWEgOWlgzblmrqfY5Uf1Z+nPR61ez440FjQElf0fD4q64L4DeW+St6W6/OmIQlaTf/UX4Md1F7hoFoKezapHTMISv551/kOuqrij1RGvo7JkzzvhlEJK2OjmRuUvUj4BO0LRYXZTPY5AK9tD+ms7qg=;7:U5TLr2hOR7NZ09ZjvTEI3+mRt0WtiTA62ZZQ4zvZH5WFlzL6s08KfRdTScESe/rP71MkZuOOMY60DtWTTl+LrVeQ+yAguoQWKPZ2SIivIn9ZbbrCKgShEan/+pTuOHfPW0a800zjvBmgjn26ztbf3g==
x-ms-office365-filtering-correlation-id: 1831a6b5-b708-43a3-8ca6-08d653d12db6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1357;
x-ms-traffictypediagnostic: MWHPR2201MB1357:
x-microsoft-antispam-prvs: <MWHPR2201MB13575FD5965226CB06481389C1D70@MWHPR2201MB1357.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1357;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1357;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(396003)(136003)(366004)(346002)(189003)(199004)(5640700003)(8936002)(68736007)(97736004)(81156014)(81166006)(8676002)(25786009)(14454004)(2501003)(508600001)(105586002)(1076002)(106356001)(2351001)(6116002)(3846002)(107886003)(71200400001)(66066001)(316002)(42882007)(1857600001)(7736002)(305945005)(36756003)(6436002)(6486002)(52116002)(44832011)(26005)(186003)(486006)(476003)(102836004)(2616005)(6506007)(2906002)(386003)(6916009)(53936002)(71190400001)(99286004)(14444005)(4326008)(256004)(5660300001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1357;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3cyodoGtamqlnIKUjA8cTWlDyLgwGW/bOl0TSR1ksXFjzmA2DJlMuuOIcW6KFxrqhcq5/o0QUbo5CA3gtCSQMc3qzTWucsX04wSkKxdQ0gcbjs+2d/DdDA5TJslU9UQfDNfGmrWFrDyoVv+ExZE9un4hNUkKuryWylpxI4OBqxPCg0i0LATEx3DadlsNGsCXDT1a6HZ4s5NsZpWmnaFTKMDaJUBTPivQXoUWMcXrCBl/EZ4dABOWPiUvOA/IXtPABmlYuPZKd/QbwENk2z6l0+rFuPL18KcrVyeW05u6IQlgisIsXosJAYg5Ilq9XbR8OJNEaprJw++AcY4RedmQQJM5SjQRMr8rn8A4a4G7fas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1831a6b5-b708-43a3-8ca6-08d653d12db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:58:40.5181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1357
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67517
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

In the same vein as commit 93e01942a6eb ("MIPS: Hardcode cpu_has_* where
known at compile time due to ISA"), we can use our knowledge of the ISA
being targeted by the kernel build to make cpu_has_mips* macros
compile-time constant in some cases. This allows the compiler greater
opportunity to optimize out code which will never execute.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/cpu-features.h | 35 +++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 0edba3e75747..2a5382545983 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -15,6 +15,7 @@
 #include <cpu-feature-overrides.h>
 
 #define __ase(ase)			(cpu_data[0].ases & (ase))
+#define __isa(isa)			(cpu_data[0].isa_level & (isa))
 #define __opt(opt)			(cpu_data[0].options & (opt))
 
 /*
@@ -52,6 +53,18 @@
 #define __isa_lt_and_ase(isa, ase)	((MIPS_ISA_REV < (isa)) && __ase(ase))
 #define __isa_lt_and_opt(isa, opt)	((MIPS_ISA_REV < (isa)) && __opt(opt))
 
+/*
+ * Similarly allow for ISA level checks that take into account knowledge of the
+ * ISA targeted by the kernel build, provided by MIPS_ISA_REV.
+ */
+#define __isa_ge_and_flag(isa, flag)	((MIPS_ISA_REV >= (isa)) && __isa(flag))
+#define __isa_ge_or_flag(isa, flag)	((MIPS_ISA_REV >= (isa)) || __isa(flag))
+#define __isa_lt_and_flag(isa, flag)	((MIPS_ISA_REV < (isa)) && __isa(flag))
+#define __isa_range(ge, lt) \
+	((MIPS_ISA_REV >= (ge)) && (MIPS_ISA_REV < (lt)))
+#define __isa_range_or_flag(ge, lt, flag) \
+	(__isa_range(ge, lt) || ((MIPS_ISA_REV < (lt)) && __isa(flag)))
+
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
@@ -257,37 +270,37 @@
 #endif
 
 #ifndef cpu_has_mips_1
-# define cpu_has_mips_1		(!cpu_has_mips_r6)
+# define cpu_has_mips_1		(MIPS_ISA_REV < 6)
 #endif
 #ifndef cpu_has_mips_2
-# define cpu_has_mips_2		(cpu_data[0].isa_level & MIPS_CPU_ISA_II)
+# define cpu_has_mips_2		__isa_lt_and_flag(6, MIPS_CPU_ISA_II)
 #endif
 #ifndef cpu_has_mips_3
-# define cpu_has_mips_3		(cpu_data[0].isa_level & MIPS_CPU_ISA_III)
+# define cpu_has_mips_3		__isa_lt_and_flag(6, MIPS_CPU_ISA_III)
 #endif
 #ifndef cpu_has_mips_4
-# define cpu_has_mips_4		(cpu_data[0].isa_level & MIPS_CPU_ISA_IV)
+# define cpu_has_mips_4		__isa_lt_and_flag(6, MIPS_CPU_ISA_IV)
 #endif
 #ifndef cpu_has_mips_5
-# define cpu_has_mips_5		(cpu_data[0].isa_level & MIPS_CPU_ISA_V)
+# define cpu_has_mips_5		__isa_lt_and_flag(6, MIPS_CPU_ISA_V)
 #endif
 #ifndef cpu_has_mips32r1
-# define cpu_has_mips32r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R1)
+# define cpu_has_mips32r1	__isa_range_or_flag(1, 6, MIPS_CPU_ISA_M32R1)
 #endif
 #ifndef cpu_has_mips32r2
-# define cpu_has_mips32r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R2)
+# define cpu_has_mips32r2	__isa_range_or_flag(2, 6, MIPS_CPU_ISA_M32R2)
 #endif
 #ifndef cpu_has_mips32r6
-# define cpu_has_mips32r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
+# define cpu_has_mips32r6	__isa_ge_or_flag(6, MIPS_CPU_ISA_M32R6)
 #endif
 #ifndef cpu_has_mips64r1
-# define cpu_has_mips64r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R1)
+# define cpu_has_mips64r1	__isa_range_or_flag(1, 6, MIPS_CPU_ISA_M64R1)
 #endif
 #ifndef cpu_has_mips64r2
-# define cpu_has_mips64r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R2)
+# define cpu_has_mips64r2	__isa_range_or_flag(2, 6, MIPS_CPU_ISA_M64R2)
 #endif
 #ifndef cpu_has_mips64r6
-# define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
+# define cpu_has_mips64r6	__isa_ge_and_flag(6, MIPS_CPU_ISA_M64R6)
 #endif
 
 /*
-- 
2.19.1
