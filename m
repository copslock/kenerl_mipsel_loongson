Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:43:12 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992336AbeCNWmI3CwDJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RL38Ub6ueRwznDM0kYcXPTqpgqN/BLoDeq40s6APEk4=;
 b=n3Y1qFoaKRGi6Je0JmgRIzV/TcXLcrmxodZjm086u7i/TYkoGjktFXnyeHa8y/ckdmct7vx8JVmPQzDyhEqq8dbKESFvYG0oRGSSoXzGQ6FzCCC6yFfBRDDnHbfj6Z0uWCmKC/Hj+FLCXiGn2ZgDprJTzHv5RPEzF2MqCL4/EXc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <carlos.munoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v5 5/7] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Wed, 14 Mar 2018 17:24:16 -0500
Message-Id: <1521066258-11376-6-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b179802-ebf2-49fb-ce65-08d589fcccef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:gNHBprFvLZAkj7MJF2zr18vHXdL7kPviHjU1Rk/ZX1RyBrvCUMLUqscDx/GIQcHRKjdQRfsAeP28oMyfUcMYFrKuisx1gL2q2F0Yle0pL6xgfelwsJFNesgA9rQo4GrDyoO0gLx/BKUqAR6FamGiXwvw02l+nL/dF9t7X5L/esGnLYQ1UDhE3E3jD0jn+8ZZGcIKN+Xduy4iO/nUXY2X4BfR2UZ2TeyNZ9mhhCm7fzG7AAScMprcmSsKvs89+p1x;25:czZgTu+Vdw+EKanXscsI8J9y+Tx+lMdE/ViSwp1wMr7w+nY3O8Xxpz/oZkaTns2A73jNhpAu5jig97IWFz18o/Eb1KQ/r3g0i7hA9zqecSiDlfvSH5r038PJi9rNoDNLJ8rX+fiRMDiRiwqxw5C1HEi+iQoL7Yxx8/e8gWtJAwKEWJe7uy8YzRd8tX2Vsgo1gYYvB0fTfmQgQBgWvagdQt1wSwwTMB2rEf2Wt3HpIyUxwqTrfrb/IE17OXFU0nmgdgr+loLbeZ2Vcs1znV7cS4axrCjRTF/WgsTtTzbCvXrxiQXPlDxYxjkM7YxRDunHU7gNe/OX/EwfuJcdbsOdMg==;31:I9oh7pey8TNOVBm+TBNuh4FoB9o1aAlpFLkXcEIdzwHjyJ8PAbbgOhM8UwWqbr/PpyVRHOjXu5TCfIOryNLoTb6LuMyonnXyLp30jHGr67WHcZ6C5zAVbzFkG/ZVwdYPzxx0jkPypvh/KAlotfhxr+Q8gsspksMtbQSmPFUu+Gl++uto2lg2EFIBwGZAbCzkk15O+mrRLml1nGH8kUppQWv5bLUvieF2xqQR4gnApqY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:7Qh4cLLGV1COuJU3XD/tJeADMWMJGR9FY4ZdVz/3TWCmM31I8akE/J2nmVn3RcspjPY53AoePHY/DJmMG2HVBYcEuIXY6fH6JSvBfsXtUY1QeT+sTsPnfrIIOg/kwg7/MQNpernjbFCKUvFiMV5sDOmz2Cp0b+eEJW6R58cGJuPlAlma36x3lGTTA30I22PgJ+cOmb2Qgpstuh4vfCuMPSjNBUsPLTUTdngNdq1lViJVJdVo57jpeFgykrqhMABKCOFLSKCkoYDNQWiDRzEDbv3F6yqIQd1/E360VqtRrdNosrB6FjuMDCdGdzIupeMp3sBspjbE0z2bN5dm2uN6fRff+hDWKwxwDv95CLyET226w/ht8DrhMldR9gLi+NySqNdAUZgtDFRv5aEk1Twe6Q9BDOn7KwYmZURb5hG7zRberL6MqPn4rFRUWDlite1drukSV6OrQ+oW6WC15hie+TGnvI3B5cgFmSNP2AM/xtLcp52qndjEFERW5Uh3N3LA;4:QfGiPypkhwBbeRHjKvEKM6AWx8adcFbCw/1BeCYebYdyBDF56BWyiC0bNBhv4gLcfiGEIZBJgc7GCHR7ROCVEKopO5V8eJB11y/eKQ5neFxN/5TIpdt5k/IX2bNAmTCgZfp5fgdpfmSTch+IJcOMHpwUw21ftFKuaQ99wtl6xv1tN8TMMASechLg57fa/icPqpqbmTWmo4+4S4ISiezRYC0CXZRWzIu5w7Lr65eWsP91IGVSESqVMLfmNdghBAN1OqdJM8p6kDXFDGJX/95ESA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610093757D17764B38B7E9080D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(59450400001)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(54906003)(81156014)(386003)(76176011)(316002)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:5IVqIW0ld7+v0tmTqZqIvWz14mRyzHH2VbD/EKifl?=
 =?us-ascii?Q?jop+bR7j7iERInLyZd20CyrU6goNW3DCGHfZHspasYjq+myDKYVJyf2DJJd9?=
 =?us-ascii?Q?94U8+SSCw6FYqtUBM2CAIaExHVm+LfThERO+3dCNtWqsCCJYuTsgdCG/bgko?=
 =?us-ascii?Q?4q4dlsWzcxD/zp3QkpawVKe9ckncHc8QNG1cddFdlJBFxXNbDI+moBM2Fh+V?=
 =?us-ascii?Q?osNMMOHCdvudQ4fwqX4qeGNfDXljm9e7wAHzvMyq1/pkWoawrY3kOSN6ayx2?=
 =?us-ascii?Q?fTG1hykxdXsU0ubEyfRS9MSkWiuYuLxNyvvKX+D4GfZ9g6sx2owHTj/0pMud?=
 =?us-ascii?Q?p5mT83wNOY8KOuAnomYRzUK3n9d6rRC6VYVCrKhuxzUuq0Qef6OSDp1Sjl/s?=
 =?us-ascii?Q?vle3WG9ErxfR3i+YXcDortwRTp1KkspGk2GprmXVlEtm1mcTXxLUpHDdG5UY?=
 =?us-ascii?Q?k0PctYofJHerx/UhnlV23LvIaW8XqUuEEOagrHk/WlKwpGk1Yq81amLGbMgW?=
 =?us-ascii?Q?PD2o49EKZrXB+C50Zqqn91N30SX0slkIabBhUj1MZ3Drp8S5PgAYMJ03NH3x?=
 =?us-ascii?Q?CIzPQYc/bndhsYc25xReNCgBaaGQSPhECsEuckFu6rxIxhwafs1y7u/sI11+?=
 =?us-ascii?Q?+xI/taYJubmZQeMs8hczxyx7MVVRZRAvJMxJRAg20q7eN+ZENdbu43tddPc7?=
 =?us-ascii?Q?Ut3UXS/pYATzzblniqev7/c42jXvaGRFnA9lKrRc/lVXTCM0lSVd4LyMgXn/?=
 =?us-ascii?Q?KGVFJ4ORtLCXWz/76BasZQFe1cPvya76jFWWESy/1eHXwBrwMJlPFLw2aNjx?=
 =?us-ascii?Q?ItYkrBzoLP6aBumdc1z2G2T/AceGXthCLYABV2Lu4M0U7b+BmCVf0T9jMfYC?=
 =?us-ascii?Q?IQo1W2/cji473gTkSqSjlyQ4Qmb5+F1wk64HiDQwaLsz2xdAAsAipWhC5JJj?=
 =?us-ascii?Q?TrPvGRth9Tmnvmwh6KGcoZ+saHnKXqHKK31eNY2dwPnRA5b/+AFcW61q4Xb6?=
 =?us-ascii?Q?s+2mXT+3XckOZVY/k09c8sZrGMY5PmCsNExaCs0JqdObMWFJhDg5xjShZV1/?=
 =?us-ascii?Q?ZDANUN+pSMcguFOirSuJ2PUNC7nFfr4im3EIwOxQUyCoCqXooAaopOTBPM+u?=
 =?us-ascii?Q?mpanFAUYh6ajOjsEcI4lshCWbOKcX/wsuztpnBJml4UXhOGdWD0pBsNrk678?=
 =?us-ascii?Q?8IIC4SbVzEPyimCuJj4Y8PFt6c5wGob+BG8vVY0m64LiQ/g+wYPlONJ9MY70?=
 =?us-ascii?Q?cI1Di9x1SFhydHrR7g=3D?=
