Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:15:27 +0100 (CET)
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:33683
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992965AbeKGXOogrslU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an9hefMn6DXt8U4tJ3aIwkQUo+OCVdr1FzlVOCLJa5I=;
 b=Y9q9bpNXKbZEvMPZxC22w4Ph8qsoBVdpzARp6BTuwhumv09XROrqiWaMyCWYIkKoitgoPUCiVixRPCDWUk7bMYzOeT7L+q1qX10GDEw6lxRM7Y1tn/5XrZ6VMSMQcmORQeuHHH11EL1ThIOUVeYMVYKM7OU/ZoDB5yMHcMXKO7I=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:11 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 20/20] MIPS: Allow FP support to be disabled
Thread-Topic: [PATCH 20/20] MIPS: Allow FP support to be disabled
Thread-Index: AQHUdu+X69JlmT59+EmHlrrj7BjjOw==
Date:   Wed, 7 Nov 2018 23:14:11 +0000
Message-ID: <20181107231341.4614-21-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:g8EvAsowzYsnYyrsaNtVtic4+lnIAb6ELrI0Mudwata5TKLV1aJcxHpKqDORSgCylSScc8k3fcvzpYsPhC5qhDOkJScCP8IF7WrFDt2c3cKM9axZNjjxOINXutCcKZRWRFcsfutO540BzEQ08zYV0iZAg4BYdmE6NT83bFORhwO3WNZpQYZeQFirVoCx8ooofz9ylmAkBqiGDW0VgyLXAlEbwDJSS1TvTGvoL+ATOqBnJbeH9nB25i5WN/ZxUOL29v5m6f2OUZhO/sO6LOVWWfnxVzVCEtgq+z4zpypv3oBfDwzrqF9jNzPzDZyeppbWkuhhkBsRDKJS7VFLrwutBP7s7cXlbIq5/u6Z5OPGlfht/A5mMoIZl3R3De1h/BxWPbg81L0IQ7vro2yAN8Iwayb5T5TzHrl1ifFDk9pU38+6cPDgQNs4vN40Bg8mwBfR3fQP5VGVyztsQMITLLz0FQ==;5:TXPtaaFnybgcp2q29906lCs4mjMWNIjhxvboWTsg5KPD9H0UxuLxmVCLZHfPRS9wYulln1tI/EiXF5ODsQn48jWdT+Bf2PGACO4c2zImZhOccUsbn3q3QECQEFgENiBH3jNc6dqlLBkm7aPaCeKq8/mIU9KJKrXNYKjLkscUBlA=;7:RVmfoxm79dbua2Uv0ePtOHzB9rptmtVic/z5jYRHl9JLvWN6LdE1Bx5fHo0PSBDVPJN92vu0crvJ3fQ+zmEk+zzaNgerLO9ZFtFOLksyea1m97Jk1b+5BaTKljMlw4TuoreUq5zuNPAaLmYCSbnMrA==
x-ms-office365-filtering-correlation-id: 1e57bb53-7794-4701-3660-08d64506b9f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB1581033612D519C18961DE19C1C40@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(99286004)(6486002)(97736004)(36756003)(66066001)(68736007)(486006)(446003)(105586002)(11346002)(2906002)(2616005)(476003)(6116002)(44832011)(1076002)(3846002)(2351001)(106356001)(53936002)(6512007)(6436002)(5640700003)(256004)(14444005)(7736002)(25786009)(71200400001)(26005)(305945005)(386003)(186003)(6916009)(42882007)(6506007)(2501003)(76176011)(71190400001)(52116002)(5660300001)(8936002)(8676002)(316002)(4326008)(81166006)(508600001)(2900100001)(107886003)(102836004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tEke62Ev+1c0QHf3H9VmBVq8ghMPKTDXKCTZsNh5j0k95Mim3f/XusXUOj9LHJpalAeVtfhJeoZn89Zs0C/wOoFOgnCXGPuXJWEnu5vV6p9yZgVc6P/f/hLW9+8rKrJvmRnDAU7a46KAHsKG5VZpND1guYlwjrG19xoNU0d5UQrA160do/CmI0rcjrGpl5xb35D6Tf4yNvmLcaZCnQ9jA2f/ICGjAkwObSnirk76CPf7Xth43vb4GOqNnmcEAehJw8V3aMwAC7WK1fUfP58/ujEGtZuzi1klU4lYq1WwIynkadUnG2NFx2aXbkDoRs0cNCAJt/kQrtQVmdgVu8hlfTggW0l9oDc34W0HsHxadDI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e57bb53-7794-4701-3660-08d64506b9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:11.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67154
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

Allow the user to configure the kernel to omit support for floating
point, by setting CONFIG_MIPS_FP_SUPPORT=n. In an attempt to avoid
problems for users who don't understand the impact of this, only expose
the option when CONFIG_EXPERT=y.

When CONFIG_MIPS_FP_SUPPORT=n all support for FPU hardware, FPU
emulation & FP context will be removed from the kernel. If a userland
program attempts to execute a floating point instruction it will receive
a SIGILL.

Setting CONFIG_MIPS_FP_SUPPORT=n shaves around 112KB from a
64r6el_defconfig build using GCC 8.1.0.

This also helps prepare us for supporting the nanoMIPS ISA, for which
floating point support has not been finalized.

Signed-off-by: Paul Burton <paul.burton@mips.com>

---

 arch/mips/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2b3891c45461..ffcf72aa9955 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2255,7 +2255,19 @@ config CPU_GENERIC_DUMP_TLB
 	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
 
 config MIPS_FP_SUPPORT
-	def_bool y
+	bool "Floating Point support" if EXPERT
+	default y
+	help
+	  Select y to include support for floating point in the kernel
+	  including initialization of FPU hardware, FP context save & restore
+	  and emulation of an FPU where necessary. Without this support any
+	  userland program attempting to use floating point instructions will
+	  receive a SIGILL.
+
+	  If you know that your userland will not attempt to use floating point
+	  instructions then you can say n here to shrink the kernel a little.
+
+	  If unsure, say y.
 
 config CPU_R2300_FPU
 	bool
-- 
2.19.1
