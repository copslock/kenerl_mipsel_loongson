Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:19:06 +0100 (CET)
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:20848
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990633AbdK3GQQDN-dy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1vFWzqx9WRBhbUDzdIYka9RRCdwH1Ogs7SDmepaEMVs=;
 b=TtaG+4r5qeXI+GPAsqqa5GUStjEAmIzRWHxhAiZF78vNt7uXd/nPGpKhuVL0kNwXuJzbhm0YVSwiQF+EokuoP9fvtRZNMZq2kzZ0GacPV7kYc9y/4J89i1G/6pNdbDUtbj4cd3XjzrwRkpXjGbwtUBi7C7dLe1cL7m0GWkIMKYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:01 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v4 1/7] MIPS: Octeon: Header and file cleaning.
Date:   Thu, 30 Nov 2017 00:06:15 -0600
Message-Id: <1512021981-15560-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4f0599-1de5-4b20-26ad-08d537b9d49f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:GTnDS+XeNHTQSokokjNeNEBBJhzgPSKqoSIpt31j4rGJKryHy305vufgFdamc2r6cn45MiEqe0fp9zoF/xyvY59V9t1JsuQ7DO+eOyLrRsMt7fEnPGH66BXpGdD2095WMyKbIS2hm0Mt0diMxNX/F6qjTK5eUoJeb9SoZMU8SPB/IbSd9D+LLVgv+IrnEmMCxeRraJt6Ai+6Osmygq6AbcTGyBg7zia4GDHGm4aNu0u5v2e5C7hTyLR/FMb/F2Kj;25:WidoRzQae4EFhC7i0oVXKyftanUn/D7JG2KmaL7B/UveQzS3Z0n7ZRdH/h7uqDtDyzfLXv1zVrNP5fcrv6KBlSnh4wyz+lGtE1OP9DTjg4bI51j308cDzvGwUrK6FexLpZuidXK0VCtFmwzSLuG2+eGFT5a/+oRdfwtpu6Hv20anMfG/P111mPj5fzXyl15ZTQ193dLVWgOZcqtJis+ehV/z7lRgPMSWJIAnkBMYf3fStaf7dLUZYaeoEHzRRH1RF4Zf52/kcw1NMIYFuhLrE3HkOGT/RTSeM0EkT2Et/HwYp/GeF9EIGQSsQeNm065yKMiyhMFNLfVi02x7KEuaYQ==;31:9oSdpC/CVDBKySVtXcpLEDjSvGS0BkOysTxFkyUVL19W/x1FEXxjTeWhzg5RVTvzUqZyfYsLQ1ECq217hQam4UZrT3IoyECTcTR30z3kzVA989JGmxnPYpE97fWQijfTHji24nF1nrThOPxHJjzMha4nilHVbMhnjCg7hFuF7s+7f2zArbEwzYiPnQDLBCkRpFq63vAsTqMXpd36Mo+j9YszW/Yu3HMTcoghEHQUtEQ=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:G7MN7Tw1kmoTvkHd9effVMCHx0co0MiUcE8lZQVFb7iEx4VJHt1YENpY7iuQ/t7wC4q7wW/Ug6QVAOwM5Y7SLqbJ+o7vZKLOpYjffdD8aZkoFEvnkQgqYSQu26+BoM8b2uDogc2DuU7lEuburIqT64GYUHc9fTlv9PmWk7dXO0xKtPSyA2XbNDYch/Df4FtBX8WV/1Pv30KspKYJtAQ56QR6p8pddmCxm8sI8JxEgxfenOfApxWeSz41LX91TDmCL30VcIHXQotWJ3NuPYFAmN7TasIMNv9uO9FWIVDAtAkYBBlpDWK7kD+3QPtqNk1MRH2aIox27EpCzu2XUE/ieiFWeCSe54CqiiFRch/6rQsaprwrVBkl3j6iGndCOWHFZ9v9v/pdoeVA9aCV/GvI72PBNSklKxWCWQlQcdGTuISzdvTKCEerS2VLCU+/SlFt0mgBSmG2Vr1c3OpxR3nG5Gh1XtVO2YGu183yYOcG8c2UH74i58oNKFipz+5TJnbz;4:kgC/otTxE2nDm668FilSyeruepu/YU08u1q6zZMMvokpDRDTKct77hwNy1+ZCxscSL/cJ+721+LfdQ6pGZqIm6qKY+HMML91LQkWH6+98SobvUn5s4jnnowo1A/uwCeRPBv6XstBbiCI2AmgDafwEE7CviQeBHFvzNddDhn8nTsoTOdBwRJtTEpzrK/h5scn0yObyIMgDbOgf1FcQr+Ro/MLZHj5q/cJbTpik40ts7ZPzy93bov7fUrqDzGGelMCNnYya08W7a/ZaMWh5ZpBiA==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803797557680BD1BC8A7A3380380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(575784001)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:k9rnD5fffSPm/sARkBqMYz0J54bKsSCvkCGZcfs?=
 =?us-ascii?Q?zjsafmShgCkdpfzZhtc3UQidgY+pAaAh6qnsv88FLvvkw+Y6BDtBJDyTJILs?=
 =?us-ascii?Q?nUyXEtcV714qicNgA4FpTDZ5HZ9nYQWsesKI20yTVU3ByOrPy7232amU6l2S?=
 =?us-ascii?Q?D/Hynoh1KZKd/OteONiCZ4gWW03KYC8xhekADZdsGWnf84h5PFcR6zqiBu5Z?=
 =?us-ascii?Q?PRiCInjtgkt33j5piKjftrfy0/7rAx3MaI4Kyb2K1R51exl8oxjrUsy8jk+k?=
 =?us-ascii?Q?bzZv7fId1uHyDcKH+1nMfqleNzYjKbXXO01SNDoobE7yhkx5gIxkJoa3qnat?=
 =?us-ascii?Q?dvgum+MNIjsc0ETx6k4/5M1fL5uigxOqfnzEkfYKYEioztvo55FHhsycB1/a?=
 =?us-ascii?Q?jLJ+9Q5qNKsywQmt0exliGgEkbxvFS9EAIq8SaSjl7U/g3wqwKLVNTtQcMvy?=
 =?us-ascii?Q?A/cWY5e1cetWLUqedjnmgI3xNPVAhFfWFZ52735k99XgJcwnmlXj2rT2NH3F?=
 =?us-ascii?Q?HnKF/WeBHRPEglo2fp0s/y8vC7cKktPFgfaAHGZ0hIaNrOz63MUUJUgZcof/?=
 =?us-ascii?Q?i2m7d1IX9viqpWqYL0JWiYSzmXG/bguHAFxColHko3RrgvFU0+WabT5hVvHr?=
 =?us-ascii?Q?VAXFMQUjEYiv2UthFTc4vMbPiWuHyH3zbrpjwSmv3V07QS2mLCWY/9tdIcaG?=
 =?us-ascii?Q?v1iWVKJafbN9Xjd1A+kN9Lx7lhAjDbFmqphKXQ7X8VsvFu62rVOLK2i2F6ji?=
 =?us-ascii?Q?Erd4c7JQlsBGCw7ayBmgnOQMA7mrC4JPDoP2DljZ/6SWHCfFlDKR382wHZs1?=
 =?us-ascii?Q?W58KLw5oDjAaMBehXMVxlxBhkZIEkQe0HSxq1w68YGfJ2YGieN9cFVQTv9aB?=
 =?us-ascii?Q?RURT1/QZJQ/RRmYIRVnWtwc8zZgoF3X+WLO5rz+3I+soIxfsfb9pnZUGqvJ7?=
 =?us-ascii?Q?D3Zq18BO3Yw5eu0KGd5tDecjC6R5B/c48Ew+KWGto0HNLzoqG8uSzOTs5UM1?=
 =?us-ascii?Q?63RGgN5nHBWljVfyW54MseY6Ds/j3h37/PwOl8snct10v79jHeHmhYSlrKDp?=
 =?us-ascii?Q?GsobL02Kk4alwpuoHxlC8LHc4h1j+pImEHmtkkxOgsb+uMijTQfh7654rTnQ?=
 =?us-ascii?Q?/Xrqmcxt+MT5es19csRfBxGBKnubU26sSTLnOCX9ePK1hdMkVyAalt+dxntP?=
 =?us-ascii?Q?WxhSsY5/H6QKfeZZYvpeRvPWrZMftRGzZzFR8TdsTlEMTOMWyDfhRLUwinY0?=
 =?us-ascii?Q?3YGpVNYxzmGtL3+wp8jM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:W46RfRk7xyUkpFPWwKsBa57GQO9A68PweY1siLemhZy5g4dYoJ6aU8cuZk9zB2MskgY54FdMVNi8QkHW/Mvzww48SpfAtUsUQERu5u528SL0sIgWrgaiMt4X4o7oisN8nxXFdGRccx30RXTZEwfuXaXYqulPix4JhNu5NMQ9e2VHGHFOthVlQIU8OcRVa2MwdivJ7kUqwemPHd54oYtScUTPXD4ZGF8VCzB4UawNAR1L7Rh+cQTfAbRE5fzn9FrMmNz8vj54G0vFqaOxsXPme9I/SFSRxkmec/PXLUCArmiWpD14rrLD6c0yFMOCdB20VAxQ71DROxsERj+2JNQyHIIcl37vZVjauB4+/w3uGKw=;5:pcYWEt9t/O0AXRoEo8W7gcdzSosdtA0nKNmra+syADZHL4m2TAy7M8Au1BOfPcRDmhNklNB9YR7nDldgk3S++dsrq0b/5+N5ygxuntLaG+k11AXe/Kx1H94T4xEix5qojhsTsuJ11vQ2vRfcVtpNfl8534QUjrBOAmXCx9/KgYg=;24:ftlidvWSOayYVpq+nK2v4Jmio3fg4MaSMa6mkEvbs+yZQyHTr6InpZxJjA+w9a+3H0/HidHS4e7uTNNxP7LkIEQizvZAY0jZu9DlcxuQW0U=;7:MRjNIU+zsnMtGxBLBa2Kd/nUETQgHTxDSDRzW7bn8gYDRSXBF4rmZbJWst37HlfE8k5f2mOgWmDoYgxm693C9vRoo7Cea6lbbyGYTOTEKLHbnZjUAoU1PaCDE7JFWiRSNT7PxiL85aV/jPVELXB3u0ozVXsGYuXDpiu1XjrvVEnLn8uAosgtSxj26Sm/PDcA1Y1mnTLiSxCJ+W1ki30rGU8nA7aPwmfS/WQ9k3Z0/SG2iqBajiDzxTAplIxJ9Db4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:01.3783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f0599-1de5-4b20-26ad-08d537b9d49f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61239
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
