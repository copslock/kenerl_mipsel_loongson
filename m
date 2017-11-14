Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:40:22 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992196AbdKNEjEZTWQ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LfYv04tbegevMiQHJ5s2Ezea7zvpXK9I/+l69Sc0W/A=;
 b=VU3qptFnrv0wmuMe8BArX/c+JKmD251FRvxIGyufUrZTlWphAG+lkj57RT6kBeBF5YnMA37YHI3YudhFasdbbTefw7HeWEXWJuSwot8OnEBAah+tIdME6CVkN8X5ZE/+LCt2jck9byVYBAdbwHHYO4/rJJE6IDno1pvuy5PiImY=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:55 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
Date:   Mon, 13 Nov 2017 22:30:20 -0600
Message-Id: <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 601ddddd-de0a-432d-d7d9-08d52b199dbb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:0GjWNPZf/UxOq1H5fqR5nLgixfH3gRkGQyq3dsjIt/OEOalOVGFXCdpMOC0tQDfohHQudCcac2HWOzTZYFyrlwY63HRHtpyfdAMQ0PbB6OZc8IuSbJcaLkRTzEDoyTp0/FkF+bT5Z2HIzXGcqyaVpcCi+R3bXJBWuIIg/nH4a4zbVentH7eSbq+qF+9XivhoSTpdynqGFQ4/tJSy/YC1vohIw50a/mTm/IVruPBJmfD0YLxsNlb2twQP56HeZjYp;25:+i9P1G7NxYOh4wcP0Wc5ZxR9er8tqsJiaUYfv19b+4uAOPoKwUYmBGNKADtBG12kdqL4tKSGSnjjFq+d2DN8PowwWaglTWWZV2NGE/Aqt1+I5N5BY8YNRAJ87AJOooeqtG3myujQg8vYW1qsyJZjzj9lyE4JX4nWzun5vE0WpBpW/IPZ0zySiIn+K3ZsbXKd+H3Zr9G06Kgm03t2jmTQWE6973m9og85R8rTjlmvCg588h0Pl7J/eYM0xdHNw45Zi0QY17jyMGiTPnktIBZwWYXxe7lALQiAn5Wi2sThdsa4al4G2NBuDRMe7r2SeYgZuu2fefIxWJf5I4q9w/ZlLw==;31:VFEJP8rYpvWG/eojB0FQ7z1P8uTo5cxbYrX1ydf6+nxG5iTR/ym3kSe5W2ics4WlQ31AX/h+DYU8L8H++/gnb4CAjAz8u3wKckQ3SKqEu6dGA9uVXblPyu0iiPDkI/Srzx8ls5nFpR8x411lVP7/29uZpBkw5ldG4MiKaOrxphqj7ZYv6EOUOUcE6Q6t/LfYBe4BCUJJFwgK2CBic7OVj8yzhYHlXcCBPjWxBgyMkK4=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:jWaFDD0z8CF29mQWDcK9v93vU5036Ywg7PfmSRJjbZHf4grHkzb+J8K2a2nmIzGTmO8edsuJo3BoQQmidtIQ9ijIR2KPOFgxuBJ9QLT8AA2HHgn7qFhmJtqRCfcHB9rT21XCKKh/o+Ce6MnwGheJj8AmCKDpopLDjJqvUpp990EgmNTkwxf7eSXFU69J4tQpeLS4slm3//0urOP3JV7pxMVB7cIi3vBsqZrn0kpT9EwNE7/yC9KKGaTR+oPtVmgujkHyoUbkNNIU7YyCbgMPc0UhdBBiMZ0sMaG81XIdzJAct2gsQMlTbdbfVQJdkQaYONw3myt5EEGJ6w95aC96wWhJrP7gkLHTK6f8ug35zVVwW3B5FWzo87uheX5whUzt9qNFv0/abyRB+3e1FN5epJmGRltF0MJgdWB4r1cNRcWxzBR/RS8wOo3h4lCPxYz2JrHeBJiVKCS8xLnI4NaZkUmyk+UtPFksGbK+6lTrN+rzSpX+mkRZY+d9l+GC2Ak2;4:U1FjqRuaT44VlaGr5j+F5Q0O8Tp6BjBs8y2987OSP0hhlBuCLTH7QwlDJN+ACOE1dqIrDkpbHryqHAljDXYy+++GsZ+zNOBsBxW23TbqULtgFg8CDlep4lcQEaAzj0cNQW5RYlcFCCcjn//oOhR4y+rql79Nft+plvsGLs9XNiHmtNAmBIGM7YzRImGWUdvKXL86y70qywiqy/+Hc5/kF4SxMVQ+4Vx7WR2+KKhl199JaPgqnJlcuT9HJncPwpGQVsHnY4rpZqUfhykZBrU7yA==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806B5901163B1065D90048A80280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(575784001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:q5HJwo2V+ICmDu6gfE1CTxLm5zhc7jf3YblHrdX?=
 =?us-ascii?Q?26l4phnIF1yJ/jos8xl43RPldKLl0fHT5VjJqiuvsMdOwVn/592ILmj//pIG?=
 =?us-ascii?Q?lwHH0qXeQ42UScjlz9k3grb3NMNdyeKwcHZlZcSCuOaSrv8va8JZ6x2Zghv1?=
 =?us-ascii?Q?lxwBod3synKl7Ka5rbkiDjXfVwapinFlxgDJNx0OKd7/sZf0TZGUvqysK1Ee?=
 =?us-ascii?Q?fDvL3zg5gN27G+zVzLBLKyzPRqcyaWolbOANlj+UflEBN/IrX5/l15poA5I3?=
 =?us-ascii?Q?Oyw28bohUMXGrWA3SLv4qISlyYGpU3y+hIjNrBS8BHGlFXTB0nxrpYWDgil5?=
 =?us-ascii?Q?enIaNsMDR6SyiWjDQ43CSCPJHN5idI26Fr5DvnIYUUrFH9+S8wZU8DS8qhjW?=
 =?us-ascii?Q?ZEuCg8EkX4vO4oPDOxAG2+K3wep31mY29FZwAX4nTzZFTjLaw1b2cuMlWMY1?=
 =?us-ascii?Q?epW7tNQ8smY+p8ESSY3rpUbPviXAWk0+R76OzKVQbUQ2IIP8hueLeWyogRI5?=
 =?us-ascii?Q?sb03D45zuqSFDKGDXLWjOPqS3epD38fPgemVuxqBdZejFOnL4FCpU/l7eWq6?=
 =?us-ascii?Q?GZ3uuCntsnAhCZnUIOz9EM5xmznCT9SiccMI1xPA/1xmr2w7Vo9mO0L+8OIz?=
 =?us-ascii?Q?yfBHepTgWnXCKLqP6M5hWz24uP9GzbktmlGrt7MWH42nsoqdfaAuVC7SsA7A?=
 =?us-ascii?Q?6TCpjZ0u/HfosBoPWWgamWQkIgulM/cxfFfGcfj1i/DGiDIdblZQxf0TE1pf?=
 =?us-ascii?Q?yGF8KNvPegmWoRlnu3EKHg8XhLBWDwBWOQDXmz43avnjedAY9b8/tZ+YV49F?=
 =?us-ascii?Q?MvHUWA0Q+GhcITm51XG/uiKeMJ+u5K0ZaZn7Xtk66irFVoQZV/uTUS+QPHHQ?=
 =?us-ascii?Q?EE/uQ7mskbjkhgie+AmIrtMkK16zzYQW3KM9DmtSQb18iqHdtKlM5hrozlAe?=
 =?us-ascii?Q?dr4shyYlKbvgw08XG3X1Qoa3mUAenO/rWC4vmSVhrAU6h5eW+kmy+7NPI7tD?=
 =?us-ascii?Q?+KQjJ6QAfVym7f2jf6a0AU2eflHGEFhSJfxJksF1WpRIrisLZiKgMH6IK5+K?=
 =?us-ascii?Q?n21pLBvpH+BT76yRI+jxV8aI5OoCnVjir5s97khijCuY8ZznRHQkjAgdj0yt?=
 =?us-ascii?Q?lj5xzcVbMIcL+2KqD+7SUp94EtD6RitnZ9/tmmcMZKRxK+ofXreRUsyPivMF?=
 =?us-ascii?Q?J0rbdvL70f35L11MpCdw6L+9EACLCSjY0eXX4?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:aTRQbDh73+mdmaQKqcV6QP4j8rlJW1ApZHJzqbgHSE6fBPM8KyaIxRLmWJFFUNjK9NeN+jV4xtcY/2mdMxHRKkjvdbOrSsm4rE3lFkhsmEgyyJ4MKdxyXMNbOrL6FE8g10Y0Nv+xMrZNkzhNBr07kykcTw0bSo848K4JrH9083FfLKr2bLMKARSgLk2HKm6SEAop007IhyIiWBw7ETIr/bc8gyBift2kYYmk0O7k1xU8j3rXF/jpDy6WPKb50ik+PDmxLOvt9wi4oW6To9gosfB+69gDSdRxtfzKqV63y3/DZ9feHTdYc0FCrqn0VGLnJp70L4TwcrVW6CclOqJJG36elOHpsp+tZeCSBpAB2pM=;5:/bUPayh4HPnzOesyiltyqSp+NEgjN8HksoW2S+CEjhb39zhjnOUaUgDX+SL9Oj1fsqGa9xlznjUjpXZyWaOF9r9xJH02nsJGOV6M4ff4id+y3Fzh039H8GJ4Hb2vXy//yA4+7Jf6gLuQfMRztB5rkie+AlmGN0bWSt2kdhpUlDI=;24:KKJh8NDD9u4xCr8Xpf+0vw7lZ3ZFsEOXelBQled09Dvqp+eX7owtDnSiyozKq8X+ZEe5phcDuTMpwfFvIwjoEjJhoqHbnyu8pFhJzN+VI+Y=;7:wUirzafguAD20jT4JpcRvtXM7uxiHWoS7CETk4VZh+ai4hnPvRGeKvG61sNKOkAkEavLQ+z1a3ksJXAj+ots0MSUOTHaOOn5JBCiHx4zDvU0a200cdNMcu+pqdf60UqVC1v0EV0XXw5fWtr9dqd0XOekNbG5bP/yqKur6KO0+qu4bmI5HU5U230G+Pb8gI81RD+WM4f6yVLThl/P6RxyBedNkCMa0asBLkbTgmujxIoJApR7vjLxw4W+A/rlYJOj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:55.7209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ddddd-de0a-432d-d7d9-08d52b199dbb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60895
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

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-spi.c    | 10 +++++-----
 arch/mips/include/asm/octeon/cvmx-fpa.h         |  4 +++-
 arch/mips/include/asm/octeon/cvmx.h             | 15 ++-------------
 arch/mips/pci/pcie-octeon.c                     | 12 ++++++------
 5 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index f24be0b..75108ec 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -862,7 +862,7 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 	 */
 	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)), 0);
 
