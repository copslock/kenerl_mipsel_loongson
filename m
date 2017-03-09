Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 15:14:57 +0100 (CET)
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:19547
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991976AbdCIOOdWnxtT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 15:14:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DZUVfQQfI+/8hjKALZg2K7WI/ofLmrECmeiMFhfKVmY=;
 b=E2VaJPTThAaPXBpj0D5M0lxl5t8KD6azVat5dhxwkn8KTor/+3hbqWjOC+XLRX5nqIMV4wcip02ht+npc+V2WkIAViaElq7PjW7a9pV64nIKizrUxMKrpIE7cilf6YtkbFoEJanOJI3zYpTYuwcTzDHd5/aAqv/l0iZ5WSGXiG8=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from white.inter.net (173.22.239.243) by
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 9 Mar 2017 14:14:22 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Remove unused L2C types and macros.
Date:   Thu,  9 Mar 2017 08:14:15 -0600
Message-Id: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: SN1PR0701CA0040.namprd07.prod.outlook.com (10.162.96.50) To
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149)
X-MS-Office365-Filtering-Correlation-Id: d18f8159-58a7-43ea-c98e-08d466f695ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;3:8PNKG+xWJGkbOBFmNPggSdvsvTd4p05sVP/Iplh2zqkQrFu22vqQ3j+xvb6lCGzoXU2msS4Z0b9dV/oSj9dzblEeQhhc+gS9HjRe4hUftOcOkW4S8LABSiZVZ8hB4XYzSuq1UvE1j4TgO60K3rrTV01etc44JpLnHaC+1AmUaFltNUy1QI472SOvx2V95svLLnk1SgypnyedSKpyrwF1Wqx7JmKzHP5xBgruhWjIs/uISlU8kQDZFjkSyJvdzcnuot8zE1RSOfGxxQMiGMnnxQ==;25:RDWdNkSJ/m73Mp43FlAgCafhXUKryQXrKwmaym3cC6YOR20jt9rki3efPQJ1pdFsMewGf5F6jd3Oqaz67o+WCUFACpLN6LXZH+eau2qRQCw+RLfqwdH51Fh2fg5PJMy497rKlRwbPyKaQKSorrTnfkeKlOp7Ck8PfoI9z/PoIuneSfdg4GrLPs5pxPNergkszDQgh+vqnU182rX5fkrLKym+82Z166Sm3Ld8Ukpy1yt+tNPhcw0TdzhJBwRoxvS75aJBasf1BONwmPmDeJYBveG4Z+tfYMvpi0ixCD3DDcbvQuMqHYMcUkE7cgRnekomneyGjUSuluDYa2O2tcZP7PnKm4iJj+bgx5xJGkJQu1/4DKeq7nxU80GuIh8d/24qu9Z9/6lOxCbZR+mu9uuz65/bRBTdAyixFmZk64gxoZV3FiSVJsoFVSS2BZpfBihedqlraOY4ZjtHkiXX9TV9WA==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;31:KE8RMSZ5UlRIawT2vX9QQ/dmxMAiJ5PWcW4EpEv7wbMkZUhb5g4I7kgWmCGx3R99G4nuCi2/BSAInz0/PzFjOENIHgH7jcqDjJU11vIT2If2K8BYCzs5PBkrO8YL2z9YhuxryhlBcRdYhQMfLZgLZZKOSAylaewIH2oEkz66AWjLsUIPqwrQRuIhf8ODXBKdhuwmd9ZdUGhoWXQX1fXBoH7rJumeZbAoDZtHrfhSQf3PItw2bZWjfFgY+Idv3zyhoYSGlPviYLoaBauF2lwK+Q==;20:awa8Pnrnec7znIZ3mGC2nWfE8o4WksCYjTlvArUn0eFZQE6kFVIfh+GXhaGzNc+h8ty7yed7c5+2dk+VnVDUtXz8GLBbgn61GGqYnjQxjowqGkgVAZTbe+PjqreCfQ06BiwJ24O3r2SRmfY1ZuNuwTKjJHFVsSeA989l8cczcKhqxiFWP1sFkALdL1J33wFCfLkEK9st6QwbESPJSL788qwxdOM8ZF3kWFr+/nN9Vd2E41KhRX2xmlWJTVCj27ZiTMdiOMJRobIL7A1But3CQ1aA2EWZ4BEHTy4m4AoTlnyw4H6CerYYKTY6b6+0tb7Oe0UcAozO5lmy83r5k/MZSJylnk6/XBvY1+ZOsKrVMRLlPTE/+92hpJbVDc5YkM83EwHPTyGc1bGTuSfT4mFzVtN/T/BrTHy7CoAHVCKob8JNu2SCrFtcYeZHo4e83k4Z0qL+KRUHKHEMKoln3TSIKT2r94l+tsn23VnQNFs3HT1ES8KY++8n2emnQjKR+1C/
X-Microsoft-Antispam-PRVS: <BN6PR07MB320345833BC933F4F7950ACE80210@BN6PR07MB3203.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123558025)(20161123555025)(20161123564025)(20161123562025)(20161123560025)(6072148);SRVR:BN6PR07MB3203;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;4:5Z0MD4TQ1VcB+lFws5AX1R3S92VeeHxGk8I2Clwbz2JRCfisdhFgR67JVDdwhysvhZbfKSfMY2uG+56TBHp7w+owpzOtzMP+1ZPyd/Tcy4mHjdZOkp+DSgiCtw0dPwGPqHHfmZLdluzznzJrrnVunwlp66Jyg+R9TlZtlaawYP7VHa1lb55Cj/rNhzLhR4WfNJKC+zQf4qnnukf8YmrMnaxusbeYIi0ipfudGlSPn+r+kiatTxK16VkOmS04XsPIebgm2HN2zl8D0F+XCpoleJkmuncAEApC8AHyiZlN+9CVrMctXtFifXhn8C29PqrYv/Vm6ZQOKdu770mDd05w4tVCUAbyiAiHUxF6HngVq0OJCKOudnW6fxoiwjEvoaUJBBLKS83Tm0wgRHFSgclx46Bqjr8bCUlon4+AOZGzry9aS1ZH+EdV09v7h/mAWNZd54RHVGQgcWMqQx2atT8+60V2+EHhuJjoMFJQWstCtnO4Cjw5sBlewWit51reyeg1DLxr/RJhmQgBQDe1IH/nD/w0riVDSN+FccOqZ5DQMTwGHhGq9LUmGTGxI5exbzEPgZN0JWGZ5Ev3K25+HF+qatU479vwfVIIprPVvQLJsLQ0vmd8R2D6uWJOW7vkWi6NZ+CqjPxoTMUapfFcYgRnDA6eYUweV1ioXwl7Vr2E9wh9ipCDOQOHddNNxyfoAsHG
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(3846002)(575784001)(6116002)(2351001)(33646002)(47776003)(50466002)(6916009)(7736002)(48376002)(66066001)(36756003)(189998001)(2361001)(53416004)(81166006)(966004)(86362001)(6666003)(305945005)(6486002)(42186005)(38730400002)(53946003)(4326008)(5660300001)(53936002)(50226002)(50986999)(2906002)(25786008)(450100002)(110136004)(6506006)(8676002)(6306002)(5003940100001)(6512007)(2004002)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3203;H:white.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB3203;23:FHUiwB/HnIYuCU5cIMpuZ9eOwfXrCGyTXUwa/Sgs5?=
 =?us-ascii?Q?5KHZmSxMKgS4UR8PcZJUsXKTkrjhoKe8dnxpIPhfuHtWX1iAe6cbTbP37SmD?=
 =?us-ascii?Q?2JTkfyqyeDiZkPnH0FuBc5IdVLLLZW8yZsmxAsNd7/P8cDSEongcwf438fHJ?=
 =?us-ascii?Q?GHRuuBuYjqB5fXETnlIo8x8a115naJ40+Xqvas4EIdjZNonkSMz/EWFWLpzU?=
 =?us-ascii?Q?uWfdHEop4KMZSlNyMKAAAHA0UzYXpSK+q2N0EVOyKD3OO/ptYzPv3DqjnV7a?=
 =?us-ascii?Q?117SzWJftmt68pspTKYG0wQKOXzVCyS+qrt5n6fkgTlx9KWwtGPxxzfaIklI?=
 =?us-ascii?Q?/OxNtpxu8Zrl5Fv7ny/z9LP+Z5y2v2/J5sT6J7BFBNI6yF6xcVmcmr7HU6kU?=
 =?us-ascii?Q?0mQ5tV3X8I7QLdPfl//E3GpLq++NLWivPUU2R9dRM1sft6X+TIDiLF6Y1Ob2?=
 =?us-ascii?Q?l/ER2EE8nfiW9EJoGfVGq3NkUwpxlKw4FS9N/vN411qbQccJWWXVCBcLRCiC?=
 =?us-ascii?Q?oyCaF5B/jmuukaIlaGBK7j6mSWn18rexCHD/vD7oV3dvlyjgPwXacwIFwp8y?=
 =?us-ascii?Q?gJ8A2lXvD/nW0Gq1VgDdsg+1KyK0DFiOXsPOhiBLIHyng5mswMeq9RaDmaiX?=
 =?us-ascii?Q?4E6IzM1EcbKCf6aisg/NSb9PXs37SDiXXeJ46OQYYmHhADgVOr46pvkWT7bw?=
 =?us-ascii?Q?ARjIhNfV4OGFcEl6pMW8wVaHzyu4avjScUh4yyv8gu/1PmIym8rQS5C7r/Ac?=
 =?us-ascii?Q?AFO/yFpnEYOv/OOkSxKzbrC/ZUlvZ2HT48A40BOt88eMkRTl3lACcY/vkesL?=
 =?us-ascii?Q?wi2ZB5A2vxh49nDVDpb6gqwP7mo52Tloj93Zi95F3dxQ7ITA8bV0Sv0uSerU?=
 =?us-ascii?Q?rP+NqpMubWjnkCksXHJLIqbJvFm7BP4s0PFb1/uEL2t6tmpTsee/Yzx5g5Xt?=
 =?us-ascii?Q?sJJUFIYKrIhfU4maR5aPQfMYyayH5Ol9m8XQIdxAuJUDw9dt7sbS7vhea0tw?=
 =?us-ascii?Q?59+E6omlpXAIOgvgWyDjVyb7t0KTKD/bDDK1bFGSwq7OAqGn6BNZWysW1RXo?=
 =?us-ascii?Q?ilUrwc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;6:CV2SxuZzxBE6o9cahOkrr2Ews6KJMt+qmo/CGn7olHy5FjSxnMGQQoscLzfz8tC5F82r1nLAVJWvhAVm+v6LvKSoWy3DFXwlDA0qu/tCI/nT8b2xSawWEj8hWYWL/DreTSxvs9vxqXGhGVqLiRzWALk0Jyk0ePNcBzsRAM4BZ5+RlvHAeHU5Uw3qumZgqmtt52qPiOWVN2ZeAnWVVpiOdwg5mavwUi6ErCKMHKUUsu1PChqEmn8rHSWMpKKnQ+G7CD5zo0I2mRSFETmo9rAnjn8F+7xwZxp1tn4gQJStj+VwwiEBBtABsGBZAhAKPwUf016ZQObQnhGYvULqIeR8exh//7F2gd6sCi3jnOzS2nYbUDSsAWjAR+WmOiikhAo3FXPCxbsfTedtjgDLXy7d7Q==;5:bj5UYiJAiAWwUEbrS655fGeuLRkQ4A+R/ZMyqEZeaHrHQrSj0vplwao1qkb9qTqxPFbb3gtzgxBYtPakCNoWBQf0AKidJdBOGTbqcRYpfyJCoKedrUric3i8zNBzGn7oqaJJhUFyNR3LQb6TqYju9Q==;24:OCDfsNqEJggHc5NZdjqX5pnmWt6b5IF/z/AP5srI6H6td25/uv2q1mGGghnJcKmBXfdYVwaXpmL5HoerEsc5fCotf/Umwi6s+iImGTNXHm8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;7:22O/L0F9FNsGBP34oDjtB57aomKV9lEFPG6j2vkM4fdW10zRES8aL6JNtrUvm4KmcNpbJwXrG0W6LnSmDCbI7zc6VgoRlAfh54YccVxDxSW08P5jRQdjxNXm1jEcfH3hGKbJtC/mhuObUfi5jqCVI+MeYhqwrC5BEov5p9L0kMCRpSH9I8yobQyQhud88924RVb4zhzzqaqypDV5XLzj664iAyegrFtDfOTwaNhO7JMt+Z9/q2Pql+ZBV7S3Col482NGE4GQ1pdvFNPTnm2/56MjHtnuhY2Qq5RqnGdy4uydZSkTNpJatlUWSa6PGPtKCyKcmHTlcbWSLZlovqyLgw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2017 14:14:22.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3203
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57093
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

Remove all unused bitfields and macros. Convert the remaining
bitfields to use __BITFIELD_FIELD instead of #ifdef.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-l2c.c     |  139 +-
 arch/mips/cavium-octeon/executive/octeon-model.c |   21 +-
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h     | 3191 +---------------------
 arch/mips/include/asm/octeon/cvmx-l2c.h          |   59 +-
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h     |  526 ----
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h     |  284 +-
 arch/mips/include/asm/octeon/cvmx.h              |    3 +-
 7 files changed, 300 insertions(+), 3923 deletions(-)
 delete mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h

diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
index 89b5273..f091c9b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -239,6 +239,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 		else {
 			uint64_t counter = 0;
 			int tad;
+
 			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
 				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC0(tad));
 			return counter;
@@ -249,6 +250,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 		else {
 			uint64_t counter = 0;
 			int tad;
+
 			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
 				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC1(tad));
 			return counter;
@@ -259,6 +261,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 		else {
 			uint64_t counter = 0;
 			int tad;
+
 			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
 				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC2(tad));
 			return counter;
@@ -270,6 +273,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 		else {
 			uint64_t counter = 0;
 			int tad;
+
 			for (tad = 0; tad < CVMX_L2C_TADS; tad++)
 				counter += cvmx_read_csr(CVMX_L2C_TADX_PFC3(tad));
 			return counter;
@@ -301,7 +305,7 @@ static void fault_in(uint64_t addr, int len)
 	 */
 	CVMX_DCACHE_INVALIDATE;
 	while (len > 0) {
-		ACCESS_ONCE(*ptr);
+		READ_ONCE(*ptr);
 		len -= CVMX_CACHE_LINE_SIZE;
 		ptr += CVMX_CACHE_LINE_SIZE;
 	}
@@ -375,7 +379,9 @@ int cvmx_l2c_lock_line(uint64_t addr)
 		if (((union cvmx_l2c_cfg)(cvmx_read_csr(CVMX_L2C_CFG))).s.idxalias) {
 			int alias_shift = CVMX_L2C_IDX_ADDR_SHIFT + 2 * CVMX_L2_SET_BITS - 1;
 			uint64_t addr_tmp = addr ^ (addr & ((1 << alias_shift) - 1)) >> CVMX_L2_SET_BITS;
+
 			lckbase.s.lck_base = addr_tmp >> 7;
+
 		} else {
 			lckbase.s.lck_base = addr >> 7;
 		}
@@ -435,6 +441,7 @@ void cvmx_l2c_flush(void)
 		/* These may look like constants, but they aren't... */
 		int assoc_shift = CVMX_L2C_TAG_ADDR_ALIAS_SHIFT;
 		int set_shift = CVMX_L2C_IDX_ADDR_SHIFT;
+
 		for (set = 0; set < n_set; set++) {
 			for (assoc = 0; assoc < n_assoc; assoc++) {
 				address = CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
@@ -519,89 +526,49 @@ int cvmx_l2c_unlock_mem_region(uint64_t start, uint64_t len)
 union __cvmx_l2c_tag {
 	uint64_t u64;
 	struct cvmx_l2c_tag_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:40;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:20;	/* Phys mem addr (33..14) */
-#else
-		uint64_t addr:20;	/* Phys mem addr (33..14) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:40;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:40,
+		__BITFIELD_FIELD(uint64_t V:1,		/* Line valid */
+		__BITFIELD_FIELD(uint64_t D:1,		/* Line dirty */
+		__BITFIELD_FIELD(uint64_t L:1,		/* Line locked */
+		__BITFIELD_FIELD(uint64_t U:1,		/* Use, LRU eviction */
+		__BITFIELD_FIELD(uint64_t addr:20,	/* Phys addr (33..14) */
+		;))))))
 	} cn50xx;
 	struct cvmx_l2c_tag_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:41;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:19;	/* Phys mem addr (33..15) */
-#else
-		uint64_t addr:19;	/* Phys mem addr (33..15) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:41;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:41,
+		__BITFIELD_FIELD(uint64_t V:1,		/* Line valid */
+		__BITFIELD_FIELD(uint64_t D:1,		/* Line dirty */
+		__BITFIELD_FIELD(uint64_t L:1,		/* Line locked */
+		__BITFIELD_FIELD(uint64_t U:1,		/* Use, LRU eviction */
+		__BITFIELD_FIELD(uint64_t addr:19,	/* Phys addr (33..15) */
+		;))))))
 	} cn30xx;
 	struct cvmx_l2c_tag_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:42;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:18;	/* Phys mem addr (33..16) */
-#else
-		uint64_t addr:18;	/* Phys mem addr (33..16) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:42;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:42,
+		__BITFIELD_FIELD(uint64_t V:1,		/* Line valid */
+		__BITFIELD_FIELD(uint64_t D:1,		/* Line dirty */
+		__BITFIELD_FIELD(uint64_t L:1,		/* Line locked */
+		__BITFIELD_FIELD(uint64_t U:1,		/* Use, LRU eviction */
+		__BITFIELD_FIELD(uint64_t addr:18,	/* Phys addr (33..16) */
+		;))))))
 	} cn31xx;
 	struct cvmx_l2c_tag_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:43;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:17;	/* Phys mem addr (33..17) */
-#else
-		uint64_t addr:17;	/* Phys mem addr (33..17) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:43;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:43,
+		__BITFIELD_FIELD(uint64_t V:1,		/* Line valid */
+		__BITFIELD_FIELD(uint64_t D:1,		/* Line dirty */
+		__BITFIELD_FIELD(uint64_t L:1,		/* Line locked */
+		__BITFIELD_FIELD(uint64_t U:1,		/* Use, LRU eviction */
+		__BITFIELD_FIELD(uint64_t addr:17,	/* Phys addr (33..17) */
+		;))))))
 	} cn38xx;
 	struct cvmx_l2c_tag_cn58xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:44;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:16;	/* Phys mem addr (33..18) */
-#else
-		uint64_t addr:16;	/* Phys mem addr (33..18) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:44;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:44,
+		__BITFIELD_FIELD(uint64_t V:1,		/* Line valid */
+		__BITFIELD_FIELD(uint64_t D:1,		/* Line dirty */
+		__BITFIELD_FIELD(uint64_t L:1,		/* Line locked */
+		__BITFIELD_FIELD(uint64_t U:1,		/* Use, LRU eviction */
+		__BITFIELD_FIELD(uint64_t addr:16,	/* Phys addr (33..18) */
+		;))))))
 	} cn58xx;
 	struct cvmx_l2c_tag_cn58xx cn56xx;	/* 2048 sets */
 	struct cvmx_l2c_tag_cn31xx cn52xx;	/* 512 sets */
@@ -629,8 +596,8 @@ static union __cvmx_l2c_tag __read_l2_tag(uint64_t assoc, uint64_t index)
 	union __cvmx_l2c_tag tag_val;
 	uint64_t dbg_addr = CVMX_L2C_DBG;
 	unsigned long flags;
-
 	union cvmx_l2c_dbg debug_val;