X-Microsoft-Antispam-Message-Info: xVBEMnpq2dkHAoYxRkjbbiGqee+k5ThE+eGsu9AiBJcYRUO2rTemVMSEJSTKDuZUcu4MErQ9Com4UBv2RF9UdfQLXRqqes7EjbbMrv2BX0EWagW0i1qXEn8qsgLN8qbdtvKkOEmr0l+1Qo3hIgJBId4b80vJJJeBesBFMzaOBrfdUjHCzweiLrZOGC8ISa8f
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:979X803pO+fvNGwxjEq7rZVMV3HGFV1v9EKv58h48wO4XZIk98w19pOAQqcVkxoBUonKwXHwM7iaTOSz82GC6yW0E7h09LJebSc04k+Hui9iHUwGpdddcNt0Om+yJ0TsV+/JzE1CEvayQMz8oQcGGw/M4zu4MZd2KGsPkyuqSKGSwMp7Ysu813wXxpV4qi/Vd9Yyxs2JaPhT7S0WLmThlRh4bKi7RKCXSrvHJ/dFbBQgzYAnm4BRZlV+ZjscDj9ZNWLtlqPiEO5BMGu9TX1wFbz0eUJ0RR2DXRrGjTByMBtnsPeZbvMJomXzychFwL12bscdoHwmn6ULbd0GGFSGfIDWPTBNWFTq/LapvxJTSUg=;5:kTdutV6t9abIDAcAJ9TN4g/7vZW/s3AliOUqIMPIE2Svw/O2SXd/q5YtE3PUu6xRA4ilBMNXHWfv0hcj+L5sCaDzitndsE3t8VtmX/q6Nb5lth/OV/T1AbCdQ56Yd3Y5w8hMMdM8iXMTNeXGav8BBpmBQHQiyPS0BKUDOGJvU30=;24:+6Clyq6QMlqM5/kDQaJlqIb2b7tjtACq7u0D4Akn3fIYWDmWpmSJoMY5Iyl9zqy9YTbYNx07MkYackd9IEBRifQSWJWBpQdda8PBXCxHr10=;7:LCUQHjQHol1ob/HBlSClHP9MkhoQ5JPxzGYabyAIRCOKBBGsYoB0e0BV4U+cxPKAmzpvIlMTAIqnjtseLiujzqL5NnkqaTt6yTZlENMBE8ywKgOsmaF+0mwGfXL+2lOOVU6JT8G3DwuechkUUET04Xx+nzlk0IO/EOTj13oljv1BNyzgNLehsoQ/KMXx0HifLo2M2SLCKzWj3AHGkXe0s9jyS7IT5J+KbHnupS/uo+LAFhFiO2PQIVcZHlQTG2Nt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:59.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b179802-ebf2-49fb-ce65-08d589fcccef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62983
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