-	cvmx_wait(100000000ull);
+	__delay(100000000ull);
 
 	for (retry_loop_cnt = 0; retry_loop_cnt < 10; retry_loop_cnt++) {
 		retry_cnt = 100000;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index 459e3b1..f51957a 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -215,7 +215,7 @@ int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
 	spxx_clk_ctl.u64 = 0;
 	spxx_clk_ctl.s.runbist = 1;
 	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
-	cvmx_wait(10 * MS);
+	__delay(10 * MS);
 	spxx_bist_stat.u64 = cvmx_read_csr(CVMX_SPXX_BIST_STAT(interface));
 	if (spxx_bist_stat.s.stat0)
 		cvmx_dprintf
@@ -265,14 +265,14 @@ int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
 	spxx_clk_ctl.s.rcvtrn = 0;
 	spxx_clk_ctl.s.srxdlck = 0;
 	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
-	cvmx_wait(100 * MS);
+	__delay(100 * MS);
 
 	/* Reset SRX0 DLL */
 	spxx_clk_ctl.s.srxdlck = 1;
 	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
 
 	/* Waiting for Inf0 Spi4 RX DLL to lock */
-	cvmx_wait(100 * MS);
+	__delay(100 * MS);
 
 	/* Enable dynamic alignment */
 	spxx_trn4_ctl.s.trntest = 0;
@@ -527,7 +527,7 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 	spxx_clk_ctl.s.rcvtrn = 1;
 	spxx_clk_ctl.s.srxdlck = 1;
 	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
-	cvmx_wait(1000 * MS);
+	__delay(1000 * MS);
 
 	/* SRX0 clear the boot bit */
 	spxx_trn4_ctl.u64 = cvmx_read_csr(CVMX_SPXX_TRN4_CTL(interface));
@@ -536,7 +536,7 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
 
 	/* Wait for the training sequence to complete */
 	cvmx_dprintf("SPI%d: Waiting for training\n", interface);
-	cvmx_wait(1000 * MS);
+	__delay(1000 * MS);
 	/* Wait a really long time here */
 	timeout_time = cvmx_get_cycle() + 1000ull * MS * 600;
 	/*
diff --git a/arch/mips/include/asm/octeon/cvmx-fpa.h b/arch/mips/include/asm/octeon/cvmx-fpa.h
index c00501d..29ae636 100644
--- a/arch/mips/include/asm/octeon/cvmx-fpa.h
+++ b/arch/mips/include/asm/octeon/cvmx-fpa.h
@@ -36,6 +36,8 @@
 #ifndef __CVMX_FPA_H__
 #define __CVMX_FPA_H__
 
+#include <linux/delay.h>
+
 #include <asm/octeon/cvmx-address.h>
 #include <asm/octeon/cvmx-fpa-defs.h>
 
@@ -165,7 +167,7 @@ static inline void cvmx_fpa_enable(void)
 		}
 
 		/* Enforce a 10 cycle delay between config and enable */
-		cvmx_wait(10);
+		__delay(10);
 	}
 
 	/* FIXME: CVMX_FPA_CTL_STATUS read is unmodelled */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 205ab2c..25854ab 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -30,6 +30,7 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 
 enum cvmx_mips_space {
 	CVMX_MIPS_SPACE_XKSEG = 3LL,
@@ -429,18 +430,6 @@ static inline uint64_t cvmx_get_cycle(void)
 }
 
 /**
- * Wait for the specified number of cycle
- *
- */
-static inline void cvmx_wait(uint64_t cycles)
-{
-	uint64_t done = cvmx_get_cycle() + cycles;
-
-	while (cvmx_get_cycle() < done)
-		; /* Spin */
-}
-
-/**
  * Reads a chip global cycle counter.  This counts CPU cycles since
  * chip reset.	The counter is 64 bit.
  * This register does not exist on CN38XX pass 1 silicion
@@ -481,7 +470,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
 				result = -1;				\
 				break;					\
 			} else						\
-				cvmx_wait(100);				\
+				__delay(100);				\
 		}							\
 	} while (0);							\
 	result;								\
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index fd28874..87ba86b 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -639,7 +639,7 @@ static int __cvmx_pcie_rc_initialize_link_gen1(int pcie_port)
 			cvmx_dprintf("PCIe: Port %d link timeout\n", pcie_port);
 			return -1;
 		}
-		cvmx_wait(10000);
+		__delay(10000);
 		pciercx_cfg032.u32 = cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
 	} while (pciercx_cfg032.s.dlla == 0);
 
@@ -821,7 +821,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 	 * don't poll PESCX_CTL_STATUS2[PCIERST], but simply wait a
 	 * fixed number of cycles.
 	 */
