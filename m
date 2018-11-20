Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 01:00:12 +0100 (CET)
Received: from mail-eopbgr780097.outbound.protection.outlook.com ([40.107.78.97]:29204
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993829AbeKTX77kPA6q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 00:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aspQIiVLA8/ppeZ6AlRwNnxgVm2NbMDsSvsfJ/FYE8=;
 b=RbdiFTjo7vnPC5Qjo/bAGhLwu5oNGgf64zGqdPPB8eHaomnvF9bgh68cWyY/XsBfD6wTecJ64tVFfC8MTSWdHs4xYUxzYhfZCJVTLHNmChIn1VF/aoZ3YypE3ZaUOFQJF31YWGI1408P9e0xLWxd0nnXkF4Bsu+kBSb6waNGwr4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1247.namprd22.prod.outlook.com (10.174.162.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 23:59:57 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 23:59:57 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: malta: Use img-ascii-lcd driver for LCD display
Thread-Topic: [PATCH] MIPS: malta: Use img-ascii-lcd driver for LCD display
Thread-Index: AQHUgS0jJtHjVT78vkq5jPtctlVABg==
Date:   Tue, 20 Nov 2018 23:59:56 +0000
Message-ID: <20181120235937.32049-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0050.namprd22.prod.outlook.com
 (2603:10b6:300:12a::12) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1247;6:mdJkDd5LLoCcAfyFgHP+CXM9YOtpyq8IKaSPNZnNdHoflESDTza09vTuXRHuyIWaZ+9Oihq8JQICyNVtIVPtVSlkNe6feh0mxZrdWn5z26n4uSlCiOyx0a+xGreWxtc09OTG3gMz7pgaMawAVCRngRk5Ix4sQ1gRhXbDUFAT3YK4peDPn/QxoRGod2LF92y3faUrG/DnZ/bOOUEAJwnbpns9XyUfcnjV95VRgO/8XO1/5Elo0E/03abMNF1gaskBoZahTKkl9VsJQXKClD3mUysGqct3e/FApW2myH4lQFlXD+097tnZ4twXP5c1ryfKr+i2ZL6lTPKwlC46ILkjdEblHNXumv2qv3bgLcrLPFL+C9i/SEyhEst5rgxzI8+MNhGmcBZtNTbJZPQWpEMjSJd2Atqqm9IU7j+5utOMirwGsGl+NZfy9vU1DsGn6FX4gEgLFMFYxaFAYWr9Xt7bOg==;5:/AuxmSsZBn8GHrGDhLerAF9zj70zNwFLwlvNdwDCR4erl4H86Vta3bX9kloEcszMbRswnaM5B6E+WiqTmt867xWSGXZq34F2PNxyuWBMroNabUghfhiXgWs1wag7ld5o5ukMjLsVblxMieJoO8QSESKarnhLBKTi347Anucwxoo=;7:S58wPJKlqqFCPxD0Whe5AsnRtCQvO/9YPEeBRtCXJFZg3t07uW4dsyvc0ONwwsLFrrNDvQUx0iqYLJpuKlaiNXGREbowA7KH4YlehcU2EqNGyACuF3hlOA0wIN4gUrpjetxmFNjuVC5d+QGvUDF8Yw==
x-ms-office365-filtering-correlation-id: 09ba6698-8dfe-421d-943d-08d64f4445cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1247;
x-ms-traffictypediagnostic: MWHPR2201MB1247:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB1247D385DBB0E42D3E8C3B4EC1D90@MWHPR2201MB1247.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1247;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1247;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39840400004)(366004)(396003)(199004)(189003)(25786009)(256004)(106356001)(5640700003)(386003)(186003)(2351001)(102836004)(26005)(6506007)(6436002)(71190400001)(1857600001)(8936002)(81166006)(42882007)(1076002)(81156014)(476003)(305945005)(8676002)(5660300001)(6116002)(2616005)(44832011)(3846002)(71200400001)(36756003)(486006)(2900100001)(508600001)(66066001)(14444005)(6916009)(97736004)(107886003)(6486002)(14454004)(2906002)(316002)(68736007)(53936002)(2501003)(6512007)(7736002)(99286004)(4326008)(575784001)(52116002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1247;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GP6b9VFlSt/7NpVH3tZfI9dXbuoxv7tEdMFJCgSsIjU/mpcP5W9IKWJsKUwvNJ+WPYZMPJ9JrndjJpdaqhYrF0ZmVF1VpACv0Oaigo7E7Ao5CuaqSBBUNuFaA2vjnC4m/c/A4xLhfqz+a81ZnapdICG8UTt0rezr4ZqcA+qSXsc1u5dYYpLw8Lnd8Cxpr6i6VjQPMMjinRaOOQ5nLT12MZUJBRd8NTEvRc6stMOgLwOg/ayhIp03s9qhwFmCaokr0UVV6ggs/X+1RCw4WbIak4uP+Jx4WQMjeZIG9RaLNXNXp3EdYmnP1PxBcyO7stkpkmzT4SAFKuah/V/r4sFl211zUkONe8PPsSQjW2Hs/04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ba6698-8dfe-421d-943d-08d64f4445cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 23:59:56.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1247
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67413
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

Remove the Malta display platform code in favour of probing the
img-ascii-lcd driver via device tree. This reduces the amount of
platform code & the img-ascii-lcd driver offers us advantages in terms
of code sharing with other boards & functionality such as changing the
displayed message via sysfs. Defconfigs are untouched because the driver
already defaults y on when CONFIG_MIPS_MALTA=y.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/boot/dts/mti/malta.dts    |  5 +++
 arch/mips/mti-malta/Makefile        |  1 -
 arch/mips/mti-malta/malta-display.c | 56 -----------------------------
 arch/mips/mti-malta/malta-init.c    |  3 --
 arch/mips/mti-malta/malta-setup.c   |  2 --
 arch/mips/mti-malta/malta-time.c    |  2 --
 6 files changed, 5 insertions(+), 64 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-display.c

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 9944e716eac8..f03279b1cde7 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -87,6 +87,11 @@
 		reg = <0x1f000000 0x1000>;
 		native-endian;
 
+		lcd@410 {
+			compatible = "mti,malta-lcd";
+			offset = <0x410>;
+		};
+
 		reboot {
 			compatible = "syscon-reboot";
 			regmap = <&fpga_regs>;
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 17c7fd471a27..94c11f5eac74 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -6,7 +6,6 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				+= malta-display.o
 obj-y				+= malta-dt.o
 obj-y				+= malta-dtshim.o
 obj-y				+= malta-init.o
diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
deleted file mode 100644
index ee0bd50f754b..000000000000
--- a/arch/mips/mti-malta/malta-display.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Display routines for display messages in MIPS boards ascii display.
- *
- * Copyright (C) 1999,2000,2012  MIPS Technologies, Inc.
- * All rights reserved.
- * Authors: Carsten Langgaard <carstenl@mips.com>
- *          Steven J. Hill <sjhill@mips.com>
- */
-#include <linux/compiler.h>
-#include <linux/timer.h>
-#include <linux/io.h>
-
-#include <asm/mips-boards/generic.h>
-
-extern const char display_string[];
-static unsigned int display_count;
-static unsigned int max_display_count;
-
-void mips_display_message(const char *str)
-{
-	static unsigned int __iomem *display = NULL;
-	int i;
-
-	if (unlikely(display == NULL))
-		display = ioremap(ASCII_DISPLAY_POS_BASE, 16*sizeof(int));
-
-	for (i = 0; i <= 14; i += 2) {
-		if (*str)
-			__raw_writel(*str++, display + i);
-		else
-			__raw_writel(' ', display + i);
-	}
-}
-
-static void scroll_display_message(struct timer_list *unused);
-static DEFINE_TIMER(mips_scroll_timer, scroll_display_message);
-
-static void scroll_display_message(struct timer_list *unused)
-{
-	mips_display_message(&display_string[display_count++]);
-	if (display_count == max_display_count)
-		display_count = 0;
-
-	mod_timer(&mips_scroll_timer, jiffies + HZ);
-}
-
-void mips_scroll_message(void)
-{
-	del_timer_sync(&mips_scroll_timer);
-	max_display_count = strlen(display_string) + 1 - 8;
-	mod_timer(&mips_scroll_timer, jiffies + 1);
-}
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 009f2918b320..ff2c1d809538 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -118,8 +118,6 @@ phys_addr_t mips_cpc_default_phys_base(void)
 
 void __init prom_init(void)
 {
-	mips_display_message("LINUX");
-
 	/*
 	 * early setup of _pcictrl_bonito so that we can determine
 	 * the system controller on a CORE_EMUL board
@@ -277,7 +275,6 @@ void __init prom_init(void)
 
 	default:
 		/* Unknown system controller */
-		mips_display_message("SC Error");
 		while (1);	/* We die here... */
 	}
 	board_nmi_handler_setup = mips_nmi_setup;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 5d4c5e5fbd69..85c6c11ebcea 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -81,8 +81,6 @@ const char *get_system_type(void)
 	return "MIPS Malta";
 }
 
-const char display_string[] = "	       LINUX ON MALTA	    ";
-
 #ifdef CONFIG_BLK_DEV_FD
 static void __init fd_activate(void)
 {
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index d22b7edc3886..f403574a1e6f 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -251,8 +251,6 @@ void __init plat_time_init(void)
 	printk("CPU frequency %d.%02d MHz\n", freq/1000000,
 	       (freq%1000000)*100/1000000);
 
-	mips_scroll_message();
-
 #ifdef CONFIG_I8253
 	/* Only Malta has a PIT. */
 	setup_pit_timer();
-- 
2.19.1
