Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:42:31 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992366AbdI1RjKP239F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PqULTTqxJ4LMkViWVQbJ1f5zHO9EIe3r6gEFxZAYqv0=;
 b=aZ173Y6T7UCYeBE5fuCKGywzXAMXUw5uz9e5i/vtVWeB863bODkQQe2H0w5C56hBjzFabszjTxSe0OW91m1N7AyjyYDfGYv3blsgfGUcCim3FOlBrRijsiMO4OR/ot8rtPHSoVUjMIKhhvwzv25TLitSZr3P/HOmPEual088Uic=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 09/12] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Thu, 28 Sep 2017 12:34:10 -0500
Message-Id: <1506620053-2557-10-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6ddda25-12db-4ea5-dc0d-08d50697cf6e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:uY937OXM2dw68lmtj5uNYsvlfrbwJPzUvXLEx99+okuUZAVCDhTM2+Rmjyn06dDRwaChbJxzMdUt1CZk8iU2L5krMZNhQoT92ytIIXawkUPmOI97S4gprfteqnaRrWf4BeoP62K5cr1eseYrNA0oXVWqw1upVEtwYDyD2QCi75DxZk3OFrBswtXtpSZhIKaFAnqy3xL0YR+2aBgZ4kJXS7NxAZkhzWSNcUZOYbeaE+19FbNz6cR9WRPpa7x1CdjL;25:JHTVmW1Bj51SsUn6xHYU82E9a+AMGxhU+O7ke1Ok0QxzqWfHurXHcrraS/s9MI2daGz7BDX0FBTbuLKbg7ec06PX0qDT10BbHM5fnczJkSOSPpm+yZVYbYsxb1e3w3ddChCj0VHDHebbx6U2XclExVMrkPDLxaCgDFmbJMXheEzB95z6vqobEsGc1yGHt5D+MMWnH1Qq2Amzge7T9N4xfS2EJGI6swn8DCy3KwyiSZ0lRjcGH4ryoQc7iq+Uoa7Avu9Y3Fxpsm1XBasoDoJBQelMkpS0Tdwl8LhXK9AroiyHH8CABnRJoJIn1AODDAhkMeAW2yXmwhjKtUhLwhW/5w==;31:IHs0LvfB8DWzWdzCev/3VV4ckivGlZQePB26YYhX601OoUVO6LQyYVqQ3wSkcegpgbj8cpLOp9I85uCRoS/itucIDc+tdVK78L3KOygsIw7leTEHDRqxZuhWPZXASezA6nNiv4YTm15V8efz/0WA0rUHiszahsJHxqU1+6yq3/FTlVcLFG0WNUDv06LE6+PNGSR/ohTVGPlXhyZRBHOGYs0GoPpJhF7MG0Tc0Kyb0tk=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:LqN0OXMndOXA9qIkgFG9M4qcEIBzT7mTAjKGvYzyExgw1e+uJQHw+D7KB+peEqQxI4KcLONJ+r+CAF9+p+Y4I3PwMR7Pfd+YxP3PhDI+8NwzVQGsiOh7RzDit3kxqvHsINYoJUltqWFq9+9YldNggtlxzjV4OgHq8Es39+jFBfhOYGMungqNr2UzaH+SHwp32pl8c2aVDTz4lOiamlrtCqWG3KW70cvmKHWj1PhmNtHzDNBADIqLh0Q5NbM96+G6m+5nrZYGC0PMmguQjJDPHqyruZQUlCnjT99qzeGqFdnu5pOe3QL+WRNBtastrEtTb7XeCReRlFQJkXm/ThdDs+zPHXMaFojFC73g9Arrx3AuDIrLItRCAxtYFro1eae31n4ekyMLoqpPWtoVCCdlZPv+aa9ciPaJp7tGol7p1P3l/ZG+2OC4Ug1r9oD+AoQgEAye7EAVo8RO4KnIfSGugXez6NlXo3fiTQ+g9pCr+qq8bdI7/EGWSRxO9EsVhLpG;4:JZtqWBRiHE3zFiTmNDqHaS63mtGzbVtxDKwRIPd/+M5f5tPa64iaTd/IBQXmYbI/7nCOv4rM6QmQPOQBlFXn8NWCcr68eyj2KBlZXR2T6t5f4U6iSSWF1I5pt167MDJIUTOvo2xHqxYP7BR7p2CAaXOjRZMxR1TE3XZirlK9Hund5zHPXO//VJYSDeUphMo/FMQTBLsIOC4kbQNT6xFDAC52u3c3PqXSJ9+EfUgRD/jgXEpV4/SWrmVgd+5Cwr9u
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807887E4BA92C2D1EE0A02A80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:YHfpXeYpJWn/WHDm27BneVkdTBRcpEvix8NzKpB?=
 =?us-ascii?Q?8cyNkHBrUvgTzU3dUVpIrd/pEEyQ4n9xcYMD6Ml1feh7A8gWjgIY8LA4mW5B?=
 =?us-ascii?Q?4SMk+cBOw1209jI/KPBXXMv9IqdMdnbuuDBpcM8NW4wU3JF3pYLBsIPn1nBi?=
 =?us-ascii?Q?QDtHtylD2i8eTrD4UMwpRLLhpP1/rUOZ0qEGYna1IApZOu+x0RtyMwtlk+TY?=
 =?us-ascii?Q?e3kssqi2RVRyYoF8xmZweQEJEp6kHqkB7CF4xfntRZUSrMMjWamB3BW95pa2?=
 =?us-ascii?Q?4X0nisNYrCQqxjBmCDC5NZ8dmg8UFKNlkNhjw/ybB7S8rk/UPzpDRa7Pu+Tz?=
 =?us-ascii?Q?3D8a8X7S7GPdDltj0zt1MM/F7P/IlBOPrWkmuPcZiTLeZEqlK91TEzUWMjxr?=
 =?us-ascii?Q?TZ81h/LqrCW7MG7J4Rzww1oravD/M9nfaaYfeFtRrrp5tpfzsLrjIWxm9aaf?=
 =?us-ascii?Q?b8H8LuhiLBVupAq2b0y7jz6sRt2HMjyN961kaNIoA1Zab6PEGN28zTb2ZF58?=
 =?us-ascii?Q?H/BV9pUwyF/MZbDZIDN2Fb9JEVgDrgNF92eXGwv0Tv2k6efVStdgiAie8oWq?=
 =?us-ascii?Q?ScXBRvKlUl3joFf61zoMNJ+p/x4l0/8zexWYLCd4WLGeWfnaSAMjVlUWmKQ9?=
 =?us-ascii?Q?APYUWNHi1SO5gXqasjr8huwxfE+gGDAkwutxLJPq+u6EKb195C8M8BHi22Cl?=
 =?us-ascii?Q?D7rPEvjK1nSUUInitRAAz//C7oYvDuAWNCNknMivD3QvGRD/qCohBNSsr1rC?=
 =?us-ascii?Q?AidcPeDiUa5Y4MZt16GzjqTq4LfLwEAs/yUD6O3ywjQG6gO74KkpoLV3yE7a?=
 =?us-ascii?Q?YTpOOXbTdK2riIURa11tDDpav3BFH5U3WEDl28hXmR9xqYsrhzVgOMrUgPkT?=
 =?us-ascii?Q?7ZdsZDZKCUndRNX0rl+UdygADAOT1rxH75Cy3gZPX+ASS9NTFAEc5SUeAIIK?=
 =?us-ascii?Q?Z2p1Aa3qzy2L9WaiXd/ytExEldOH7Ww7X4fRY/ygPKUpGHAXsP+rV1nL80Rm?=
 =?us-ascii?Q?4h1ngsRGupS6+dAKKXd6GSW7Uv/RtGs+CLjV2YMDK8DsJMGQUZlpaOOSqiL5?=
 =?us-ascii?Q?TmchU3kNSJ8m75RBlpAK+iznWLtEg6azHii3voF7Hbg66VOP/IBLazRKih1R?=
 =?us-ascii?Q?OYD4FnQ9Lus46hu3mcZrStKgWrDmEXrIIZ0UzsSTFFrBMhuQ5hkIs/dSN6O0?=
 =?us-ascii?Q?RWB0Pisf6xtBahk8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:rmY9P40fn+ydpsculmiQcvwgbFdHfBxp3XnPEC9akvJ2mpl1jpgtieDyYBwtZRQCK6yVj10miOhZux0Cx5TFZQiJV3AZCvn0wYdUU0Qyo89cFcV4EodLDzY572g4NlsM4Rr62C7sEaR7oVhFBGLw/4CPZA67h+iUSrS2Cl9Em0RG7PfitQoBveUusnCMFuwSzTr5fGC+EnEvcpkrE4UulRJqxLbOrMDhsfVIjpFhPigiX69KMAd9k5t7hPPyVMlItq6yMwRe9IOG24iUR8xbKePjjFYP0sFzWwZJrsy2OaMy+d2ZxnoxJfmDCaleW46+p4eyR6Eut1qJCoBP1C8tTQ==;5:E1bewijPxR/ef9pnjQ1Um+DgBRQ7Nx+0tw2xuWCa9ZtDU/yzzq3GlbOfV0YZA9KWdoCjdjad98IjEaCiM/rh/pKiyldhQYJRn/ENlm3yuEbvLJMLtQ2c+TUdfaYDPipaEfqw0ZQHugZGNQI+TW/0HQ==;24:/2+FO53c2X/1bpRGz0aGkTbM/QWsHOLanN2ddMcXblP5T1NoTpCVi4VpUh5VwKv/C030VG/6ALAOTvxeAKb4eQh1YJ9d4QdT22i4YYcUZJA=;7:m+RVDfDRkLwigYJddp2mcIfQASjsEwASP0snjomqcgfZfHAEAMNgYHqB/nTt+sjdbr9BHrA2ZjpIWGc4V9en64kQNwH04R53XqbSW2NgVUDs3jM/YJ4FnvotjjvQJSZRK2CBlDfH36w1o31OfvFCBdOKKM44KbkOg2qdTIthqZwzH3pD/Aaw4LggsIYseRSLlLJnXU55iKO9M1of9LV48ZUzBgCZUrirp14WmZ0bvRE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:02.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60193
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