-	cvmx_wait(400000);
+	__delay(400000);
 
 	/*
 	 * PESCX_BIST_STATUS2[PCLK_RUN] was missing on pass 1 of
@@ -1018,7 +1018,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 		i = in_p_offset;
 		while (i--) {
 			cvmx_write64_uint32(write_address, 0);
-			cvmx_wait(10000);
+			__delay(10000);
 		}
 
 		/*
@@ -1034,7 +1034,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 			dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
 			old_in_fif_p_count = dbg_data.s.data & 0xff;
 			cvmx_write64_uint32(write_address, 0);
-			cvmx_wait(10000);
+			__delay(10000);
 			dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
 			in_fif_p_count = dbg_data.s.data & 0xff;
 		} while (in_fif_p_count != ((old_in_fif_p_count+1) & 0xff));
@@ -1053,7 +1053,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 			cvmx_dprintf("PCIe: Port %d aligning TLP counters as workaround to maintain ordering\n", pcie_port);
 			while (in_fif_p_count != 0) {
 				cvmx_write64_uint32(write_address, 0);
-				cvmx_wait(10000);
+				__delay(10000);
 				in_fif_p_count = (in_fif_p_count + 1) & 0xff;
 			}
 			/*
@@ -1105,7 +1105,7 @@ static int __cvmx_pcie_rc_initialize_link_gen2(int pcie_port)
 	do {
 		if (cvmx_get_cycle() - start_cycle >  octeon_get_clock_rate())
 			return -1;
-		cvmx_wait(10000);
+		__delay(10000);
 		pciercx_cfg032.u32 = cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
 	} while ((pciercx_cfg032.s.dlla == 0) || (pciercx_cfg032.s.lt == 1));
 
-- 
2.1.4
