Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:40:44 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992240AbdKNEjEsmpY3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JilhAZrEVCMnbI9amEGnsTqSt2zyKignOE6u5KILrSs=;
 b=okbtdHleknQuLaBgsMA9DmDQ5SjAJMnEZS6ubHyVSbj8VxNG8YgnRGgyBEmlJC6lpJlKib9QX97137k0gaP8YQiJ75oj7vePU7dyAwVYHeJH4T6oDLmzhbhbXQeG9JljH4AORbsmoqb2fA/40q+Z3lVfESjWNjMz00DBCzLpdmI=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 05/11] MIPS: Octeon: Header and file cleaning.
Date:   Mon, 13 Nov 2017 22:30:21 -0600
Message-Id: <1510633827-23548-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f672ba0-6d23-416c-82dd-08d52b199e48
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:zzyAU8J0873s0UYLbVohMbYm51UHRF553J1FyitAacFhYa6/3YQ2glGPuYPF1QelkRuDWhEkZdA+RCY4xNa6pdJ1hcLEKJIIdwmNHXGKw1SASJekAlqD27q259IVJpPum3UBi+7bpy8QGaCU7HVDJdrzfhZMr4GQM2uVL+hrAe2wwjA7A6f+LrTaqvNHZ8fHGjweMw8huGitqtYDI6HRIZubrbuR76XEJUgtlSZSZJxB3T6nKBXs4uT1DECAN36X;25:1h3qKXiC6Ixw0OGNf8qBhic1JAxjTvadpPjjUc2MfeK7gh4j4JtMBRfpD+DQRYEuLAZRN1v/g0GCJh3mgVtE9r3k7FsH4RYfCgQW1qpGrwLCaNBo7dVuFEpaIfA9FXDYVb9hT/G4M7wd1mUxhNS5w2VHJlV5Mf3d3i+NeEyOCVtfkkoRRab9soqeWvYu7WXY/7arkCuakTBDoqHhDWFJTIdRAethRqt0/zm0nd0WI7KxcmhkcxY6eL8ss9l3l2mCoKtyvvx9z0QqgImzlNPPC2UqUM7VY28bjaWUqA701Ec/LlYzQyMYfsGQk63coDk26PMK5ab5Vb/0xsCJiggjDw==;31:MS1RwfWKWPMYruIFiTg3/pyKgTcil/x3A4Ic/TpBPMJsPn5d0owCuf19gZHBnFsraiEZG9c4jn4DEy7OWqHirvdA3bFdXUC5egumEPpD4Qc83xr5hz8jc3ngz3fSUK5Bex2rIzIIdeJaD/xUI00lQSiEscQ2SW0M0+VAf0J6THtdJ1rrcZh4iNCNFGuwJR1NTfgaRoTku9RZ9BXm2MRNImA2MiauOHmIX31M2aC942Q=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:ORaIcTQ4EISpL+baKxbiH9rYq2GgGmz3R5cdo0uZMKoFLvDELEXdSTTosCjH+DswouFozw5olc9ROvpfbdfl5qv1YIZbLz2lQvLpuThV059puQkIiKay2tNf8J8gbND5DJmD55NG1HGN+Mvwq6IwfUXUIpoYr1vELEHa+CFa3yCcD/wuQZG//uQAkHZGRo74lm+yWRQJrzJSQdaWaoIayR7wQ73svGaPL8AD+nh5/XNRIyMQnmA7TYxlRJxxQoFP8QKUsgfPi3DChuHOK/2eAe243vbQT8hMn9Ar4G/Ooz9yyZmZ+z/EubTQyXdMjIovagWH849V0tzzRzVNvq169dAciGteyP5l9Mza28v8Xe35HgepIdtQ6RhmZ+0CsyMAJLu1rovyA+6YydXDbxwBSEmUwCR9N0g4Ax17mNJaEH9BDkoEvQTSBWD18jyRTspA1g8FkEvAB/i4VZiku2hVVqPFn81k25VpohYhFq3FNzef03r9RqBfhw6Vb/5Git9S;4:jpRGrG1O0LBjCRtl3qbzTHNX5NXAfRg2wrjokUDZCDR5YMLNGvpP7M2tNiuD0oTQkEz/E7dHktEcen6duAssSuJBn1ieaigFodeUGEo3s9t34M81K18yf0HK0B715NvZHtzLm23ybw0MJHfR/dXGGpcAp1RtD3yOx1AygeJwcj0i3cy2qkkFZKv3OTSbAZFqnkONjMk3ObYO148he/qDGf9D/wUlqMwnr3vOcY3qeGOTQHIOnaTp/8ByjxrRp1YyDaPO1RHTSweVtmLl+oO+fg==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38064700C8D7B12B827D50E880280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:GtyfBWosDTEEGLDDe3t5Tq5GqH/+CckYbtM06rm?=
 =?us-ascii?Q?UL6rSYJYwf/y054CO9gM9VwDRToDt2FNP7wY/fTPCuR2mxEklu5FtI7WT5bb?=
 =?us-ascii?Q?9nlTYlXVIT2ub+kzCVrVPjjOxoj3iLIg6f4Ho7g8hykDAKbBqP6SaX30a8zr?=
 =?us-ascii?Q?hB1G5xfQEntxKGmMjiTwOKaZXHEYmwrv3qyylE41+q8/N3IJfZE7tKoL7E+U?=
 =?us-ascii?Q?8DVCfO0Ibt6M1WZSrXwAqVU3qqtKp4qlznsBkRogbSVnr4pHfkBFz99HLQeU?=
 =?us-ascii?Q?+ye+hRDn2r94TC0oWLwLAHK4y0kg6TMkhzCMLnGILnkYB5q2Hb93R/AoENWt?=
 =?us-ascii?Q?/3zEi6HL0TVOSvEHVNXm3BTctrfgBtMYKvsrE/whVv4VUWH5b2LWdV2cv26o?=
 =?us-ascii?Q?dQGu3bDjyZtJRXo9TkogKR9F6qSVyqrw+zhsqOTeTa9elDTrDSQqaSkwN0Z1?=
 =?us-ascii?Q?1rHge4CRkODK4OzWQ0GGyuB1tIOyv/Q/pC8bMyzAfKdJFhB54DjHkTFvr+3h?=
 =?us-ascii?Q?uk3AAugaToy16DULyHvcONxMTBexW0nHcafysXP1uZW2BvMurdUQs+bQVwRl?=
 =?us-ascii?Q?jX5RvT2DPhY9B3biuxfpyamEzlWzhs8LEEFD+r9h8b15ezVxQBb+qtnbT/hx?=
 =?us-ascii?Q?JLewaTq2ZCv2Lj882L/u7Yt3zUgKKYx+eV4s/QxzxgHLWFLu+gY4SDatbw/i?=
 =?us-ascii?Q?bJugHO/NU6JUewW7AzfcmorimcxvTPE0Uw8WfQUgchZJvfGOSM5HB8lJI7xs?=
 =?us-ascii?Q?++pScoP0hTVeN7Hc7b8gM1jWyEnNd2frlkxcaZRQWZHzr0sxmhsI0UpaL2xG?=
 =?us-ascii?Q?27+Hso3jw2XRDkuEC8jM7ZJqLBQwHuO6X5KAH7i7/+T3xrhBxeRh2vu3Dtt2?=
 =?us-ascii?Q?BFfo5k8BtR8az3mI8JE5o3ArOyVg4X6eLjGvDP9A+tH7li5lQ0aIWauMcAzd?=
 =?us-ascii?Q?PT0VGyfGz1QSNOE/4W8Dmxzg32/BitpC5fctv4XKxaKgI+uWbGl5vjLIp3gP?=
 =?us-ascii?Q?lvSDoNHg/qxcDZd4K4wKQVnerWnBk3u02x26+4u/G2fGYtYgM2QrVexj3Upn?=
 =?us-ascii?Q?PbRFRa4+A/Fx2SZbGrS8KXLD5dWQI/vrW0Sp0vugjKRhV/pkGy5/jGjHoGKw?=
 =?us-ascii?Q?9TEDkDvk574zmZM+PftzFAHgLdmy/QEesSbWSWge3oOIQsgm8ywHf58tYFeC?=
 =?us-ascii?Q?CnNBlL5ilb56aMF2A3uyzcV1sFI0w7ivnB9Ph?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:OMSdRhlMYOoEIyQHvjfx1f2A1h7TSHK5WzdDZfEe5cg+YcXy6ANjoKrzZ1lrhytPmg+FtB7VU2i4UGoQHZXa9xsE4UFPAmfUN159IX+0VhWf9B+lDbJxojz1awx428bDPD/snGpacRYFDN2zoDagtGvJLW41rEMpKvsy/G2Px6ivPGC89zHWPyo5ObhTE1YIewQskCWRlV2Iib/Tn44S84PtuAFnmPVPZ49HUHqPSqiCBoerZDlg282X9nGZ+JmBNBODBTRkcutFH+3vhOnd4FycOBcsjJ2Ywkcw4ZMfSK/v0ZK54jFqmdb/f8AhEceDGbiQECuXhiyRq6dB9GEFJ9cGxH4KbFEGw+2/+pu21ng=;5:J7ZF/izEHB3iwx2rLo7Rwpm97PXM3m5Bp2TAyua3IblnQJYdGfWAHGDlHCEojUx3Mm0tAmlEmr5kpIU27LH6+cHX6DqDhHy+Rqavf8Yrv+j7NT9SV21ZG7yDufF5ZdfigcN56W0zsCq93b4EczfxeigQn2nvuLEb/PBx4rMp1ZM=;24:RfwN4ErLaGB4b4m7SZ9ydsKxtk0EytW+QAAfkFi6kneEduOlw3nGrV1VwKoa2c0X+qdxnJhkvLvDv1uHCe7CHZ57/V642Wt9QfMW9vz45jc=;7:BsVppmKr4vKq4jYs77rl1WeqasVay9Txn6Mxs3zWDpKIoV2jMeInfU1NQ8ZiykEMF7Mfm8DyKLJlfG3Pxija+pH+/U6FGRKqmlrkkJWAlHJHltLygs4yHiSem3euGVCg76pmLWP7z90rOQb0xg0EL+6Xi/oUTZdmXsSia9MomPoIzyLAk9QyD1cC7xOr6dKx7xHx98Aur/QiKDDscCGbHuFsHqoBe2Rt+b2TwZ5HFWmP+sV9eAg7qdHStX0ygqm5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:56.6428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f672ba0-6d23-416c-82dd-08d52b199e48
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60896
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
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c  |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper-spi.c   |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c       |  1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c          |  1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c          |  1 +
 arch/mips/cavium-octeon/octeon-platform.c             |  1 +
 arch/mips/cavium-octeon/setup.c                       | 10 +++++++++-
 arch/mips/cavium-octeon/smp.c                         |  1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h        |  8 ++++++++
 arch/mips/include/asm/octeon/cvmx-asm.h               |  6 ++++--
 arch/mips/include/asm/octeon/cvmx-sysinfo.h           |  4 ++--
 arch/mips/include/asm/octeon/cvmx.h                   | 10 +++-------
 16 files changed, 37 insertions(+), 13 deletions(-)

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