+
 	debug_val.u64 = 0;
 	/*
 	 * For low core count parts, the core number is always small
@@ -683,8 +650,8 @@ static union __cvmx_l2c_tag __read_l2_tag(uint64_t assoc, uint64_t index)
 union cvmx_l2c_tag cvmx_l2c_get_tag(uint32_t association, uint32_t index)
 {
 	union cvmx_l2c_tag tag;
-	tag.u64 = 0;
 
+	tag.u64 = 0;
 	if ((int)association >= cvmx_l2c_get_num_assoc()) {
 		cvmx_dprintf("ERROR: cvmx_l2c_get_tag association out of range\n");
 		return tag;
@@ -767,10 +734,12 @@ uint32_t cvmx_l2c_address_to_index(uint64_t addr)
 
 	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
 		union cvmx_l2c_ctl l2c_ctl;
+
 		l2c_ctl.u64 = cvmx_read_csr(CVMX_L2C_CTL);
 		indxalias = !l2c_ctl.s.disidxalias;
 	} else {
 		union cvmx_l2c_cfg l2c_cfg;
+
 		l2c_cfg.u64 = cvmx_read_csr(CVMX_L2C_CFG);
 		indxalias = l2c_cfg.s.idxalias;
 	}
@@ -778,6 +747,7 @@ uint32_t cvmx_l2c_address_to_index(uint64_t addr)
 	if (indxalias) {
 		if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
 			uint32_t a_14_12 = (idx / (CVMX_L2C_MEMBANK_SELECT_SIZE/(1<<CVMX_L2C_IDX_ADDR_SHIFT))) & 0x7;
+
 			idx ^= idx / cvmx_l2c_get_num_sets();
 			idx ^= a_14_12;
 		} else {
@@ -801,6 +771,7 @@ int cvmx_l2c_get_cache_size_bytes(void)
 int cvmx_l2c_get_set_bits(void)
 {
 	int l2_set_bits;
+
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
 		l2_set_bits = 11;	/* 2048 sets */
 	else if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN63XX))
@@ -828,6 +799,7 @@ int cvmx_l2c_get_num_sets(void)
 int cvmx_l2c_get_num_assoc(void)
 {
 	int l2_assoc;
+
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) ||
 	    OCTEON_IS_MODEL(OCTEON_CN52XX) ||
 	    OCTEON_IS_MODEL(OCTEON_CN58XX) ||
@@ -869,16 +841,17 @@ int cvmx_l2c_get_num_assoc(void)
 		else if (mio_fus_dat3.s.l2c_crip == 1)
 			l2_assoc = 12;
 	} else {
-		union cvmx_l2d_fus3 val;
-		val.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
+		uint64_t l2d_fus3;
+
+		l2d_fus3 = cvmx_read_csr(CVMX_L2D_FUS3);
 		/*
 		 * Using shifts here, as bit position names are
 		 * different for each model but they all mean the
 		 * same.
 		 */
-		if ((val.u64 >> 35) & 0x1)
+		if ((l2d_fus3 >> 35) & 0x1)
 			l2_assoc = l2_assoc >> 2;
-		else if ((val.u64 >> 34) & 0x1)
+		else if ((l2d_fus3 >> 34) & 0x1)
 			l2_assoc = l2_assoc >> 1;
 	}
 	return l2_assoc;
diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index d08a2bc..3410523 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -63,16 +63,15 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	char pass[4];
 	int clock_mhz;
 	const char *suffix;
-	union cvmx_l2d_fus3 fus3;
 	int num_cores;
 	union cvmx_mio_fus_dat2 fus_dat2;
 	union cvmx_mio_fus_dat3 fus_dat3;
 	char fuse_model[10];
 	uint32_t fuse_data = 0;
+	uint64_t l2d_fus3 = 0;
 
-	fus3.u64 = 0;
 	if (OCTEON_IS_MODEL(OCTEON_CN3XXX) || OCTEON_IS_MODEL(OCTEON_CN5XXX))
-		fus3.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
+		l2d_fus3 = (cvmx_read_csr(CVMX_L2D_FUS3) >> 34) & 0x3;
 	fus_dat2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
 	fus_dat3.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT3);
 	num_cores = cvmx_octeon_num_cores();
