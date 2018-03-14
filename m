Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:44:00 +0100 (CET)
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:38112
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992391AbeCNWmNPRjgJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1vFWzqx9WRBhbUDzdIYka9RRCdwH1Ogs7SDmepaEMVs=;
 b=oBLM/SrgZZL+v1oQa0ATTK7S2nlJAADctqs+M9zzoXO/MRCU167clFtB6ikHYk4UhEH8/291pRlCjvZJoj8FoC9b1Dxs9NWNQc4Qt2OTpCHvOaV7wkgCvJrlxyz8nqJugcglbK0XivgptCi3igB5csKPJKr1h2EdRj3rdPWkAK4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v5 1/7] MIPS: Octeon: Header and file cleaning.
Date:   Wed, 14 Mar 2018 17:24:12 -0500
Message-Id: <1521066258-11376-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:4:ad::47) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb90e08a-6f1d-4286-5499-08d589fccb91
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:LnWC7XpFNe8mnRPuUZqWSTQ+2iu4GE4RSJgcVwOMjBn72xijjgYSyg73ZOvTB80AyRts46o6k+7YG8+JdiB075x/F0nPjjeY0lu9uRKr5l/ORVEu7XwBwh/01l4FPsYaVk6OlNxajP1LqIWObqkmqZmLcb+XDw9c6r2ii3iiMXoJKG/KNydlLeQPguUhCbCgbGoh0hgUE+sD9tiRqVWTGCjC0NqH93BJo8Pz2E8OIsKZE5O+a3g6ELAGFXv4JYSZ;25:na4N+ShkLsuMp3zl9H/yPbsoeM9FMqawC+OBh/Z3095VmPKfA9Y94IIOqVGGW/QncXjgkj1F7w2MaXt1z3SiABF0z9veA9kiZR1t8/8t/7SBKYnSbJF5LJs6HX53QEt346+IOeyHaJ0nA5Y+DYlh+CAeWwn4EjPbVOP/xEmOahbiuuR42E2UIcdGEQreGcVDFigXtrKnLI76iSo1YBpPS/bsQVylelxWdW+x3LLegfTMYwUmuH4IBVkQDIBtmDv1vWY2a4XIm+hJpqQ7K0RmL6RLOGhfZ1FDlJkmMkG3twnA9Rm+TVNbs+y3WX16zHte7rUXNoMZsRtyoHrraJMixw==;31:y4oaSYpb+lmgekL0Yg4KnO1b4mDbTZ+ST3BOSZjXPWMuHKCYJeV9HXmVbAE9v7+RqTh/rIzXahmP6EMDlYr9YMNfBOlzk8+bCbRELp8QparDLjG7jVlU68y7lrqwf63Gf9GTiiDOrjvoFrutGQZxd1ALe++GQCdL/J2SvlFcm9Su/xzd552s+8jpKVe4WOIspdTUy9Dp/TwUOevFWXU8vaVD+lYZHKeSG7tKwPcbrjE=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:zRdO3AHfmkKo0u4foSFcUACz2QXXNNXXvgE4yGoH9+9+/iOGSR/cKWjHrygcFg1M5bnImAo0CjwmkAV+8zRPIlQRMX126K+uIXoV81g5dbl8Vcsl4rH46SElwANhecMEY4BMwNpAuSbUNzaSEMaV6zzNhNkxLpE3+06qH5P2//6bysGSv/Y4pKmiT4+D1K6igw+mh/DaIB503S2zog8EBENQhOqHvI31auw6T7ikT6bnWFbEBNKwZ3t3Wa4u+rlPEXgRgP9mg1ZgNnMe4GXnGGKKUVD+oNrD4IO6W5fAKEltZkdtSJj2mtvMday4w/Jp1K623tkF7Jn7zsiyH855iFugco1ScAIjZ2U86Ufa0o/aHgFmrBbI1h4FDuYeeZ3s6eI9IkAjbj9iuhSyHU1PwV1mpSsubBSoJGo2SyobOkBw8s4GcH/xODaLosiLH+2gWRvSXROhizMa0RufbcR098/6F8fY/b2LbrQ2Hg2wLQxeLA5JjYK6yVwJBC/dtLIL;4:BZGVgqt5leKlMSvuc2e9A05ylICyLld2BtcdoU5dF5blHDTetoKitWqayBd/DaA3NV3tejo3OKXTdTHCMHIy031IpGL5CSvctxc96ZVWz7/ZiBntU2TR10XqFqmlY+t77c0apg4+JpCXTWHBEK8mhoIjCf+ABoJXmSuVNdDlMIIDmrcstxr8G1AlHLx/Pz6SIRF85AcOzpfEyGTbKIYyUT0egP0MfvpXzkXxy/KaUeVR2htdbxx9uesRFsfcrv66gaCXGx0JlW58m1xNqpIiPg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB36107BC6839D5E5FEAA7483680D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(59450400001)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(81156014)(386003)(76176011)(316002)(575784001)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(107886003)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:CIlWAvmaLmn07WGT2ti7jiPTCWl3B2Tx6Cjt7lo6j?=
 =?us-ascii?Q?Zahzbx9kHeqibVXP7Ixsq6uzT9JVH7/dzdqMf+C0eOMIAmAZxtjuqik2vGBl?=
 =?us-ascii?Q?1ZbDvC+TEEyH1uXZPWzT9uXLB94raWzt3MU+WJ/otRwIMsiWpH/8L90KuTDi?=
 =?us-ascii?Q?m0lUzNvIyBMMkTFnjsMQJJLwU+EL3O6pXc5jDD82LiDug+nvkSpMSTD8aqdT?=
 =?us-ascii?Q?TdRVFrbWuKDlX4iEEkx/FXVorjxi5WKQTw8A1FO/0EroZ+Zt86czTgnfkNMu?=
 =?us-ascii?Q?gGmXr8xHO1xJGMO26CZzHQoDwOgLGow3pjtkUK2FV2h8x8jz7uI76HHxlQlq?=
 =?us-ascii?Q?mSciMtv587qcuWrrF7gDqLt6GsYWN8J69VFHNIdTQNjTZgAPuidU3DiLwt4Y?=
 =?us-ascii?Q?grxkomhNtVIxm+NkdFk3EIwZ47hdIrJnn1sluEcgICHeJvjV1m/GLYWDW5ku?=
 =?us-ascii?Q?xods2cRzaaWWGdIiZr6cyM0QJp7FpJCgXzmRaoRBS4s6fioyoatkCyqJXZQn?=
 =?us-ascii?Q?s7rkDiX+4QCG0GLz/SibvaK1m8Noi79V0p2kFO8RZz3BKQhqQszy1yVhG5QJ?=
 =?us-ascii?Q?1+h0l5C28fUa7dWARRKQzEzhzcjjd/arkCya6L5wtocbC4UmRFA2fFZWSVrR?=
 =?us-ascii?Q?WfwUK1nuM0+DKgK/OFI3HNLLxhUT8/2omcwS+ITxmnqTPux3epJdndkx/b4n?=
 =?us-ascii?Q?OfH6v8B4oUHk3NFqMxCI3s9XDnnwk1yEt4bQmMzAJITFwLBWSCScBTASO+XO?=
 =?us-ascii?Q?0mq4GCGAdohLQpZSTUIBfRj3YZsynGUkY0ImE1+ze0fH89c6Ls2H/3SUbSX1?=
 =?us-ascii?Q?aoyuAS5qVeynSaHuxqKZulqgTX4Cjs/gdG5ZkH/3iO/NTFLPlY9FeJIULtkE?=
 =?us-ascii?Q?6ezyvMJ0CVS3jgmPqO36kXyxhV3mvvPnWrXsZQEB5eJo+N2AFdd40Kw6g3Ex?=
 =?us-ascii?Q?LS3WzHgnhZbJSiRCbL3LhEG8MzSAV3bw3VvAQlaKcD+3bbS/VDjEkHBWmlT9?=
 =?us-ascii?Q?mGPJWp/Vy8GZ4bo9Zo9XW2G9Db/VUNER58jL4Lf2tK9p9gqrtvO5/uB6ixtt?=
 =?us-ascii?Q?Qxw0seOstKo3yXkseppcFo7Gfk45I7gsKuZuJ5nBpjgdZ71Doth3KGFdWPrE?=
 =?us-ascii?Q?xSazKI8N27s8TSTC4KgyB0UiHEcb5PRyTyMVcCAsX/RAWVgaEPVicrSwiKym?=
 =?us-ascii?Q?tNu0Qi1GaLwtpKblfVigBT30cXJ+zQAtIK5cS+gyRToowmhyiCAGPU2EYZG5?=
 =?us-ascii?Q?Nov4fBjDeoEdVyGtDAoF5yAM/YciHRtrHh4yrknMDK5W1U6fUx+03mg9xmtH?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: rXoE9Q9nmZK/mgf2WyQTQnVY2Cls2KpKG5iDcOhAnvVQ8Bque8Be/T6oLGRqQq8FVfa6Wo3KWcZDC7rp54VZK+gUwKN7x/YwPBg22jqIDmFVMeAxKD2g7JTxbKABTiQkCk1CsxZbdjy2kmOFW/mn64b9krA4K83gTuJTqZ1GsSWRPRsO4w4kqOjhiRYXtubV
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:5vsps1JHWnShkdAaz6Wrzf1Ttw894lou6tir9i3TZ6uNuYdDcKg5tlDG21dRVzfjrwUxaQLwAWfuyX+CpmQShoesAO1wJQqVXF+WY3Ekk6HZPG4aimN5Tj3Im0Ien4kpCSDrOjLs4k8844KUhJ7gYXXjdsMCGbbVgWXxK2YfSKO3HS4SQG80x28AVA56EYdvj0bUQRezKyh2Lrh5jcNutnc4spUh9jvCFv1kfgRLThQz0QJS0wTzF02qF6cMlaDRcaEMwgP3P5Z2waqFYTbMGdj0COS/rheuP6BPRQANbe1VTFnnbIPugMMRVnwcLhW22bfo3oqTWRzLLfzRjz4wjsAjGEUaepPLqAmUU2ymjYk=;5:TufEJqch3xe5uIlbq0dxFhZ2cbffPm3S2psvwFM7lVGp8fJACeM/XapADCiFVXqG0HU8mkT/XTBKTEhU8LLlC2vthxI8KmHwWsSv3fieMB4ERqqtNMkpIT5S3lQXFJLtlDQWlh4H8b35pjRMZAjICpOxt0lV9edAC/fXyy6CTCU=;24:174X9NYZr0BFRaEmMVLUdHsfNwQYTh0yUjEegUdHzdeMjBUgV6H9YFeCqm/hkbGVbto+/d/aSuQTmys4BeWkRj+MKJdkB6t/agMG0zUpBvs=;7:GNLXbCDa4FlqGo+TlFgDfrEzFqS8MbUMkBTL8XDdEjqeDG4YcIVershvX+5u1xWSgaeTr3A0NBxFO6UP3n7pPoXCOCm+xNjW5ZkJo3tg/M+V1ZMKwFjVUz7qHNL/oYuke6qU1Z5CDlGsdDHA+PMTavjQJBhFi57HbGaQgUrP/So+q9qntyuvCi+DWBGOIsfRfTdljE+BoJmh+Xwuq6dkTPLxyDdTMfiO8TE364BcNOegtEMOaiI5T6X5QOL6VNOA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:57.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90e08a-6f1d-4286-5499-08d589fccb91
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62986
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

