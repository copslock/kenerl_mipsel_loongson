Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:37:09 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992675AbdIOReEsJlzM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PqULTTqxJ4LMkViWVQbJ1f5zHO9EIe3r6gEFxZAYqv0=;
 b=TPLFWxZAt/zxpQQLJMOK6DlLF2LyYXHm7O53kTcTDu9dWT/087i6PUAKn7WVysOui3huUGgEYdNwqx3Shr8rcdmSViunwnyzaoCwxyh6DD9frX6sHMZQ+yvChzXQef9RowWc2P3Y79/1LiT0H50IyUT7NDZMrAQcE41DCimkJWQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 08/11] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Fri, 15 Sep 2017 12:30:10 -0500
Message-Id: <1505496613-27879-9-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5de8797f-f727-4e63-38ea-08d4fc5ff180
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:OyR5WkVLZVYgEzCw7B5i53soFA3TUckTvCwSDZr27P/on5DpiQ40lYAMhIMnSBvovReux+MnEMOFnjMUOmaM91PGXHq5ftUMZ0N4NGGQ4AcmzPI/dHrYOl4B21YuY1/yT7btZmMT+L3dgKIQKzQ3cHFJWgH0Z1A9in3sYe+lVkZDST6qVQY1a/lYm1PVxwZXKSCixy7EOz6xE9M/+N4XAt2shg2H7K6ksnq6XH1YbCjCk2q/Kxl3afpQNPY44ZwT;25:QJRQUcTXusvi18OIyE7xfUuquVmM3jEcaHaXX86NYGfsXHmn5Q94knz9OwO9Mgc+RPBKG9UpiJleJkPiAjDuH3rf78uE+yK5PKonb6nUNaxcHH9sfkrP5O6Fas/70Dt5qM8bXU3nA3eyrW0ISkr7jOolyw8eLl4sNftIS0vVoTgjdn16Vrmp13KmMUHQ0KMK6uu8kMex7PSvWH9BJZMi1ABbmfoY5NibWVzSd1VGcT4GEaMRd4/ZqMmz7+aYTp63v52YXJbcKdp0eGiqVfSZKJc/kp6vH3oRLfrs/8eaFZtPn/KhWTrY6/b/z54sEWdQH+E4NrxdpPWII2GSJKA1xQ==;31:ilNPbozr/I8uzWRj5asmSVGEhMBVtDVDUojamaseI1MoBzm2yyosdN2o+dhDVnwDCcOwKiDBAjffZA2EalLPhMlv+OiUYoN8gz9ETkZ7tjksQidIUwAihLcqB9CQnel03RGIFbXUFuoePqiExaMUsEm6Qc6LE1BsoOYug0SLOLlVmknpdnQ34oZEERVGtJ29x+64xK92bZajQamqgZ4eEdVUBUh+6h+kfEFX8kzMKHY=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:s7UZb3cnU16qW1jJuqm27oljxLOhbbjgbBQOIrhBt+iW7nHZRg2x5Nd+k+KLgFQwLePDg7B3z8IGLgSmzxEC3XXfZXd4BACElnxa4A02gFmsg/DrlsZuVq2GSFMXQjXombF206xgo7QtYTJ4Xv+Kw2kPgUrW1QI6BKfMQFdQKz63P6eT0RggDCnk/JSOJyiaqKbfrc8a37FGaDW89jD9hKh9zZ1UMC8qoHIIgs3hx598KEanEZccXBhz7su1JS4RkEyNgn0SeN7aknhuio4gD7kxBeWEgrUOrZvNBk8k365ZDIAN5CEJbbIGovGNtSRkXFAiGUazp599j4BgCgKXgM+dhi+G5yvLqzRTwVc1w+qMD9yFRUJBqlqFzNuwZsrBnkEMea82wyGQks+WbarMmRPfiualf+MFcH7gjfrN6FL36oZ2Qt7/1hCx2/5kg0p1zGbame3ZPGyomyc5j6cjKJAEUuTLeOGyVknbLkuJnnnu+8Tvau37JxdpVNguOnKx;4:mOJzTvOkpxV3BYPQFKNeC7tXhTRntTghKmgmEUu7E9XxpeK0/iMVJn9BkXyJ/kUX0+mDWx/qyaEN7n+hmN+nNI2T+yVA7WZZhR7MasI5gRvuIymq6bV/0ZJq88MyINrdGZt5WdxE1AF5625ZHtwhpf+PLxa5DW/92umWZa/mZy8eNzPbOHfLkgwZc/05NsvfkN0KWWeIMI98w7L54IC4FcH36e6ohT2XbJxCRB+aMfQI8OE8F0MFzjPR0zuFugKm
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800EC867E11C35C7D5A0DFB806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:Ajv9b6qhPXF1Sv/TjlXwiOFhrOEwLX/nE+YKu2d?=
 =?us-ascii?Q?XVDlgMnmFjmJOrb6oK7S101jDB4JFNAWoBj/hcfw6ZegSojnikmy3XsO331z?=
 =?us-ascii?Q?5s7Emarw5ovaG7cisH9FBjHYroo5BgS9r2OnNRYGvvRtK6fEQyOEFwfy3dpu?=
 =?us-ascii?Q?6pO+0oTVNlsE8Lu471DIixopj5sWMg9tqfFcIZLqa2V1cnptJMLqr8PFOHx/?=
 =?us-ascii?Q?xEo7HLQ9vbrESYzrFqmir1DcgrWT4gNokJsp7KAwpTwETkMmdvAHdHYXnkxT?=
 =?us-ascii?Q?/1MUZrXq576RWXgRqO6Vo/bm0lsj5Am3Ew4JnwzHu6XCQPUn1ylHyRdVX9oD?=
 =?us-ascii?Q?IxL4XPg3qprYXSPEby4Plv3KexCneioqfrUWRH9bBgjgLQxT8mU7DjsENSkq?=
 =?us-ascii?Q?OG7Eu/h7sA5K5BdCTCbW318aXXM2IlBksQO+uR1jVD2QaW0+svHZyU5mWf6Q?=
 =?us-ascii?Q?zPFkjw7ULQISzfZKebxSEz6qa861sJFU1CD5m63VvfjNNt+HGkdxIR5neiyR?=
 =?us-ascii?Q?n+5zgI3QDM6zT0zEt/C2ARZzqfwXnKcPshNhcY6QAj2tbIcLHkrKI6Z4TLua?=
 =?us-ascii?Q?19e6ecw5MZqlgRnah5DB/+cwCuN/GHAYgjB4pnBTXc0KLVmKSAggMMY2f7ly?=
 =?us-ascii?Q?rbz3Yzwlh7V5AmOIjfKSW3YsQZBBYZcYfckgdeOYYtBO5gYlsxwixBV8wlZf?=
 =?us-ascii?Q?hk1czixKxFqVsgAcQEV9YdRj20sHOOT9qC+PTDRA9DKa3GfPtjldDUK7ElaW?=
 =?us-ascii?Q?MS3xtjF5Lq4uHcsxFDL9NozwCZu02WndetnkQi6Q4P6ZSEMupg8MrHixiFY8?=
 =?us-ascii?Q?iE6npfhaEfGuelwOTA+xZyBADmY8Df9yOTFeQ7Ig8yRRFhohwStaPODWokz6?=
 =?us-ascii?Q?WcfJw2CSV0Q+duqSZfEgF377aFc7272coEBoPwHgTiX8UJisMG9GzwORXWMw?=
 =?us-ascii?Q?LpVGoBLoqK1Dxt/p3PyApoGI290TBgmhCQMRbv0OVMzxyInCNC/7TvUYFPaM?=
 =?us-ascii?Q?fdIWHVk7pv1C7w2uQHnDOFue6nZKTZg0n37traJVB3d0L7469ywo24La8fwW?=
 =?us-ascii?Q?+AmKvl8jwK/zii7dAY8mjUGAJvoWPYAjnOhYhqOBL1MkBKqx/KiS87Z8rlpP?=
 =?us-ascii?Q?haAlIhm/QDSaS+efK/o6teZsW5UEh2svX3B6NjHGTkX8Uzv43NZ7pa3k9n76?=
 =?us-ascii?Q?LMKyS1C8aia3vSO1xlm9gXmQZQkxZ3GTrqZ6M?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:tmtFS1o08Cg/ykLQ/mvGCIW6QoIZ0nvOVSnGza8Up6+UQUD4Adqbo72Ye8XyDXQRUCLDiT/GI2pvlA4o/AaFYc+Dc1mizyBYqgUade0QYPTtET1zIPAhaCeu6vBP/FScvgrqSTIJxOO3nhx2uCLP1fTL+lZLGJK3e00U1tOTTi7R8B2x44HbBC8Qnq6w1iaPs+y4Uadh1yzOCYeGiX8+Hal5OZ2Vh9fYpRBCiWOdVGAC+fb7PE0aPCeVIOxsHABQvyB+T5Puh2l5Iw1KMwPA+gdmrybTTEAfyUVt1/BnTgVJLxSIjvzmTUAalylsCEFrDwHTIrCNelxebVULru9n7A==;5:nolmG8TJBGi5CvMGei3pSwqNzAUicuRdtrOKIZ9LVuJr3MTWv6gTeCjYRtFhl3Oot5boEPXCBFLrw2/BeU9yd67cRSvWTSm5JK+DFGBDG7lScKBnM8T317ueXdP2iYnO7qdp4JlrscK9VBHT2UcUPQ==;24:o3Lkv7wEJPEyVSqaEZQPRmzbgfv2p8bvBUdlig/k3SlY1GCj3UJS7y9MCIsjf7DAgkj7Hg7H21GgRQVcVU/zSzac9d3E1oL1+um8wBW4muw=;7:BCQv/7c2OBguBG3iO0bhzQYZvhv81tWMkvygFCy8+V6LIykXpd7vSn+yK1KmTLm9LhUQ70vwCSibVjt2nfVN6yyrHWOsz2P5pdfcyGBDfSJl2aFlMU2Gh4U8zN9/qIdBBVyXckQz8CaiSzHR4YHFpJHtvpkOXagdbLdGw/7rJcSxb/OOCuHeIEgwP7ZagWUczZ491aC4bXuoi7ljWbyUgn+SImdx4h1QcX85x/3XRFA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:56.5356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60020
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