From: David Daney <david.daney@cavium.com>

Command line syntax is:

  mem=block:block_name1,block_name2,...

A maximum of 4 blocks are currently supported

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <carlos.munoz@caviumnetworks.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 46e2bb0..2855d8d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -198,6 +198,9 @@ static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
 
+/* Up to four blocks may be specified. */
+static char __initdata named_memory_blocks[4][CVMX_BOOTMEM_NAME_LEN];
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -774,7 +777,26 @@ void __init prom_init(void)
 	for (i = 0; i < argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
-		if ((strncmp(arg, "MEM=", 4) == 0) ||
+		if (strncmp(arg, "mem=block:", 10) == 0) {
+			const char *pos = arg + 10;
+			int j;
+
+			for (j = 0; pos[0] && j < ARRAY_SIZE(named_memory_blocks); j++) {
+				int len;
+				char *comma = strchr(pos, ',');
+				if (comma)
+					len = comma - pos;
+				else
+					len = max(strlen(pos), ARRAY_SIZE(named_memory_blocks[0]));
+				strncpy(named_memory_blocks[j], pos, len);
+				if (comma)
+					pos = comma + 1;
+				else
+					break;
+			}
+			for (j = 0; j < ARRAY_SIZE(named_memory_blocks); j++)
+				pr_err("Named Block[%d] = \"%s\"\n", j, named_memory_blocks[j]);
+		} else if ((strncmp(arg, "MEM=", 4) == 0) ||
 		    (strncmp(arg, "mem=", 4) == 0)) {
 			max_memory = memparse(arg + 4, &p);
 			if (max_memory == 0)
@@ -875,10 +897,35 @@ void __init plat_mem_setup(void)
 	uint64_t total;
 	uint64_t crashk_end;
 	int64_t memory;
+	const struct cvmx_bootmem_named_block_desc *named_block;
 
 	total = 0;
 	crashk_end = 0;
 
+	if (named_memory_blocks[0][0]) {
+		/* Memory from named blocks only */
+		int i;
+
+		for (i = 0;
+		     named_memory_blocks[i][0] && i < ARRAY_SIZE(named_memory_blocks);
+		     i++) {
+			named_block = cvmx_bootmem_find_named_block(named_memory_blocks[i]);
+			if (!named_block) {
+				pr_err("Error: Couldn't find cvmx_bootmem block \"%s\"",
+				       named_memory_blocks[i]);
+				return;
+			}
+			pr_info("Adding memory from \"%s\": %016lx @ %016lx\n",
+				named_memory_blocks[i],
+				(unsigned long)named_block->size,
+				(unsigned long)named_block->base_addr);
+			add_memory_region(named_block->base_addr, named_block->size,
+					  BOOT_MEM_RAM);
+			total += named_block->size;
+		}
+		goto mem_alloc_done;
+	}
+
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
@@ -901,18 +948,23 @@ void __init plat_mem_setup(void)
 		crashk_end = crashk_base + crashk_size;
 	}
 #endif
-	/*
-	 * When allocating memory, we want incrementing addresses from
-	 * bootmem_alloc so the code in add_memory_region can merge
-	 * regions next to each other.
-	 */
 	cvmx_bootmem_lock();
 	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
 		&& (total < max_memory)) {
+#if defined(CONFIG_64BIT) || defined(CONFIG_64BIT_PHYS_ADDR)
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
 						__pa_symbol(&_end), -1,
 						0x100000,
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#elif defined(CONFIG_HIGHMEM)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 1ull << 31,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#else
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 512 << 20,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#endif
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
 
@@ -942,7 +994,7 @@ void __init plat_mem_setup(void)
 	}
 	cvmx_bootmem_unlock();
 #endif /* CONFIG_CRASH_DUMP */
-
+mem_alloc_done:
 #ifdef CONFIG_CAVIUM_RESERVE32
 	/*
 	 * Now that we've allocated the kernel memory it is safe to
-- 
2.1.4
