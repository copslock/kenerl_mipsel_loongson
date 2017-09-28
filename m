Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:40:26 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992339AbdI1RjHmBwnF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y1G8gRvLNWOUo0QonG75bYJGYzSuZ3D/3pe0wu6sIkw=;
 b=JHUsLEPofLRt7T5Kh5xMdKT6PtpGicg5h8o2V9+Gs64vj2DjNlDlim1MYIsHShxEoiXl1j00SVKrXNjyivYb1LV8iAdBavwjkrufStVDsi2joIe9C4w0Vq5AKoRUR2kc56aNZb52mCJU/AwKvWiWouWcjjHmvMfGQYsVHHtmxi0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:38:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 04/12] MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
Date:   Thu, 28 Sep 2017 12:34:05 -0500
Message-Id: <1506620053-2557-5-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 61d8a798-112a-4162-de3b-08d50697cd6b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:OIiE5O0rygKSjuqB5Y8jngEISjI4xqMzZvkr6lxCoAWmd1R9kmiyYAdxT8ig+Yl0CevaYhvlGW7FB8v/oTY2KqYJnjSYw3aPwyQ2p6PgqrcssH8PvaC2+s9hUYCNG0Wz7WHZcOpLsTlzMXiH+aDimgVu+mh1AZHeTMQNvIbP/shnCO9LfLPs81nVIqi9uIvNrrnggbvo4BTRImdUgHOnlHYlVNwadCQuUd6jgU+o33yBJN5NQOLs65oB3yhyNqCY;25:0V5vHO7B2NHUG0xXFrLY+7wEvFX1rCOOe7nL5gPLwZ6Gg1MfdTIHI0BoRkX2KooOQof6FjNBQKR4KtD9GaMo7Nxvl9ThCEesG8JLNSyYiiK34oT8rDoHgltIQn03mx5IC+FlK70ESZyYoRBXic0iV8XOh1NRZwgFcsHVaWXzAMfbYdOGKaTPnHzHk9zQHkBb1rD//C+rUR/bQiWvqBk4T24CnR4KPdDuGR/R4gnTJTMZnL+APJ7SPY1jbFAfGdwB17MrMRvECFmFFJ7OLB4TuPYgPlLR+QDxQR73CPPuUq9whItjl4EOtziVTND4Y4bMTIHwKIz/GZmercVYuI5bgQ==;31:/Ex/9yr7RUl49TTztKr22ZlX54ochaK6ixRPuWpaI8dhMYq2Bkv8GbqZaQjJ910Awq2VMRwcWWEC9rcq1WSPJ6742gEN+LG7O+LkMhQCw6cPt8DiwY/0XFn+8xlc3vZ4V9n7GTlwyezq9wgZD0BQITGcmJM4/fLveRYizo/SQhbgB9rGFrCyUyyJITEQ8qKF08HU5L53z64+3pRbGuUU/b+ywuFFBTznSATYce/TDII=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:yaLWkp+pKExH5y/0IrGFkies6XDUkHEfNda9Zne5p7k2XnhYcXNTkYetJvqcm3mhDyXHpRqoT5Z2VHB3iUxrIWe/UTI8XdPyTSdFoATbjVwCBW05l3yUSf8cJnj7DJtxeDyudMcCm17F+jAiDAbPACTtutGLiHD+Nij81yL4CJezF30PcZtsH2z+Vo+BHZ9WWAys7Bu1RoU5tt3ejMDqBxXh5ei5IcNKxtZXnQIz9MGOKyxn5+0WoxkTzjlR9Gzw8//Fq4eVkIiHV2vaNNI163wDtnWxSxEyqzMBEzS+hcuuOPsu9kJSZOHWCWZ/HAHG8iUit/TQAPubpVEIU6S6HBgSVZs1Ot8xqcyQmQ+I7m16lQcZFDgkfxCBR6wLKQhqX2nRdTaNn7cr06oSMIg1O1RKEWoWm68tWoGRHv9cEu2l1uOB2f8Hf+LEKgRwWaFuCtMNz+6l8AOGLY7SvQYCs8SYE+yn4qfy4f3rDmTeD/8+e3f1r/mk687qkskYJ47j;4:bNKkaDDAKXNtRsxZe9caJDxCfHxOx6hJtD+jViDd/xPFhkcfgyHc+sByOB3fx5X3jRuscpW8TLHi1zTolYCnlqEsQuk+GTLCbzosNNaJlsNFkc8pC5ZKQTlWcOW58M1BNz2/kgsI/ZFkvF6TGX7ptngbWPEuqzMzdE+WNK+NxGgEAKTKieU6CphMLiiV8tC4xmNLzTB9+pl0dleg+eyel8yG10anxKkfC6Lf1DLK6S0HeSMLPv3u4qSuMBois4RD
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38070870B6B1FACCEE3C7D1380790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(575784001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:nLO1+NJE3TuGCVgDkdcZX1Fy2znbO7EtidzHBgy?=
 =?us-ascii?Q?gyO9aJoQZkqT7rkQh0co/0NXKV1gmD7q5tg9H7DXH4ER7ponehnTGsjNTBAs?=
 =?us-ascii?Q?QIFt6itHBl06IrGWfsSJco4Zkaj7o+iKKksbh8tVNY9hi7Ogn2PWT2WMBzPU?=
 =?us-ascii?Q?q6SAnocn7rg6tM0y9JCnX7AJ9uX97BeLu6H09mqjAmvZavwe3YVWqJAS2d4y?=
 =?us-ascii?Q?QDCrameT/q9Wukngm1m6+XXQtEFKrqc6djDuFXQdeBInZf5DOb4ysidiFQED?=
 =?us-ascii?Q?72Zpoq3SxA8fCF1AXVo6OfWs5rlvwusIr9njAfH/yeZHT4Mt6hWeGcUFaN3z?=
 =?us-ascii?Q?2hfS8rMtJEjF+T27xir2HNRYOBEGR/YlpQD0VADS+wnaN4uCFO9GaRWxgHEy?=
 =?us-ascii?Q?8ybyjEWoAOZFPQsZhBBGHiau8wWbCq8omXp11wl4UrGjEdI1/X9urklqpW/R?=
 =?us-ascii?Q?pP5MeN+0h758/JQVxybJsTZAMRo6MBmP+qxNyHYBAsmNx+T9T/1sHfWuF1GF?=
 =?us-ascii?Q?ORCxmFmMMg1Jm5/szVeUlwWAK4qzvPAnIcYup7YAqC7E7oDSRzVxzYw8wosr?=
 =?us-ascii?Q?zd5Je2waYfYYORPl+uruqcFGO88enQ5QHQsLLwHNL0YGhaXFfplgKt5+vqs9?=
 =?us-ascii?Q?e8LlIfcFG7W76a4MxNw2SQ7lwuv+gGO4IqPVpsAYpJg18dyEgLo1p7lq5Dlf?=
 =?us-ascii?Q?1AiXQJvWuGBMl7dH5Ojlv2rcE2ngWUkvClfKTKezxqF5KhuDVGQ3Jv2O2v+3?=
 =?us-ascii?Q?w9gmlfSGWatjuJzFy1dyriZIC0+DFwJQp+60LuBAzOHbKdi3oAjBueO0t4t9?=
 =?us-ascii?Q?xg6PDEbYGKDjrHgVirthVJq0CsqdXBIo8Oc72f7qNkFDmez/tuxeFhMoZH4w?=
 =?us-ascii?Q?FM3jXoInIoG2sFEpJfmuitxPR2VUWNsRX9HvHLk98FGLl0f1xCM+I30B1AKo?=
 =?us-ascii?Q?yTPxZK/wJr2EoiF82OYlcRVQTfQSslGAvWQT/dK+Hd3fl523dMr58gNq4jzd?=
 =?us-ascii?Q?tkZyh5jSpw7+phn0XZrVixSYC2x6W/RtsEODCwIbeG8VwuBebNYBukAOpcIH?=
 =?us-ascii?Q?UwUY0+nMNV7No5oZDXixhwCEUT0Ulkrxf1geGK84yuVDE8MadAD/EHUmHtgl?=
 =?us-ascii?Q?1wClIh6ygSWyFOig0NWqQVOYI0MDpWLuWXnSW0Q9v1tFrUxxGB4v+DU8PLJI?=
 =?us-ascii?Q?JhN0vrLzShBpA7KA5GGHSzfVY+j0ffX5WIAgk?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:CcFz1M6u6r7yoeh+m+3Zfw8T+9ZrfV3w/0t1LhgS5FvCjiLDfQ0PcgGnqsfCNlstFTJ1JC+ejcSBOg7sfd/uRmx0zNnwQ6IkgOqBA/F0GddsoqpN4E2lc/mlGoNUzExGiVnNxffW+RiN+Jjj1ZtJkTwlZVyuYeoW5dDhg3XKomkr657/rdSUVwbQjOSlErANt3KFSn3Arv0qsGdyAUREIw8POzRwKPqWZbwZtPNfq24c0JmMGlf/MygQrv280ghVO9kztJXoqpxue3K/MFj4kbD0r0BOB6yYDJPoTbK6V8oyOaMlaKUYOjC/+KaE2yQzJVzXerVMnz+GRSE1jepkmA==;5:/bWx1OB0GhvU+LZ1xzSz8TELHDkpaXHcR0/wBtt6eJXKBvDI4SlBv7Frx/bGq9BlLIP7mE4Vpi2WmPi8eV7YWRflVaYaBGS+Lw1IdfXYNhWHKgVU/PBbfLCTOFu/Zx6GNXPJO+jSoqmtmtg/znO8YA==;24:y1xnTXXaeL/02zMVBJ7WUwEnSJq7xZGrU5XdE5MDnjSK85gkQVUn65aYmZEOfieagvS0n1bgJI1SOguHVmqA2Hk4rtrInJQgIV/1aNqYv3E=;7:7LuTIVm35fogtY5XF3xi+i47PRndtRLlkME8bSDJ8Bn76H38nS/7I3SQriXNnGz6AHcr5z9VYRFyM84U5PXitLjORpXt+BcvmTpmO7/aiCfEgNS4r4yHUy1Wx6hzQOxxnU6E4AbBEJAhaGuyi387nx1SYRiMf2BC40pwqFhwxVbQCTS7prienA2hCZLLWgNj4C7o5yFN9iJjZp0Gd5cf5ljAuXaHRH1jdt8dOx2vMLg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:38:59.5426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60188
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
index 205ab2c..25854abc 100644
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
