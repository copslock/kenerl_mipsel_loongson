Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:40:52 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992348AbdI1RjIKYOAF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BRlfQZ6c279OTiyUi1BpcQpZO3qF08d1H8Y0yPoLnf0=;
 b=P1CMRVapp92onDiiA0kWpPiVZ2g2g4vsQslqO4h3lUAzcwxLKxsO3344CXjj0hAvB75WMj/s3n0eZoa72MsVaML0K+BJfvsv8UytfXl2XnlJnUGYYJBM22pYxAxwuEX5+TCtTwFVLLD6+o5BwqOZsSv5FR2sBDWgGqqcZp33ouY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 05/12] MIPS: Octeon: Header and file cleaning.
Date:   Thu, 28 Sep 2017 12:34:06 -0500
Message-Id: <1506620053-2557-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03e7590-276b-4702-2876-08d50697cdd7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:9r+J8DFGg2cfw9oeIucYrA5CdZvbDE0AhtOkq/qaL+P2mbUx8QN1fZUxAyoFpWzuhm539t020rqdjMOH4hzpMTjFDxvryhYwOEDxUToYLkGOHkqwbCGyGMhR7DrJVKOua1gxkjV8psZJEwFZiapWJJ0eX2geNpyw2+aLz+t6soTj5LLJgza+/7GY/epoJUDaS0ZRZKlTeFmPoK8yehPzqXp9B3aQVSafMR0wrOhNFZRf7aX4K7RhR2S27iP2OfE3;25:vKvs8+MdopCwI2HWPEosldJ8SGuYvfO/sQ/X52x8ILQ/F/+LAPI/xdDymvferqAISR6x9LbTLwZonUVv6+MKfEyWR5JLM7EespqVt4qAEjD7CQb/pZopV74JfWYuQsnncpGbYaI7N3k+U/V8UpU5Sfthx33i2j7RjUMxeYJXsvh0Avu4mB/pBesgY+I3ZhrsLAwklLNCQMZzFS9EDVP0c/MpJ8sce+7tZcG2b4LCfAM23prEunaYC5LI8RmmH4KlvcOovwExXiwemPcjnjT0q5BT465J3p/pJ1OZxH1ItKoZHKnu8knpGzNeLb8XeYY+mZlbGvYHBgCB9rzPwPgsag==;31:IuQCVuPvpgZnxY7iIOG8IE7bLFe2io4Cz+BuyAHH97i+gTcYylF+3vawKXlDORrxnkswc4dCzHMLFYFQEkd31d0CeOuvVSfsuGmRZyVKt3b/jw03MzXvX7EtuoW9InCNs2cW+HF9MLLR9jy3nURFzQB+A8ZV/YO1aWhf/ShEZTI7ojPSR/z+CUTDp1RpRu5eeL1M9MzzCQ1C9VYdHYGw4ls6A7sKoINFUsrqM6ECTRY=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:pPcEtTR0znK7YPDaFtrFWipsNWHQwB9rkw65zy8PFR/c7vmyzoccPaMkGbOovHjKeAH0qsJENf7Ni5nA97VEdqyK8PoaEVeoQxtQ4GEGL4aBjp1ThgQ9LjG6TB9aPcrKvdakC6kAMpVmfNk9bhP6Ou97/ZJrW/bbfouX2/Yfw5P8p0Rzoe3BiFD+pN4rCsG7qR7MhWi34fiuipz4fZ9Vnca+MJoKmdIqYAM0NawhJLH8aT7ANRRlO0+ytPaio1myNX1JKKAiPI/ZAAS0hRXOlSUC2gELEnwQiKD7Y72TBHsMc2vyWJF8YRQUM8w4uggmvVttPsB7z6ddY1TViZRuNFGx/ZRYrTIWznd35Ox+SgbspGbNMNbHABw8KejmhXhCYg3Kn8JGcMmgAIxorZaRzTO5hkup0a/2FpUje4ChP7AlXfGRKEZTIht5jmqOiuldx7WoHy2V5yf6LLtHVLvzjMab0brVMyl9Cr5b30Z8EExPkySGYfBhWdDK5+NDP2cf;4:erN3xdJbwTCoMbOpxvsA89xCjDlwBJETSdPpGuLLVOGilwBDurUpDJsb5yOYVV6uKklDw+i4lrCHyX6bqjUdhzyJEoao6wIAMQ2Pa0RfiZ91fYPT4C4DAA3x/MRTAmqeloe8RhDkiF1JESSimm9HcCzG51plRtfV838hHbqZHnJXTAzMx9ajK5kktoveccJJ0dDn9SIwQXvJ62E6W/Hrur6bxIlwpi/KPR85rrBG7ZgWj5aFMBzi7Gk75Cxib24A
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB380734717A7FBB7EBAA994D280790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:MlNmZ05/V9xYhUIPU7Ys/WhuscX5y6sBgCUx6xh?=
 =?us-ascii?Q?NAtaMg251NI+YiOqx9ee1hf9gqJigGFQvx+1Xe5QWmTyGOsksLeTDiQo96wV?=
 =?us-ascii?Q?1jd5ju3gvEWKQLxN6KZfVTP53q/OE2OUsCyIuc8sPbjuYJykLtsjDth9x3rr?=
 =?us-ascii?Q?eqtTcL2M8cPqFyZdRQSgUu05BWVE6Q6Igyp/uJpYp5Jd9IfPUcGglRcXe3CD?=
 =?us-ascii?Q?+yV1csLVSuew8sXCaAqr985m9iURMq4QKh1Nm7SZqBkj3NMffEEMZTeloBiu?=
 =?us-ascii?Q?bPHWWxNCnQA/QWC7UDpszLEAx4b0ypOI64FqjDoksvCJ1ZnqiemVPrCyU4aE?=
 =?us-ascii?Q?TwmoAA/86eGl/bh5/t9vVIvEzcp6EzsXCeXhFyJ9A249tUEpEjt5ydPh2Z3B?=
 =?us-ascii?Q?YUYG+/Rt6g8ne6qCEwln2ccqnOUQrBuwnFbQ65v05g3rKBD9Djxne1IKu5Qs?=
 =?us-ascii?Q?QVSv2d1aNsb62qJtnidmDGt0sWXoP3oNMRT/j+H2O5U6KZ9BnkzcvTq+QZAN?=
 =?us-ascii?Q?l80MjMYS717BqaWQCaQT4D4HOSpnlY+wnFZ54fbDsO0sPa/Bvj+uUEGr2y0p?=
 =?us-ascii?Q?niCHuAvTbuNxMXa6N2UuhafZm0SWZKzU75K4L2VAaFWkYULMgNgG/NVcj+M1?=
 =?us-ascii?Q?I+DwooIBWart1OB3+WJdpf2KxE7xjvJw6WjPqLkhesZPgIvs1iwfv5Nj4BEo?=
 =?us-ascii?Q?8mvuqm3gB7v1hAsdKIi5yEZGQc+RLYm2IRR+KuNXqZW2GPOSQq24c867igNS?=
 =?us-ascii?Q?+itN4SwxNpdTIk6wxVyjHkivkI+BVk1f/1kGUrBDjBFO4dL6ghzzA7/Jf65h?=
 =?us-ascii?Q?tYpz2MD9kPM2+NOosuTZQma9wYNGCVdzlXfjA1d+cFjAcHEj59LqGccZHUZw?=
 =?us-ascii?Q?F/cECTITmu+k6RTepLOa1A82pCpExHecxOwto7xpM3GIcwwN6GzbYUgI6aJL?=
 =?us-ascii?Q?iDPh2RxRtuK9W0K7yqbLjhvB5jFLkdfVrUxhnYB3ELrt35rCVUM4AeJSDetb?=
 =?us-ascii?Q?5oc0fc4097XHDdIYQsfdt5mxJpMxN5FOKoQMqSnn2YN3nVpkvcieJHLchp47?=
 =?us-ascii?Q?Eb3z95A9R36HUb3kKWnuv++JEaKOtjjfLaMrNraZylkKeQN56BR28EfwGAKH?=
 =?us-ascii?Q?n4gNnG+fqqigX59peUpg7MS6wuqjJXmCaBxVsepB+cbVc77hHIMM+0xCbc2X?=
 =?us-ascii?Q?gjVOoLDUxxuDtpbI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:hIDZvjPna+4Ks9+r7RufxodlGuQLrWOlhk9cROEWteLu3lr8FDj1NuQ1NfAEySYkTJNklDbwvgK1x3Gm82EbyF+uvN6Zvue9EuyHdPW9EFxt9fHbzTURqBLB65VFI/jZkUU82MOJmMYa5GXe+A9drZsDJ8Hb1hKIVjC0lymr+7J9g3ICIKqxH7r3b92u9OPoVWtwfWEh4oVuy9ou8nFM698Lkc5YBqBWc0SwnIbIqLzSmlovrjX37nMtoTUtI2IsqeO1HXEJnK6783Gz7Wko98Oe+CDn4XW7l5TATZkUvYCuk2YXpDutOX+nX2aQULuVyv3z2yR/ojEC4w7lv4MUBQ==;5:zs6poCM9guntBf7emihKF2HCRQ98NGmt8myGvoNiJF7WQYBMiTz7P/fZhPDuEhOg5yjOusOl9XxHcVMQ+Vx2paeE3dacbPbqqJYvhfLOSlH9KjIuMkpa0PvlySz8uN8wl8Iww0edVearrIXMZMMegg==;24:rmKqVjnajQ1Md1XzqC6Gsw5m+5vttxOkLlPtIj+kfnP3wTD88m48UQQnxV3arVzXMHB1B73pLQ7TipUvj9Mg2MegtRF9KKac51+kW2rMh0E=;7:tZhBXFGqpn0YyWIE2vKV4ZZKo0c+1do5Buo0/aiZz+KA92NYXMyGY7yogdnna2/JojIGZG8/0cnYuW0+3s3BrM6ExB75MDzSzLpA4UI1IUmcsSgz84SsOQZC3UL7N3NIKCdxDSV13WSoKUObvpl9fQj7/FFB/mpblNVpDgP24yEOIVu/BM5e4zumMYD7rPViQeWxLSH+tLnQWw5q+JL9SwuWjBOqQvWZFrKnIvSw/50=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:00.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60189
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
* Remove usage of arch/mips/cavium-octeon/octeon_boot.h
* Clean-ups from checkpatch in arch/mips/cavium-octeon/setup.c
* Add defining of NR_IRQS_LEGACY for completeness.
* Move CVMX_TMP_STR macros from top level to cvmx-asm.h
* Update some copyright dates.
* Add some missing register include files to top level.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    |  2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |  1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |  1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |  1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |  1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |  1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  1 +
 arch/mips/cavium-octeon/octeon-platform.c          |  1 +
 arch/mips/cavium-octeon/octeon_boot.h              | 95 ----------------------
 arch/mips/cavium-octeon/setup.c                    | 10 ++-
 arch/mips/cavium-octeon/smp.c                      | 17 ++--
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  8 ++
 arch/mips/include/asm/octeon/cvmx-asm.h            |  6 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |  4 +-
 arch/mips/include/asm/octeon/cvmx.h                | 10 +--
 17 files changed, 42 insertions(+), 119 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

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
diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
deleted file mode 100644
index a6ce7c4..0000000
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * (C) Copyright 2004, 2005 Cavium Networks
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#ifndef __OCTEON_BOOT_H__
-#define __OCTEON_BOOT_H__
-
-#include <linux/types.h>
-
-struct boot_init_vector {
-	/* First stage address - in ram instead of flash */
-	uint64_t code_addr;
-	/* Setup code for application, NOT application entry point */
-	uint32_t app_start_func_addr;
-	/* k0 is used for global data - needs to be passed to other cores */
-	uint32_t k0_val;
-	/* Address of boot info block structure */
-	uint64_t boot_info_addr;
-	uint32_t flags;		/* flags */
-	uint32_t pad;
-};
-
-/* similar to bootloader's linux_app_boot_info but without global data */
-struct linux_app_boot_info {
-#ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t labi_signature;
-	uint32_t start_core0_addr;
-	uint32_t avail_coremask;
-	uint32_t pci_console_active;
-	uint32_t icache_prefetch_disable;
-	uint32_t padding;
-	uint64_t InitTLBStart_addr;
-	uint32_t start_app_addr;
-	uint32_t cur_exception_base;
-	uint32_t no_mark_private_data;
-	uint32_t compact_flash_common_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-	uint32_t led_display_base_addr;
-#else
-	uint32_t start_core0_addr;
-	uint32_t labi_signature;
-
-	uint32_t pci_console_active;
-	uint32_t avail_coremask;
-
-	uint32_t padding;
-	uint32_t icache_prefetch_disable;
-
-	uint64_t InitTLBStart_addr;
-
-	uint32_t cur_exception_base;
-	uint32_t start_app_addr;
-
-	uint32_t compact_flash_common_base_addr;
-	uint32_t no_mark_private_data;
-
-	uint32_t led_display_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-#endif
-};
-
-/* If not to copy a lot of bootloader's structures
-   here is only offset of requested member */
-#define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
-
-/* hardcoded in bootloader */
-#define	 LABI_ADDR_IN_BOOTLOADER			 0x700
-
-#define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
-
-#define LABI_SIGNATURE 0xAABBCC01
-
-/*  from uboot-headers/octeon_mem_map.h */
-#define EXCEPTION_BASE_INCR	(4 * 1024)
-			       /* Increment size for exception base addresses (4k minimum) */
-#define EXCEPTION_BASE_BASE	0
-#define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
-#define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
-
-#endif /* __OCTEON_BOOT_H__ */
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
index 75e7c86..01da400 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -24,11 +24,11 @@
 
 #include "octeon_boot.h"
 
