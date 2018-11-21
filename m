Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 22:58:12 +0100 (CET)
Received: from mail-eopbgr710133.outbound.protection.outlook.com ([40.107.71.133]:18400
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993843AbeKUV4isAZLK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 22:56:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cf6Ha4LpYUTcPUz8TR1RCy1zwduk+wL8F2JtoqPGiY=;
 b=ZUxOplSqZqWkOMh41eR9DrEAAcF+kD3du5kYcT2UiIQLNKELMD5MpLZGeDGyTMb9HQhMBsEvKo0qXHyx+LWyxWhrfNEVgovCaXPp5RY2JY9RQgsDZtLDsGy8NgwWSBZ5J52cPs5BAh+IYyV+VlN0qsjymzP+48Y1JWxUMFFBcW8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 21:56:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 21:56:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Enable dead code elimination
Thread-Topic: [PATCH] MIPS: Enable dead code elimination
Thread-Index: AQHUgeUSZdktL+pHu0CuQIGgjSaL2g==
Date:   Wed, 21 Nov 2018 21:56:36 +0000
Message-ID: <20181121215623.31911-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:300:ee::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:c7J9TYOZsDhL4Q1FlFjUZ5ArUf4BJP/DLnZTSt1a6UP/qjNwvP7IdOyyDQMKalF1+girFNLEPrkW47s7NKIb8CHo6FpQUslsbbSuP+Ycy5ksw7pfSOxcc1s45UoeeqMQTUb5U+eefE2D9fZ2qWJ4dJXHs7uMjuqTcWfW8vxrytSHXyakkrLWGYSJChllBwvzHyg54Vg/dpiFmXhB885gbyfamnbQdoLmjY0YF+7ejZeEfVn6DuCa+lJdoVNSfZrRHnOTVtCbCtGNeTTX6YJfaa2c5K1UiSrh0UknNLaKwzqVDUl0tflBXIq4tTGKls6wHFJAYmrN6J+A+C+ED9RlOgBSI1g3lGa7SvEhf7Ug/Uikeij60UxZIieV9byfPayCy9yPXevTq6KlFMdOhdx+D/Ww3wIdJHgVRlF44uDEUAkNM5x+ywijN3aQaUTk3zIgyPKe5jx5mpyvksQGGvVWzQ==;5:Ia6/zVriSoEGeCf+H13NaLI7OOLUipsgIxEExQynXw2+IVAdgXuNmWTD4HY6Loccew0ssP6bCKRyWSwAVG2+O65pJdGnbrulJnV6lwk8XYDdXrzBfK0KXnaqe4YrjZC5SoWEsQs/yZHSrisv7qNvvKGFGMU+ydVVTxPaMMKdJyg=;7:/atVjPxW5WwMErZYhuPv99SxuXs8xqwKjULLqnyivIIXYizK7hW3fT0tiScETZ5v7HOfKWTbHhuIG/AbmjUt3Cr6VMIl38HmpF2arltJnga0IMUG35BI9f6ZCwOdVfwmnGK58Qe3sZKqFIL4OaPV8Q==
x-ms-office365-filtering-correlation-id: a70bdcff-1b85-49a5-acd4-08d64ffc34cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB1119D177BB34B22D3149D401C1DA0@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39840400004)(136003)(396003)(199004)(189003)(8936002)(486006)(4326008)(476003)(7736002)(14444005)(102836004)(66066001)(386003)(6506007)(105586002)(97736004)(36756003)(106356001)(42882007)(2616005)(68736007)(2501003)(186003)(14454004)(1857600001)(256004)(44832011)(81156014)(81166006)(26005)(6436002)(8676002)(305945005)(316002)(25786009)(107886003)(6116002)(5660300001)(6916009)(99286004)(52116002)(966005)(575784001)(1076002)(3846002)(2900100001)(53936002)(71200400001)(2906002)(71190400001)(508600001)(6306002)(5640700003)(6486002)(6512007)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Af9oSErUWXBk3RQURnwureuNtm7ZSktaik8UOMnpPDGTt85RF4eQI2uB6TZp0BkBDn3xj9WztMhXU0kSdCmA4KaQ11XDhnWXdP9d0eleiK/CN/9UH8Zr+RQOVvuDtR6rbAQSPDjnC7QNUvalxn9US0o1IZgygqnLxBfN57ckWmQACEaxMlAL7xDYEVQJhsk988X9wPhg1auGcFHRE8AFXfXQ8oyM0heEsLdCKkNc9QU/QVGQ2NNu+w13lbGC5J51AnOUhL/on3zGCr80afJjBn+flm+J6ah91v9+qbQDHyvc4SCqCbdyZMhWE47Og1mJIsDJV9m06i9pSwOCrjI5BaM0MwdZf3okYY3hV8yC2WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70bdcff-1b85-49a5-acd4-08d64ffc34cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 21:56:36.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67428
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

Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for MIPS, allowing the
user to enable dead code elimination. In order for this to work, ensure
that we keep the data bus exception table & the machine list by
annotating them with KEEP.

This shrinks both 32r2el_defconfig & 64r6el_defconfig builds by ~6%, as
shown by numbers from scripts/bloat-o-meter:

          | 32r2el_defconfig | 64r6el_defconfig
  --------|------------------|------------------
   No DCE | 8919864          | 8286307
      DCE | 8338988 (-6.51%) | 7741808 (-6.57%)

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org

---
v1: https://patchwork.linux-mips.org/patch/14441/

Changes in v2:
- Drop CONFIG_THIN_ARCHIVES, which is no longer configurable.
- Keep Kconfig alphabetically sorted.

 arch/mips/Kconfig              | 1 +
 arch/mips/kernel/vmlinux.lds.S | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e83a8cce41e9..e49b5a0c8585 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -63,6 +63,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 971a504001c2..cb7e9ed7a453 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -72,7 +72,7 @@ SECTIONS
 	/* Exception table for data bus errors */
 	__dbe_table : {
 		__start___dbe_table = .;
-		*(__dbe_table)
+		KEEP(*(__dbe_table))
 		__stop___dbe_table = .;
 	}
 
@@ -123,7 +123,7 @@ SECTIONS
 	. = ALIGN(4);
 	.mips.machines.init : AT(ADDR(.mips.machines.init) - LOAD_OFFSET) {
 		__mips_machines_start = .;
-		*(.mips.machines.init)
+		KEEP(*(.mips.machines.init))
 		__mips_machines_end = .;
 	}
 
-- 
2.19.1