In preparation for new hotplug CPU, some housekeeping:

* Clean-up header file dependencies, specifically move inclusion
  of some headers to only the files that need them.
* Clean-ups from checkpatch in arch/mips/cavium-octeon/setup.c
* Add defining of NR_IRQS_LEGACY for completeness.
* Move CVMX_TMP_STR macros from top level to cvmx-asm.h
* Update some copyright dates.
* Add some missing register include files to top level.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   1 +
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/setup.c                    |  10 +-
 arch/mips/cavium-octeon/smp.c                      |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 ++
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 141 +++++++--------------
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  10 +-
 17 files changed, 81 insertions(+), 110 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e..22d46fe 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -32,7 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e6..e417037 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -33,6 +33,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-helper-jtag.h>
 
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index d18ed5a..2d84490 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -30,6 +30,7 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5782833..a25275d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -31,6 +31,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index ef16aa0..d9dac21 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -34,6 +34,7 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-spi.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 19d54e0..d692638 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -32,6 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec..1e807f8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -31,6 +31,7 @@
  *
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 676fab5..ec5b013 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -30,6 +30,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-pko.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a..d346ea7 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -30,6 +30,7 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..a605191 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,6 +13,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..2085138 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -39,6 +39,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-rst-defs.h>
 
@@ -165,6 +166,7 @@ static int octeon_kexec_prepare(struct kimage *image)
 			int argc = 0, offt;
 			char *str = (char *)image->segment[i].buf;
 			char *ptr = strchr(str, ' ');