@@ -192,7 +191,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	/* Now figure out the family, the first two digits */
 	switch ((chip_id >> 8) & 0xff) {
 	case 0:		/* CN38XX, CN37XX or CN36XX */
-		if (fus3.cn38xx.crip_512k) {
+		if (l2d_fus3) {
 			/*
 			 * For some unknown reason, the 16 core one is
 			 * called 37 instead of 36.
@@ -223,7 +222,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		}
 		break;
 	case 1:		/* CN31XX or CN3020 */
-		if ((chip_id & 0x10) || fus3.cn31xx.crip_128k)
+		if ((chip_id & 0x10) || l2d_fus3)
 			family = "30";
 		else
 			family = "31";
@@ -246,7 +245,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	case 2:		/* CN3010 or CN3005 */
 		family = "30";
 		/* A chip with half cache is an 05 */
-		if (fus3.cn30xx.crip_64k)
+		if (l2d_fus3)
 			core_model = "05";
 		/*
 		 * This series of chips didn't follow the standard
@@ -267,7 +266,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	case 3:		/* CN58XX */
 		family = "58";
 		/* Special case. 4 core, half cache (CP with half cache) */
-		if ((num_cores == 4) && fus3.cn58xx.crip_1024k && !strncmp(suffix, "CP", 2))
+		if ((num_cores == 4) && l2d_fus3 && !strncmp(suffix, "CP", 2))
 			core_model = "29";
 
 		/* Pass 1 uses different encodings for pass numbers */
@@ -290,7 +289,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		break;
 	case 4:		/* CN57XX, CN56XX, CN55XX, CN54XX */
 		if (fus_dat2.cn56xx.raid_en) {
-			if (fus3.cn56xx.crip_1024k)
+			if (l2d_fus3)
 				family = "55";
 			else
 				family = "57";
@@ -309,7 +308,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 				if (fus_dat3.cn56xx.bar2_en)
 					suffix = "NSPB2";
 			}
-			if (fus3.cn56xx.crip_1024k)
+			if (l2d_fus3)
 				family = "54";
 			else
 				family = "56";
@@ -319,7 +318,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		family = "50";
 		break;
 	case 7:		/* CN52XX */
-		if (fus3.cn52xx.crip_256k)
+		if (l2d_fus3)
 			family = "51";
 		else
 			family = "52";
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
index 10262cb..9346798 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,3140 +28,175 @@
 #ifndef __CVMX_L2C_DEFS_H__
 #define __CVMX_L2C_DEFS_H__
 
-#define CVMX_L2C_BIG_CTL (CVMX_ADD_IO_SEG(0x0001180080800030ull))
-#define CVMX_L2C_BST (CVMX_ADD_IO_SEG(0x00011800808007F8ull))
-#define CVMX_L2C_BST0 (CVMX_ADD_IO_SEG(0x00011800800007F8ull))
-#define CVMX_L2C_BST1 (CVMX_ADD_IO_SEG(0x00011800800007F0ull))
-#define CVMX_L2C_BST2 (CVMX_ADD_IO_SEG(0x00011800800007E8ull))
-#define CVMX_L2C_BST_MEMX(block_id) (CVMX_ADD_IO_SEG(0x0001180080C007F8ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_BST_TDTX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007F0ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_BST_TTGX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007F8ull) + ((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
 #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
-#define CVMX_L2C_COP0_MAPX(offset) (CVMX_ADD_IO_SEG(0x0001180080940000ull) + ((offset) & 16383) * 8)
 #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
-#define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
-#define CVMX_L2C_DUT (CVMX_ADD_IO_SEG(0x0001180080000050ull))
-#define CVMX_L2C_DUT_MAPX(offset) (CVMX_ADD_IO_SEG(0x0001180080E00000ull) + ((offset) & 8191) * 8)
-#define CVMX_L2C_ERR_TDTX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_ERR_TTGX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_ERR_VBFX(block_id) (CVMX_ADD_IO_SEG(0x0001180080C007F0ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_ERR_XMC (CVMX_ADD_IO_SEG(0x00011800808007D8ull))
-#define CVMX_L2C_GRPWRR0 (CVMX_ADD_IO_SEG(0x00011800800000C8ull))
-#define CVMX_L2C_GRPWRR1 (CVMX_ADD_IO_SEG(0x00011800800000D0ull))
-#define CVMX_L2C_INT_EN (CVMX_ADD_IO_SEG(0x0001180080000100ull))
-#define CVMX_L2C_INT_ENA (CVMX_ADD_IO_SEG(0x0001180080800020ull))
-#define CVMX_L2C_INT_REG (CVMX_ADD_IO_SEG(0x0001180080800018ull))
-#define CVMX_L2C_INT_STAT (CVMX_ADD_IO_SEG(0x00011800800000F8ull))
-#define CVMX_L2C_IOCX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800420ull))
-#define CVMX_L2C_IORX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800428ull))
 #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
 #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
-#define CVMX_L2C_LFB0 (CVMX_ADD_IO_SEG(0x0001180080000038ull))
-#define CVMX_L2C_LFB1 (CVMX_ADD_IO_SEG(0x0001180080000040ull))
-#define CVMX_L2C_LFB2 (CVMX_ADD_IO_SEG(0x0001180080000048ull))
-#define CVMX_L2C_LFB3 (CVMX_ADD_IO_SEG(0x00011800800000B8ull))
-#define CVMX_L2C_OOB (CVMX_ADD_IO_SEG(0x00011800800000D8ull))
-#define CVMX_L2C_OOB1 (CVMX_ADD_IO_SEG(0x00011800800000E0ull))
-#define CVMX_L2C_OOB2 (CVMX_ADD_IO_SEG(0x00011800800000E8ull))
-#define CVMX_L2C_OOB3 (CVMX_ADD_IO_SEG(0x00011800800000F0ull))
+#define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
+#define CVMX_L2C_PFCX(offset) (CVMX_ADD_IO_SEG(0x0001180080000098ull) +	       \
+		((offset) & 3) * 8)
 #define CVMX_L2C_PFC0 CVMX_L2C_PFCX(0)
 #define CVMX_L2C_PFC1 CVMX_L2C_PFCX(1)
 #define CVMX_L2C_PFC2 CVMX_L2C_PFCX(2)
 #define CVMX_L2C_PFC3 CVMX_L2C_PFCX(3)
-#define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
-#define CVMX_L2C_PFCX(offset) (CVMX_ADD_IO_SEG(0x0001180080000098ull) + ((offset) & 3) * 8)
-#define CVMX_L2C_PPGRP (CVMX_ADD_IO_SEG(0x00011800800000C0ull))
-#define CVMX_L2C_QOS_IOBX(offset) (CVMX_ADD_IO_SEG(0x0001180080880200ull) + ((offset) & 1) * 8)
-#define CVMX_L2C_QOS_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080880000ull) + ((offset) & 31) * 8)
-#define CVMX_L2C_QOS_WGT (CVMX_ADD_IO_SEG(0x0001180080800008ull))
-#define CVMX_L2C_RSCX_PFC(offset) (CVMX_ADD_IO_SEG(0x0001180080800410ull) + ((offset) & 3) * 64)
-#define CVMX_L2C_RSDX_PFC(offset) (CVMX_ADD_IO_SEG(0x0001180080800418ull) + ((offset) & 3) * 64)
 #define CVMX_L2C_SPAR0 (CVMX_ADD_IO_SEG(0x0001180080000068ull))
 #define CVMX_L2C_SPAR1 (CVMX_ADD_IO_SEG(0x0001180080000070ull))
 #define CVMX_L2C_SPAR2 (CVMX_ADD_IO_SEG(0x0001180080000078ull))
 #define CVMX_L2C_SPAR3 (CVMX_ADD_IO_SEG(0x0001180080000080ull))
 #define CVMX_L2C_SPAR4 (CVMX_ADD_IO_SEG(0x0001180080000088ull))
-#define CVMX_L2C_TADX_ECC0(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00018ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_ECC1(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00020ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_IEN(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00000ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_INT(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00028ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_PFC0(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00400ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_PFC1(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00408ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_PFC2(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00410ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_PFC3(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00418ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_PRF(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00008ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_TADX_TAG(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00010ull) + ((block_id) & 3) * 0x40000ull)
-#define CVMX_L2C_VER_ID (CVMX_ADD_IO_SEG(0x00011800808007E0ull))
-#define CVMX_L2C_VER_IOB (CVMX_ADD_IO_SEG(0x00011800808007F0ull))
-#define CVMX_L2C_VER_MSC (CVMX_ADD_IO_SEG(0x00011800808007D0ull))
-#define CVMX_L2C_VER_PP (CVMX_ADD_IO_SEG(0x00011800808007E8ull))
-#define CVMX_L2C_VIRTID_IOBX(offset) (CVMX_ADD_IO_SEG(0x00011800808C0200ull) + ((offset) & 1) * 8)
-#define CVMX_L2C_VIRTID_PPX(offset) (CVMX_ADD_IO_SEG(0x00011800808C0000ull) + ((offset) & 31) * 8)
-#define CVMX_L2C_VRT_CTL (CVMX_ADD_IO_SEG(0x0001180080800010ull))
-#define CVMX_L2C_VRT_MEMX(offset) (CVMX_ADD_IO_SEG(0x0001180080900000ull) + ((offset) & 1023) * 8)
-#define CVMX_L2C_WPAR_IOBX(offset) (CVMX_ADD_IO_SEG(0x0001180080840200ull) + ((offset) & 1) * 8)
-#define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull) + ((offset) & 31) * 8)
-#define CVMX_L2C_XMCX_PFC(offset) (CVMX_ADD_IO_SEG(0x0001180080800400ull) + ((offset) & 3) * 64)
-#define CVMX_L2C_XMC_CMD (CVMX_ADD_IO_SEG(0x0001180080800028ull))
-#define CVMX_L2C_XMDX_PFC(offset) (CVMX_ADD_IO_SEG(0x0001180080800408ull) + ((offset) & 3) * 64)
-
-union cvmx_l2c_big_ctl {
-	uint64_t u64;
-	struct cvmx_l2c_big_ctl_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_8_63:56;
-		uint64_t maxdram:4;
-		uint64_t reserved_1_3:3;
-		uint64_t disable:1;
-#else
-		uint64_t disable:1;
-		uint64_t reserved_1_3:3;
-		uint64_t maxdram:4;
-		uint64_t reserved_8_63:56;
-#endif
-	} s;
-	struct cvmx_l2c_big_ctl_s cn61xx;
-	struct cvmx_l2c_big_ctl_s cn63xx;
-	struct cvmx_l2c_big_ctl_s cn66xx;
-	struct cvmx_l2c_big_ctl_s cn68xx;
-	struct cvmx_l2c_big_ctl_s cn68xxp1;
-	struct cvmx_l2c_big_ctl_s cnf71xx;
-};
-
-union cvmx_l2c_bst {
-	uint64_t u64;
-	struct cvmx_l2c_bst_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dutfl:32;
-		uint64_t rbffl:4;
-		uint64_t xbffl:4;
-		uint64_t tdpfl:4;
-		uint64_t ioccmdfl:4;
-		uint64_t iocdatfl:4;
-		uint64_t dutresfl:4;
-		uint64_t vrtfl:4;
-		uint64_t tdffl:4;
-#else
-		uint64_t tdffl:4;
-		uint64_t vrtfl:4;
-		uint64_t dutresfl:4;
-		uint64_t iocdatfl:4;
-		uint64_t ioccmdfl:4;
-		uint64_t tdpfl:4;
-		uint64_t xbffl:4;
-		uint64_t rbffl:4;
-		uint64_t dutfl:32;
-#endif
-	} s;
-	struct cvmx_l2c_bst_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_36_63:28;
-		uint64_t dutfl:4;
-		uint64_t reserved_17_31:15;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t tdffl:1;
-#else
-		uint64_t tdffl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_17_31:15;
-		uint64_t dutfl:4;
-		uint64_t reserved_36_63:28;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_bst_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_38_63:26;
-		uint64_t dutfl:6;
-		uint64_t reserved_17_31:15;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t tdffl:1;
-#else
-		uint64_t tdffl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_17_31:15;
-		uint64_t dutfl:6;
-		uint64_t reserved_38_63:26;
-#endif
-	} cn63xx;
-	struct cvmx_l2c_bst_cn63xx cn63xxp1;
-	struct cvmx_l2c_bst_cn66xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_42_63:22;
-		uint64_t dutfl:10;
-		uint64_t reserved_17_31:15;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t tdffl:1;
-#else
-		uint64_t tdffl:1;
-		uint64_t reserved_1_3:3;
-		uint64_t vrtfl:1;
-		uint64_t reserved_5_7:3;
-		uint64_t dutresfl:1;
-		uint64_t reserved_9_11:3;
-		uint64_t iocdatfl:1;
-		uint64_t reserved_13_15:3;
-		uint64_t ioccmdfl:1;
-		uint64_t reserved_17_31:15;
-		uint64_t dutfl:10;
-		uint64_t reserved_42_63:22;
-#endif
-	} cn66xx;
-	struct cvmx_l2c_bst_s cn68xx;
-	struct cvmx_l2c_bst_s cn68xxp1;
-	struct cvmx_l2c_bst_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_bst0 {
-	uint64_t u64;
-	struct cvmx_l2c_bst0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t dtbnk:1;
-		uint64_t wlb_msk:4;
-		uint64_t dtcnt:13;
-		uint64_t dt:1;
-		uint64_t stin_msk:1;
-		uint64_t wlb_dat:4;
-#else
-		uint64_t wlb_dat:4;
-		uint64_t stin_msk:1;
-		uint64_t dt:1;
-		uint64_t dtcnt:13;
-		uint64_t wlb_msk:4;
-		uint64_t dtbnk:1;
-		uint64_t reserved_24_63:40;
-#endif
-	} s;
-	struct cvmx_l2c_bst0_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_23_63:41;
-		uint64_t wlb_msk:4;
-		uint64_t reserved_15_18:4;
-		uint64_t dtcnt:9;
-		uint64_t dt:1;
-		uint64_t reserved_4_4:1;
-		uint64_t wlb_dat:4;
-#else
-		uint64_t wlb_dat:4;
-		uint64_t reserved_4_4:1;
-		uint64_t dt:1;
-		uint64_t dtcnt:9;
-		uint64_t reserved_15_18:4;
-		uint64_t wlb_msk:4;
-		uint64_t reserved_23_63:41;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_bst0_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_23_63:41;
-		uint64_t wlb_msk:4;
-		uint64_t reserved_16_18:3;
-		uint64_t dtcnt:10;
-		uint64_t dt:1;
-		uint64_t stin_msk:1;
-		uint64_t wlb_dat:4;
-#else
-		uint64_t wlb_dat:4;
-		uint64_t stin_msk:1;
-		uint64_t dt:1;
-		uint64_t dtcnt:10;
-		uint64_t reserved_16_18:3;
-		uint64_t wlb_msk:4;
-		uint64_t reserved_23_63:41;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_bst0_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_19_63:45;
-		uint64_t dtcnt:13;
-		uint64_t dt:1;
-		uint64_t stin_msk:1;
-		uint64_t wlb_dat:4;
-#else
-		uint64_t wlb_dat:4;
-		uint64_t stin_msk:1;
-		uint64_t dt:1;
-		uint64_t dtcnt:13;
-		uint64_t reserved_19_63:45;
-#endif
-	} cn38xx;
-	struct cvmx_l2c_bst0_cn38xx cn38xxp2;
-	struct cvmx_l2c_bst0_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t dtbnk:1;
-		uint64_t wlb_msk:4;
-		uint64_t reserved_16_18:3;
-		uint64_t dtcnt:10;
-		uint64_t dt:1;
-		uint64_t stin_msk:1;
-		uint64_t wlb_dat:4;
-#else
-		uint64_t wlb_dat:4;
-		uint64_t stin_msk:1;
-		uint64_t dt:1;
-		uint64_t dtcnt:10;
-		uint64_t reserved_16_18:3;
-		uint64_t wlb_msk:4;
-		uint64_t dtbnk:1;
-		uint64_t reserved_24_63:40;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_bst0_cn50xx cn52xx;
-	struct cvmx_l2c_bst0_cn50xx cn52xxp1;
-	struct cvmx_l2c_bst0_s cn56xx;
-	struct cvmx_l2c_bst0_s cn56xxp1;
-	struct cvmx_l2c_bst0_s cn58xx;
-	struct cvmx_l2c_bst0_s cn58xxp1;
-};
-
-union cvmx_l2c_bst1 {
-	uint64_t u64;
-	struct cvmx_l2c_bst1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t l2t:9;
-#else
-		uint64_t l2t:9;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_bst1_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t vwdf:4;
-		uint64_t lrf:2;
-		uint64_t vab_vwcf:1;
-		uint64_t reserved_5_8:4;
-		uint64_t l2t:5;
-#else
-		uint64_t l2t:5;
-		uint64_t reserved_5_8:4;
-		uint64_t vab_vwcf:1;
-		uint64_t lrf:2;
-		uint64_t vwdf:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_bst1_cn30xx cn31xx;
-	struct cvmx_l2c_bst1_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t vwdf:4;
-		uint64_t lrf:2;
-		uint64_t vab_vwcf:1;
-		uint64_t l2t:9;
-#else
-		uint64_t l2t:9;
-		uint64_t vab_vwcf:1;
-		uint64_t lrf:2;
-		uint64_t vwdf:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn38xx;
-	struct cvmx_l2c_bst1_cn38xx cn38xxp2;
-	struct cvmx_l2c_bst1_cn38xx cn50xx;
-	struct cvmx_l2c_bst1_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_19_63:45;
-		uint64_t plc2:1;
-		uint64_t plc1:1;
-		uint64_t plc0:1;
-		uint64_t vwdf:4;
-		uint64_t reserved_11_11:1;
-		uint64_t ilc:1;
-		uint64_t vab_vwcf:1;
-		uint64_t l2t:9;
-#else
-		uint64_t l2t:9;
-		uint64_t vab_vwcf:1;
-		uint64_t ilc:1;
-		uint64_t reserved_11_11:1;
-		uint64_t vwdf:4;
-		uint64_t plc0:1;
-		uint64_t plc1:1;
-		uint64_t plc2:1;
-		uint64_t reserved_19_63:45;
-#endif
-	} cn52xx;
-	struct cvmx_l2c_bst1_cn52xx cn52xxp1;
-	struct cvmx_l2c_bst1_cn56xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t plc2:1;
-		uint64_t plc1:1;
-		uint64_t plc0:1;
-		uint64_t ilc:1;
-		uint64_t vwdf1:4;
-		uint64_t vwdf0:4;
-		uint64_t vab_vwcf1:1;
-		uint64_t reserved_10_10:1;
-		uint64_t vab_vwcf0:1;
-		uint64_t l2t:9;
-#else
-		uint64_t l2t:9;
-		uint64_t vab_vwcf0:1;
-		uint64_t reserved_10_10:1;
-		uint64_t vab_vwcf1:1;
-		uint64_t vwdf0:4;
-		uint64_t vwdf1:4;
-		uint64_t ilc:1;
-		uint64_t plc0:1;
-		uint64_t plc1:1;
-		uint64_t plc2:1;
-		uint64_t reserved_24_63:40;
-#endif
-	} cn56xx;
-	struct cvmx_l2c_bst1_cn56xx cn56xxp1;
-	struct cvmx_l2c_bst1_cn38xx cn58xx;
-	struct cvmx_l2c_bst1_cn38xx cn58xxp1;
-};
-
-union cvmx_l2c_bst2 {
-	uint64_t u64;
-	struct cvmx_l2c_bst2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mrb:4;
-		uint64_t reserved_4_11:8;
-		uint64_t ipcbst:1;
-		uint64_t picbst:1;
-		uint64_t xrdmsk:1;
-		uint64_t xrddat:1;
-#else
-		uint64_t xrddat:1;
-		uint64_t xrdmsk:1;
-		uint64_t picbst:1;
-		uint64_t ipcbst:1;
-		uint64_t reserved_4_11:8;
-		uint64_t mrb:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} s;
-	struct cvmx_l2c_bst2_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mrb:4;
-		uint64_t rmdf:4;
-		uint64_t reserved_4_7:4;
-		uint64_t ipcbst:1;
-		uint64_t reserved_2_2:1;
-		uint64_t xrdmsk:1;
-		uint64_t xrddat:1;
-#else
-		uint64_t xrddat:1;
-		uint64_t xrdmsk:1;
-		uint64_t reserved_2_2:1;
-		uint64_t ipcbst:1;
-		uint64_t reserved_4_7:4;
-		uint64_t rmdf:4;
-		uint64_t mrb:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_bst2_cn30xx cn31xx;
-	struct cvmx_l2c_bst2_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mrb:4;
-		uint64_t rmdf:4;
-		uint64_t rhdf:4;
-		uint64_t ipcbst:1;
-		uint64_t picbst:1;
-		uint64_t xrdmsk:1;
-		uint64_t xrddat:1;
-#else
-		uint64_t xrddat:1;
-		uint64_t xrdmsk:1;
-		uint64_t picbst:1;
-		uint64_t ipcbst:1;
-		uint64_t rhdf:4;
-		uint64_t rmdf:4;
-		uint64_t mrb:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn38xx;
-	struct cvmx_l2c_bst2_cn38xx cn38xxp2;
-	struct cvmx_l2c_bst2_cn30xx cn50xx;
-	struct cvmx_l2c_bst2_cn30xx cn52xx;
-	struct cvmx_l2c_bst2_cn30xx cn52xxp1;
-	struct cvmx_l2c_bst2_cn56xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mrb:4;
-		uint64_t rmdb:4;
-		uint64_t rhdb:4;
-		uint64_t ipcbst:1;
-		uint64_t picbst:1;
-		uint64_t xrdmsk:1;
-		uint64_t xrddat:1;
-#else
-		uint64_t xrddat:1;
-		uint64_t xrdmsk:1;
-		uint64_t picbst:1;
-		uint64_t ipcbst:1;
-		uint64_t rhdb:4;
-		uint64_t rmdb:4;
-		uint64_t mrb:4;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn56xx;
-	struct cvmx_l2c_bst2_cn56xx cn56xxp1;
-	struct cvmx_l2c_bst2_cn56xx cn58xx;
-	struct cvmx_l2c_bst2_cn56xx cn58xxp1;
-};
-
-union cvmx_l2c_bst_memx {
-	uint64_t u64;
-	struct cvmx_l2c_bst_memx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t start_bist:1;
-		uint64_t clear_bist:1;
-		uint64_t reserved_5_61:57;
-		uint64_t rdffl:1;
-		uint64_t vbffl:4;
-#else
-		uint64_t vbffl:4;
-		uint64_t rdffl:1;
-		uint64_t reserved_5_61:57;
-		uint64_t clear_bist:1;
-		uint64_t start_bist:1;
-#endif
-	} s;
-	struct cvmx_l2c_bst_memx_s cn61xx;
-	struct cvmx_l2c_bst_memx_s cn63xx;
-	struct cvmx_l2c_bst_memx_s cn63xxp1;
-	struct cvmx_l2c_bst_memx_s cn66xx;
-	struct cvmx_l2c_bst_memx_s cn68xx;
-	struct cvmx_l2c_bst_memx_s cn68xxp1;
-	struct cvmx_l2c_bst_memx_s cnf71xx;
-};
-
-union cvmx_l2c_bst_tdtx {
-	uint64_t u64;
-	struct cvmx_l2c_bst_tdtx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t fbfrspfl:8;
-		uint64_t sbffl:8;
-		uint64_t fbffl:8;
-		uint64_t l2dfl:8;
-#else
-		uint64_t l2dfl:8;
-		uint64_t fbffl:8;
-		uint64_t sbffl:8;
-		uint64_t fbfrspfl:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_bst_tdtx_s cn61xx;
-	struct cvmx_l2c_bst_tdtx_s cn63xx;
-	struct cvmx_l2c_bst_tdtx_cn63xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t sbffl:8;
-		uint64_t fbffl:8;
-		uint64_t l2dfl:8;
-#else
-		uint64_t l2dfl:8;
-		uint64_t fbffl:8;
-		uint64_t sbffl:8;
-		uint64_t reserved_24_63:40;
-#endif
-	} cn63xxp1;
-	struct cvmx_l2c_bst_tdtx_s cn66xx;
-	struct cvmx_l2c_bst_tdtx_s cn68xx;
-	struct cvmx_l2c_bst_tdtx_s cn68xxp1;
-	struct cvmx_l2c_bst_tdtx_s cnf71xx;
-};
+#define CVMX_L2C_TADX_PFCX(offset, block_id)				       \
+		(CVMX_ADD_IO_SEG(0x0001180080A00400ull) + (((offset) & 3) +    \
+		((block_id) & 7) * 0x8000ull) * 8)
+#define CVMX_L2C_TADX_PFC0(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00400ull) + \
+		((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_TADX_PFC1(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00408ull) + \
+		((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_TADX_PFC2(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00410ull) + \
+		((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_TADX_PFC3(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00418ull) + \
+		((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_TADX_PRF(offset) (CVMX_ADD_IO_SEG(0x0001180080A00008ull)    + \
+		((offset) & 7) * 0x40000ull)
+#define CVMX_L2C_TADX_TAG(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00010ull)  + \
+		((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_WPAR_IOBX(offset) (CVMX_ADD_IO_SEG(0x0001180080840200ull)   + \
+		((offset) & 1) * 8)
+#define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull)    + \
+		((offset) & 31) * 8)
+#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
-union cvmx_l2c_bst_ttgx {
-	uint64_t u64;
-	struct cvmx_l2c_bst_ttgx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
-		uint64_t lrufl:1;
-		uint64_t tagfl:16;
-#else
-		uint64_t tagfl:16;
-		uint64_t lrufl:1;
-		uint64_t reserved_17_63:47;
-#endif
-	} s;
-	struct cvmx_l2c_bst_ttgx_s cn61xx;
-	struct cvmx_l2c_bst_ttgx_s cn63xx;
-	struct cvmx_l2c_bst_ttgx_s cn63xxp1;
-	struct cvmx_l2c_bst_ttgx_s cn66xx;
-	struct cvmx_l2c_bst_ttgx_s cn68xx;
-	struct cvmx_l2c_bst_ttgx_s cn68xxp1;
-	struct cvmx_l2c_bst_ttgx_s cnf71xx;
-};
 
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t bstrun:1;
-		uint64_t lbist:1;
-		uint64_t xor_bank:1;
-		uint64_t dpres1:1;
-		uint64_t dpres0:1;
-		uint64_t dfill_dis:1;
-		uint64_t fpexp:4;
-		uint64_t fpempty:1;
-		uint64_t fpen:1;
-		uint64_t idxalias:1;
-		uint64_t mwf_crd:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t lrf_arb_mode:1;
-#else
-		uint64_t lrf_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t mwf_crd:4;
-		uint64_t idxalias:1;
-		uint64_t fpen:1;
-		uint64_t fpempty:1;
-		uint64_t fpexp:4;
-		uint64_t dfill_dis:1;
-		uint64_t dpres0:1;
-		uint64_t dpres1:1;
-		uint64_t xor_bank:1;
-		uint64_t lbist:1;
-		uint64_t bstrun:1;
-		uint64_t reserved_20_63:44;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_20_63:44,
+		__BITFIELD_FIELD(uint64_t bstrun:1,
+		__BITFIELD_FIELD(uint64_t lbist:1,
+		__BITFIELD_FIELD(uint64_t xor_bank:1,
+		__BITFIELD_FIELD(uint64_t dpres1:1,
+		__BITFIELD_FIELD(uint64_t dpres0:1,
+		__BITFIELD_FIELD(uint64_t dfill_dis:1,
+		__BITFIELD_FIELD(uint64_t fpexp:4,
+		__BITFIELD_FIELD(uint64_t fpempty:1,
+		__BITFIELD_FIELD(uint64_t fpen:1,
+		__BITFIELD_FIELD(uint64_t idxalias:1,
+		__BITFIELD_FIELD(uint64_t mwf_crd:4,
+		__BITFIELD_FIELD(uint64_t rsp_arb_mode:1,
+		__BITFIELD_FIELD(uint64_t rfb_arb_mode:1,
+		__BITFIELD_FIELD(uint64_t lrf_arb_mode:1,
+		;)))))))))))))))
 	} s;
-	struct cvmx_l2c_cfg_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_14_63:50;
-		uint64_t fpexp:4;
-		uint64_t fpempty:1;
-		uint64_t fpen:1;
-		uint64_t idxalias:1;
-		uint64_t mwf_crd:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t lrf_arb_mode:1;
-#else
-		uint64_t lrf_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t mwf_crd:4;
-		uint64_t idxalias:1;
-		uint64_t fpen:1;
-		uint64_t fpempty:1;
-		uint64_t fpexp:4;
-		uint64_t reserved_14_63:50;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_cfg_cn30xx cn31xx;
-	struct cvmx_l2c_cfg_cn30xx cn38xx;
-	struct cvmx_l2c_cfg_cn30xx cn38xxp2;
-	struct cvmx_l2c_cfg_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t bstrun:1;
-		uint64_t lbist:1;
-		uint64_t reserved_14_17:4;
-		uint64_t fpexp:4;
-		uint64_t fpempty:1;
-		uint64_t fpen:1;
-		uint64_t idxalias:1;
-		uint64_t mwf_crd:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t lrf_arb_mode:1;
-#else
-		uint64_t lrf_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t mwf_crd:4;
-		uint64_t idxalias:1;
-		uint64_t fpen:1;
-		uint64_t fpempty:1;
-		uint64_t fpexp:4;
-		uint64_t reserved_14_17:4;
-		uint64_t lbist:1;
-		uint64_t bstrun:1;
-		uint64_t reserved_20_63:44;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_cfg_cn50xx cn52xx;
-	struct cvmx_l2c_cfg_cn50xx cn52xxp1;
-	struct cvmx_l2c_cfg_s cn56xx;
-	struct cvmx_l2c_cfg_s cn56xxp1;
-	struct cvmx_l2c_cfg_cn58xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t bstrun:1;
-		uint64_t lbist:1;
-		uint64_t reserved_15_17:3;
-		uint64_t dfill_dis:1;
-		uint64_t fpexp:4;
-		uint64_t fpempty:1;
-		uint64_t fpen:1;
-		uint64_t idxalias:1;
-		uint64_t mwf_crd:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t lrf_arb_mode:1;
-#else
-		uint64_t lrf_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t mwf_crd:4;
-		uint64_t idxalias:1;
-		uint64_t fpen:1;
-		uint64_t fpempty:1;
-		uint64_t fpexp:4;
-		uint64_t dfill_dis:1;
-		uint64_t reserved_15_17:3;
-		uint64_t lbist:1;
-		uint64_t bstrun:1;
-		uint64_t reserved_20_63:44;
-#endif
-	} cn58xx;
-	struct cvmx_l2c_cfg_cn58xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_15_63:49;
-		uint64_t dfill_dis:1;
-		uint64_t fpexp:4;
-		uint64_t fpempty:1;
-		uint64_t fpen:1;
-		uint64_t idxalias:1;
-		uint64_t mwf_crd:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t lrf_arb_mode:1;
-#else
-		uint64_t lrf_arb_mode:1;
-		uint64_t rfb_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t mwf_crd:4;
-		uint64_t idxalias:1;
-		uint64_t fpen:1;
-		uint64_t fpempty:1;
-		uint64_t fpexp:4;
-		uint64_t dfill_dis:1;
-		uint64_t reserved_15_63:49;
-#endif
-	} cn58xxp1;
-};
-
-union cvmx_l2c_cop0_mapx {
-	uint64_t u64;
-	struct cvmx_l2c_cop0_mapx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t data:64;
-#else
-		uint64_t data:64;
-#endif
-	} s;
-	struct cvmx_l2c_cop0_mapx_s cn61xx;
-	struct cvmx_l2c_cop0_mapx_s cn63xx;
-	struct cvmx_l2c_cop0_mapx_s cn63xxp1;
-	struct cvmx_l2c_cop0_mapx_s cn66xx;
-	struct cvmx_l2c_cop0_mapx_s cn68xx;
-	struct cvmx_l2c_cop0_mapx_s cn68xxp1;
-	struct cvmx_l2c_cop0_mapx_s cnf71xx;
 };
 
 union cvmx_l2c_ctl {
 	uint64_t u64;
 	struct cvmx_l2c_ctl_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_30_63:34;
-		uint64_t sepcmt:1;
-		uint64_t rdf_fast:1;
-		uint64_t disstgl2i:1;
-		uint64_t l2dfsbe:1;
-		uint64_t l2dfdbe:1;
-		uint64_t discclk:1;
-		uint64_t maxvab:4;
-		uint64_t maxlfb:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t ef_ena:1;
-		uint64_t ef_cnt:7;
-		uint64_t vab_thresh:4;
-		uint64_t disecc:1;
-		uint64_t disidxalias:1;
-#else
-		uint64_t disidxalias:1;
-		uint64_t disecc:1;
-		uint64_t vab_thresh:4;
-		uint64_t ef_cnt:7;
-		uint64_t ef_ena:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t maxlfb:4;
-		uint64_t maxvab:4;
-		uint64_t discclk:1;
-		uint64_t l2dfdbe:1;
-		uint64_t l2dfsbe:1;
-		uint64_t disstgl2i:1;
-		uint64_t rdf_fast:1;
-		uint64_t sepcmt:1;
-		uint64_t reserved_30_63:34;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_30_63:34,
+		__BITFIELD_FIELD(uint64_t sepcmt:1,
+		__BITFIELD_FIELD(uint64_t rdf_fast:1,
+		__BITFIELD_FIELD(uint64_t disstgl2i:1,
+		__BITFIELD_FIELD(uint64_t l2dfsbe:1,
+		__BITFIELD_FIELD(uint64_t l2dfdbe:1,
+		__BITFIELD_FIELD(uint64_t discclk:1,
+		__BITFIELD_FIELD(uint64_t maxvab:4,
+		__BITFIELD_FIELD(uint64_t maxlfb:4,
+		__BITFIELD_FIELD(uint64_t rsp_arb_mode:1,
+		__BITFIELD_FIELD(uint64_t xmc_arb_mode:1,
+		__BITFIELD_FIELD(uint64_t ef_ena:1,
+		__BITFIELD_FIELD(uint64_t ef_cnt:7,
+		__BITFIELD_FIELD(uint64_t vab_thresh:4,
+		__BITFIELD_FIELD(uint64_t disecc:1,
+		__BITFIELD_FIELD(uint64_t disidxalias:1,
+		;))))))))))))))))
 	} s;
-	struct cvmx_l2c_ctl_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_29_63:35;
-		uint64_t rdf_fast:1;
-		uint64_t disstgl2i:1;
-		uint64_t l2dfsbe:1;
-		uint64_t l2dfdbe:1;
-		uint64_t discclk:1;
-		uint64_t maxvab:4;
-		uint64_t maxlfb:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t ef_ena:1;
-		uint64_t ef_cnt:7;
-		uint64_t vab_thresh:4;
-		uint64_t disecc:1;
-		uint64_t disidxalias:1;
-#else
-		uint64_t disidxalias:1;
-		uint64_t disecc:1;
-		uint64_t vab_thresh:4;
-		uint64_t ef_cnt:7;
-		uint64_t ef_ena:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t maxlfb:4;
-		uint64_t maxvab:4;
-		uint64_t discclk:1;
-		uint64_t l2dfdbe:1;
-		uint64_t l2dfsbe:1;
-		uint64_t disstgl2i:1;
-		uint64_t rdf_fast:1;
-		uint64_t reserved_29_63:35;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_ctl_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t disstgl2i:1;
-		uint64_t l2dfsbe:1;
-		uint64_t l2dfdbe:1;
-		uint64_t discclk:1;
-		uint64_t maxvab:4;
-		uint64_t maxlfb:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t ef_ena:1;
-		uint64_t ef_cnt:7;
-		uint64_t vab_thresh:4;
-		uint64_t disecc:1;
-		uint64_t disidxalias:1;
-#else
-		uint64_t disidxalias:1;
-		uint64_t disecc:1;
-		uint64_t vab_thresh:4;
-		uint64_t ef_cnt:7;
-		uint64_t ef_ena:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t maxlfb:4;
-		uint64_t maxvab:4;
-		uint64_t discclk:1;
-		uint64_t l2dfdbe:1;
-		uint64_t l2dfsbe:1;
-		uint64_t disstgl2i:1;
-		uint64_t reserved_28_63:36;
-#endif
-	} cn63xx;
-	struct cvmx_l2c_ctl_cn63xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_25_63:39;
-		uint64_t discclk:1;
-		uint64_t maxvab:4;
-		uint64_t maxlfb:4;
-		uint64_t rsp_arb_mode:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t ef_ena:1;
-		uint64_t ef_cnt:7;
-		uint64_t vab_thresh:4;
-		uint64_t disecc:1;
-		uint64_t disidxalias:1;
-#else
-		uint64_t disidxalias:1;
-		uint64_t disecc:1;
-		uint64_t vab_thresh:4;
-		uint64_t ef_cnt:7;
-		uint64_t ef_ena:1;
-		uint64_t xmc_arb_mode:1;
-		uint64_t rsp_arb_mode:1;
-		uint64_t maxlfb:4;
-		uint64_t maxvab:4;
-		uint64_t discclk:1;
-		uint64_t reserved_25_63:39;
-#endif
-	} cn63xxp1;
-	struct cvmx_l2c_ctl_cn61xx cn66xx;
-	struct cvmx_l2c_ctl_s cn68xx;
-	struct cvmx_l2c_ctl_cn63xx cn68xxp1;
-	struct cvmx_l2c_ctl_cn61xx cnf71xx;
 };
 
 union cvmx_l2c_dbg {
 	uint64_t u64;
 	struct cvmx_l2c_dbg_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_15_63:49;
-		uint64_t lfb_enum:4;
-		uint64_t lfb_dmp:1;
-		uint64_t ppnum:4;
-		uint64_t set:3;
-		uint64_t finv:1;
-		uint64_t l2d:1;
-		uint64_t l2t:1;
-#else
-		uint64_t l2t:1;
-		uint64_t l2d:1;
-		uint64_t finv:1;
-		uint64_t set:3;
-		uint64_t ppnum:4;
-		uint64_t lfb_dmp:1;
-		uint64_t lfb_enum:4;
-		uint64_t reserved_15_63:49;
-#endif
-	} s;
-	struct cvmx_l2c_dbg_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_13_63:51;
-		uint64_t lfb_enum:2;
-		uint64_t lfb_dmp:1;
-		uint64_t reserved_7_9:3;
-		uint64_t ppnum:1;
-		uint64_t reserved_5_5:1;
-		uint64_t set:2;
-		uint64_t finv:1;
-		uint64_t l2d:1;
-		uint64_t l2t:1;
-#else
-		uint64_t l2t:1;
-		uint64_t l2d:1;
-		uint64_t finv:1;
-		uint64_t set:2;
-		uint64_t reserved_5_5:1;
-		uint64_t ppnum:1;
-		uint64_t reserved_7_9:3;
-		uint64_t lfb_dmp:1;
-		uint64_t lfb_enum:2;
-		uint64_t reserved_13_63:51;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_dbg_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_14_63:50;
-		uint64_t lfb_enum:3;
-		uint64_t lfb_dmp:1;
-		uint64_t reserved_7_9:3;
-		uint64_t ppnum:1;
-		uint64_t reserved_5_5:1;
-		uint64_t set:2;
-		uint64_t finv:1;
-		uint64_t l2d:1;
-		uint64_t l2t:1;
-#else
-		uint64_t l2t:1;
-		uint64_t l2d:1;
-		uint64_t finv:1;
-		uint64_t set:2;
-		uint64_t reserved_5_5:1;
-		uint64_t ppnum:1;
-		uint64_t reserved_7_9:3;
-		uint64_t lfb_dmp:1;
-		uint64_t lfb_enum:3;
-		uint64_t reserved_14_63:50;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_dbg_s cn38xx;
-	struct cvmx_l2c_dbg_s cn38xxp2;
-	struct cvmx_l2c_dbg_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_14_63:50;
-		uint64_t lfb_enum:3;
-		uint64_t lfb_dmp:1;
-		uint64_t reserved_7_9:3;
-		uint64_t ppnum:1;
-		uint64_t set:3;
-		uint64_t finv:1;
-		uint64_t l2d:1;
-		uint64_t l2t:1;
-#else
-		uint64_t l2t:1;
-		uint64_t l2d:1;
-		uint64_t finv:1;
-		uint64_t set:3;
-		uint64_t ppnum:1;
-		uint64_t reserved_7_9:3;
-		uint64_t lfb_dmp:1;
-		uint64_t lfb_enum:3;
-		uint64_t reserved_14_63:50;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_dbg_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_14_63:50;
-		uint64_t lfb_enum:3;
-		uint64_t lfb_dmp:1;
-		uint64_t reserved_8_9:2;
-		uint64_t ppnum:2;
-		uint64_t set:3;
-		uint64_t finv:1;
-		uint64_t l2d:1;
-		uint64_t l2t:1;
-#else
-		uint64_t l2t:1;
-		uint64_t l2d:1;
-		uint64_t finv:1;
-		uint64_t set:3;
-		uint64_t ppnum:2;
-		uint64_t reserved_8_9:2;
-		uint64_t lfb_dmp:1;
-		uint64_t lfb_enum:3;
-		uint64_t reserved_14_63:50;
-#endif
-	} cn52xx;
-	struct cvmx_l2c_dbg_cn52xx cn52xxp1;
-	struct cvmx_l2c_dbg_s cn56xx;
-	struct cvmx_l2c_dbg_s cn56xxp1;
-	struct cvmx_l2c_dbg_s cn58xx;
-	struct cvmx_l2c_dbg_s cn58xxp1;
-};
-
-union cvmx_l2c_dut {
-	uint64_t u64;
-	struct cvmx_l2c_dut_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t dtena:1;
-		uint64_t reserved_30_30:1;
-		uint64_t dt_vld:1;
-		uint64_t dt_tag:29;
-#else
-		uint64_t dt_tag:29;
-		uint64_t dt_vld:1;
-		uint64_t reserved_30_30:1;
-		uint64_t dtena:1;
-		uint64_t reserved_32_63:32;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_15_63:49,
+		__BITFIELD_FIELD(uint64_t lfb_enum:4,
+		__BITFIELD_FIELD(uint64_t lfb_dmp:1,
+		__BITFIELD_FIELD(uint64_t ppnum:4,
+		__BITFIELD_FIELD(uint64_t set:3,
+		__BITFIELD_FIELD(uint64_t finv:1,
+		__BITFIELD_FIELD(uint64_t l2d:1,
+		__BITFIELD_FIELD(uint64_t l2t:1,
+		;))))))))
 	} s;
