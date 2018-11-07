Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:16 +0100 (CET)
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:46351
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992918AbeKGXODf1xfU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mQI08IUPGFuyZnhZWkrSTxJHPkLOob4VFAmi0IDgFk=;
 b=HGY/ARH36uAoUhjbyKVSGnJ1ekT6iUQP1JFazIMdmW1rEd50BNF4GpQiegKNkpN/AtugXvLxQCiBcYWfqeRMAKJPuqdUd5n1dIDUH/rtsCDms5N+YA/PGrqZTkhU3RaJIfGjCrVk3EjeKHWGx7C9m8uXyHViuy5v3Gm5Xs+6B0U=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:02 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:02 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 06/20] MIPS: Better abstract R2300 FPU usage in Kconfig
Thread-Topic: [PATCH 06/20] MIPS: Better abstract R2300 FPU usage in Kconfig
Thread-Index: AQHUdu+Ra6f1aH7ExkO9FEoYqOoWLw==
Date:   Wed, 7 Nov 2018 23:14:02 +0000
Message-ID: <20181107231341.4614-7-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:vPjdB4kLJ7YIofH9+gjS4aGXNxVHLNF5scXCplRaImC3Keqq8tyOl4VQJDCtd69w2aPOc59ZZxX+95fXoOpu+KhR+xOwM6AN4IIEwCbiO+mOv2dtAnQ9JR0EUKRQuEqmdoRy5vJAiWc9gflxdDrZHctQKoTMv4IHn+Rnm8oIGYWJQl3K8d699wrauj2rxtYiJMFjX4qm4aJ5AHTaI0KgSeWCe2/Kla3O9uTQX+AOuwl+mjTbgpCafBrx0G0Xl26iwWxLkRms402YZxaeD1PUoRSc7+QiscNeqj2kkxpXs8OyqAnUA1nFjXQkEo4c1+mgNOTUI5cZv7muvycKaTG9+cgREMewtrX913Xrarc+skhxXM7UvOMdDeV4kmG2YajeIfguKWVZEn/BhKt5qyQNTJjAPKknFMtHYxSMFJmHQuJFjcUjOriquTVGL0hKLfM6pKJTUGJp0aokj5u2imUoJg==;5:Sxg/ScDTRzAHKyejfuWQu5yhDwywnfxrM71blsEO8WEfqqadkXa2l76AWs702Xvnk8gp5cvXIYHM3Y/RVKldDzDZhSHZ4zHh+MQHPy5j85uOu10pEIpXOKbubIKRldkBA7zU+SttEAhLnoyZslUF7EZEyvCSEO2ClCo+48BhBVU=;7:8+DdwTDgzrNBrxoDs7VlIlR3QW3Qbnv5zui/hWNhHGqPx8oPSA2vxnriSS5W6Je5BERhFmVJrOqB+bJgWU/obFKVUVxpVxYGtpYM8JjHnChfrxcsOPyZR1WR5huAU2oWTlzp+DuGbwRmHjbnQ82qTw==
x-ms-office365-filtering-correlation-id: 84e92c78-d5a3-4d86-512c-08d64506b406
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472DA956F22B87E271287B8C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(575784001)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5CJdzH9FxIprQ3ntvYt0cnJEAKx25St9URsIu0Y0WR0VnWcd/9BLOKN+SCscRYagGf7sljtkqTHQfrQ2sIaFulf9IwsFIl+JhrAA4ha9Dc7tJBlLUnXOGcDvktZYmgaDNB9CSZPdsHbpL7C0f5UwmdsN5pQx4Ig5la72T/5dT4EmVpRb+pFtpzVO8yXvyPPiVh3s3SdMW28BzNt6mo7+Lyv1L1B8IunFmHCdRzhwBTOy4ITIv4axbLMXISqHxbZf//N+c7ADHB86oGDfg7AQnxs687VGeHETh8vTn3ySBxrMciuY+bko9nYuNoUNvjRAXQSFSvfTdM2T38oIJv/1Zf/nCJoMaSUCZqJOM0RUfMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e92c78-d5a3-4d86-512c-08d64506b406
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:02.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67142
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

Introduce a CONFIG_CPU_R2300_FPU Kconfig symbol mirroring the existing
CONFIG_CPU_R4K_FPU, and use it to determine whether to build r4k_fpu.S.

This removes the duplicate R3000 & TX39XX cases in
arch/mips/kernel/Makefile and prepares us for the possibility of
disabling FP support later.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Kconfig         | 6 +++++-
 arch/mips/kernel/Makefile | 3 +--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cf0f5a55a0a4..f69779491868 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2254,9 +2254,13 @@ config CPU_GENERIC_DUMP_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
 
+config CPU_R2300_FPU
+	bool
+	default y if CPU_R3000 || CPU_TX39XX
+
 config CPU_R4K_FPU
 	bool
-	default y if !(CPU_R3000 || CPU_TX39XX)
+	default y if !CPU_R2300_FPU
 
 config CPU_R4K_CACHE_TLB
 	bool
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 210c2802cf4d..847d71c90053 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -42,9 +42,8 @@ sw-$(CONFIG_CPU_TX39XX)		:= r2300_switch.o
 sw-$(CONFIG_CPU_CAVIUM_OCTEON)	:= octeon_switch.o
 obj-y				+= $(sw-y)
 
+obj-$(CONFIG_CPU_R2300_FPU)	+= r2300_fpu.o
 obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o
-obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o
-obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
-- 
2.19.1
