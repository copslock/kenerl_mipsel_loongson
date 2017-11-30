Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:17:55 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990593AbdK3GQNN8kxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RL38Ub6ueRwznDM0kYcXPTqpgqN/BLoDeq40s6APEk4=;
 b=nCVr7fUnLRWMnDSBNeGBXGA+5SkTnsxoy9OPMXxwjj+4y2rUhhyg9BPM3Of8zADMivjgLqouEERG17vH8advIwx4XfoIuSEaH5wd03rt1RTPHN1BCNnVM0c6qojYQW6mo5/ZN7GAb9xGx1WObBaRSl7bl4JMpC+CSj1l6vwDsME=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:04 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Carlos Munoz <carlos.munoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v4 5/7] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Thu, 30 Nov 2017 00:06:19 -0600
Message-Id: <1512021981-15560-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805440ca-8637-444f-0ed1-08d537b9d6cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:WdMy4SKP9damtjV9rRReDrERyHnnBzAM8cbxOAomRF/VMYif/X2fZPLSSo5T/Va9dAq+z0XuxouUipI2YlUOCdjqVUmBmJ0SCHHYEYbCZKGbqs8tj2qZ2BV23BDlb1xblqzf1pnt6tb3WsRJeY00omcj/YWmjxVkpLoOLsQBa7+bCXrPsfi9cle0/wgkRXfhzigDfkYEZPQ+1CH6RjVZdnA9HP0tTGSUEulhjjPfCgL/yrdqiEE8umDjBioPjSDI;25:31saLTbZSK5FjGWD1JDaqHYIi8Qrtk2PcNaLnifQL3W2BQhPjiKF6OmXc48fIrf21ZQPF8MuK3MXUkoQ/bYczFawHzSEvTln4ZFnbJoo7jTHKVawEUrEg2ggpnkOt1F/9VYJ6xaW7dBjgyNgAXtKhoeHbi8sf5oDjxCkDsqK8qYOpzzezZsyuvGCpEjMkvBdTUbC48BN0+JEfFisGILFHrcR0nmCgHssRB7mFNUM+7A/TMZU8O1gVCXiJRMVLGkrv5FvlXhuh5JzNlsUh8witVtivIVz1YQ+801w+1+YlAAttNc35B3ndFq423ObV3OVTLuiMZ26rqcmSYF+EAlYug==;31:uF5H37Hc2a91/Me3EoimgxOg6XkZSyBxYMOUUYXuRVena2vm8FDZ2jOwg+PkLLDXX6c9kDQbwBcigjR/BJCpl6jiI8JOkgQ6xYtblpz+NfOpYTm5C0eCx1aRPG7h4xLMPhC9qTsnWeoWBaR6zqXxnrv+/eeXHVhK8cQnHocSMPgTdb08Yr+lJFU1zOkKMtNvV9UnX4j5OWJk2ei4ij3XrktMi/fxtMKkT2AhjfmYfRw=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:/lnBMeFpvy7bu3QqLDPDtjuukbiXRCbw5BMyyzwT/3lsHNXyAbMOfm5281Na4EPJNNAZAmjNGFFz+00sJ7IOY8IyY2ly8WAX4UzU+kFlxV5O78q8DahCPteuigsk6wml3SIzfl0JacR6nnoiAOTQFWmJe8+VulMvAY5+QyEqRbQt8YlLHYGRFTjBMDbeHxLY8pJgKe/l/TTHVdFRjFOMIo125x/Dok9WFaVrRAwUu5SzBW5CtqhK//zZ8d3dcDF0d4QYJGEJ1/P5yTyUh495mdyHogV5UFihLrUwG+zc4Y/4+vHw6/1WHhdKwXjkg0n83QKcC0BZaSJ2+el5AkhZCvbEVXJZLjYk7+8Wo4wR7w57x2XFQGQPOk052ix7Qv8mHda6g63ZrdmGF/wTTs8MSeLtdup6pcHO5y63Q769xzYMXcEGojgndcPSv+u0o9lIu+OSFmoLXW1Wn8mmsiQpZpTcBI0T4/m0iWEm0RrwQWLVHoyC0ypiK3scq0EGtBNc;4:uGnE6n1phFAGZ9rcwLlsr2zrSMxNVYVZM0zhBaMRddB06e8dAvV5AwjdVq3WB27WT0h0amHE2AF7dREowk9CKYCWHnHYkc8FPPHrcQBtPFkzI8so66MYjw/GQPqepNvAPuj6o/R8BEjTDn8BWuPKATq5r5iEb5etNgJU4qYnrUYDtUhHqL70Rmx1z+r1EVWIs7b4zNy48dEj9mqazIUf9dSwuckEFwMioadob0qvDLj4UuyUJw982r0p+LZyDWi8innrkIJ3IgpizMnj/vggFQ==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB38034C8BAB5CC76CF7DC6FEB80380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(54906003)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:6uQnf4U4xKXxtZH2DLmIrtPqcih2IE0Sdh2Rcxg?=
 =?us-ascii?Q?nuquR6JvQbvZF9Hg/9NR/cj7b9pOTOOyZ8MrlXRg8+o5uNTbfXaMdys5j2hB?=
 =?us-ascii?Q?mwAk7NLfsudJoXl5GCFuSjua5uMe0W8MT5QMRk9FBomDGc6Rd9QU/NPkgRNw?=
 =?us-ascii?Q?s+gTMDq/h1dMldgjbB0stn/UJeQoMj0MKReEGUEWXpZeYdPPLC6+xCxTw44c?=
 =?us-ascii?Q?DcDKiFanBxNzjtKspPhqbClMpV3uxPreh+ynXKGcDoU9qjQe28YJSqCHm0qO?=
 =?us-ascii?Q?9XP5xXmpaWpodKCPAPSz/JLUv9hFfOjsASJSKJd6BE2fqqq5ldKMatLudTC0?=
 =?us-ascii?Q?JcHlftjpTQ37PDsGOEc6wDl6V2Ws7twfNqWDVSWnRYtZRRQYH4VmeeaWzQUf?=
 =?us-ascii?Q?RyEFMZsjj/0Ii/24taVRZ8VDe9e9PW8Jxr5eFCslIHKzlOxexcNbhICspxyp?=
 =?us-ascii?Q?5NPUK9M20Y6JKotnfbnQ7/uYs5rAKp8ZWgcmQEWKICGLcX+296DqLapP1zun?=
 =?us-ascii?Q?tb6kOWG0xk1mUTc00dNwY5bmxA7LRl3yORZEzxL7UCv6QqaP9VoqUQezJGLg?=
 =?us-ascii?Q?X9+zwU5k9Utz5yBA5jhr7An/4I4SPoB+Ukd9dPK2GRjiNQ9NOhgR59iD/54J?=
 =?us-ascii?Q?OCHKjF/Qg2hKmpYEPyEaZ4zC6aMfsGMVmldS8kghp8QGbmfGuQYy3YTP28A3?=
 =?us-ascii?Q?qZ0pyQZfFiFNEhcViC+sqS75JHp5bROqc9PNLw40jj36kxVOG57jz32//G4D?=
 =?us-ascii?Q?hbN0PWdXHH87voPy1uAXHHdAmprj66+7rINxgNruo/FYcVv7KOD/WxKKrXAh?=
 =?us-ascii?Q?ENO5b7LF0TEAYCtjfpGKa+o3G8FQTBQOYSYN5RKaj6pOLIvMbygT/jBSnO6R?=
 =?us-ascii?Q?EdiIBHT4gyncaQSIzWHflGe/X9G4CAINGDePUPr/BxrBthH3hNgwm+9GQTJO?=
 =?us-ascii?Q?r1/JNqZrSC/mFfNEyMfUa6kUfM9mocnuKY8/qiuDG2UoYR/BkaW4K6TZpMuE?=
 =?us-ascii?Q?BbX7j26WoOBWZ1acqH1Xc/T7oI5+rWcACHEuLsEhGgCQEv3BEgPQ4B3kJJhx?=
 =?us-ascii?Q?cmQiPN+EXW2Vl4LjY8kW9zA7r5vf4es31V3vHs8MEGX5vT6YZD5mCVDLi1Bs?=
 =?us-ascii?Q?3PHrduseVp6MfU3CR/g95M5CJrl385Yn4SrBlf6EJlQGlAd5K0qemxOcbJbN?=
 =?us-ascii?Q?JsBFUE6U2XiifxXMqHnFEg8ijzka25mneS1A5?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:BNXdDteyKpRZdLznszXqgFmTrpVTwum5qFu4QmQlggO9LVdvAIUdceUc2jc3hlH/agSBpuHgCdSZaRAsbDHL6KgmQULhF4W8isnT6G/ejw35NTXeOe0r/u6ihr54ttrLPBiv6+TxRdP0nyn4kuq5efgaHoAW4uAz7FRyp2ilp7Jku6nbkAvujYYa3i4xJChg2KK7UWWjS0/DMCMxnFZFD0Od3mWlYnYI+lcJ8s+JjgAgBfisskk/zTBOY0/eJymNs4yjV0CJApwAgDd5GX7PVVNZq1irs2H8zaCC7gDF20kjtpuhiyM0BfjGF3BWW5GSwzxFT/4rs66dD/g2uoKaM/UH8wRyQC1X0o6gfZE/v+A=;5:b11MLLdPjDFI+MbPl5u5iq7O/VolFM+P4isbiVANxDr8nK2cTF3jMaSiStx4UKOWrmpaU5EL4url0ciY1X8xJTf5qS97aLG1xoCyX1h63d/p8GJuJlQ1scFkWHLB68sfEZmmEUUzHEsh+SMrigRKCdeHv2AiLiBPuvMXFZCHaM0=;24:UoWRmAnzwQzOuzgzhjNg0koEoTPewLZbkKJkzA/LSU/kThnwwrzchU55Cn1uKBgkIwu/I+FJLntZN5+oMWVo7gzZtgq1+QMLFQ1YIZbgAik=;7:GZcku/U7VLffeaUcNA/ZUyxaJBf8WuDS4sGai26m99HWhbc6XZdBS7JPHa2yN+ZSwbGhABgcFCwq1OE9gEetJeuXgl1zh3hRH6VMJuCqoOckNoJf62Oq52sEE1aUgXCr624qnC9dqyrox3uxo3a3w0bP2MFtpMuy+SqetE7HDobGrzAjPSSFH9lATAqrrz95DTyJd015FlEajoT15muioGSMxK7gMj4Q85LXTAW+ZRDYokzUjit+Jc14z0eUattU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:04.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805440ca-8637-444f-0ed1-08d537b9d6cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61236
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