-	struct cvmx_l2c_dut_s cn30xx;
-	struct cvmx_l2c_dut_s cn31xx;
-	struct cvmx_l2c_dut_s cn38xx;
-	struct cvmx_l2c_dut_s cn38xxp2;
-	struct cvmx_l2c_dut_s cn50xx;
-	struct cvmx_l2c_dut_s cn52xx;
-	struct cvmx_l2c_dut_s cn52xxp1;
-	struct cvmx_l2c_dut_s cn56xx;
-	struct cvmx_l2c_dut_s cn56xxp1;
-	struct cvmx_l2c_dut_s cn58xx;
-	struct cvmx_l2c_dut_s cn58xxp1;
-};
-
-union cvmx_l2c_dut_mapx {
-	uint64_t u64;
-	struct cvmx_l2c_dut_mapx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_38_63:26;
-		uint64_t tag:28;
-		uint64_t reserved_1_9:9;
-		uint64_t valid:1;
-#else
-		uint64_t valid:1;
-		uint64_t reserved_1_9:9;
-		uint64_t tag:28;
-		uint64_t reserved_38_63:26;
-#endif
-	} s;
-	struct cvmx_l2c_dut_mapx_s cn61xx;
-	struct cvmx_l2c_dut_mapx_s cn63xx;
-	struct cvmx_l2c_dut_mapx_s cn63xxp1;
-	struct cvmx_l2c_dut_mapx_s cn66xx;
-	struct cvmx_l2c_dut_mapx_s cn68xx;
-	struct cvmx_l2c_dut_mapx_s cn68xxp1;
-	struct cvmx_l2c_dut_mapx_s cnf71xx;
-};
-
-union cvmx_l2c_err_tdtx {
-	uint64_t u64;
-	struct cvmx_l2c_err_tdtx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t vdbe:1;
-		uint64_t vsbe:1;
-		uint64_t syn:10;
-		uint64_t reserved_22_49:28;
-		uint64_t wayidx:18;
-		uint64_t reserved_2_3:2;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_3:2;
-		uint64_t wayidx:18;
-		uint64_t reserved_22_49:28;
-		uint64_t syn:10;
-		uint64_t vsbe:1;
-		uint64_t vdbe:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} s;
-	struct cvmx_l2c_err_tdtx_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t vdbe:1;
-		uint64_t vsbe:1;
-		uint64_t syn:10;
-		uint64_t reserved_20_49:30;
-		uint64_t wayidx:16;
-		uint64_t reserved_2_3:2;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_3:2;
-		uint64_t wayidx:16;
-		uint64_t reserved_20_49:30;
-		uint64_t syn:10;
-		uint64_t vsbe:1;
-		uint64_t vdbe:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_err_tdtx_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t vdbe:1;
-		uint64_t vsbe:1;
-		uint64_t syn:10;
-		uint64_t reserved_21_49:29;
-		uint64_t wayidx:17;
-		uint64_t reserved_2_3:2;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_3:2;
-		uint64_t wayidx:17;
-		uint64_t reserved_21_49:29;
-		uint64_t syn:10;
-		uint64_t vsbe:1;
-		uint64_t vdbe:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} cn63xx;
-	struct cvmx_l2c_err_tdtx_cn63xx cn63xxp1;
-	struct cvmx_l2c_err_tdtx_cn63xx cn66xx;
-	struct cvmx_l2c_err_tdtx_s cn68xx;
-	struct cvmx_l2c_err_tdtx_s cn68xxp1;
-	struct cvmx_l2c_err_tdtx_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_err_ttgx {
-	uint64_t u64;
-	struct cvmx_l2c_err_ttgx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t noway:1;
-		uint64_t reserved_56_60:5;
-		uint64_t syn:6;
-		uint64_t reserved_22_49:28;
-		uint64_t wayidx:15;
-		uint64_t reserved_2_6:5;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_6:5;
-		uint64_t wayidx:15;
-		uint64_t reserved_22_49:28;
-		uint64_t syn:6;
-		uint64_t reserved_56_60:5;
-		uint64_t noway:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} s;
-	struct cvmx_l2c_err_ttgx_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t noway:1;
-		uint64_t reserved_56_60:5;
-		uint64_t syn:6;
-		uint64_t reserved_20_49:30;
-		uint64_t wayidx:13;
-		uint64_t reserved_2_6:5;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_6:5;
-		uint64_t wayidx:13;
-		uint64_t reserved_20_49:30;
-		uint64_t syn:6;
-		uint64_t reserved_56_60:5;
-		uint64_t noway:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_err_ttgx_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t dbe:1;
-		uint64_t sbe:1;
-		uint64_t noway:1;
-		uint64_t reserved_56_60:5;
-		uint64_t syn:6;
-		uint64_t reserved_21_49:29;
-		uint64_t wayidx:14;
-		uint64_t reserved_2_6:5;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_6:5;
-		uint64_t wayidx:14;
-		uint64_t reserved_21_49:29;
-		uint64_t syn:6;
-		uint64_t reserved_56_60:5;
-		uint64_t noway:1;
-		uint64_t sbe:1;
-		uint64_t dbe:1;
-#endif
-	} cn63xx;
-	struct cvmx_l2c_err_ttgx_cn63xx cn63xxp1;
-	struct cvmx_l2c_err_ttgx_cn63xx cn66xx;
-	struct cvmx_l2c_err_ttgx_s cn68xx;
-	struct cvmx_l2c_err_ttgx_s cn68xxp1;
-	struct cvmx_l2c_err_ttgx_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_err_vbfx {
-	uint64_t u64;
-	struct cvmx_l2c_err_vbfx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_62_63:2;
-		uint64_t vdbe:1;
-		uint64_t vsbe:1;
-		uint64_t vsyn:10;
-		uint64_t reserved_2_49:48;
-		uint64_t type:2;
-#else
-		uint64_t type:2;
-		uint64_t reserved_2_49:48;
-		uint64_t vsyn:10;
-		uint64_t vsbe:1;
-		uint64_t vdbe:1;
-		uint64_t reserved_62_63:2;
-#endif
-	} s;
-	struct cvmx_l2c_err_vbfx_s cn61xx;
-	struct cvmx_l2c_err_vbfx_s cn63xx;
-	struct cvmx_l2c_err_vbfx_s cn63xxp1;
-	struct cvmx_l2c_err_vbfx_s cn66xx;
-	struct cvmx_l2c_err_vbfx_s cn68xx;
-	struct cvmx_l2c_err_vbfx_s cn68xxp1;
-	struct cvmx_l2c_err_vbfx_s cnf71xx;
-};
-
-union cvmx_l2c_err_xmc {
-	uint64_t u64;
-	struct cvmx_l2c_err_xmc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t cmd:6;
-		uint64_t reserved_54_57:4;
-		uint64_t sid:6;
-		uint64_t reserved_38_47:10;
-		uint64_t addr:38;
-#else
-		uint64_t addr:38;
-		uint64_t reserved_38_47:10;
-		uint64_t sid:6;
-		uint64_t reserved_54_57:4;
-		uint64_t cmd:6;
-#endif
-	} s;
-	struct cvmx_l2c_err_xmc_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t cmd:6;
-		uint64_t reserved_52_57:6;
-		uint64_t sid:4;
-		uint64_t reserved_38_47:10;
-		uint64_t addr:38;
-#else
-		uint64_t addr:38;
-		uint64_t reserved_38_47:10;
-		uint64_t sid:4;
-		uint64_t reserved_52_57:6;
-		uint64_t cmd:6;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_err_xmc_cn61xx cn63xx;
-	struct cvmx_l2c_err_xmc_cn61xx cn63xxp1;
-	struct cvmx_l2c_err_xmc_cn66xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t cmd:6;
-		uint64_t reserved_53_57:5;
-		uint64_t sid:5;
-		uint64_t reserved_38_47:10;
-		uint64_t addr:38;
-#else
-		uint64_t addr:38;
-		uint64_t reserved_38_47:10;
-		uint64_t sid:5;
-		uint64_t reserved_53_57:5;
-		uint64_t cmd:6;
-#endif
-	} cn66xx;
-	struct cvmx_l2c_err_xmc_s cn68xx;
-	struct cvmx_l2c_err_xmc_s cn68xxp1;
-	struct cvmx_l2c_err_xmc_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_grpwrr0 {
-	uint64_t u64;
-	struct cvmx_l2c_grpwrr0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t plc1rmsk:32;
-		uint64_t plc0rmsk:32;
-#else
-		uint64_t plc0rmsk:32;
-		uint64_t plc1rmsk:32;
-#endif
-	} s;
-	struct cvmx_l2c_grpwrr0_s cn52xx;
-	struct cvmx_l2c_grpwrr0_s cn52xxp1;
-	struct cvmx_l2c_grpwrr0_s cn56xx;
-	struct cvmx_l2c_grpwrr0_s cn56xxp1;
-};
-
-union cvmx_l2c_grpwrr1 {
-	uint64_t u64;
-	struct cvmx_l2c_grpwrr1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t ilcrmsk:32;
-		uint64_t plc2rmsk:32;
-#else
-		uint64_t plc2rmsk:32;
-		uint64_t ilcrmsk:32;
-#endif
-	} s;
-	struct cvmx_l2c_grpwrr1_s cn52xx;
-	struct cvmx_l2c_grpwrr1_s cn52xxp1;
-	struct cvmx_l2c_grpwrr1_s cn56xx;
-	struct cvmx_l2c_grpwrr1_s cn56xxp1;
-};
-
-union cvmx_l2c_int_en {
-	uint64_t u64;
-	struct cvmx_l2c_int_en_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t lck2ena:1;
-		uint64_t lckena:1;
-		uint64_t l2ddeden:1;
-		uint64_t l2dsecen:1;
-		uint64_t l2tdeden:1;
-		uint64_t l2tsecen:1;
-		uint64_t oob3en:1;
-		uint64_t oob2en:1;
-		uint64_t oob1en:1;
-#else
-		uint64_t oob1en:1;
-		uint64_t oob2en:1;
-		uint64_t oob3en:1;
-		uint64_t l2tsecen:1;
-		uint64_t l2tdeden:1;
-		uint64_t l2dsecen:1;
-		uint64_t l2ddeden:1;
-		uint64_t lckena:1;
-		uint64_t lck2ena:1;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_int_en_s cn52xx;
-	struct cvmx_l2c_int_en_s cn52xxp1;
-	struct cvmx_l2c_int_en_s cn56xx;
-	struct cvmx_l2c_int_en_s cn56xxp1;
-};
-
-union cvmx_l2c_int_ena {
-	uint64_t u64;
-	struct cvmx_l2c_int_ena_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_8_63:56;
-		uint64_t bigrd:1;
-		uint64_t bigwr:1;
-		uint64_t vrtpe:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtwr:1;
-		uint64_t holewr:1;
-		uint64_t holerd:1;
-#else
-		uint64_t holerd:1;
-		uint64_t holewr:1;
-		uint64_t vrtwr:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtpe:1;
-		uint64_t bigwr:1;
-		uint64_t bigrd:1;
-		uint64_t reserved_8_63:56;
-#endif
-	} s;
-	struct cvmx_l2c_int_ena_s cn61xx;
-	struct cvmx_l2c_int_ena_s cn63xx;
-	struct cvmx_l2c_int_ena_cn63xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_6_63:58;
-		uint64_t vrtpe:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtwr:1;
-		uint64_t holewr:1;
-		uint64_t holerd:1;
-#else
-		uint64_t holerd:1;
-		uint64_t holewr:1;
-		uint64_t vrtwr:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtpe:1;
-		uint64_t reserved_6_63:58;
-#endif
-	} cn63xxp1;
-	struct cvmx_l2c_int_ena_s cn66xx;
-	struct cvmx_l2c_int_ena_s cn68xx;
-	struct cvmx_l2c_int_ena_s cn68xxp1;
-	struct cvmx_l2c_int_ena_s cnf71xx;
-};
-
-union cvmx_l2c_int_reg {
-	uint64_t u64;
-	struct cvmx_l2c_int_reg_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t tad3:1;
-		uint64_t tad2:1;
-		uint64_t tad1:1;
-		uint64_t tad0:1;
-		uint64_t reserved_8_15:8;
-		uint64_t bigrd:1;
-		uint64_t bigwr:1;
-		uint64_t vrtpe:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtwr:1;
-		uint64_t holewr:1;
-		uint64_t holerd:1;
-#else
-		uint64_t holerd:1;
-		uint64_t holewr:1;
-		uint64_t vrtwr:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtpe:1;
-		uint64_t bigwr:1;
-		uint64_t bigrd:1;
-		uint64_t reserved_8_15:8;
-		uint64_t tad0:1;
-		uint64_t tad1:1;
-		uint64_t tad2:1;
-		uint64_t tad3:1;
-		uint64_t reserved_20_63:44;
-#endif
-	} s;
-	struct cvmx_l2c_int_reg_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
-		uint64_t tad0:1;
-		uint64_t reserved_8_15:8;
-		uint64_t bigrd:1;
-		uint64_t bigwr:1;
-		uint64_t vrtpe:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtwr:1;
-		uint64_t holewr:1;
-		uint64_t holerd:1;
-#else
-		uint64_t holerd:1;
-		uint64_t holewr:1;
-		uint64_t vrtwr:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtpe:1;
-		uint64_t bigwr:1;
-		uint64_t bigrd:1;
-		uint64_t reserved_8_15:8;
-		uint64_t tad0:1;
-		uint64_t reserved_17_63:47;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_int_reg_cn61xx cn63xx;
-	struct cvmx_l2c_int_reg_cn63xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
-		uint64_t tad0:1;
-		uint64_t reserved_6_15:10;
-		uint64_t vrtpe:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtwr:1;
-		uint64_t holewr:1;
-		uint64_t holerd:1;
-#else
-		uint64_t holerd:1;
-		uint64_t holewr:1;
-		uint64_t vrtwr:1;
-		uint64_t vrtidrng:1;
-		uint64_t vrtadrng:1;
-		uint64_t vrtpe:1;
-		uint64_t reserved_6_15:10;
-		uint64_t tad0:1;
-		uint64_t reserved_17_63:47;
-#endif
-	} cn63xxp1;
-	struct cvmx_l2c_int_reg_cn61xx cn66xx;
-	struct cvmx_l2c_int_reg_s cn68xx;
-	struct cvmx_l2c_int_reg_s cn68xxp1;
-	struct cvmx_l2c_int_reg_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_int_stat {
-	uint64_t u64;
-	struct cvmx_l2c_int_stat_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t lck2:1;
-		uint64_t lck:1;
-		uint64_t l2dded:1;
-		uint64_t l2dsec:1;
-		uint64_t l2tded:1;
-		uint64_t l2tsec:1;
-		uint64_t oob3:1;
-		uint64_t oob2:1;
-		uint64_t oob1:1;
-#else
-		uint64_t oob1:1;
-		uint64_t oob2:1;
-		uint64_t oob3:1;
-		uint64_t l2tsec:1;
-		uint64_t l2tded:1;
-		uint64_t l2dsec:1;
-		uint64_t l2dded:1;
-		uint64_t lck:1;
-		uint64_t lck2:1;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_int_stat_s cn52xx;
-	struct cvmx_l2c_int_stat_s cn52xxp1;
-	struct cvmx_l2c_int_stat_s cn56xx;
-	struct cvmx_l2c_int_stat_s cn56xxp1;
-};
-
-union cvmx_l2c_iocx_pfc {
-	uint64_t u64;
-	struct cvmx_l2c_iocx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_iocx_pfc_s cn61xx;
-	struct cvmx_l2c_iocx_pfc_s cn63xx;
-	struct cvmx_l2c_iocx_pfc_s cn63xxp1;
-	struct cvmx_l2c_iocx_pfc_s cn66xx;
-	struct cvmx_l2c_iocx_pfc_s cn68xx;
-	struct cvmx_l2c_iocx_pfc_s cn68xxp1;
-	struct cvmx_l2c_iocx_pfc_s cnf71xx;
-};
-
-union cvmx_l2c_iorx_pfc {
-	uint64_t u64;
-	struct cvmx_l2c_iorx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_iorx_pfc_s cn61xx;
-	struct cvmx_l2c_iorx_pfc_s cn63xx;
-	struct cvmx_l2c_iorx_pfc_s cn63xxp1;
-	struct cvmx_l2c_iorx_pfc_s cn66xx;
-	struct cvmx_l2c_iorx_pfc_s cn68xx;
-	struct cvmx_l2c_iorx_pfc_s cn68xxp1;
-	struct cvmx_l2c_iorx_pfc_s cnf71xx;
-};
-
-union cvmx_l2c_lckbase {
-	uint64_t u64;
-	struct cvmx_l2c_lckbase_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_31_63:33;
-		uint64_t lck_base:27;
-		uint64_t reserved_1_3:3;
-		uint64_t lck_ena:1;
-#else
-		uint64_t lck_ena:1;
-		uint64_t reserved_1_3:3;
-		uint64_t lck_base:27;
-		uint64_t reserved_31_63:33;
-#endif
-	} s;
-	struct cvmx_l2c_lckbase_s cn30xx;
-	struct cvmx_l2c_lckbase_s cn31xx;
-	struct cvmx_l2c_lckbase_s cn38xx;
-	struct cvmx_l2c_lckbase_s cn38xxp2;
-	struct cvmx_l2c_lckbase_s cn50xx;
-	struct cvmx_l2c_lckbase_s cn52xx;
-	struct cvmx_l2c_lckbase_s cn52xxp1;
-	struct cvmx_l2c_lckbase_s cn56xx;
-	struct cvmx_l2c_lckbase_s cn56xxp1;
-	struct cvmx_l2c_lckbase_s cn58xx;
-	struct cvmx_l2c_lckbase_s cn58xxp1;
-};
-
-union cvmx_l2c_lckoff {
-	uint64_t u64;
-	struct cvmx_l2c_lckoff_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_10_63:54;
-		uint64_t lck_offset:10;
-#else
-		uint64_t lck_offset:10;
-		uint64_t reserved_10_63:54;
-#endif
-	} s;
-	struct cvmx_l2c_lckoff_s cn30xx;
-	struct cvmx_l2c_lckoff_s cn31xx;
-	struct cvmx_l2c_lckoff_s cn38xx;
-	struct cvmx_l2c_lckoff_s cn38xxp2;
-	struct cvmx_l2c_lckoff_s cn50xx;
-	struct cvmx_l2c_lckoff_s cn52xx;
-	struct cvmx_l2c_lckoff_s cn52xxp1;
-	struct cvmx_l2c_lckoff_s cn56xx;
-	struct cvmx_l2c_lckoff_s cn56xxp1;
-	struct cvmx_l2c_lckoff_s cn58xx;
-	struct cvmx_l2c_lckoff_s cn58xxp1;
-};
-
-union cvmx_l2c_lfb0 {
-	uint64_t u64;
-	struct cvmx_l2c_lfb0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t stcpnd:1;
-		uint64_t stpnd:1;
-		uint64_t stinv:1;
-		uint64_t stcfl:1;
-		uint64_t vam:1;
-		uint64_t inxt:4;
-		uint64_t itl:1;
-		uint64_t ihd:1;
-		uint64_t set:3;
-		uint64_t vabnum:4;
-		uint64_t sid:9;
-		uint64_t cmd:4;
-		uint64_t vld:1;
-#else
-		uint64_t vld:1;
-		uint64_t cmd:4;
-		uint64_t sid:9;
-		uint64_t vabnum:4;
-		uint64_t set:3;
-		uint64_t ihd:1;
-		uint64_t itl:1;
-		uint64_t inxt:4;
-		uint64_t vam:1;
-		uint64_t stcfl:1;
-		uint64_t stinv:1;
-		uint64_t stpnd:1;
-		uint64_t stcpnd:1;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_lfb0_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t stcpnd:1;
-		uint64_t stpnd:1;
-		uint64_t stinv:1;
-		uint64_t stcfl:1;
-		uint64_t vam:1;
-		uint64_t reserved_25_26:2;
-		uint64_t inxt:2;
-		uint64_t itl:1;
-		uint64_t ihd:1;
-		uint64_t reserved_20_20:1;
-		uint64_t set:2;
-		uint64_t reserved_16_17:2;
-		uint64_t vabnum:2;
-		uint64_t sid:9;
-		uint64_t cmd:4;
-		uint64_t vld:1;
-#else
-		uint64_t vld:1;
-		uint64_t cmd:4;
-		uint64_t sid:9;
-		uint64_t vabnum:2;
-		uint64_t reserved_16_17:2;
-		uint64_t set:2;
-		uint64_t reserved_20_20:1;
-		uint64_t ihd:1;
-		uint64_t itl:1;
-		uint64_t inxt:2;
-		uint64_t reserved_25_26:2;
-		uint64_t vam:1;
-		uint64_t stcfl:1;
-		uint64_t stinv:1;
-		uint64_t stpnd:1;
-		uint64_t stcpnd:1;
-		uint64_t reserved_32_63:32;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_lfb0_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t stcpnd:1;
-		uint64_t stpnd:1;
-		uint64_t stinv:1;
-		uint64_t stcfl:1;
-		uint64_t vam:1;
-		uint64_t reserved_26_26:1;
-		uint64_t inxt:3;
-		uint64_t itl:1;
-		uint64_t ihd:1;
-		uint64_t reserved_20_20:1;
-		uint64_t set:2;
-		uint64_t reserved_17_17:1;
-		uint64_t vabnum:3;
-		uint64_t sid:9;
-		uint64_t cmd:4;
-		uint64_t vld:1;
-#else
-		uint64_t vld:1;
-		uint64_t cmd:4;
-		uint64_t sid:9;
-		uint64_t vabnum:3;
-		uint64_t reserved_17_17:1;
-		uint64_t set:2;
-		uint64_t reserved_20_20:1;
-		uint64_t ihd:1;
-		uint64_t itl:1;
-		uint64_t inxt:3;
-		uint64_t reserved_26_26:1;
-		uint64_t vam:1;
-		uint64_t stcfl:1;
-		uint64_t stinv:1;
-		uint64_t stpnd:1;
-		uint64_t stcpnd:1;
-		uint64_t reserved_32_63:32;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_lfb0_s cn38xx;
-	struct cvmx_l2c_lfb0_s cn38xxp2;
-	struct cvmx_l2c_lfb0_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t stcpnd:1;
-		uint64_t stpnd:1;
-		uint64_t stinv:1;
-		uint64_t stcfl:1;
-		uint64_t vam:1;
-		uint64_t reserved_26_26:1;
-		uint64_t inxt:3;
-		uint64_t itl:1;
-		uint64_t ihd:1;
-		uint64_t set:3;
-		uint64_t reserved_17_17:1;
-		uint64_t vabnum:3;
-		uint64_t sid:9;
-		uint64_t cmd:4;
-		uint64_t vld:1;
-#else
-		uint64_t vld:1;
-		uint64_t cmd:4;
-		uint64_t sid:9;
-		uint64_t vabnum:3;
-		uint64_t reserved_17_17:1;
-		uint64_t set:3;
-		uint64_t ihd:1;
-		uint64_t itl:1;
-		uint64_t inxt:3;
-		uint64_t reserved_26_26:1;
-		uint64_t vam:1;
-		uint64_t stcfl:1;
-		uint64_t stinv:1;
-		uint64_t stpnd:1;
-		uint64_t stcpnd:1;
-		uint64_t reserved_32_63:32;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_lfb0_cn50xx cn52xx;
-	struct cvmx_l2c_lfb0_cn50xx cn52xxp1;
-	struct cvmx_l2c_lfb0_s cn56xx;
-	struct cvmx_l2c_lfb0_s cn56xxp1;
-	struct cvmx_l2c_lfb0_s cn58xx;
-	struct cvmx_l2c_lfb0_s cn58xxp1;
-};
-
-union cvmx_l2c_lfb1 {
-	uint64_t u64;
-	struct cvmx_l2c_lfb1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_19_63:45;
-		uint64_t dsgoing:1;
-		uint64_t bid:2;
-		uint64_t wtrsp:1;
-		uint64_t wtdw:1;
-		uint64_t wtdq:1;
-		uint64_t wtwhp:1;
-		uint64_t wtwhf:1;
-		uint64_t wtwrm:1;
-		uint64_t wtstm:1;
-		uint64_t wtrda:1;
-		uint64_t wtstdt:1;
-		uint64_t wtstrsp:1;
-		uint64_t wtstrsc:1;
-		uint64_t wtvtm:1;
-		uint64_t wtmfl:1;
-		uint64_t prbrty:1;
-		uint64_t wtprb:1;
-		uint64_t vld:1;
-#else
-		uint64_t vld:1;
-		uint64_t wtprb:1;
-		uint64_t prbrty:1;
-		uint64_t wtmfl:1;
-		uint64_t wtvtm:1;
-		uint64_t wtstrsc:1;
-		uint64_t wtstrsp:1;
-		uint64_t wtstdt:1;
-		uint64_t wtrda:1;
-		uint64_t wtstm:1;
-		uint64_t wtwrm:1;
-		uint64_t wtwhf:1;
-		uint64_t wtwhp:1;
-		uint64_t wtdq:1;
-		uint64_t wtdw:1;
-		uint64_t wtrsp:1;
-		uint64_t bid:2;
-		uint64_t dsgoing:1;
-		uint64_t reserved_19_63:45;
-#endif
-	} s;
-	struct cvmx_l2c_lfb1_s cn30xx;
-	struct cvmx_l2c_lfb1_s cn31xx;
-	struct cvmx_l2c_lfb1_s cn38xx;
-	struct cvmx_l2c_lfb1_s cn38xxp2;
-	struct cvmx_l2c_lfb1_s cn50xx;
-	struct cvmx_l2c_lfb1_s cn52xx;
-	struct cvmx_l2c_lfb1_s cn52xxp1;
-	struct cvmx_l2c_lfb1_s cn56xx;
-	struct cvmx_l2c_lfb1_s cn56xxp1;
-	struct cvmx_l2c_lfb1_s cn58xx;
-	struct cvmx_l2c_lfb1_s cn58xxp1;
-};
-
-union cvmx_l2c_lfb2 {
-	uint64_t u64;
-	struct cvmx_l2c_lfb2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_0_63:64;
-#else
-		uint64_t reserved_0_63:64;
-#endif
-	} s;
-	struct cvmx_l2c_lfb2_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_27_63:37;
-		uint64_t lfb_tag:19;
-		uint64_t lfb_idx:8;
-#else
-		uint64_t lfb_idx:8;
-		uint64_t lfb_tag:19;
-		uint64_t reserved_27_63:37;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_lfb2_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_27_63:37;
-		uint64_t lfb_tag:17;
-		uint64_t lfb_idx:10;
-#else
-		uint64_t lfb_idx:10;
-		uint64_t lfb_tag:17;
-		uint64_t reserved_27_63:37;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_lfb2_cn31xx cn38xx;
-	struct cvmx_l2c_lfb2_cn31xx cn38xxp2;
-	struct cvmx_l2c_lfb2_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_27_63:37;
-		uint64_t lfb_tag:20;
-		uint64_t lfb_idx:7;
-#else
-		uint64_t lfb_idx:7;
-		uint64_t lfb_tag:20;
-		uint64_t reserved_27_63:37;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_lfb2_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_27_63:37;
-		uint64_t lfb_tag:18;
-		uint64_t lfb_idx:9;
-#else
-		uint64_t lfb_idx:9;
-		uint64_t lfb_tag:18;
-		uint64_t reserved_27_63:37;
-#endif
-	} cn52xx;
-	struct cvmx_l2c_lfb2_cn52xx cn52xxp1;
-	struct cvmx_l2c_lfb2_cn56xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_27_63:37;
-		uint64_t lfb_tag:16;
-		uint64_t lfb_idx:11;
-#else
-		uint64_t lfb_idx:11;
-		uint64_t lfb_tag:16;
-		uint64_t reserved_27_63:37;
-#endif
-	} cn56xx;
-	struct cvmx_l2c_lfb2_cn56xx cn56xxp1;
-	struct cvmx_l2c_lfb2_cn56xx cn58xx;
-	struct cvmx_l2c_lfb2_cn56xx cn58xxp1;
-};
-
-union cvmx_l2c_lfb3 {
-	uint64_t u64;
-	struct cvmx_l2c_lfb3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_5_63:59;
-		uint64_t stpartdis:1;
-		uint64_t lfb_hwm:4;
-#else
-		uint64_t lfb_hwm:4;
-		uint64_t stpartdis:1;
-		uint64_t reserved_5_63:59;
-#endif
-	} s;
-	struct cvmx_l2c_lfb3_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_5_63:59;
-		uint64_t stpartdis:1;
-		uint64_t reserved_2_3:2;
-		uint64_t lfb_hwm:2;
-#else
-		uint64_t lfb_hwm:2;
-		uint64_t reserved_2_3:2;
-		uint64_t stpartdis:1;
-		uint64_t reserved_5_63:59;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_lfb3_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_5_63:59;
-		uint64_t stpartdis:1;
-		uint64_t reserved_3_3:1;
-		uint64_t lfb_hwm:3;
-#else
-		uint64_t lfb_hwm:3;
-		uint64_t reserved_3_3:1;
-		uint64_t stpartdis:1;
-		uint64_t reserved_5_63:59;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_lfb3_s cn38xx;
-	struct cvmx_l2c_lfb3_s cn38xxp2;
-	struct cvmx_l2c_lfb3_cn31xx cn50xx;
-	struct cvmx_l2c_lfb3_cn31xx cn52xx;
-	struct cvmx_l2c_lfb3_cn31xx cn52xxp1;
-	struct cvmx_l2c_lfb3_s cn56xx;
-	struct cvmx_l2c_lfb3_s cn56xxp1;
-	struct cvmx_l2c_lfb3_s cn58xx;
-	struct cvmx_l2c_lfb3_s cn58xxp1;
-};
-
-union cvmx_l2c_oob {
-	uint64_t u64;
-	struct cvmx_l2c_oob_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_2_63:62;
-		uint64_t dwbena:1;
-		uint64_t stena:1;
-#else
-		uint64_t stena:1;
-		uint64_t dwbena:1;
-		uint64_t reserved_2_63:62;
-#endif
-	} s;
-	struct cvmx_l2c_oob_s cn52xx;
-	struct cvmx_l2c_oob_s cn52xxp1;
-	struct cvmx_l2c_oob_s cn56xx;
-	struct cvmx_l2c_oob_s cn56xxp1;
-};
-
-union cvmx_l2c_oob1 {
-	uint64_t u64;
-	struct cvmx_l2c_oob1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t fadr:27;
-		uint64_t fsrc:1;
-		uint64_t reserved_34_35:2;
-		uint64_t sadr:14;
-		uint64_t reserved_14_19:6;
-		uint64_t size:14;
-#else
-		uint64_t size:14;
-		uint64_t reserved_14_19:6;
-		uint64_t sadr:14;
-		uint64_t reserved_34_35:2;
-		uint64_t fsrc:1;
-		uint64_t fadr:27;
-#endif
-	} s;
-	struct cvmx_l2c_oob1_s cn52xx;
-	struct cvmx_l2c_oob1_s cn52xxp1;
-	struct cvmx_l2c_oob1_s cn56xx;
-	struct cvmx_l2c_oob1_s cn56xxp1;
-};
-
-union cvmx_l2c_oob2 {
-	uint64_t u64;
-	struct cvmx_l2c_oob2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t fadr:27;
-		uint64_t fsrc:1;
-		uint64_t reserved_34_35:2;
-		uint64_t sadr:14;
-		uint64_t reserved_14_19:6;
-		uint64_t size:14;
-#else
-		uint64_t size:14;
-		uint64_t reserved_14_19:6;
-		uint64_t sadr:14;
-		uint64_t reserved_34_35:2;
-		uint64_t fsrc:1;
-		uint64_t fadr:27;
-#endif
-	} s;
-	struct cvmx_l2c_oob2_s cn52xx;
-	struct cvmx_l2c_oob2_s cn52xxp1;
-	struct cvmx_l2c_oob2_s cn56xx;
-	struct cvmx_l2c_oob2_s cn56xxp1;
-};
-
-union cvmx_l2c_oob3 {
-	uint64_t u64;
-	struct cvmx_l2c_oob3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t fadr:27;
-		uint64_t fsrc:1;
-		uint64_t reserved_34_35:2;
-		uint64_t sadr:14;
-		uint64_t reserved_14_19:6;
-		uint64_t size:14;
-#else
-		uint64_t size:14;
-		uint64_t reserved_14_19:6;
-		uint64_t sadr:14;
-		uint64_t reserved_34_35:2;
-		uint64_t fsrc:1;
-		uint64_t fadr:27;
-#endif
-	} s;
-	struct cvmx_l2c_oob3_s cn52xx;
-	struct cvmx_l2c_oob3_s cn52xxp1;
-	struct cvmx_l2c_oob3_s cn56xx;
-	struct cvmx_l2c_oob3_s cn56xxp1;
-};
-
-union cvmx_l2c_pfcx {
-	uint64_t u64;
-	struct cvmx_l2c_pfcx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_36_63:28;
-		uint64_t pfcnt0:36;
-#else
-		uint64_t pfcnt0:36;
-		uint64_t reserved_36_63:28;
-#endif
-	} s;
-	struct cvmx_l2c_pfcx_s cn30xx;
-	struct cvmx_l2c_pfcx_s cn31xx;
-	struct cvmx_l2c_pfcx_s cn38xx;
-	struct cvmx_l2c_pfcx_s cn38xxp2;
-	struct cvmx_l2c_pfcx_s cn50xx;
-	struct cvmx_l2c_pfcx_s cn52xx;
-	struct cvmx_l2c_pfcx_s cn52xxp1;
-	struct cvmx_l2c_pfcx_s cn56xx;
-	struct cvmx_l2c_pfcx_s cn56xxp1;
-	struct cvmx_l2c_pfcx_s cn58xx;
-	struct cvmx_l2c_pfcx_s cn58xxp1;
 };
 
 union cvmx_l2c_pfctl {
 	uint64_t u64;
 	struct cvmx_l2c_pfctl_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_36_63:28;
-		uint64_t cnt3rdclr:1;
-		uint64_t cnt2rdclr:1;
-		uint64_t cnt1rdclr:1;
-		uint64_t cnt0rdclr:1;
-		uint64_t cnt3ena:1;
-		uint64_t cnt3clr:1;
-		uint64_t cnt3sel:6;
-		uint64_t cnt2ena:1;
-		uint64_t cnt2clr:1;
-		uint64_t cnt2sel:6;
-		uint64_t cnt1ena:1;
-		uint64_t cnt1clr:1;
-		uint64_t cnt1sel:6;
-		uint64_t cnt0ena:1;
-		uint64_t cnt0clr:1;
-		uint64_t cnt0sel:6;
-#else
-		uint64_t cnt0sel:6;
-		uint64_t cnt0clr:1;
-		uint64_t cnt0ena:1;
-		uint64_t cnt1sel:6;
-		uint64_t cnt1clr:1;
-		uint64_t cnt1ena:1;
-		uint64_t cnt2sel:6;
-		uint64_t cnt2clr:1;
-		uint64_t cnt2ena:1;
-		uint64_t cnt3sel:6;
-		uint64_t cnt3clr:1;
-		uint64_t cnt3ena:1;
-		uint64_t cnt0rdclr:1;
-		uint64_t cnt1rdclr:1;
-		uint64_t cnt2rdclr:1;
-		uint64_t cnt3rdclr:1;
-		uint64_t reserved_36_63:28;
-#endif
-	} s;
-	struct cvmx_l2c_pfctl_s cn30xx;
-	struct cvmx_l2c_pfctl_s cn31xx;
-	struct cvmx_l2c_pfctl_s cn38xx;
-	struct cvmx_l2c_pfctl_s cn38xxp2;
-	struct cvmx_l2c_pfctl_s cn50xx;
-	struct cvmx_l2c_pfctl_s cn52xx;
-	struct cvmx_l2c_pfctl_s cn52xxp1;
-	struct cvmx_l2c_pfctl_s cn56xx;
-	struct cvmx_l2c_pfctl_s cn56xxp1;
-	struct cvmx_l2c_pfctl_s cn58xx;
-	struct cvmx_l2c_pfctl_s cn58xxp1;
-};
-
-union cvmx_l2c_ppgrp {
-	uint64_t u64;
-	struct cvmx_l2c_ppgrp_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t pp11grp:2;
-		uint64_t pp10grp:2;
-		uint64_t pp9grp:2;
-		uint64_t pp8grp:2;
-		uint64_t pp7grp:2;
-		uint64_t pp6grp:2;
-		uint64_t pp5grp:2;
-		uint64_t pp4grp:2;
-		uint64_t pp3grp:2;
-		uint64_t pp2grp:2;
-		uint64_t pp1grp:2;
-		uint64_t pp0grp:2;
-#else
-		uint64_t pp0grp:2;
-		uint64_t pp1grp:2;
-		uint64_t pp2grp:2;
-		uint64_t pp3grp:2;
-		uint64_t pp4grp:2;
-		uint64_t pp5grp:2;
-		uint64_t pp6grp:2;
-		uint64_t pp7grp:2;
-		uint64_t pp8grp:2;
-		uint64_t pp9grp:2;
-		uint64_t pp10grp:2;
-		uint64_t pp11grp:2;
-		uint64_t reserved_24_63:40;
-#endif
-	} s;
-	struct cvmx_l2c_ppgrp_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_8_63:56;
-		uint64_t pp3grp:2;
-		uint64_t pp2grp:2;
-		uint64_t pp1grp:2;
-		uint64_t pp0grp:2;
-#else
-		uint64_t pp0grp:2;
-		uint64_t pp1grp:2;
-		uint64_t pp2grp:2;
-		uint64_t pp3grp:2;
-		uint64_t reserved_8_63:56;
-#endif
-	} cn52xx;
-	struct cvmx_l2c_ppgrp_cn52xx cn52xxp1;
-	struct cvmx_l2c_ppgrp_s cn56xx;
-	struct cvmx_l2c_ppgrp_s cn56xxp1;
-};
-
-union cvmx_l2c_qos_iobx {
-	uint64_t u64;
-	struct cvmx_l2c_qos_iobx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_7_63:57;
-		uint64_t dwblvl:3;
-		uint64_t reserved_3_3:1;
-		uint64_t lvl:3;
-#else
-		uint64_t lvl:3;
-		uint64_t reserved_3_3:1;
-		uint64_t dwblvl:3;
-		uint64_t reserved_7_63:57;
-#endif
-	} s;
-	struct cvmx_l2c_qos_iobx_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_6_63:58;
-		uint64_t dwblvl:2;
-		uint64_t reserved_2_3:2;
-		uint64_t lvl:2;
-#else
-		uint64_t lvl:2;
-		uint64_t reserved_2_3:2;
-		uint64_t dwblvl:2;
-		uint64_t reserved_6_63:58;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_qos_iobx_cn61xx cn63xx;
-	struct cvmx_l2c_qos_iobx_cn61xx cn63xxp1;
-	struct cvmx_l2c_qos_iobx_cn61xx cn66xx;
-	struct cvmx_l2c_qos_iobx_s cn68xx;
-	struct cvmx_l2c_qos_iobx_s cn68xxp1;
-	struct cvmx_l2c_qos_iobx_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_qos_ppx {
-	uint64_t u64;
-	struct cvmx_l2c_qos_ppx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_3_63:61;
-		uint64_t lvl:3;
-#else
-		uint64_t lvl:3;
-		uint64_t reserved_3_63:61;
-#endif
-	} s;
-	struct cvmx_l2c_qos_ppx_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_2_63:62;
-		uint64_t lvl:2;
-#else
-		uint64_t lvl:2;
-		uint64_t reserved_2_63:62;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_qos_ppx_cn61xx cn63xx;
-	struct cvmx_l2c_qos_ppx_cn61xx cn63xxp1;
-	struct cvmx_l2c_qos_ppx_cn61xx cn66xx;
-	struct cvmx_l2c_qos_ppx_s cn68xx;
-	struct cvmx_l2c_qos_ppx_s cn68xxp1;
-	struct cvmx_l2c_qos_ppx_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_qos_wgt {
-	uint64_t u64;
-	struct cvmx_l2c_qos_wgt_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t wgt7:8;
-		uint64_t wgt6:8;
-		uint64_t wgt5:8;
-		uint64_t wgt4:8;
-		uint64_t wgt3:8;
-		uint64_t wgt2:8;
-		uint64_t wgt1:8;
-		uint64_t wgt0:8;
-#else
-		uint64_t wgt0:8;
-		uint64_t wgt1:8;
-		uint64_t wgt2:8;
-		uint64_t wgt3:8;
-		uint64_t wgt4:8;
-		uint64_t wgt5:8;
-		uint64_t wgt6:8;
-		uint64_t wgt7:8;
-#endif
-	} s;
-	struct cvmx_l2c_qos_wgt_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t wgt3:8;
-		uint64_t wgt2:8;
-		uint64_t wgt1:8;
-		uint64_t wgt0:8;
-#else
-		uint64_t wgt0:8;
-		uint64_t wgt1:8;
-		uint64_t wgt2:8;
-		uint64_t wgt3:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_qos_wgt_cn61xx cn63xx;
-	struct cvmx_l2c_qos_wgt_cn61xx cn63xxp1;
-	struct cvmx_l2c_qos_wgt_cn61xx cn66xx;
-	struct cvmx_l2c_qos_wgt_s cn68xx;
-	struct cvmx_l2c_qos_wgt_s cn68xxp1;
-	struct cvmx_l2c_qos_wgt_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_rscx_pfc {
-	uint64_t u64;
-	struct cvmx_l2c_rscx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_rscx_pfc_s cn61xx;
-	struct cvmx_l2c_rscx_pfc_s cn63xx;
-	struct cvmx_l2c_rscx_pfc_s cn63xxp1;
-	struct cvmx_l2c_rscx_pfc_s cn66xx;
-	struct cvmx_l2c_rscx_pfc_s cn68xx;
-	struct cvmx_l2c_rscx_pfc_s cn68xxp1;
-	struct cvmx_l2c_rscx_pfc_s cnf71xx;
-};
-
-union cvmx_l2c_rsdx_pfc {
-	uint64_t u64;
-	struct cvmx_l2c_rsdx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_rsdx_pfc_s cn61xx;
-	struct cvmx_l2c_rsdx_pfc_s cn63xx;
-	struct cvmx_l2c_rsdx_pfc_s cn63xxp1;
-	struct cvmx_l2c_rsdx_pfc_s cn66xx;
-	struct cvmx_l2c_rsdx_pfc_s cn68xx;
-	struct cvmx_l2c_rsdx_pfc_s cn68xxp1;
-	struct cvmx_l2c_rsdx_pfc_s cnf71xx;
-};
-
-union cvmx_l2c_spar0 {
-	uint64_t u64;
-	struct cvmx_l2c_spar0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t umsk3:8;
-		uint64_t umsk2:8;
-		uint64_t umsk1:8;
-		uint64_t umsk0:8;
-#else
-		uint64_t umsk0:8;
-		uint64_t umsk1:8;
-		uint64_t umsk2:8;
-		uint64_t umsk3:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_spar0_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_4_63:60;
-		uint64_t umsk0:4;
-#else
-		uint64_t umsk0:4;
-		uint64_t reserved_4_63:60;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_spar0_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_12_63:52;
-		uint64_t umsk1:4;
-		uint64_t reserved_4_7:4;
-		uint64_t umsk0:4;
-#else
-		uint64_t umsk0:4;
-		uint64_t reserved_4_7:4;
-		uint64_t umsk1:4;
-		uint64_t reserved_12_63:52;
-#endif
-	} cn31xx;
-	struct cvmx_l2c_spar0_s cn38xx;
-	struct cvmx_l2c_spar0_s cn38xxp2;
-	struct cvmx_l2c_spar0_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t umsk1:8;
-		uint64_t umsk0:8;
-#else
-		uint64_t umsk0:8;
-		uint64_t umsk1:8;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn50xx;
-	struct cvmx_l2c_spar0_s cn52xx;
-	struct cvmx_l2c_spar0_s cn52xxp1;
-	struct cvmx_l2c_spar0_s cn56xx;
-	struct cvmx_l2c_spar0_s cn56xxp1;
-	struct cvmx_l2c_spar0_s cn58xx;
-	struct cvmx_l2c_spar0_s cn58xxp1;
-};
-
-union cvmx_l2c_spar1 {
-	uint64_t u64;
-	struct cvmx_l2c_spar1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t umsk7:8;
-		uint64_t umsk6:8;
-		uint64_t umsk5:8;
-		uint64_t umsk4:8;
-#else
-		uint64_t umsk4:8;
-		uint64_t umsk5:8;
-		uint64_t umsk6:8;
-		uint64_t umsk7:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_spar1_s cn38xx;
-	struct cvmx_l2c_spar1_s cn38xxp2;
-	struct cvmx_l2c_spar1_s cn56xx;
-	struct cvmx_l2c_spar1_s cn56xxp1;
-	struct cvmx_l2c_spar1_s cn58xx;
-	struct cvmx_l2c_spar1_s cn58xxp1;
-};
-
-union cvmx_l2c_spar2 {
-	uint64_t u64;
-	struct cvmx_l2c_spar2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t umsk11:8;
-		uint64_t umsk10:8;
-		uint64_t umsk9:8;
-		uint64_t umsk8:8;
-#else
-		uint64_t umsk8:8;
-		uint64_t umsk9:8;
-		uint64_t umsk10:8;
-		uint64_t umsk11:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_spar2_s cn38xx;
-	struct cvmx_l2c_spar2_s cn38xxp2;
-	struct cvmx_l2c_spar2_s cn56xx;
-	struct cvmx_l2c_spar2_s cn56xxp1;
-	struct cvmx_l2c_spar2_s cn58xx;
-	struct cvmx_l2c_spar2_s cn58xxp1;
-};
-
-union cvmx_l2c_spar3 {
-	uint64_t u64;
-	struct cvmx_l2c_spar3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t umsk15:8;
-		uint64_t umsk14:8;
-		uint64_t umsk13:8;
-		uint64_t umsk12:8;
-#else
-		uint64_t umsk12:8;
-		uint64_t umsk13:8;
-		uint64_t umsk14:8;
-		uint64_t umsk15:8;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_spar3_s cn38xx;
-	struct cvmx_l2c_spar3_s cn38xxp2;
-	struct cvmx_l2c_spar3_s cn58xx;
-	struct cvmx_l2c_spar3_s cn58xxp1;
-};
-
-union cvmx_l2c_spar4 {
-	uint64_t u64;
-	struct cvmx_l2c_spar4_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_8_63:56;
-		uint64_t umskiob:8;
-#else
-		uint64_t umskiob:8;
-		uint64_t reserved_8_63:56;
-#endif
-	} s;
-	struct cvmx_l2c_spar4_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_4_63:60;
-		uint64_t umskiob:4;
-#else
-		uint64_t umskiob:4;
-		uint64_t reserved_4_63:60;
-#endif
-	} cn30xx;
-	struct cvmx_l2c_spar4_cn30xx cn31xx;
-	struct cvmx_l2c_spar4_s cn38xx;
-	struct cvmx_l2c_spar4_s cn38xxp2;
-	struct cvmx_l2c_spar4_s cn50xx;
-	struct cvmx_l2c_spar4_s cn52xx;
-	struct cvmx_l2c_spar4_s cn52xxp1;
-	struct cvmx_l2c_spar4_s cn56xx;
-	struct cvmx_l2c_spar4_s cn56xxp1;
-	struct cvmx_l2c_spar4_s cn58xx;
-	struct cvmx_l2c_spar4_s cn58xxp1;
-};
-
-union cvmx_l2c_tadx_ecc0 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_ecc0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_58_63:6;
-		uint64_t ow3ecc:10;
-		uint64_t reserved_42_47:6;
-		uint64_t ow2ecc:10;
-		uint64_t reserved_26_31:6;
-		uint64_t ow1ecc:10;
-		uint64_t reserved_10_15:6;
-		uint64_t ow0ecc:10;
-#else
-		uint64_t ow0ecc:10;
-		uint64_t reserved_10_15:6;
-		uint64_t ow1ecc:10;
-		uint64_t reserved_26_31:6;
-		uint64_t ow2ecc:10;
-		uint64_t reserved_42_47:6;
-		uint64_t ow3ecc:10;
-		uint64_t reserved_58_63:6;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_ecc0_s cn61xx;
-	struct cvmx_l2c_tadx_ecc0_s cn63xx;
-	struct cvmx_l2c_tadx_ecc0_s cn63xxp1;
-	struct cvmx_l2c_tadx_ecc0_s cn66xx;
-	struct cvmx_l2c_tadx_ecc0_s cn68xx;
-	struct cvmx_l2c_tadx_ecc0_s cn68xxp1;
-	struct cvmx_l2c_tadx_ecc0_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_ecc1 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_ecc1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_58_63:6;
-		uint64_t ow7ecc:10;
-		uint64_t reserved_42_47:6;
-		uint64_t ow6ecc:10;
-		uint64_t reserved_26_31:6;
-		uint64_t ow5ecc:10;
-		uint64_t reserved_10_15:6;
-		uint64_t ow4ecc:10;
-#else
-		uint64_t ow4ecc:10;
-		uint64_t reserved_10_15:6;
-		uint64_t ow5ecc:10;
-		uint64_t reserved_26_31:6;
-		uint64_t ow6ecc:10;
-		uint64_t reserved_42_47:6;
-		uint64_t ow7ecc:10;
-		uint64_t reserved_58_63:6;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_ecc1_s cn61xx;
-	struct cvmx_l2c_tadx_ecc1_s cn63xx;
-	struct cvmx_l2c_tadx_ecc1_s cn63xxp1;
-	struct cvmx_l2c_tadx_ecc1_s cn66xx;
-	struct cvmx_l2c_tadx_ecc1_s cn68xx;
-	struct cvmx_l2c_tadx_ecc1_s cn68xxp1;
-	struct cvmx_l2c_tadx_ecc1_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_ien {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_ien_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t wrdislmc:1;
-		uint64_t rddislmc:1;
-		uint64_t noway:1;
-		uint64_t vbfdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t tagsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t l2dsbe:1;
-#else
-		uint64_t l2dsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t tagsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t vbfdbe:1;
-		uint64_t noway:1;
-		uint64_t rddislmc:1;
-		uint64_t wrdislmc:1;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_ien_s cn61xx;
-	struct cvmx_l2c_tadx_ien_s cn63xx;
-	struct cvmx_l2c_tadx_ien_cn63xxp1 {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_7_63:57;
-		uint64_t noway:1;
-		uint64_t vbfdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t tagsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t l2dsbe:1;
-#else
-		uint64_t l2dsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t tagsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t vbfdbe:1;
-		uint64_t noway:1;
-		uint64_t reserved_7_63:57;
-#endif
-	} cn63xxp1;
-	struct cvmx_l2c_tadx_ien_s cn66xx;
-	struct cvmx_l2c_tadx_ien_s cn68xx;
-	struct cvmx_l2c_tadx_ien_s cn68xxp1;
-	struct cvmx_l2c_tadx_ien_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_int {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_int_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t wrdislmc:1;
-		uint64_t rddislmc:1;
-		uint64_t noway:1;
-		uint64_t vbfdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t tagsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t l2dsbe:1;
-#else
-		uint64_t l2dsbe:1;
-		uint64_t l2ddbe:1;
-		uint64_t tagsbe:1;
-		uint64_t tagdbe:1;
-		uint64_t vbfsbe:1;
-		uint64_t vbfdbe:1;
-		uint64_t noway:1;
-		uint64_t rddislmc:1;
-		uint64_t wrdislmc:1;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_int_s cn61xx;
-	struct cvmx_l2c_tadx_int_s cn63xx;
-	struct cvmx_l2c_tadx_int_s cn66xx;
-	struct cvmx_l2c_tadx_int_s cn68xx;
-	struct cvmx_l2c_tadx_int_s cn68xxp1;
-	struct cvmx_l2c_tadx_int_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_pfc0 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_pfc0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_pfc0_s cn61xx;
-	struct cvmx_l2c_tadx_pfc0_s cn63xx;
-	struct cvmx_l2c_tadx_pfc0_s cn63xxp1;
-	struct cvmx_l2c_tadx_pfc0_s cn66xx;
-	struct cvmx_l2c_tadx_pfc0_s cn68xx;
-	struct cvmx_l2c_tadx_pfc0_s cn68xxp1;
-	struct cvmx_l2c_tadx_pfc0_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_pfc1 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_pfc1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_pfc1_s cn61xx;
-	struct cvmx_l2c_tadx_pfc1_s cn63xx;
-	struct cvmx_l2c_tadx_pfc1_s cn63xxp1;
-	struct cvmx_l2c_tadx_pfc1_s cn66xx;
-	struct cvmx_l2c_tadx_pfc1_s cn68xx;
-	struct cvmx_l2c_tadx_pfc1_s cn68xxp1;
-	struct cvmx_l2c_tadx_pfc1_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_pfc2 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_pfc2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_pfc2_s cn61xx;
-	struct cvmx_l2c_tadx_pfc2_s cn63xx;
-	struct cvmx_l2c_tadx_pfc2_s cn63xxp1;
-	struct cvmx_l2c_tadx_pfc2_s cn66xx;
-	struct cvmx_l2c_tadx_pfc2_s cn68xx;
-	struct cvmx_l2c_tadx_pfc2_s cn68xxp1;
-	struct cvmx_l2c_tadx_pfc2_s cnf71xx;
-};
-
-union cvmx_l2c_tadx_pfc3 {
-	uint64_t u64;
-	struct cvmx_l2c_tadx_pfc3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_36_63:28,
+		__BITFIELD_FIELD(uint64_t cnt3rdclr:1,
+		__BITFIELD_FIELD(uint64_t cnt2rdclr:1,
+		__BITFIELD_FIELD(uint64_t cnt1rdclr:1,
+		__BITFIELD_FIELD(uint64_t cnt0rdclr:1,
+		__BITFIELD_FIELD(uint64_t cnt3ena:1,
+		__BITFIELD_FIELD(uint64_t cnt3clr:1,
+		__BITFIELD_FIELD(uint64_t cnt3sel:6,
+		__BITFIELD_FIELD(uint64_t cnt2ena:1,
+		__BITFIELD_FIELD(uint64_t cnt2clr:1,
+		__BITFIELD_FIELD(uint64_t cnt2sel:6,
+		__BITFIELD_FIELD(uint64_t cnt1ena:1,
+		__BITFIELD_FIELD(uint64_t cnt1clr:1,
+		__BITFIELD_FIELD(uint64_t cnt1sel:6,
+		__BITFIELD_FIELD(uint64_t cnt0ena:1,
+		__BITFIELD_FIELD(uint64_t cnt0clr:1,
+		__BITFIELD_FIELD(uint64_t cnt0sel:6,
+		;)))))))))))))))))
 	} s;
