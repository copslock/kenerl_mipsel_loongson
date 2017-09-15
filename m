Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:34:37 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992036AbdIOReBnnfUM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dpYRUC0M7+5KAdO+wgaYheHl0ICkiu90PyvqTbafDVw=;
 b=VT1zKpIl/UQ1BDMcySgIm3g1MWPrwDw0E656fB1FCkc+Hl+iLU8/ffJHnqHAKqaR/8fbjCGDdSf5jYrT3FmVAsP1E/b/LuKJpJHkZ9F6WatqGTbW3ymmJoy4o2zc5IQzG3H8vrdb1JjjMcWqS/QrL9lZL9Brzdzc0oCT8tHNJ/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:52 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 02/11] MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
Date:   Fri, 15 Sep 2017 12:30:04 -0500
Message-Id: <1505496613-27879-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecdb97a9-5268-4bcc-7d17-08d4fc5feedd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:u7gqRI6JDWd9B6jjKj90AwNso65JvIlNSRpupXxY1i1+2P7LnhuuYbZto53ou8VCrmohtwICkJ3fbaFwC1X8ejzXLiff/ACLqxex0V28XC5FSIG4OiTWDnGwwgmW8ibTvc+6bpNyX+XoRTT9gDY/qQXT9+cX6Drh9z+4efjye2SVbQgIR9h6zGSipoeRrMRtz/CqHwoeGpA8CGhHxmTyux5siFRhrkGi0HCfJIp5yWKOYUqNcQ+uZEoZaT+GkNGI;25:dx5/NXjivvjchNbm45VQwL+ZVt9b/h64t42pDPEOxSnXvvhW1rUk7ixCY9oIZ8ccm9QI4LzD/CGihDT796xMBlo69QrrzUslYqzXGhoNzbV0h5gXctV/f4Iz0VIIhhmFAOyedR46oxNG8bYiEsUO8tUbAr8JtvGQVLKlxW6NLx71enb2aIiZ0k5cg62JIlUIdTL/IfSfEjQQcM3dPn2tSmLLnxx0ZQ08Bil9UnfiH0fH/uuC/caJ3LnI/9RUHl3fxfOgbX3IN4kU08P+64c4+9v2ZJJGJPTJ284V7rfa9f6eiFtPzCMy7Fu0xEnfXGZSOOlMFFfHk342n8kUEBZi5Q==;31:bVycRDT9Z/B4AaMUK8UTFUu4FIw6Smyv6qWDWPaKfzZjZMSfajTzWFvTQIFZ5JAfpcFqfBa3Exc0JStX4J2ySzrFZljFErViphceNS4YjpsWvrtazvM01uSeNeuSjjPjKNLL1cYuakUSbWAk9Daowa1NF8IO+kd6f/DSnukKYvAj1kKtyG8hLskKSua5iYPQ/NKAVc+RMNIOBw5TTPecQZf0eMHfP7MP0avaBB1dil0=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:9hNezRJTYrLFqCPYuLWpf28O2uUR3PoQIuyrjWSsRELucI+Cp5+JziCHy6AoL2MDNoaI7Y3slsZk3VJBEHU2OfcW2MDtCq4DSrl6H9Ksz8UoJcPltU1PH9tnynQ+DxEtTVI4aYkWWvk9UiPdVoxHmt7V4cNFBD9vDem7IL/YcCXOXVmZmavJAIjsMYQO46+6Gen1D4crCPKLERsSfoYI13nER8rc7O8KmLmDR9vgUV/cdUsFuL+FBjwYkzri9hpO8PyvN6djplw0ZJs5+0LMp2pha9PtGCUiwPceGgsoAJw5AshWLROHHRQtyHiLXBIK/bXUPqWNYEXWHJqEFIhl3EWkCQevI3HHrrWjTCTwgOpNYye44LC9GIuvlIvjMV2MC1gBAMv+eV21d5pH1nAT3Q6+ZySNDENrI/qSozpLIqAaH3HqF+ZZd+1guiagAMLqLE5l5kRnJhATOGVubpDr0+C0wvUfZBayXWxk5PAeJ9T4028ELYgcEvgYE1PLUKcL;4:ITJ7P/Y2xLlxRKOuIDkL6yuyV2JKLgZXe5VOmwNhZ6J06hZdGaic/pQSWqwQYdQZb7HYbS65AIKuhMqemSZO+iKRs/WoT4IwByR9PlaVLl9w/0WZ0cHOb9y4AmEDuULPTs2NPsNTd5CIox6AmnSDLKaiyra1Upc47793T7pc6d5NpZTohKWCPUaUW9wKgZDY2QRim0M6qvzY/dpd6dy2yBTKjAS1+gT2vZ3EFwTsV9vasLIyUFfMZeKwvXlZohZ3
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB380024166FDF099C7F20E35E806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:ss/p183SvSysTQkjI7Som7QhU1snAPvcBaFIpZI?=
 =?us-ascii?Q?5YijlFangOsJvlVZrEvkmGlzb+B5Wn4RzdpB2pN3otHXJHP+3sXeAGvQQoRD?=
 =?us-ascii?Q?YnXfTieR0F5TiOPp6XZyN6cfb6ou5xgbXFZTEW1DJvFwluEEquMmjPQospMF?=
 =?us-ascii?Q?gwYEet16Fiv/QdVRzZN9q/F4SWOEq4JrlhOojnema39xaaMTP/HsToNglV6G?=
 =?us-ascii?Q?4M9Ln5LOVrmusecrEAE7tm+C/h5HpwNOW8yPqHyudHYRDTWg+DUCYDKdMySh?=
 =?us-ascii?Q?0rP+/Ava7tNzumIaEC78GjlHKKs44tRlVxh1gQHWKrBDNN0K9TuQjaKHzPf0?=
 =?us-ascii?Q?NwQQLz7/C1EuvxiFkbaNpxwChpazEU/UymWuOeJV9qJEEelKJQxI8M/pwc3m?=
 =?us-ascii?Q?JQJPEmdYZ0eo8Hpjs4iHB+nzPdi47M0rPkkrsfoJC53/AmAxELgaUSTmbHT+?=
 =?us-ascii?Q?6xeN7vQlm826mpk4vVizAOjwzS+5Cl5YQYI+7hJZvn1vwK2aDuubySc4nCH3?=
 =?us-ascii?Q?zaPxPX4uPT8xcMhISCYRGfIsssweG70B+uZwwPNS2GrlfibPsCcjdqXtLZyK?=
 =?us-ascii?Q?leBgvpsY6j3Yf8ir4TVRn5eId/RaJiaJESkwH/zwrDW3HKJ7IoRk35FC7on2?=
 =?us-ascii?Q?O3ZSUbAXvYrBK/qZmMpzpBKWgfHB98Ci4X1U3ABWuCC+gbE5TfrsdhFh/VHq?=
 =?us-ascii?Q?pDCtyFcjTVHp97hci8Tq1ELDYjg1UsWVBCwPRcerO1RzGPYVrvt3KCGFo5sf?=
 =?us-ascii?Q?eI8VWsKMUkwBQgcUXZ5S/Kvr6+P4tqixq5ELf9ho7DjQxoEnoUmumh1z8c3Y?=
 =?us-ascii?Q?SjYAlPstC+6AuP/0081AmFiybarY1znR/AR/tP4Lv7bWVQBPVREBbkCgmeP+?=
 =?us-ascii?Q?9UEIwY0WxWfjDUAZQOPETVYFFivi71onfUnYXwh3vVDTsBjq+f4qtIZ/4xoh?=
 =?us-ascii?Q?EI89C+DqkoUdXz+Wf3ao4CdSwbsc6KbrvK4mdrg2KDd9UtT8lzAxZReMwnQk?=
 =?us-ascii?Q?7BWpZNd6Fpt+rCxDANMAVHyjFVEXQGwqqychnmYG1vLP25s+VR9TnsmVoEZz?=
 =?us-ascii?Q?VZaVt0Q7o0a2LaaJblKw8SF61+k82BEUoJSdLwh4AifwDIw3Cb5Rr2TFxIdd?=
 =?us-ascii?Q?rSSXQgeSlKU1jBVhUkrt3XKVETTKVy2vRBAY1aHSUiE1zWIzTCyTapsA1S9E?=
 =?us-ascii?Q?oNz9sGg3D2T6feKNu5xl+YmErGW631j31sbZFdeDSvtc3NckdLuiDsVtgHw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:4zMXiYQOJVhl78W3u16V1FkeSxBGsJy3MnANRXnf3/s1p6r7xsui/kAELhPm9ndzw69czbc27hQHCibCsat8pYIJjFiMv1H7i4MrCJQfLy/WDOCD+RAM1nSG8HVGInXhVnCfIFbaYx84qNb77A+rA8Ntq1FQZYJzo08EgYZVLA2DhQqBa1ggg7PwwmrehY/2z0b8DuNiM+1yqCkpleGNS5YQCV2SJ0yE85wnAR//NH59cXxDhkpM7MhRdVdNSLZKOvMKY6zE6EVXzjlygv7DlbfliL+oMbwqH8adqSIrNfOI1yiw+5ytX/GWVlN2eAVXMPRfCxQw8hLDiDOx0R7+kw==;5:At+vUBa3nqnf+nJXqCTj1BPb/YLr3iuXQ9x3GvnS79bT8RW649EGuJTXm0ReT5/rVIlL3+9ypNzrh6mcWmDkYHJgVeegUdn2t8DJucUgmUcV7KhNLPFWkZut60Q2WVRbizQ7EbD4Pr3K3KAgvJb9uA==;24:StrJshc0jwwC1nR05bG8uG3uTBRsmOdkMZRCVH4JtbR2cImRdfpY0/dNRMwdxvu6GGpj2hrPK3BZmor+9eoNlMJ92lFl4rcJ+Yv96Zl2o7U=;7:JogimsSW4NP4gEwa0pheCnE6YxP/vV2twUKc6Jd+X4bF/gAPAqkgy/sYD9tLxh9D4KUcfF3gKpAwhl4RQmoBDIhJTep7JeUk4lNsDXazRGQ+BuJanhTPPWszbIt6o376Sgd2254jfzgVGOCIDdWMzkQt/7bMk+nypA5iwXt4elQzxM/j5FNltmJ+fy7ZCd+Y6Aj11YArmLm9JX4MMvfIjCds3LSQ7jUD0/OH6amI6t4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:52.2386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60014
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
index e638735..4c14382 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -30,6 +30,7 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 
 enum cvmx_mips_space {
 	CVMX_MIPS_SPACE_XKSEG = 3LL,
@@ -401,18 +402,6 @@ static inline uint64_t cvmx_get_cycle(void)
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
@@ -453,7 +442,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
 				result = -1;				\
 				break;					\
 			} else						\
-				cvmx_wait(100);				\
+				__delay(100);				\
 		}							\
 	} while (0);							\
 	result;								\
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index ad3584d..3295f74 100644
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
