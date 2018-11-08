Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 00:46:13 +0100 (CET)
Received: from mail-eopbgr730129.outbound.protection.outlook.com ([40.107.73.129]:34459
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990429AbeKHXo6omYa7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 00:44:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap0flt5BLVTKZIJM1Lq96rhFcLiiMfXXnZHo+RY7wTs=;
 b=iffULshZGp6kIhKgUn8X5poV4k1ANm1IhtamFloJPnOqUBmHfpTOxBy9j6wKRBGzZs/0z+KZ8fJ6SCRt1++XePty+TeBhps0GMko//gQ6wQEWdGdJch2i3rDJIylIGIQP1mU7xvwf+HrNAJ+FQJBJTKfSmKNQ0m87CA/s3Mizk0=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1757.namprd22.prod.outlook.com (10.164.133.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 23:44:56 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 23:44:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 1/2] MIPS: Use Kconfig to select CPU_NO_EFFICIENT_FFS
Thread-Topic: [PATCH 1/2] MIPS: Use Kconfig to select CPU_NO_EFFICIENT_FFS
Thread-Index: AQHUd70Nj7bmBkBSmUuHKRskL/vjkQ==
Date:   Thu, 8 Nov 2018 23:44:55 +0000
Message-ID: <20181108234409.21199-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0074.namprd22.prod.outlook.com
 (2603:10b6:301:5e::27) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1757;6:f8S2810fWrWvSo9lj7hTflGHk8Ee0eVM6hf9nhhoBK1RnnmDRWjjqktdhIhmV145kWKuEJ50AqdGhfik5ffi+TD1Q85pk6eZjIZkj0WKmcQ9I12C+T2jwOaN4I0YA0KrL6xHW4/pBSTrGuD247b9gFbhqFBWsgacH2mPtEhmPeeqzRJP1lztnKY7ZXmAheKMk7Pg3y8PqjUNanJAjP3Sy8X35s6tnaREu7FeJ0doa2UQnkIE/ldkGZ6mp1J2EEM6/JdUqdVm6PbgrUVP1FyGahW1WMQuUMxGbiOlNDqMwHqHvQk0lj4sh3DHoHxUPZqrXpODGW8LFMqoyvLDonQWTNtQwaNuT7BKI9zCtn2B/Xcxh7u7bj1lR1LFBCTIrAINjw70XvyWfBUeqb1wpRmaNVnAkgRF7WPcY5HAp7c1nA1KZGNUx5H65UTVad7XQ7gyfNFuAlnS0QrYrqMkp1nviQ==;5:4PDiFqlCy8SeMVnK45x9f+Y8pd4F/OFHQLVPBg6smRzkspGcw/3L+BsYYMEEiFXRhO3hnhwmQ/FZNuhqFWj2WEphf6UC0ddRgz9j2/vS1NQrU3vrPM8UeqzV2S94ulOeoQ2Ih+kt6a1YwDm6sjhZ/Tg0R4iiWwi3bzmbFEmkt68=;7:8BVxaTaFcCJhcU8Z0PHJl6z5qA/sC3WhnsA+mtW6gtYcea/rLCq1IM95JxGND6fnKOZlijmqETE0R7KLtwp5AE82d8X4Q5a6Ige55k6YGrPFQpd+KYK9iWMV8OtbVGxZ58dzU5Z/B3XpDfpT4xaLpw==
x-ms-office365-filtering-correlation-id: 8df833e4-55c8-4b19-0419-08d645d42f65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1757;
x-ms-traffictypediagnostic: MWHPR2201MB1757:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB1757AF794992D28EE75A7920C1C50@MWHPR2201MB1757.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1757;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1757;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(136003)(376002)(396003)(346002)(189003)(199004)(186003)(1076002)(316002)(26005)(2351001)(14444005)(256004)(2906002)(105586002)(7736002)(305945005)(106356001)(8676002)(6116002)(81166006)(8936002)(81156014)(3846002)(99286004)(68736007)(52116002)(102836004)(386003)(54906003)(2900100001)(6506007)(39060400002)(53936002)(4326008)(2501003)(508600001)(44832011)(25786009)(5660300001)(486006)(71200400001)(6512007)(2616005)(71190400001)(476003)(97736004)(66066001)(14454004)(6486002)(42882007)(6916009)(6436002)(5640700003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1757;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gkDgyoh3sW49/N+ZQTqnIXlkrIhCQPnqtdXLTp3gXZHK1ziS7bN/W9c2s8bE33e4sdeTP5UF/rrkvEIm4GMLzPNXaf9QsC9fb88X/2/izOVGuYmLwPCjmiMNaQMxhXsieO5jrLb4bysFLSCC3LTnu9Wc8TOWDqNPsYbg5yN4oPyYridE6bj6v6JviVe4s3nueHIA3bykwSAGdzi6kZyQd+VucUfjbOMIcRNRlrYRnDcdMgwEYA6i5sCnMRaSVMB5K0Ypew8QiY/ad95jvZPiGLZA+hROQOAUqFm2ViO2jyLslf2OCrucwDrGxQ3GQD9rFx/lIW2dT3oj5y+LNuZls2cCPs7a8xksbyQ/76BSjF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df833e4-55c8-4b19-0419-08d645d42f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 23:44:55.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1757
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67187
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

Select CONFIG_CPU_NO_EFFICIENT_FFS via Kconfig when the kernel is
configured for a pre-MIPS32r1 CPU, rather than defining its equivalent
in asm/cpu-features.h based upon overrides of cpu_has_mips* macros.

The latter only works if a platform has an cpu-feature-overrides.h
header which defines cpu_has_mips* macros, which are not generally
needed. There are many cases where we know that the target ISA for a
kernel build is MIPS32r1 or later & thus includes the CLZ instruction,
without requiring any overrides from the platform. Using Kconfig allows
us to take those into account, and more naturally make a decision about
instruction support using information about the target ISA.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---

 arch/mips/Kconfig                    | 13 ++++++++++++-
 arch/mips/include/asm/cpu-features.h | 10 ----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71aaa5bcd805..6696eadf7267 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -15,6 +15,7 @@ config MIPS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
+	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE
 	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
@@ -2032,7 +2033,7 @@ config CPU_MIPS64
 	default y if CPU_MIPS64_R1 || CPU_MIPS64_R2 || CPU_MIPS64_R6
 
 #
-# These two indicate the revision of the architecture, either Release 1 or Release 2
+# These indicate the revision of the architecture
 #
 config CPU_MIPSR1
 	bool
@@ -2053,6 +2054,16 @@ config CPU_MIPSR6
 	select MIPS_CRC_SUPPORT
 	select MIPS_SPRAM
 
+config TARGET_ISA_REV
+	int
+	default 1 if CPU_MIPSR1
+	default 2 if CPU_MIPSR2
+	default 6 if CPU_MIPSR6
+	default 0
+	help
+	  Reflects the ISA revision being targeted by the kernel build. This
+	  is effectively the Kconfig equivalent of MIPS_ISA_REV.
+
 config EVA
 	bool
 
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1f3f7453c1d2..83a27af8ada6 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -261,16 +261,6 @@
 #endif
 #endif
 
-/* __builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r */
-#if !((defined(cpu_has_mips32r1) && cpu_has_mips32r1) || \
-	  (defined(cpu_has_mips32r2) && cpu_has_mips32r2) || \
-	  (defined(cpu_has_mips32r6) && cpu_has_mips32r6) || \
-	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
-	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
-	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
-#define CPU_NO_EFFICIENT_FFS 1
-#endif
-
 #ifndef cpu_has_mips_1
 # define cpu_has_mips_1		(MIPS_ISA_REV < 6)
 #endif
-- 
2.19.1