-volatile unsigned long octeon_processor_boot = 0xff;
-volatile unsigned long octeon_processor_sp;
-volatile unsigned long octeon_processor_gp;
+unsigned long octeon_processor_boot = 0xff;
+unsigned long octeon_processor_sp;
+unsigned long octeon_processor_gp;
 #ifdef CONFIG_RELOCATABLE
-volatile unsigned long octeon_processor_relocated_kernel_entry;
+unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -36,8 +36,6 @@ uint64_t octeon_bootloader_entry_addr;
 EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif
 
-extern void kernel_entry(unsigned long arg1, ...);
-
 static void octeon_icache_flush(void)
 {
 	asm volatile ("synci 0($0)\n");
@@ -98,10 +96,7 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 void octeon_send_ipi_single(int cpu, unsigned int action)
 {
 	int coreid = cpu_logical_map(cpu);
-	/*
-	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
-	       coreid, action);
-	*/
+
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
@@ -148,7 +143,7 @@ static void __init octeon_smp_setup(void)
 #endif
 
 	/* The present CPUs are initially just the boot cpu (CPU 0). */
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < num_possible_cpus(); id++) {
 		set_cpu_possible(id, id == 0);
 		set_cpu_present(id, id == 0);
 	}
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
index 25854abc..392556a 100644
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