-	struct cvmx_l2c_tadx_pfc3_s cn61xx;
-	struct cvmx_l2c_tadx_pfc3_s cn63xx;
-	struct cvmx_l2c_tadx_pfc3_s cn63xxp1;
-	struct cvmx_l2c_tadx_pfc3_s cn66xx;
-	struct cvmx_l2c_tadx_pfc3_s cn68xx;
-	struct cvmx_l2c_tadx_pfc3_s cn68xxp1;
-	struct cvmx_l2c_tadx_pfc3_s cnf71xx;
 };
 
 union cvmx_l2c_tadx_prf {
 	uint64_t u64;
 	struct cvmx_l2c_tadx_prf_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t cnt3sel:8;
-		uint64_t cnt2sel:8;
-		uint64_t cnt1sel:8;
-		uint64_t cnt0sel:8;
-#else
-		uint64_t cnt0sel:8;
-		uint64_t cnt1sel:8;
-		uint64_t cnt2sel:8;
-		uint64_t cnt3sel:8;
-		uint64_t reserved_32_63:32;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_32_63:32,
+		__BITFIELD_FIELD(uint64_t cnt3sel:8,
+		__BITFIELD_FIELD(uint64_t cnt2sel:8,
+		__BITFIELD_FIELD(uint64_t cnt1sel:8,
+		__BITFIELD_FIELD(uint64_t cnt0sel:8,
+		;)))))
 	} s;