+
 			while (ptr && (OCTEON_ARGV_MAX_ARGS > argc)) {
 				*ptr = '\0';
 				if (ptr[1] != ' ') {
@@ -357,6 +359,7 @@ void octeon_write_lcd(const char *s)
 			ioremap_nocache(octeon_bootinfo->led_display_base_addr,
 					8);
 		int i;
+
 		for (i = 0; i < 8; i++, s++) {
 			if (*s)
 				iowrite8(*s, lcd_address + i);
@@ -429,6 +432,7 @@ static void octeon_restart(char *command)
 	/* Disable all watchdogs before soft reset. They don't get cleared */
 #ifdef CONFIG_SMP
 	int cpu;
+
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
@@ -715,11 +719,13 @@ void __init prom_init(void)
 	if (OCTEON_IS_OCTEON2()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else if (OCTEON_IS_OCTEON3()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else {
@@ -927,6 +933,7 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
 		u64 inc = addr - *mem;
+
 		add_memory_region(*mem, inc, BOOT_MEM_RAM);
 		*mem += inc;
 		*size -= inc;
@@ -947,6 +954,7 @@ void __init fw_init_cmdline(void)
 	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
+
 		if (strlen(arcs_cmdline) + strlen(arg) + 1 <
 			   sizeof(arcs_cmdline) - 1) {
 			strcat(arcs_cmdline, " ");
@@ -1202,7 +1210,7 @@ void __init device_tree_init(void)
 	init_octeon_system_type();
 }
 
-static int __initdata disable_octeon_edac_p;
+static int disable_octeon_edac_p __initdata;
 
 static int __init disable_octeon_edac(char *str)
 {
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..f08f175 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include "octeon_boot.h"
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 64b86b9..7c2bf76 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -11,6 +11,14 @@
 #define NR_IRQS OCTEON_IRQ_LAST
 #define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0
 
+/*
+ * 0    - unused.
+ * 1..8 - MIPS
+ *
+ * For a total of 9
+ */
+#define NR_IRQS_LEGACY 9
+
 enum octeon_irq {
 /* 1 - 8 represent the 8 MIPS standard interrupt sources */
 	OCTEON_IRQ_SW0 = 1,
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index 31eacc2..0c6ae93 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,9 @@
 #ifndef __CVMX_ASM_H__
 #define __CVMX_ASM_H__
 
-#include <asm/octeon/octeon-model.h>
+/* turn the variable name into a string */
+#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
+#define CVMX_TMP_STR2(x) #x
 
 /* other useful stuff */
 #define CVMX_SYNC asm volatile ("sync" : : : "memory")
diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 6e61792..af9164b 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -64,94 +64,47 @@
 #define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if ((cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) == OCTEON_CN68XX)
 		return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
 }
-
 static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if ((cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) == OCTEON_CN68XX)
 		return CVMX_ADD_IO_SEG(0x0001070100100400ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
 #define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
 #define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
 #define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
 static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
+	case OCTEON_CN68XX:
+		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
 #define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
 #define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
@@ -179,34 +132,28 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 #define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
 static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
+	case OCTEON_CN68XX:
+		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
 union cvmx_ciu_bist {
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index c6c3ee3..ea1381a 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2016 Cavium, Inc.
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,7 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
-#include "cvmx-coremask.h"
+#include <asm/octeon/cvmx-bootinfo.h>
 
 #define OCTEON_SERIAL_LEN 20
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 25854ab..392556a 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -54,8 +54,7 @@ enum cvmx_mips_space {
 #endif
 
 #include <asm/octeon/cvmx-asm.h>
-#include <asm/octeon/cvmx-packet.h>
-#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/octeon-model.h>
 
 #include <asm/octeon/cvmx-ciu-defs.h>
 #include <asm/octeon/cvmx-ciu3-defs.h>
@@ -68,8 +67,9 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-pow-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
-#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-bootmem.h>
 #include <asm/octeon/cvmx-l2c.h>
 
@@ -102,10 +102,6 @@ static inline uint32_t cvmx_get_proc_id(void)
 	return id;
 }
 
-/* turn the variable name into a string */
-#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
-#define CVMX_TMP_STR2(x) #x
-
 /**
  * Builds a bit mask given the required size in bits.
  *
-- 
2.1.4
