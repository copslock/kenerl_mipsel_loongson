Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:50:29 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:25310
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994694AbeFEFtcXRqbB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogimwudVHIbWnwhRLmfZNCg4oSH5GUW87nYm6wX2Uo0=;
 b=S5pjsqG9OMzFqgv4TjOTItUysiF+z2aUcAc23rjEdqAhPB87osY6cqSLudNogx76WOwM5rE37497cWz2hjTlEQxRoT1VzZKYobtm3KAtZk3nmknFna6zxeY1mCy+3vMZsxSExQNWll7DTX4FYXTOwGw0YdziBE6cAQ9gmg5l7Dc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:12 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v7 2/8] MIPS: Octeon: Remove extern declarations.
Date:   Tue,  5 Jun 2018 00:24:51 -0500
Message-Id: <1528176297-21697-3-git-send-email-steven.hill@cavium.com>
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
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:0Ba54QDCq+2afHtHETuYARRj8hngoVrH3ZiGOtMJ+syBU/DszBne6o60McL7f9dqlac28Roaro0dQxVXDc0Nb6NgslLlXmB1Dy7a1pRbIk5ks9pXpmPsZZWenOEgNFU0dZSieDOl0wJLMjLc1FlkJrWV/1QztNK6gF59/K93vVK8ZaEAJOYOBjVSf3oEksYMQMHVBjEJ80HwlimxgFAxzUBICa6p2did2CH1U8xAJcwXP98AE2nktSgwBcLlexWS;25:6rVDIP5Iqcvl7vXm0OXc/GdsuaGXVJ2950Yd9mb8HqRKijYiAidJ0aOAO+I7lpLgv0Nk8NWoQy3cyC5igrxc4uHpzo0By8Gm7zb2wfc+/dKfuFlVD9z8iG2iiZe1gYwKMXJJpYoJYBUacMJP3ZwGeknaXyvXKEVCPT1lEAELCGiSfADrWYYldi7QDsdUtJRig+rFP9NPer21zOGkd3zHZB7ncv/ZKu9fp8yaObSOWJpM/VbvH+bq9+0oz/JlYeTSrpGiA1TXLsA4wjTRwuefFqkhQoAW7SGJm/QjCVxxxRNMcOUnd+GrssfPNddZpohSj63gJhAOHrtKVasM3vH62Q==;31:R8NinvuLuEH8ZiS1MDI440dk3b07rc9q+snORb4eC0BtxWsPsiznjE7p9LOspuRtMzAMjDQHA8xNR5umvwK5Fv+N7fY/6sUyRgd4bk9owwgD22bNKpzBYzMb191Eh39SSr+/FjF/vHQRUoj7vyXitHnsx4pJ7CcJqxuan4l1/Ke4WKIepXJjt8ed08DId1Hxk8KFWaS0jBj9/R8G3bdAYjVvTPeHpkvkXrk1JBKYjWo=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:SDJGRjPQkB1lBOHREFAxRRt+NSgkv8fymt1w1RofmEjnnkXQKh4ihuQLIpkofcoK2WF9erdTABf9IRVvgINg5sb/Kbt4YfzbKmf+Tjf4QpXmJf4UoNqNID45IRTGM2st87V1KxCUCePBlFUWVFRzrXKoVA/tbCLCciy7hll8wTo1EJnSNd4yplvban+4znhuC+KLEByPZnMDTYkGF8cZzlopZfQIbjMF0EKKp2gV9a9AYIl0qclkBDp/3h5yR+9xNEX5/gMJW9pSYKxmPIbAoovCd+fntl6GsqjbPBeQ8Ar+8oG3ldJTKFHLFESo3RU3wA1EzqVsLTDIVu+dN8ZOax8dtm30cC3+df9xNxE5TKx4vBIMsDiX8bcuTnRYJ94mgI1FTtrt6YBBdl/wcvhwNRMocbtU47hqyGSwuWnWxY94mCauvwUzd19cb9M134JaXvBVFkkyz+cxYxoUD+p64NOXcyBpp8lpVIEEer1FjYieQN5ZC9fnZr7JEDYfQpoC;4:gnO5FB+Unnn1yrJqtypQTFIakQVV3sZlD1poHWgzBVSQM6+PZ+8vVAGZG5xkj8VXPOY1m0ZyiFvp7965US7/DsfDG0hN8VXRsZcJw0H8KimWLapkuOxrgPSbwID8JR4C+CLCqFtFHZ3CU4X96E9hvAtpGsO93Ys7+pIl/j/hFKo32/U1jRSsL2WGJK/ZHSz2l3uZcaJwsquvN4LcJv1DgBroYta7z+zPrq5Lw/vaUFrbK3k3GY43cVtOAlI2FlIVbiyBh6DjQ0x4Gd/E1hlmHA==
X-Microsoft-Antispam-PRVS: <SN1PR07MB396680EA997FB80195B4837A80660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(305945005)(48376002)(6916009)(7736002)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(51416003)(68736007)(16586007)(2004002)(358055004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:inSzLz5JNQp3F2/zB27KR4nOT9glySusbKW5QRxLd?=
 =?us-ascii?Q?2/JbgscY4pRgPnn3EDiCeiO/4gS5BN9cinuAn5o2tMOaimKMBm68c5jgdRv0?=
 =?us-ascii?Q?g42ZJDlO2o1CajZgvpYq8rM4VLCpM55g94oz7fuz/Sfj/EUdXQ7WfFpNGtoL?=
 =?us-ascii?Q?aSfI5xsUky7QOQ56fpV98rqnv/jQQThwa4IYL+3gBn9xp7/LxJEjm62TiZnC?=
 =?us-ascii?Q?VfWuWhpq3R4joxmPOcKXoQ0MQJzLytv8v1a8CIkJNjxFVGudEj9HX48ZJy0d?=
 =?us-ascii?Q?xRXI4IbxVIFkbw7/IZzikVLOTTr78FNDsyMKyRdoycVgqNwLfVm0k2LHIYsV?=
 =?us-ascii?Q?VO+aNKjMmM520jCbEIe2DlWbCH20NzdLUhAM3ssdOdbm7NuFYuAbbSpL0afC?=
 =?us-ascii?Q?gKdLQlEPrON0OEx04AZNgws7ud2zha6tF/g+hlMtWZ6erAmZli0LHml+bsFc?=
 =?us-ascii?Q?YS438utzdAy41YQyCx4Rt5a9PUFuyIvYcn1+dM1e9zIUJnVfSc9Sw82D2R6Y?=
 =?us-ascii?Q?E+25jDlcMDjkMR2UXDygt/ap/7Ktt7P09mqdjwYTTJH38igwSAp/jqmzSNuw?=
 =?us-ascii?Q?wtViB/K/tNymomfbh7T83idFW55xxG49qinNhgeE/X+zrWqtoiBFn++Sx5im?=
 =?us-ascii?Q?RSHg1E+FrF5VD4t3OFKwvagNppQSyUgFyRrKUlRjEbyA4h/FdP5FqaOKrFd5?=
 =?us-ascii?Q?NR4ueOm/CfnFGsFBRUkThZ5W/xEayPGEDbtDG/2w59WEyQd1Wu2r1rtBWrDz?=
 =?us-ascii?Q?QP3g/R/0X1u++XYVIBMzjUcyMJuK/mLvNhjbLdSpVKvidrIGCtFX2I7arBzJ?=
 =?us-ascii?Q?o/DjtQy40AT2TlkTNnX16f0diVOLzbFX6xGTSZJ49E6lsUjZ8Au4wVu/OQUK?=
 =?us-ascii?Q?R5k3lxwDYYBM+bFEOeFWzOZk1Oo3r3A/13rKiugInCqMNGO8oMeoHqDJCrUf?=
 =?us-ascii?Q?7zF2m23S57jV+KetyCUoNcS4F3LG9IIKOQCtXDsQPc7l+O1TqnGiUkRAef+Q?=
 =?us-ascii?Q?95/nWmyHwiruzVY61sv/2rCGNzjl1w4KWT0fbdDEF6Epb7JfW5KK5cy8eu4H?=
 =?us-ascii?Q?pyHQfPTFZ64tG9Rdc2AxfDs77b/0fySQslrp2nsSFkAJl+T1ZzlQMtASvb9F?=
 =?us-ascii?Q?APkBZXCjxW7wADvVAryY/LSnlHUsQFOM/yQWAuFzG2dtX05iY0NXqPyYrwsZ?=
 =?us-ascii?Q?MD7XvdcMl64mUlFvy/BalBIvzK4F13GLZSNoFm8jWJoaarFXBSAFYTV4Pl/a?=
 =?us-ascii?Q?RDBHf7E2cTaoBSOT3VYSfNHkniq2A/cA+5Z4ZGmv6b4No0mQZpOtM3nOXES8?=
 =?us-ascii?Q?By3Vfn/4rmRXvLaFZSx2Ts=3D?=
X-Microsoft-Antispam-Message-Info: Nn+z/adhnaKMlLa1pk5EUhwIlNJC9N5m89fXuLqwHGWpOrwvro4jUBaoXE6EEIXsjWPalLDx6r+AWDL9nSPwvBC1A0pq8uvYxO9/wKpK31ADdhMdXq6hWUTsMAXY4Z4uBtTxisHimFA1YkWu2uIVmNVFOwqgHKCGsDGgO42jFGKuh9Szb90/iLJBgbqIKhmH
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:FLtVBjygvPe3QM2kslfHTn+FvUbMHw5MQ1M0f8s+GoFJffcsD9z0/ILltW5SZ7RteJpTS32wrTq9SqRtcHIZhZxbBImTxWxIn6qbdNvHTvySNW5yqJjLlcj6Zxq2aR6AxKASQ9qZUANVVPrx1+5/l9IlgV/zkm66h6J6o9oD/aFWf4k5xilupoVn1edSQeKmI7lHEV5Jyqc7cY82XN/aT3gMnn9G8ICxolc6bRiD+w/iYsgSX2vtGgnfM5YR/zgI9xnXpzCfBsIMhnPdKNlL2zK3ZMP+E0i72uIcvHNnGPd2hXRPb0kXWN+rtoolwV0txZ2A/kXwny0KRD9nTw6SN7JRt5dmByD2+rDtebJm82Inx0TafG4r0xxqApVcad7jJZVY8GxBynxB+qAZmzkzYv8fQdHa7AzSPgjvXczHgyE4+PqG9clP2JhizE2DkAZ2qZQCFap3oIKwhsGm1CgJ3A==;5:9GoP8wT24Bd9NNL6MEFgwv42hzt1Y/LoXOJGv61hI+DbLLgv/IoOhvuhV8EBjL4B/pj/sQtEI07fMFO3L1UiPWjfhMZtrjYL3wT9wO/eWoQl8uNu3d2BiLFRBB30w8wJDqRWlKdfKZI2FigvLmxOEiVp+BqPtu0T7sYyi0b6GzE=;24:OQrOCC72FloFPX+ZuYsmVuwen3tfUxrnEOGZpxRJkzzUKOkKVRj9joNd+X8hOt7iOoDkqDAXk7KxiJgQzmpPjMflPeLcGlkiTgYrxQ1s9SQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:vN66cwTdduXOxbLT87zMYYuBYe2R06cajDKmNLXnzH0OgkTh6tHSyaHo4yW6Pqs61GshJBWa3Um6TevsAkir6XRvraltlSDPE1jtsX4futhsiBUpTfI6PdCiKWd1VXlbBx3Dr4j6B8B8dpCvy6Tpw8F3JA8GWSC/08ebJG2oiKvtyUs9h1fYSwdLOecPiCiHYdQmAQlBsM4GrgF+iCu19kVT7Jom4aEO7guHvQIzZEbLlOlRmqXq1zM9tMHcBMQi
X-MS-Office365-Filtering-Correlation-Id: c04a5c30-5ff6-41fd-44a5-08d5caa81101
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:12.7655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04a5c30-5ff6-41fd-44a5-08d5caa81101
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64184
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

Get rid of extern declarations in .c functions and included
the necessary header file. Also remove unused UART declares.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c | 5 +----
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c | 7 ++-----
 arch/mips/cavium-octeon/executive/cvmx-helper-spi.c   | 8 +++-----
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  | 7 ++-----
 arch/mips/cavium-octeon/setup.c                       | 4 ----
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h         | 4 +++-
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h         | 4 +++-
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h         | 4 +++-
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h        | 4 +++-
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h         | 4 +++-
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h         | 4 +++-
 arch/mips/include/asm/octeon/octeon.h                 | 9 ++++-----
 12 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index d18ed5a..b8898e2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -42,9 +42,6 @@
 #include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-dbg-defs.h>
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_asxx_enable(int block);
-
 /**
  * Probe RGMII ports and determine the number present
  *
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5782833..a176358 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -39,10 +39,7 @@
 
 #include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-pcsx-defs.h>
-
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
-void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+#include <asm/octeon/cvmx-pcsxx-defs.h>
 
 /**
  * Perform initialization required only once for an SGMII port.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index ef16aa0..2a574d2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -25,10 +25,6 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_spxx_int_msk_enable(int index);
-void __cvmx_interrupt_stxx_int_msk_enable(int index);
-
 /*
  * Functions for SPI initialization, configuration,
  * and monitoring.
@@ -41,6 +37,8 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
 
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-pko-defs.h>
+#include <asm/octeon/cvmx-spxx-defs.h>
+#include <asm/octeon/cvmx-stxx-defs.h>
 
 /*
  * CVMX_HELPER_SPI_TIMEOUT is used to determine how long the SPI
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 19d54e0..2bb6912 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -39,12 +39,9 @@
 
 #include <asm/octeon/cvmx-pko-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-pcsx-defs.h>
 #include <asm/octeon/cvmx-pcsxx-defs.h>
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
-void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
-
 int __cvmx_helper_xaui_enumerate(int interface)
 {
 	union cvmx_gmxx_hg2_control gmx_hg2_control;
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..3ef1d47 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1154,11 +1154,7 @@ void __init prom_free_prom_memory(void)
 }
 
 void __init octeon_fill_mac_addresses(void);
-int octeon_prune_device_tree(void);
 
-extern const char __appended_dtb;
-extern const char __dtb_octeon_3xxx_begin;
-extern const char __dtb_octeon_68xx_begin;
 void __init device_tree_init(void)
 {
 	const void *fdt;
diff --git a/arch/mips/include/asm/octeon/cvmx-asxx-defs.h b/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
index a1e21a3..1eef155 100644
--- a/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -55,6 +55,8 @@
 #define CVMX_ASXX_TX_HI_WATERX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800B0000080ull) + (((offset) & 3) + ((block_id) & 1) * 0x1000000ull) * 8)
 #define CVMX_ASXX_TX_PRT_EN(block_id) (CVMX_ADD_IO_SEG(0x00011800B0000008ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_asxx_enable(int block);
+
 union cvmx_asxx_gmii_rx_clk_set {
 	uint64_t u64;
 	struct cvmx_asxx_gmii_rx_clk_set_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index e347496..80e4f83 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -2070,6 +2070,8 @@ static inline uint64_t CVMX_GMXX_XAUI_EXT_LOOPBACK(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x8000000ull;
 }
 
+void __cvmx_interrupt_gmxx_enable(int interface);
+
 union cvmx_gmxx_bad_reg {
 	uint64_t u64;
 	struct cvmx_gmxx_bad_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h b/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
index a5e8fd8..39da7f9 100644
--- a/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -334,6 +334,8 @@ static inline uint64_t CVMX_PCSX_TX_RXX_POLARITY_REG(unsigned long offset, unsig
 	return CVMX_ADD_IO_SEG(0x00011800B0001048ull) + ((offset) + (block_id) * 0x20000ull) * 1024;
 }
 
+void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
+
 union cvmx_pcsx_anx_adv_reg {
 	uint64_t u64;
 	struct cvmx_pcsx_anx_adv_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h b/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
index b5b45d2..847dd9dc 100644
--- a/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -268,6 +268,8 @@ static inline uint64_t CVMX_PCSXX_TX_RX_STATES_REG(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x00011800B0000830ull) + (block_id) * 0x1000000ull;
 }
 
+void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+
 union cvmx_pcsxx_10gbx_status_reg {
 	uint64_t u64;
 	struct cvmx_pcsxx_10gbx_status_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-spxx-defs.h b/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
index c7d601d..f4c4e80 100644
--- a/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -45,6 +45,8 @@
 #define CVMX_SPXX_TPA_SEL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000328ull) + ((block_id) & 1) * 0x8000000ull)
 #define CVMX_SPXX_TRN4_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000360ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_spxx_int_msk_enable(int index);
+
 union cvmx_spxx_bckprs_cnt {
 	uint64_t u64;
 	struct cvmx_spxx_bckprs_cnt_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-stxx-defs.h b/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
index 1463540..3c409a8 100644
--- a/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (C) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -45,6 +45,8 @@
 #define CVMX_STXX_STAT_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000638ull) + ((block_id) & 1) * 0x8000000ull)
 #define CVMX_STXX_STAT_PKT_XMT(block_id) (CVMX_ADD_IO_SEG(0x0001180090000640ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_stxx_int_msk_enable(int index);
+
 union cvmx_stxx_arb_ctl {
 	uint64_t u64;
 	struct cvmx_stxx_arb_ctl_s {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6..6048150 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -279,13 +279,12 @@ union octeon_cvmemctl {
 	} s;
 };
 
-extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
-extern int octeon_get_boot_uart(void);
 
-struct uart_port;
-extern unsigned int octeon_serial_in(struct uart_port *, int);
-extern void octeon_serial_out(struct uart_port *, int, int);
+int octeon_prune_device_tree(void);
+extern const char __appended_dtb;
+extern const char __dtb_octeon_3xxx_begin;
+extern const char __dtb_octeon_68xx_begin;
 
 /**
  * Write a 32bit value to the Octeon NPI register space
-- 
2.1.4