-	struct cvmx_l2c_tadx_prf_s cn61xx;
-	struct cvmx_l2c_tadx_prf_s cn63xx;
-	struct cvmx_l2c_tadx_prf_s cn63xxp1;
-	struct cvmx_l2c_tadx_prf_s cn66xx;
-	struct cvmx_l2c_tadx_prf_s cn68xx;
-	struct cvmx_l2c_tadx_prf_s cn68xxp1;
-	struct cvmx_l2c_tadx_prf_s cnf71xx;
 };
 
 union cvmx_l2c_tadx_tag {
 	uint64_t u64;
 	struct cvmx_l2c_tadx_tag_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_46_63:18;
-		uint64_t ecc:6;
-		uint64_t reserved_36_39:4;
-		uint64_t tag:19;
-		uint64_t reserved_4_16:13;
-		uint64_t use:1;
-		uint64_t valid:1;
-		uint64_t dirty:1;
-		uint64_t lock:1;
-#else
-		uint64_t lock:1;
-		uint64_t dirty:1;
-		uint64_t valid:1;
-		uint64_t use:1;
-		uint64_t reserved_4_16:13;
-		uint64_t tag:19;
-		uint64_t reserved_36_39:4;
-		uint64_t ecc:6;
-		uint64_t reserved_46_63:18;
-#endif
-	} s;
-	struct cvmx_l2c_tadx_tag_s cn61xx;
-	struct cvmx_l2c_tadx_tag_s cn63xx;
-	struct cvmx_l2c_tadx_tag_s cn63xxp1;
-	struct cvmx_l2c_tadx_tag_s cn66xx;
-	struct cvmx_l2c_tadx_tag_s cn68xx;
-	struct cvmx_l2c_tadx_tag_s cn68xxp1;
-	struct cvmx_l2c_tadx_tag_s cnf71xx;
-};
-
-union cvmx_l2c_ver_id {
-	uint64_t u64;
-	struct cvmx_l2c_ver_id_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t mask:64;
-#else
-		uint64_t mask:64;
-#endif
-	} s;
-	struct cvmx_l2c_ver_id_s cn61xx;
-	struct cvmx_l2c_ver_id_s cn63xx;
-	struct cvmx_l2c_ver_id_s cn63xxp1;
-	struct cvmx_l2c_ver_id_s cn66xx;
-	struct cvmx_l2c_ver_id_s cn68xx;
-	struct cvmx_l2c_ver_id_s cn68xxp1;
-	struct cvmx_l2c_ver_id_s cnf71xx;
-};
-
-union cvmx_l2c_ver_iob {
-	uint64_t u64;
-	struct cvmx_l2c_ver_iob_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_2_63:62;
-		uint64_t mask:2;
-#else
-		uint64_t mask:2;
-		uint64_t reserved_2_63:62;
-#endif
-	} s;
-	struct cvmx_l2c_ver_iob_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_1_63:63;
-		uint64_t mask:1;
-#else
-		uint64_t mask:1;
-		uint64_t reserved_1_63:63;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_ver_iob_cn61xx cn63xx;
-	struct cvmx_l2c_ver_iob_cn61xx cn63xxp1;
-	struct cvmx_l2c_ver_iob_cn61xx cn66xx;
-	struct cvmx_l2c_ver_iob_s cn68xx;
-	struct cvmx_l2c_ver_iob_s cn68xxp1;
-	struct cvmx_l2c_ver_iob_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_ver_msc {
-	uint64_t u64;
-	struct cvmx_l2c_ver_msc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_2_63:62;
-		uint64_t invl2:1;
-		uint64_t dwb:1;
-#else
-		uint64_t dwb:1;
-		uint64_t invl2:1;
-		uint64_t reserved_2_63:62;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_46_63:18,
+		__BITFIELD_FIELD(uint64_t ecc:6,
+		__BITFIELD_FIELD(uint64_t reserved_36_39:4,
+		__BITFIELD_FIELD(uint64_t tag:19,
+		__BITFIELD_FIELD(uint64_t reserved_4_16:13,
+		__BITFIELD_FIELD(uint64_t use:1,
+		__BITFIELD_FIELD(uint64_t valid:1,
+		__BITFIELD_FIELD(uint64_t dirty:1,
+		__BITFIELD_FIELD(uint64_t lock:1,
+		;)))))))))
 	} s;
