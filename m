Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:49:47 +0200 (CEST)
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:11990
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994695AbeFEFt0gRVJB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw+7FZ/Vl4FYV3byQq9eed3Y54PYkT4e2mNHWsEr7LY=;
 b=GXZIZaHJBPrkJ5TW88NOIZtzVugCQIRGJ6AHcjVhVlFFvGhu0SuSvB/QGaevqMrWvFB3VWunxZzkhSdObEmCwSUWgjmLvZ0Ey44O1R3eMrlrNhl4mswScNj9wRZeNKRdTotHeuowg79fPfpxwaVAq33qq39jxbAPBIHCL858m0c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:13 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v7 3/8] MIPS: Octeon: Properly use sysinfo header file.
Date:   Tue,  5 Jun 2018 00:24:52 -0500
Message-Id: <1528176297-21697-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [12.108.191.226]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com
 (2a01:111:e400:5173::22) To SN1PR07MB3966.namprd07.prod.outlook.com
 (2603:10b6:802:26::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3966;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:hDfqNsM6NSehY9NFeGDFyuebj9sfY2h65O9phRjAcSuqP8Q1saWCxOiHAQ7wMrbzp+Yr1SFNX6Ev2goOoPLnNL1Fvg3rwq67npMy06aBFPiLn0qSS1y7zvLVcqAW/T/LB6JfdVRdW01GunBoKklaF/C0gBsJcoHamulw02gOAl4SHr/wP8gerh8Vo5/BKYcSfw+WmuCuMuX2QRyPA+a1UcMt5Z6I/oZjjzfDSjgMbCiorqX6N2WetMS5oe5kZVgz;25:WiHjT+R4QJaQzMy7NyHsukhhiXVvzlzGM2MMIFxOKYGn2QK+FtnowcuCnTGz4meHT/y+W5Qd2k5QR6rVdeMQ3i90cd3+L8hoVp86ps8vRwP0VLSZtYLrxuQLc0PmkYEoiZBq+u8efxunFhkAjON2GZ/LoBQVBg12cS6IVGOIGcyK/rYzXooc+EEa+2aO8ZCX6I7FuWVQDiKcav8zkTHqAgmK1bw6lci5NwZ2x0obKrJ7qxVdGr10Q2WX2VGmDrgHmwXFxWOIcWCmb8996C4/1vnRH9nhQKhQEo871n+nWor9KeBWp24pE/TDJlSpRnmgw2YCFuf7XAFQEteteID8wA==;31:B66d40HNb9vRg7xAe1mBHAKKp25R5o1JGppcJVnDHemyW4sieRgmC6A8MY37NPVY7kCFi/r8qnwE169TtoFK3nYmN+DxeERDLUC8sAu162f4L0MmVB6flKBOJqx4es2Fbs1y9IVgL33P0aJ4FPgiPB6LynmFyzAGJVWb2/bx71zf67Loag6bQWd4SvOl8KdjFREwfk1zGcaw/VIc64n6YGB5Of6KNjb2C5Bty6iJa+c=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:oJxCOIQyoFvkTr4lvGtDkMS0Zr5/4ms4lUMGeaOf3iLEMetNZ094DPZau3JYgz/kGHCrEtfww6XfDufmrGznHedNFTM80+hJurzLGYZLvryeL7Hu2TeS8XP4etaBeX3WmtaV1XL3Tomkc2pKUKN44bBc+V4ihd4i9VKXZhMxFfePimyAAfChVv3/il+ys2H5cB0pvvdTQV/g5WCmpEqEuj4rxszdFdr64CELY+yZVaiHsOdRJ0nXFTaygVylRyk/hI7XbCq6fllXzwoZG8PLDuihW3uuSxMQzV7g1raXnFnbT7yf/Kas04aefu4AvwTe2IiNHcaIm38vvB2zPslrOmAF9jpoHk0rnITjyK3lpQD/raJqMgc/SkJQCRXp8jw9egGYVlCcGnFqWd/Blfz/diw77rwiHppLXwBDOISLBg2SqhVCye1pMgU+/ibP11+mHUlVgNz59rM++xVdeEYbC/qNsp1xE7+CS9+ABxwszBvfMoL/bMCIsd4GSe0Ti8e7;4:7kUb1ymnMgsSj2/A7kKduXd/M3B7Me1vREdcYiCxb2Q+PDkQSzFvrR8K+fsIpGSuYLOzTBu+2XSBNly0ZVzhEwzF9hSStx674LWCfkBwHcrVDL/C68omGTi5XUtLebcQsLiMjWg97NF8vIXoJGmxmY/O+i+SNUlUhW38PJ2NyAlczTXhdn43/xzcHswnfp2+/S29dNTL0Ay0f5/TMrZQ0ZvQE4t4JvcP8tYCsxPsJqmI8EGIgthfJabUZyDtIcFtO+mA4tvO8nbLcDagKyxkcw==
X-Microsoft-Antispam-PRVS: <SN1PR07MB396602DCC441B5A0358536D880660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(305945005)(48376002)(6916009)(7736002)(59450400001)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(51416003)(68736007)(16586007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:nh962dU6WK2knr5yDHjqp6JMnzl8UFXB9hiFyAsGc?=
 =?us-ascii?Q?uZwmmADN69DA41xWxBU2Fgavp37kBPxghPQkM5eLlLyh/gxy2UYqrfSB2sKj?=
 =?us-ascii?Q?Unzz5lUPjZg18pLhI1VEB0wlSaHIUPBsGkC8SOmn787KnLr/hie34ehp8jTG?=
 =?us-ascii?Q?Deoa6JwCQYlkuBXcafuUFO2z+IiLFB39Ldgki0VGpnhtmW4bZ+6VGO3xCG9p?=
 =?us-ascii?Q?G7PXE405q+tHfWgjeoh76RIPPcooSluFEywUdVuVP1gKxflH+gOxnqdnIIPr?=
 =?us-ascii?Q?VVQPYYbLs3Hv2GFUtOLSAC+pRj8sDJuoHmMFlnkFQO+6jI/Soe9eavBg+69a?=
 =?us-ascii?Q?6KwcJNuEgxxPpLdfCNDgF1KOWkx9+w+3iyY+dypVAK41r4QD7QGgIktH81m/?=
 =?us-ascii?Q?VUe5MXTucSur1rQzcDVfcX5UOHUPzPb5UVbMfsAhHPBZzg/T26owZyYkMCyJ?=
 =?us-ascii?Q?VT+Z5ditt7KG/jOHgjz/5Z9408A9pC/IGyjgL0LqEwLwk+XuqQzMFEVIU952?=
 =?us-ascii?Q?XKruZsW/b2uSmlMjE8xFqnqY4gxW0jpFayJpCMKpr7wh35Tyc/E7I0wOpk/t?=
 =?us-ascii?Q?TUjftWcYI1QjlcLkghAcuFcXoaYzr1pb3lqK0gNA4fJP0OBiVJjlKHUk3ptQ?=
 =?us-ascii?Q?XU2DW/D2u52DjrUwPWqunPXvJQN6ho6UTRlAi2wJWQts5ptDxx5m367f0LDA?=
 =?us-ascii?Q?/ap3jQ2Z212hWBltQXGPiWMxBQs9d3zaQPeJtMNgFjdGFtVka6a9WmOLw2l3?=
 =?us-ascii?Q?fSOn58YPOw6l8iVG4v4PPu4m1PQwNST8jH8q3PFMDzpHjFDltYMO3Bf9Dd0u?=
 =?us-ascii?Q?i4mmjbNuI9o6rx+Yv+bNy9p4EFw6UbTMwNsrZr5PNKdZ6SNNiYgnZJ0K6gC7?=
 =?us-ascii?Q?zOpJQMtR1UE1B+9GqfhWG/WxW2DdGcGN6W1FnWuxDQFkYExi+4Or9JDho3CT?=
 =?us-ascii?Q?U5r43dvxdW5/XP+ixXUe6pVldZb7OiXBow/cFHPtIFXeTLImkGKNG0hYp7Gv?=
 =?us-ascii?Q?gjGxz1frQc9orsUkTwSmOxMal7lZO1XxpGIT9YFhPJGF4s9R8+0FhAHPb/Ua?=
 =?us-ascii?Q?E0GEsb9NpHAkMF4WcFD5K25PGAU/WRWMVnNgggy5FXhGY5/Ab36L/eJ4RH9Q?=
 =?us-ascii?Q?zrqrEqM18Bb9YoRgs3BIcBZASKiNFWe3jKjDSVXuMZUJHTzktonx1OGP6mZt?=
 =?us-ascii?Q?CcWH4Vv7RHQn6p/LgPAsAgF7GdxK35vMicn4OyfPChVxoBfvyXfUy14tm0ZU?=
 =?us-ascii?Q?T6u/8XzfhgMTWtmlMHfTeH7Nkjm2wllMZds+KX6Wi5D+trMQiiIqakOWN2ya?=
 =?us-ascii?Q?xJ/Fb+ufTUC5VfuJLXFkiw=3D?=
X-Microsoft-Antispam-Message-Info: 2ZlrEed3BsHHE+B/QDw0vYk2OFMU7LsWOSX74VGjrdCdErcKc9tb/7sZDE7iihZQP7PRAk5KGHU6q/MRTSEV5HKiPaOii4Dr6ARWVL9UHPi5HBEmPSzi5hNB9Z1YplWCATmWsvMK2hb4Q/B50DBeNqcBqvQTPJBPHUvvYPbKrWsM/h3aac3rmvmm6M6PoE7W
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:lg+H/AGxbHhUV+PLTCtkmzi+Gba87cRR2eytRRMgaCj+K2NXLCWFDBx4V50sdoVTVOK020NEHBHWlTk+6TbOse8lFz9cyntwQwBHyB5aWGcbXpjtYzXuWCXklx5rIIpyjF3159jkpFQ7w01BuMvqfm8g4zZBjrEWwHuM2OOj8UK+yJxGlBO/omUtUFAK2AZObfMgeLCltRR59Tf4oAUUl1ia4NzZWtNnL/UQX8rLmjXGLf0y7X/xj8T8Mzh1/yuL5bg+qT99gs8uOnaPJ5I9VfcHiJEyiP+kwMQzfiggcgspiTpvs5Gvw3LrOAvGbXxlZBbhSNupdmCp2StLVwxcr1XjZZyUtNvBza0y32IIhGiQfuRUjntqWM7NJXNjXHzlRqnHvrzJ5MmHvcMOyfM7FcUhZjBXV5M2spUYXJwrT0psN3V0YM4TjIfDeT75edrDU8Uo9aDkpfwz3My39b8QVw==;5:C6uxtb1XZc2yA7nCW9Mab7/9y4kCjtJvLmVppol2qAqknt3YRbFSbt8KoCTt+VtkrgqNp+82nDidnPkwv5O/7sbYYfmWSVfvKAfeJNEPGMcc3Jy5XisT3YDIlWfF6okG8EPNbO/zLFtxlaRF7t7zoVGXsx2xwR/VY1U1ntgfHwc=;24:wEM1DHnyQ/ub0rDw8FYYjOyt4w24myb8UjZHfWRpjxMW7jogx0GfFY6pR8I+1kXaP2r/SVZ1wn/T41wV4Bt0LJN/h5OF7IR833v/nm5+kvA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:N4x6QPtuPSwJDjucftACgWGQCK1kD1OSs7nk5TeaveeZdbSoYbrTzVMvR5quf2793nwCSbWht7WSdR3VjG5ZcHL/tCvpZaGG3P8M1ifFhTpSOQuGcpMCY5LE8rYQpENNaQVMkwTB1btmcXWhsCv+rvTkzQhqOGBMUtH7olY9A5gRLf2dvV2U+0ldJD7zikHxd47yYcvc2rmd4WKpqA6Hap0cENvpWp4HGgJyrLIyN+Je+a7mrpG2xoFSEbE8kkgY
X-MS-Office365-Filtering-Correlation-Id: bdc4c125-d270-43b2-9ed6-08d5caa811bd
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:13.6718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc4c125-d270-43b2-9ed6-08d5caa811bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Clean up usage of 'cvmx-sysinfo.h' header file. Also sort the
inclusing of header files and update copyrights.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c |  9 ++++-----
 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c  |  3 ++-
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c |  6 +++---
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper-spi.c   |  5 +++--
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  |  4 ++--
 arch/mips/cavium-octeon/executive/cvmx-helper.c       | 13 +++++++------
 arch/mips/cavium-octeon/executive/cvmx-pko.c          |  7 ++++---
 arch/mips/cavium-octeon/executive/cvmx-spi.c          |  6 +++---
 arch/mips/cavium-octeon/octeon-platform.c             |  3 ++-
 arch/mips/cavium-octeon/setup.c                       |  5 +++--
 arch/mips/cavium-octeon/smp.c                         |  1 +
 arch/mips/include/asm/octeon/cvmx-ipd.h               |  3 ++-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h           |  4 ++--
 arch/mips/include/asm/octeon/cvmx.h                   |  2 +-
 15 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e..971c03e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,16 +32,15 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-util.h>
 #include <asm/octeon/cvmx-helper-board.h>
+#include <asm/octeon/cvmx-helper-util.h>
 
-#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 
 /**
  * Return the MII PHY address associated with the given IPD
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e6..c79c8cf 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -5,7 +5,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -33,6 +33,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-helper-jtag.h>
 
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index b8898e2..427f29e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -30,17 +30,17 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#include <asm/octeon/cvmx-npi-defs.h>
-#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-dbg-defs.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-npi-defs.h>
 
 /**
  * Probe RGMII ports and determine the number present
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index a176358..194b3dd 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -31,8 +31,8 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index 2a574d2..0384cac 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -30,10 +30,11 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-spi.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
 #include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-spi.h>
 
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-pko-defs.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 2bb6912..650c239 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -32,15 +32,15 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
 
-#include <asm/octeon/cvmx-pko-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-pcsx-defs.h>
 #include <asm/octeon/cvmx-pcsxx-defs.h>
+#include <asm/octeon/cvmx-pko-defs.h>
 
 int __cvmx_helper_xaui_enumerate(int interface)
 {
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec..9a27dfe 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -31,20 +31,21 @@
  *
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-board.h>
 
 #include <asm/octeon/cvmx-fpa.h>
+#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-pip.h>
 #include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-spi.h>
-#include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-board.h>
 
+#include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-smix-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
 
 /**
  * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 676fab5..e1cd963 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,10 +30,11 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-pko.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
 #include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-pko.h>
 
 /**
  * Internal state of packet output
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a..4901ab2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,15 +30,15 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-spi.h>
 
 #include <asm/octeon/cvmx-spxx-defs.h>
-#include <asm/octeon/cvmx-stxx-defs.h>
 #include <asm/octeon/cvmx-srxx-defs.h>
+#include <asm/octeon/cvmx-stxx-defs.h>
 
 #define INVOKE_CB(function_p, args...)		\
 	do {					\
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..1a52f23 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2017 Cavium, Inc.
+ * Copyright (C) 2004-2018 Cavium, Inc.
  * Copyright (C) 2008 Wind River Systems
  */
 
@@ -13,6 +13,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 3ef1d47..09696cf 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2007 Cavium Networks
+ * Copyright (C) 2004-2018 Cavium, Inc.
  * Copyright (C) 2008, 2009 Wind River Systems
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
@@ -39,8 +39,9 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/pci-octeon.h>
 
 /*
  * TRUE for devices having registers with little-endian byte
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..f08f175 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include "octeon_boot.h"
 
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd.h b/arch/mips/include/asm/octeon/cvmx-ipd.h
index cbdc14b..31fdbeb 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd.h
+++ b/arch/mips/include/asm/octeon/cvmx-ipd.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -36,6 +36,7 @@
 #include <asm/octeon/octeon-feature.h>
 
 #include <asm/octeon/cvmx-ipd-defs.h>
+#include <asm/octeon/cvmx-pip-defs.h>
 
 enum cvmx_ipd_mode {
    CVMX_IPD_OPC_MODE_STT = 0LL,	  /* All blocks DRAM, not cached in L2 */
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index c6c3ee3..f1a11a9 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2016 Cavium, Inc.
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,7 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
-#include "cvmx-coremask.h"
+#include<asm/octeon/cvmx-bootinfo.h>
 
 #define OCTEON_SERIAL_LEN 20
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 25854ab..a58f265 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2017 Cavium, Inc.
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
-- 
2.1.4