-	struct cvmx_l2c_ver_msc_s cn61xx;
-	struct cvmx_l2c_ver_msc_s cn63xx;
-	struct cvmx_l2c_ver_msc_s cn66xx;
-	struct cvmx_l2c_ver_msc_s cn68xx;
-	struct cvmx_l2c_ver_msc_s cn68xxp1;
-	struct cvmx_l2c_ver_msc_s cnf71xx;
 };
 
-union cvmx_l2c_ver_pp {
-	uint64_t u64;
-	struct cvmx_l2c_ver_pp_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t mask:32;
-#else
-		uint64_t mask:32;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_l2c_ver_pp_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_4_63:60;
-		uint64_t mask:4;
-#else
-		uint64_t mask:4;
-		uint64_t reserved_4_63:60;
-#endif
-	} cn61xx;
-	struct cvmx_l2c_ver_pp_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_6_63:58;
-		uint64_t mask:6;
-#else
-		uint64_t mask:6;
-		uint64_t reserved_6_63:58;
-#endif
-	} cn63xx;
-	struct cvmx_l2c_ver_pp_cn63xx cn63xxp1;
-	struct cvmx_l2c_ver_pp_cn66xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_10_63:54;
-		uint64_t mask:10;
-#else
-		uint64_t mask:10;
-		uint64_t reserved_10_63:54;
-#endif
-	} cn66xx;
-	struct cvmx_l2c_ver_pp_s cn68xx;
-	struct cvmx_l2c_ver_pp_s cn68xxp1;
-	struct cvmx_l2c_ver_pp_cn61xx cnf71xx;
-};
-
-union cvmx_l2c_virtid_iobx {
-	uint64_t u64;
-	struct cvmx_l2c_virtid_iobx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_14_63:50;
-		uint64_t dwbid:6;
-		uint64_t reserved_6_7:2;
-		uint64_t id:6;
-#else
-		uint64_t id:6;
-		uint64_t reserved_6_7:2;
-		uint64_t dwbid:6;
-		uint64_t reserved_14_63:50;
-#endif
-	} s;
-	struct cvmx_l2c_virtid_iobx_s cn61xx;
-	struct cvmx_l2c_virtid_iobx_s cn63xx;
-	struct cvmx_l2c_virtid_iobx_s cn63xxp1;
-	struct cvmx_l2c_virtid_iobx_s cn66xx;
-	struct cvmx_l2c_virtid_iobx_s cn68xx;
-	struct cvmx_l2c_virtid_iobx_s cn68xxp1;
-	struct cvmx_l2c_virtid_iobx_s cnf71xx;
-};
-
-union cvmx_l2c_virtid_ppx {
-	uint64_t u64;
-	struct cvmx_l2c_virtid_ppx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_6_63:58;
-		uint64_t id:6;
-#else
-		uint64_t id:6;
-		uint64_t reserved_6_63:58;
-#endif
-	} s;
-	struct cvmx_l2c_virtid_ppx_s cn61xx;
-	struct cvmx_l2c_virtid_ppx_s cn63xx;
-	struct cvmx_l2c_virtid_ppx_s cn63xxp1;
-	struct cvmx_l2c_virtid_ppx_s cn66xx;
-	struct cvmx_l2c_virtid_ppx_s cn68xx;
-	struct cvmx_l2c_virtid_ppx_s cn68xxp1;
-	struct cvmx_l2c_virtid_ppx_s cnf71xx;
-};
-
-union cvmx_l2c_vrt_ctl {
-	uint64_t u64;
-	struct cvmx_l2c_vrt_ctl_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_9_63:55;
-		uint64_t ooberr:1;
-		uint64_t reserved_7_7:1;
-		uint64_t memsz:3;
-		uint64_t numid:3;
-		uint64_t enable:1;
-#else
-		uint64_t enable:1;
-		uint64_t numid:3;
-		uint64_t memsz:3;
-		uint64_t reserved_7_7:1;
-		uint64_t ooberr:1;
-		uint64_t reserved_9_63:55;
-#endif
-	} s;
-	struct cvmx_l2c_vrt_ctl_s cn61xx;
-	struct cvmx_l2c_vrt_ctl_s cn63xx;
-	struct cvmx_l2c_vrt_ctl_s cn63xxp1;
-	struct cvmx_l2c_vrt_ctl_s cn66xx;
-	struct cvmx_l2c_vrt_ctl_s cn68xx;
-	struct cvmx_l2c_vrt_ctl_s cn68xxp1;
-	struct cvmx_l2c_vrt_ctl_s cnf71xx;
-};
-
-union cvmx_l2c_vrt_memx {
-	uint64_t u64;
-	struct cvmx_l2c_vrt_memx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_36_63:28;
-		uint64_t parity:4;
-		uint64_t data:32;
-#else
-		uint64_t data:32;
-		uint64_t parity:4;
-		uint64_t reserved_36_63:28;
-#endif
-	} s;
-	struct cvmx_l2c_vrt_memx_s cn61xx;
-	struct cvmx_l2c_vrt_memx_s cn63xx;
-	struct cvmx_l2c_vrt_memx_s cn63xxp1;
-	struct cvmx_l2c_vrt_memx_s cn66xx;
-	struct cvmx_l2c_vrt_memx_s cn68xx;
-	struct cvmx_l2c_vrt_memx_s cn68xxp1;
-	struct cvmx_l2c_vrt_memx_s cnf71xx;
-};
-
-union cvmx_l2c_wpar_iobx {
-	uint64_t u64;
-	struct cvmx_l2c_wpar_iobx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mask:16;
-#else
-		uint64_t mask:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} s;
-	struct cvmx_l2c_wpar_iobx_s cn61xx;
-	struct cvmx_l2c_wpar_iobx_s cn63xx;
-	struct cvmx_l2c_wpar_iobx_s cn63xxp1;
-	struct cvmx_l2c_wpar_iobx_s cn66xx;
-	struct cvmx_l2c_wpar_iobx_s cn68xx;
-	struct cvmx_l2c_wpar_iobx_s cn68xxp1;
-	struct cvmx_l2c_wpar_iobx_s cnf71xx;
-};
-
-union cvmx_l2c_wpar_ppx {
-	uint64_t u64;
-	struct cvmx_l2c_wpar_ppx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t mask:16;
-#else
-		uint64_t mask:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} s;
-	struct cvmx_l2c_wpar_ppx_s cn61xx;
-	struct cvmx_l2c_wpar_ppx_s cn63xx;
-	struct cvmx_l2c_wpar_ppx_s cn63xxp1;
-	struct cvmx_l2c_wpar_ppx_s cn66xx;
-	struct cvmx_l2c_wpar_ppx_s cn68xx;
-	struct cvmx_l2c_wpar_ppx_s cn68xxp1;
-	struct cvmx_l2c_wpar_ppx_s cnf71xx;
-};
-
-union cvmx_l2c_xmcx_pfc {
-	uint64_t u64;
-	struct cvmx_l2c_xmcx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
-	} s;
-	struct cvmx_l2c_xmcx_pfc_s cn61xx;
-	struct cvmx_l2c_xmcx_pfc_s cn63xx;
-	struct cvmx_l2c_xmcx_pfc_s cn63xxp1;
-	struct cvmx_l2c_xmcx_pfc_s cn66xx;
-	struct cvmx_l2c_xmcx_pfc_s cn68xx;
-	struct cvmx_l2c_xmcx_pfc_s cn68xxp1;
-	struct cvmx_l2c_xmcx_pfc_s cnf71xx;
-};
-
-union cvmx_l2c_xmc_cmd {
+union cvmx_l2c_lckbase {
 	uint64_t u64;
-	struct cvmx_l2c_xmc_cmd_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t inuse:1;
-		uint64_t cmd:6;
-		uint64_t reserved_38_56:19;
-		uint64_t addr:38;
-#else
-		uint64_t addr:38;
-		uint64_t reserved_38_56:19;
-		uint64_t cmd:6;
-		uint64_t inuse:1;
-#endif
+	struct cvmx_l2c_lckbase_s {
+		__BITFIELD_FIELD(uint64_t reserved_31_63:33,
+		__BITFIELD_FIELD(uint64_t lck_base:27,
+		__BITFIELD_FIELD(uint64_t reserved_1_3:3,
+		__BITFIELD_FIELD(uint64_t lck_ena:1,
+		;))))
 	} s;
-	struct cvmx_l2c_xmc_cmd_s cn61xx;
-	struct cvmx_l2c_xmc_cmd_s cn63xx;
-	struct cvmx_l2c_xmc_cmd_s cn63xxp1;
-	struct cvmx_l2c_xmc_cmd_s cn66xx;
-	struct cvmx_l2c_xmc_cmd_s cn68xx;
-	struct cvmx_l2c_xmc_cmd_s cn68xxp1;
-	struct cvmx_l2c_xmc_cmd_s cnf71xx;
 };
 
-union cvmx_l2c_xmdx_pfc {
+union cvmx_l2c_lckoff {
 	uint64_t u64;
-	struct cvmx_l2c_xmdx_pfc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t count:64;
-#else
-		uint64_t count:64;
-#endif
+	struct cvmx_l2c_lckoff_s {
+		__BITFIELD_FIELD(uint64_t reserved_10_63:54,
+		__BITFIELD_FIELD(uint64_t lck_offset:10,
+		;))
 	} s;
-	struct cvmx_l2c_xmdx_pfc_s cn61xx;
-	struct cvmx_l2c_xmdx_pfc_s cn63xx;
-	struct cvmx_l2c_xmdx_pfc_s cn63xxp1;
-	struct cvmx_l2c_xmdx_pfc_s cn66xx;
-	struct cvmx_l2c_xmdx_pfc_s cn68xx;
-	struct cvmx_l2c_xmdx_pfc_s cn68xxp1;
-	struct cvmx_l2c_xmdx_pfc_s cnf71xx;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c.h b/arch/mips/include/asm/octeon/cvmx-l2c.h
index ddb4292..d9e4873 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -33,48 +33,37 @@
 #ifndef __CVMX_L2C_H__
 #define __CVMX_L2C_H__
 
-#define CVMX_L2_ASSOC	  cvmx_l2c_get_num_assoc()   /* Deprecated macro, use function */
-#define CVMX_L2_SET_BITS  cvmx_l2c_get_set_bits()    /* Deprecated macro, use function */
-#define CVMX_L2_SETS	  cvmx_l2c_get_num_sets()    /* Deprecated macro, use function */
+#define CVMX_L2_ASSOC	 cvmx_l2c_get_num_assoc()	/* Deprecated macro */
+#define CVMX_L2_SET_BITS cvmx_l2c_get_set_bits()	/* Deprecated macro */
+#define CVMX_L2_SETS	 cvmx_l2c_get_num_sets()	/* Deprecated macro */
 
-
-#define CVMX_L2C_IDX_ADDR_SHIFT 7  /* based on 128 byte cache line size */
+/* Based on 128 byte cache line size */
+#define CVMX_L2C_IDX_ADDR_SHIFT	7
 #define CVMX_L2C_IDX_MASK	(cvmx_l2c_get_num_sets() - 1)
 
 /* Defines for index aliasing computations */
-#define CVMX_L2C_TAG_ADDR_ALIAS_SHIFT (CVMX_L2C_IDX_ADDR_SHIFT + cvmx_l2c_get_set_bits())
+#define CVMX_L2C_TAG_ADDR_ALIAS_SHIFT (CVMX_L2C_IDX_ADDR_SHIFT +	       \
+		cvmx_l2c_get_set_bits())
 #define CVMX_L2C_ALIAS_MASK (CVMX_L2C_IDX_MASK << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT)
-#define CVMX_L2C_MEMBANK_SELECT_SIZE  4096
+#define CVMX_L2C_MEMBANK_SELECT_SIZE 4096
 
-/* Defines for Virtualizations, valid only from Octeon II onwards. */
-#define CVMX_L2C_VRT_MAX_VIRTID_ALLOWED ((OCTEON_IS_MODEL(OCTEON_CN63XX)) ? 64 : 0)
-#define CVMX_L2C_VRT_MAX_MEMSZ_ALLOWED ((OCTEON_IS_MODEL(OCTEON_CN63XX)) ? 32 : 0)
+/* Number of L2C Tag-and-data sections (TADs) that are connected to LMC. */
+#define CVMX_L2C_TADS  1
 
 union cvmx_l2c_tag {
 	uint64_t u64;
 	struct {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved:28;
-		uint64_t V:1;		/* Line valid */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t L:1;		/* Line locked */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t addr:32;	/* Phys mem (not all bits valid) */
-#else
-		uint64_t addr:32;	/* Phys mem (not all bits valid) */
-		uint64_t U:1;		/* Use, LRU eviction */
-		uint64_t L:1;		/* Line locked */
-		uint64_t D:1;		/* Line dirty */
-		uint64_t V:1;		/* Line valid */
-		uint64_t reserved:28;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved:28,
+		__BITFIELD_FIELD(uint64_t V:1,
+		__BITFIELD_FIELD(uint64_t D:1,
+		__BITFIELD_FIELD(uint64_t L:1,
+		__BITFIELD_FIELD(uint64_t U:1,
+		__BITFIELD_FIELD(uint64_t addr:32,
+		;))))))
 	} s;
 };
 
-/* Number of L2C Tag-and-data sections (TADs) that are connected to LMC. */
-#define CVMX_L2C_TADS  1
-
-  /* L2C Performance Counter events. */
+/* L2C Performance Counter events. */
 enum cvmx_l2c_event {
 	CVMX_L2C_EVENT_CYCLES		=  0,
 	CVMX_L2C_EVENT_INSTRUCTION_MISS =  1,
@@ -175,7 +164,8 @@ enum cvmx_l2c_tad_event {
  *
  * @note The routine does not clear the counter.
  */
-void cvmx_l2c_config_perf(uint32_t counter, enum cvmx_l2c_event event, uint32_t clear_on_read);
+void cvmx_l2c_config_perf(uint32_t counter, enum cvmx_l2c_event event,
+			  uint32_t clear_on_read);
 
 /**
  * Read the given L2 Cache performance counter. The counter must be configured
@@ -307,8 +297,11 @@ enum cvmx_l2c_tad_event {
 union cvmx_l2c_tag cvmx_l2c_get_tag(uint32_t association, uint32_t index);
 
 /* Wrapper providing a deprecated old function name */
-static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association, uint32_t index) __attribute__((deprecated));
-static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association, uint32_t index)
+static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association,
+						  uint32_t index)
+						  __attribute__((deprecated));
+static inline union cvmx_l2c_tag cvmx_get_l2c_tag(uint32_t association,
+						  uint32_t index)
 {
 	return cvmx_l2c_get_tag(association, index);
 }
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
deleted file mode 100644
index 11a4562..0000000
--- a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
+++ /dev/null
@@ -1,526 +0,0 @@
-/***********************license start***************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2012 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
-
-#ifndef __CVMX_L2D_DEFS_H__
-#define __CVMX_L2D_DEFS_H__
-
-#define CVMX_L2D_BST0 (CVMX_ADD_IO_SEG(0x0001180080000780ull))
-#define CVMX_L2D_BST1 (CVMX_ADD_IO_SEG(0x0001180080000788ull))
-#define CVMX_L2D_BST2 (CVMX_ADD_IO_SEG(0x0001180080000790ull))
-#define CVMX_L2D_BST3 (CVMX_ADD_IO_SEG(0x0001180080000798ull))
-#define CVMX_L2D_ERR (CVMX_ADD_IO_SEG(0x0001180080000010ull))
-#define CVMX_L2D_FADR (CVMX_ADD_IO_SEG(0x0001180080000018ull))
-#define CVMX_L2D_FSYN0 (CVMX_ADD_IO_SEG(0x0001180080000020ull))
-#define CVMX_L2D_FSYN1 (CVMX_ADD_IO_SEG(0x0001180080000028ull))
-#define CVMX_L2D_FUS0 (CVMX_ADD_IO_SEG(0x00011800800007A0ull))
-#define CVMX_L2D_FUS1 (CVMX_ADD_IO_SEG(0x00011800800007A8ull))
-#define CVMX_L2D_FUS2 (CVMX_ADD_IO_SEG(0x00011800800007B0ull))
-#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
-
-union cvmx_l2d_bst0 {
-	uint64_t u64;
-	struct cvmx_l2d_bst0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_35_63:29;
-		uint64_t ftl:1;
-		uint64_t q0stat:34;
-#else
-		uint64_t q0stat:34;
-		uint64_t ftl:1;
-		uint64_t reserved_35_63:29;
-#endif
-	} s;
-	struct cvmx_l2d_bst0_s cn30xx;
-	struct cvmx_l2d_bst0_s cn31xx;
-	struct cvmx_l2d_bst0_s cn38xx;
-	struct cvmx_l2d_bst0_s cn38xxp2;
-	struct cvmx_l2d_bst0_s cn50xx;
-	struct cvmx_l2d_bst0_s cn52xx;
-	struct cvmx_l2d_bst0_s cn52xxp1;
-	struct cvmx_l2d_bst0_s cn56xx;
-	struct cvmx_l2d_bst0_s cn56xxp1;
-	struct cvmx_l2d_bst0_s cn58xx;
-	struct cvmx_l2d_bst0_s cn58xxp1;
-};
-
-union cvmx_l2d_bst1 {
-	uint64_t u64;
-	struct cvmx_l2d_bst1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q1stat:34;
-#else
-		uint64_t q1stat:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_bst1_s cn30xx;
-	struct cvmx_l2d_bst1_s cn31xx;
-	struct cvmx_l2d_bst1_s cn38xx;
-	struct cvmx_l2d_bst1_s cn38xxp2;
-	struct cvmx_l2d_bst1_s cn50xx;
-	struct cvmx_l2d_bst1_s cn52xx;
-	struct cvmx_l2d_bst1_s cn52xxp1;
-	struct cvmx_l2d_bst1_s cn56xx;
-	struct cvmx_l2d_bst1_s cn56xxp1;
-	struct cvmx_l2d_bst1_s cn58xx;
-	struct cvmx_l2d_bst1_s cn58xxp1;
-};
-
-union cvmx_l2d_bst2 {
-	uint64_t u64;
-	struct cvmx_l2d_bst2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q2stat:34;
-#else
-		uint64_t q2stat:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_bst2_s cn30xx;
-	struct cvmx_l2d_bst2_s cn31xx;
-	struct cvmx_l2d_bst2_s cn38xx;
-	struct cvmx_l2d_bst2_s cn38xxp2;
-	struct cvmx_l2d_bst2_s cn50xx;
-	struct cvmx_l2d_bst2_s cn52xx;
-	struct cvmx_l2d_bst2_s cn52xxp1;
-	struct cvmx_l2d_bst2_s cn56xx;
-	struct cvmx_l2d_bst2_s cn56xxp1;
-	struct cvmx_l2d_bst2_s cn58xx;
-	struct cvmx_l2d_bst2_s cn58xxp1;
-};
-
-union cvmx_l2d_bst3 {
-	uint64_t u64;
-	struct cvmx_l2d_bst3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q3stat:34;
-#else
-		uint64_t q3stat:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_bst3_s cn30xx;
-	struct cvmx_l2d_bst3_s cn31xx;
-	struct cvmx_l2d_bst3_s cn38xx;
-	struct cvmx_l2d_bst3_s cn38xxp2;
-	struct cvmx_l2d_bst3_s cn50xx;
-	struct cvmx_l2d_bst3_s cn52xx;
-	struct cvmx_l2d_bst3_s cn52xxp1;
-	struct cvmx_l2d_bst3_s cn56xx;
-	struct cvmx_l2d_bst3_s cn56xxp1;
-	struct cvmx_l2d_bst3_s cn58xx;
-	struct cvmx_l2d_bst3_s cn58xxp1;
-};
-
-union cvmx_l2d_err {
-	uint64_t u64;
-	struct cvmx_l2d_err_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_6_63:58;
-		uint64_t bmhclsel:1;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t bmhclsel:1;
-		uint64_t reserved_6_63:58;
-#endif
-	} s;
-	struct cvmx_l2d_err_s cn30xx;
-	struct cvmx_l2d_err_s cn31xx;
-	struct cvmx_l2d_err_s cn38xx;
-	struct cvmx_l2d_err_s cn38xxp2;
-	struct cvmx_l2d_err_s cn50xx;
-	struct cvmx_l2d_err_s cn52xx;
-	struct cvmx_l2d_err_s cn52xxp1;
-	struct cvmx_l2d_err_s cn56xx;
-	struct cvmx_l2d_err_s cn56xxp1;
-	struct cvmx_l2d_err_s cn58xx;
-	struct cvmx_l2d_err_s cn58xxp1;
-};
-
-union cvmx_l2d_fadr {
-	uint64_t u64;
-	struct cvmx_l2d_fadr_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_19_63:45;
-		uint64_t fadru:1;
-		uint64_t fowmsk:4;
-		uint64_t fset:3;
-		uint64_t fadr:11;
-#else
-		uint64_t fadr:11;
-		uint64_t fset:3;
-		uint64_t fowmsk:4;
-		uint64_t fadru:1;
-		uint64_t reserved_19_63:45;
-#endif
-	} s;
-	struct cvmx_l2d_fadr_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_18_63:46;
-		uint64_t fowmsk:4;
-		uint64_t reserved_13_13:1;
-		uint64_t fset:2;
-		uint64_t reserved_9_10:2;
-		uint64_t fadr:9;
-#else
-		uint64_t fadr:9;
-		uint64_t reserved_9_10:2;
-		uint64_t fset:2;
-		uint64_t reserved_13_13:1;
-		uint64_t fowmsk:4;
-		uint64_t reserved_18_63:46;
-#endif
-	} cn30xx;
-	struct cvmx_l2d_fadr_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_18_63:46;
-		uint64_t fowmsk:4;
-		uint64_t reserved_13_13:1;
-		uint64_t fset:2;
-		uint64_t reserved_10_10:1;
-		uint64_t fadr:10;
-#else
-		uint64_t fadr:10;
-		uint64_t reserved_10_10:1;
-		uint64_t fset:2;
-		uint64_t reserved_13_13:1;
-		uint64_t fowmsk:4;
-		uint64_t reserved_18_63:46;
-#endif
-	} cn31xx;
-	struct cvmx_l2d_fadr_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_18_63:46;
-		uint64_t fowmsk:4;
-		uint64_t fset:3;
-		uint64_t fadr:11;
-#else
-		uint64_t fadr:11;
-		uint64_t fset:3;
-		uint64_t fowmsk:4;
-		uint64_t reserved_18_63:46;
-#endif
-	} cn38xx;
-	struct cvmx_l2d_fadr_cn38xx cn38xxp2;
-	struct cvmx_l2d_fadr_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_18_63:46;
-		uint64_t fowmsk:4;
-		uint64_t fset:3;
-		uint64_t reserved_8_10:3;
-		uint64_t fadr:8;
-#else
-		uint64_t fadr:8;
-		uint64_t reserved_8_10:3;
-		uint64_t fset:3;
-		uint64_t fowmsk:4;
-		uint64_t reserved_18_63:46;
-#endif
-	} cn50xx;
-	struct cvmx_l2d_fadr_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_18_63:46;
-		uint64_t fowmsk:4;
-		uint64_t fset:3;
-		uint64_t reserved_10_10:1;
-		uint64_t fadr:10;
-#else
-		uint64_t fadr:10;
-		uint64_t reserved_10_10:1;
-		uint64_t fset:3;
-		uint64_t fowmsk:4;
-		uint64_t reserved_18_63:46;
-#endif
-	} cn52xx;
-	struct cvmx_l2d_fadr_cn52xx cn52xxp1;
-	struct cvmx_l2d_fadr_s cn56xx;
-	struct cvmx_l2d_fadr_s cn56xxp1;
-	struct cvmx_l2d_fadr_s cn58xx;
-	struct cvmx_l2d_fadr_s cn58xxp1;
-};
-
-union cvmx_l2d_fsyn0 {
-	uint64_t u64;
-	struct cvmx_l2d_fsyn0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t fsyn_ow1:10;
-		uint64_t fsyn_ow0:10;
-#else
-		uint64_t fsyn_ow0:10;
-		uint64_t fsyn_ow1:10;
-		uint64_t reserved_20_63:44;
-#endif
-	} s;
-	struct cvmx_l2d_fsyn0_s cn30xx;
-	struct cvmx_l2d_fsyn0_s cn31xx;
-	struct cvmx_l2d_fsyn0_s cn38xx;
-	struct cvmx_l2d_fsyn0_s cn38xxp2;
-	struct cvmx_l2d_fsyn0_s cn50xx;
-	struct cvmx_l2d_fsyn0_s cn52xx;
-	struct cvmx_l2d_fsyn0_s cn52xxp1;
-	struct cvmx_l2d_fsyn0_s cn56xx;
-	struct cvmx_l2d_fsyn0_s cn56xxp1;
-	struct cvmx_l2d_fsyn0_s cn58xx;
-	struct cvmx_l2d_fsyn0_s cn58xxp1;
-};
-
-union cvmx_l2d_fsyn1 {
-	uint64_t u64;
-	struct cvmx_l2d_fsyn1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t fsyn_ow3:10;
-		uint64_t fsyn_ow2:10;
-#else
-		uint64_t fsyn_ow2:10;
-		uint64_t fsyn_ow3:10;
-		uint64_t reserved_20_63:44;
-#endif
-	} s;
-	struct cvmx_l2d_fsyn1_s cn30xx;
-	struct cvmx_l2d_fsyn1_s cn31xx;
-	struct cvmx_l2d_fsyn1_s cn38xx;
-	struct cvmx_l2d_fsyn1_s cn38xxp2;
-	struct cvmx_l2d_fsyn1_s cn50xx;
-	struct cvmx_l2d_fsyn1_s cn52xx;
-	struct cvmx_l2d_fsyn1_s cn52xxp1;
-	struct cvmx_l2d_fsyn1_s cn56xx;
-	struct cvmx_l2d_fsyn1_s cn56xxp1;
-	struct cvmx_l2d_fsyn1_s cn58xx;
-	struct cvmx_l2d_fsyn1_s cn58xxp1;
-};
-
-union cvmx_l2d_fus0 {
-	uint64_t u64;
-	struct cvmx_l2d_fus0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q0fus:34;
-#else
-		uint64_t q0fus:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_fus0_s cn30xx;
-	struct cvmx_l2d_fus0_s cn31xx;
-	struct cvmx_l2d_fus0_s cn38xx;
-	struct cvmx_l2d_fus0_s cn38xxp2;
-	struct cvmx_l2d_fus0_s cn50xx;
-	struct cvmx_l2d_fus0_s cn52xx;
-	struct cvmx_l2d_fus0_s cn52xxp1;
-	struct cvmx_l2d_fus0_s cn56xx;
-	struct cvmx_l2d_fus0_s cn56xxp1;
-	struct cvmx_l2d_fus0_s cn58xx;
-	struct cvmx_l2d_fus0_s cn58xxp1;
-};
-
-union cvmx_l2d_fus1 {
-	uint64_t u64;
-	struct cvmx_l2d_fus1_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q1fus:34;
-#else
-		uint64_t q1fus:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_fus1_s cn30xx;
-	struct cvmx_l2d_fus1_s cn31xx;
-	struct cvmx_l2d_fus1_s cn38xx;
-	struct cvmx_l2d_fus1_s cn38xxp2;
-	struct cvmx_l2d_fus1_s cn50xx;
-	struct cvmx_l2d_fus1_s cn52xx;
-	struct cvmx_l2d_fus1_s cn52xxp1;
-	struct cvmx_l2d_fus1_s cn56xx;
-	struct cvmx_l2d_fus1_s cn56xxp1;
-	struct cvmx_l2d_fus1_s cn58xx;
-	struct cvmx_l2d_fus1_s cn58xxp1;
-};
-
-union cvmx_l2d_fus2 {
-	uint64_t u64;
-	struct cvmx_l2d_fus2_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_34_63:30;
-		uint64_t q2fus:34;
-#else
-		uint64_t q2fus:34;
-		uint64_t reserved_34_63:30;
-#endif
-	} s;
-	struct cvmx_l2d_fus2_s cn30xx;
-	struct cvmx_l2d_fus2_s cn31xx;
-	struct cvmx_l2d_fus2_s cn38xx;
-	struct cvmx_l2d_fus2_s cn38xxp2;
-	struct cvmx_l2d_fus2_s cn50xx;
-	struct cvmx_l2d_fus2_s cn52xx;
-	struct cvmx_l2d_fus2_s cn52xxp1;
-	struct cvmx_l2d_fus2_s cn56xx;
-	struct cvmx_l2d_fus2_s cn56xxp1;
-	struct cvmx_l2d_fus2_s cn58xx;
-	struct cvmx_l2d_fus2_s cn58xxp1;
-};
-
-union cvmx_l2d_fus3 {
-	uint64_t u64;
-	struct cvmx_l2d_fus3_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_40_63:24;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_34_36:3;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t reserved_34_36:3;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_40_63:24;
-#endif
-	} s;
-	struct cvmx_l2d_fus3_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_35_63:29;
-		uint64_t crip_64k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_64k:1;
-		uint64_t reserved_35_63:29;
-#endif
-	} cn30xx;
-	struct cvmx_l2d_fus3_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_35_63:29;
-		uint64_t crip_128k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_128k:1;
-		uint64_t reserved_35_63:29;
-#endif
-	} cn31xx;
-	struct cvmx_l2d_fus3_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_36_63:28;
-		uint64_t crip_256k:1;
-		uint64_t crip_512k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_512k:1;
-		uint64_t crip_256k:1;
-		uint64_t reserved_36_63:28;
-#endif
-	} cn38xx;
-	struct cvmx_l2d_fus3_cn38xx cn38xxp2;
-	struct cvmx_l2d_fus3_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_40_63:24;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_36_36:1;
-		uint64_t crip_32k:1;
-		uint64_t crip_64k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_64k:1;
-		uint64_t crip_32k:1;
-		uint64_t reserved_36_36:1;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_40_63:24;
-#endif
-	} cn50xx;
-	struct cvmx_l2d_fus3_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_40_63:24;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_36_36:1;
-		uint64_t crip_128k:1;
-		uint64_t crip_256k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_256k:1;
-		uint64_t crip_128k:1;
-		uint64_t reserved_36_36:1;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_40_63:24;
-#endif
-	} cn52xx;
-	struct cvmx_l2d_fus3_cn52xx cn52xxp1;
-	struct cvmx_l2d_fus3_cn56xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_40_63:24;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_36_36:1;
-		uint64_t crip_512k:1;
-		uint64_t crip_1024k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_1024k:1;
-		uint64_t crip_512k:1;
-		uint64_t reserved_36_36:1;
-		uint64_t ema_ctl:3;
-		uint64_t reserved_40_63:24;
-#endif
-	} cn56xx;
-	struct cvmx_l2d_fus3_cn56xx cn56xxp1;
-	struct cvmx_l2d_fus3_cn58xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_39_63:25;
-		uint64_t ema_ctl:2;
-		uint64_t reserved_36_36:1;
-		uint64_t crip_512k:1;
-		uint64_t crip_1024k:1;
-		uint64_t q3fus:34;
-#else
-		uint64_t q3fus:34;
-		uint64_t crip_1024k:1;
-		uint64_t crip_512k:1;
-		uint64_t reserved_36_36:1;
-		uint64_t ema_ctl:2;
-		uint64_t reserved_39_63:25;
-#endif
-	} cn58xx;
-	struct cvmx_l2d_fus3_cn58xx cn58xxp1;
-};
-
-#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
index 83ce22c..5af3b0c 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,210 +28,114 @@
 #ifndef __CVMX_L2T_DEFS_H__
 #define __CVMX_L2T_DEFS_H__
 
-#define CVMX_L2T_ERR (CVMX_ADD_IO_SEG(0x0001180080000008ull))
+#define CVMX_L2T_ERR	(CVMX_ADD_IO_SEG(0x0001180080000008ull))
+
 
 union cvmx_l2t_err {
 	uint64_t u64;
 	struct cvmx_l2t_err_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_29_63:35;
-		uint64_t fadru:1;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t fset:3;
-		uint64_t fadr:10;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:10;
-		uint64_t fset:3;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t fadru:1;
-		uint64_t reserved_29_63:35;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_29_63:35,
+		__BITFIELD_FIELD(uint64_t fadru:1,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t fset:3,
+		__BITFIELD_FIELD(uint64_t fadr:10,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;))))))))))))))
 	} s;
 	struct cvmx_l2t_err_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t reserved_23_23:1;
-		uint64_t fset:2;
-		uint64_t reserved_19_20:2;
-		uint64_t fadr:8;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:8;
-		uint64_t reserved_19_20:2;
-		uint64_t fset:2;
-		uint64_t reserved_23_23:1;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t reserved_28_63:36;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_28_63:36,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t reserved_23_23:1,
+		__BITFIELD_FIELD(uint64_t fset:2,
+		__BITFIELD_FIELD(uint64_t reserved_19_20:2,
+		__BITFIELD_FIELD(uint64_t fadr:8,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))))))))))
 	} cn30xx;
 	struct cvmx_l2t_err_cn31xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t reserved_23_23:1;
-		uint64_t fset:2;
-		uint64_t reserved_20_20:1;
-		uint64_t fadr:9;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:9;
-		uint64_t reserved_20_20:1;
-		uint64_t fset:2;
-		uint64_t reserved_23_23:1;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t reserved_28_63:36;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_28_63:36,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t reserved_23_23:1,
+		__BITFIELD_FIELD(uint64_t fset:2,
+		__BITFIELD_FIELD(uint64_t reserved_20_20:1,
+		__BITFIELD_FIELD(uint64_t fadr:9,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))))))))))
 	} cn31xx;
 	struct cvmx_l2t_err_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t fset:3;
-		uint64_t fadr:10;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:10;
-		uint64_t fset:3;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t reserved_28_63:36;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_28_63:36,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t fset:3,
+		__BITFIELD_FIELD(uint64_t fadr:10,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))))))))
 	} cn38xx;
 	struct cvmx_l2t_err_cn38xx cn38xxp2;
 	struct cvmx_l2t_err_cn50xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t fset:3;
-		uint64_t reserved_18_20:3;
-		uint64_t fadr:7;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:7;
-		uint64_t reserved_18_20:3;
-		uint64_t fset:3;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t reserved_28_63:36;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_28_63:36,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t fset:3,
+		__BITFIELD_FIELD(uint64_t reserved_18_20:3,
+		__BITFIELD_FIELD(uint64_t fadr:7,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;))))))))))))))
 	} cn50xx;
 	struct cvmx_l2t_err_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_28_63:36;
-		uint64_t lck_intena2:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr:1;
-		uint64_t fset:3;
-		uint64_t reserved_20_20:1;
-		uint64_t fadr:9;
-		uint64_t fsyn:6;
-		uint64_t ded_err:1;
-		uint64_t sec_err:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_intena:1;
-		uint64_t ecc_ena:1;
-#else
-		uint64_t ecc_ena:1;
-		uint64_t sec_intena:1;
-		uint64_t ded_intena:1;
-		uint64_t sec_err:1;
-		uint64_t ded_err:1;
-		uint64_t fsyn:6;
-		uint64_t fadr:9;
-		uint64_t reserved_20_20:1;
-		uint64_t fset:3;
-		uint64_t lckerr:1;
-		uint64_t lck_intena:1;
-		uint64_t lckerr2:1;
-		uint64_t lck_intena2:1;
-		uint64_t reserved_28_63:36;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_28_63:36,
+		__BITFIELD_FIELD(uint64_t lck_intena2:1,
+		__BITFIELD_FIELD(uint64_t lckerr2:1,
+		__BITFIELD_FIELD(uint64_t lck_intena:1,
+		__BITFIELD_FIELD(uint64_t lckerr:1,
+		__BITFIELD_FIELD(uint64_t fset:3,
+		__BITFIELD_FIELD(uint64_t reserved_20_20:1,
+		__BITFIELD_FIELD(uint64_t fadr:9,
+		__BITFIELD_FIELD(uint64_t fsyn:6,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;))))))))))))))
 	} cn52xx;
 	struct cvmx_l2t_err_cn52xx cn52xxp1;
 	struct cvmx_l2t_err_s cn56xx;
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 2530e87..9742202 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -62,7 +62,6 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-l2c-defs.h>
-#include <asm/octeon/cvmx-l2d-defs.h>
 #include <asm/octeon/cvmx-l2t-defs.h>
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
-- 
1.9.1
