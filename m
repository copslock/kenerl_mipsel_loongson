Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:51:05 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:25310
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994700AbeFEFtdRnJRB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ1rbnCda4ydnz6/jdlioE6kHRDzhmfy06n3Tk6kbeA=;
 b=DqBNU2gV1F1x0k0URVRTvLmP/F6rCTmL+qRnxZARqa4q0ywTkktCeGZHrhx6yZZu50LEo/UuIKINL7QkvxOT+qxoch5v5TUvZDwjTH8VP2fTYyH8XB2Bj3VOBAroVyt2jwtSXLEkSPWU8YediMdJerhzFFzvsAIh5M3jv7hRiQc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:17 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <carlos.munoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v7 6/8] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Tue,  5 Jun 2018 00:24:55 -0500
Message-Id: <1528176297-21697-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [12.108.191.226]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com
 (2a01:111:e400:5173::22) To SN1PR07MB3966.namprd07.prod.outlook.com
 (2603:10b6:802:26::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3966;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:DXlI/oxyuI8ry7yHMJyNp8AxYCqJuNA8C5dWXtHuweOStv+WTETJMqtoORhLHOIdMCJhgVgI1jfpiq686uFus9M+DhCNXIo9cyNG7TZc1oW+HcMmYNEn7yjzFsm5UPXK/lt+MMJ7KPwi3AUZc1BB3HruVf+j1pQV8OMPT8ru1PDqy8soGE3sgpLOg7b4iQrf5Ydm6FV6/HMdaK5RXEqOeCguXDPOdV3bGZs0Gb9XBm5xBrYzvFhEa1lOh0xOPfTn;25:F6jSvH6lv5FbR68109F0tk+laI8DGo5mo0pSY9gLURRSieQC9JGmOXLBSP4FJFB8hyoiiKzQf7jZu9QLpwtpynG9KgU8iAFtFkT78A03OqBVQlYillmVeP6Nr7J1oeFE6o0hy7+78UiqFKLCGPiE4117fg8zAvMZ8m8DwyDR2Q6sY26Iz14wdn57YWli9C229xBVgbEtxH1wPeFlT0byxGTGcIKjy3q1m2iodn7kO2+hbNvzR0Ad+IPrGl9m4RcOyung+EiFfnnWjMR3HtaRD1SZm8vZDpsu5Qm4p251xqnxjMtkuPVWgL7WJYwhygRYHCm/NsTN/1V4TDR1giDb7Q==;31:jz/zEmr9tt8/rktzAl4oRw+lBPXaiLGM0N6w662Bx3l3L7AGKafTcqfEHPdO8RI3POAUIgWBdAe7zBaoMBr20ZVaHp8RF1JXF1tJsJlXPW1PPoGh9s8lV5Pi4acwwvY7i2EckmGioT91Kk0FDS1GjIUsOjhteH4Mnc3tpbW1tRwFajKeVuOrfOFmDFUJnZyvEhbGevxowg2myKiE5NFGjEP7lAqJCYUwyP0Pjc2hos8=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:fjkUIXFY0J0i7TRl+mmJvbS2H1ZbuVzpLmEkZtZMx18+8lIJOzyv5zSmCnkqiAwoyFDim1+oATy65ndAC3zSOvrykGYeM6qSmTB/l0DLX8aJteCw/gJpeiR1yt8H7VnfpWqxaJizQvXToZmXoeAg0Yss6VjIUnT1/hNrfPWGeOF4eUxRIEKuNLmhGHgibm+UwvMfya54yGAnb+kSfWNOBJG7J/B5FMgR2gwfIzgEWChiHRG6zz9T1GA9WNjoMls7Qad4vIQmn2z7ghZZgwoJl00tAGD2Ds5LVNBET/8LA+CQp61HJ9ZOq58PEcmk6cgC8m7l2R2+6luqfQE435A0xon1hx1zoYd6LnfGNb0tVD5TPjfcSQ4O7r1LRzyuKinP04YPHNVNojiO6F4gIKH1R1BA0QqgumuuYm//r3kVaAtVnWWUCc6m/P/aAFZd7KhSL7Yu4muBjogu/S9PWyT52LSFV9tlePLDtVpnJ30EKd1IdknflGlT141/AYbS3TBe;4:ESsUw9J5BmyExlj2WvIGsZcuo/Etd8OW7U8k52Lty8VCTJEwTOUUhg/ddFXjUjW/zzu2Y2KR++mb0nBVxQ6McCey9jQipCChR8wpYEFiStpaCAQzty9p++Duwoac8yF9OSgMyYzp6KP0/8aJJ6AycQ2f9nmzXkpJWqC+cl85s3Ku+XbyNE24jtp2h0/RFYzH0okbEVggTm5QJK/NOVcwKckHh4uxMS+g0lGp+usU9DK99uwDcFm1eO2INft1r+QPir8uUIpsh9vnSuWftUd/RA==
X-Microsoft-Antispam-PRVS: <SN1PR07MB396679CF8FA74793EEB869AD80660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(54906003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(305945005)(48376002)(6916009)(7736002)(59450400001)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(4326008)(51416003)(68736007)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:I9Jt4wPErWNocoj4KvDNia1wUZ/HlVTWUNr8g32Tv?=
 =?us-ascii?Q?JkCdw4I4+stnUnBYXG4OIvhib2FtptTMWZ434Uwzgo2RXPkH1TsRi6sUEKG+?=
 =?us-ascii?Q?L6aG/BJvEUc6Tz05bmZiAuZHdfV1FKMNUHAlK9DramTKLuWDF+xv8NY5grbT?=
 =?us-ascii?Q?LT3Sw2teyX5yebKpbnDnIJjE7SNE9yabSxgz4AZJk85pdM4ZmQpzqdNuR0UN?=
 =?us-ascii?Q?IpDqQ2+Ws3n/PWHAgvLBANppBBknbY1VE/I4Kh/KPh71/MwblGHCt5S3OWp+?=
 =?us-ascii?Q?yiqXGjAHWYRshjWq+dIyFX6fRBUpjuvlo2tT2KN6tXbTlz6SNiwjKyFJbQbK?=
 =?us-ascii?Q?tMPfLQhZGY5zUhXsZmjwxxfRWvuqjRxQBBbBYuRhd+EFARkWPI59xQEGLE5+?=
 =?us-ascii?Q?wSr7E/FjP5uLA8MF4yOX9QmX5Qmou5gLMiK25ezXA9x4BhBrqbW1UVV1CJ/P?=
 =?us-ascii?Q?wYUrQS8/Q9OQROt68de7TuOFpavxBB9TV2cMDp1RkZMFdNiox7+Oh5I02pZm?=
 =?us-ascii?Q?z9OkWUvwq2R0OIi5sUev1DF99zGdmXMSehMUcs+bDSoziMd19QafZWY1G8Ha?=
 =?us-ascii?Q?MniGdGOW6G0W4z7J99MbpfHFeIME1VjoQMf0Bv5BZz3y22kSbPq9tNILZtHM?=
 =?us-ascii?Q?o6OwkrbEAgmeT7pXgXTGhQIIdiuZpM4qDBAxOocXC8exWsNhZbyuOCLsWHLv?=
 =?us-ascii?Q?B3Wv341N8NtBc2xINEjyO8ORL3Giu8R5X/sCD7xgroGFyxYeBKFHlR7/fJ0g?=
 =?us-ascii?Q?SkDTepLUtofWl7IxE4y2U1NHVFkGFuoA7lufsmQsc5QiW4JBnptLbx6R24ey?=
 =?us-ascii?Q?I5rlIZs6XWfRoiMBDmUFgVly3xa1ikizYpxJogDUe2Y76aLlEqwq02aQF4Kn?=
 =?us-ascii?Q?lRcflkf6EHoft/aNs8aQ5IO+ayVo3lG/DxS6JOCN3ZlWn5YWDfK3RWrLft/c?=
 =?us-ascii?Q?fA9aNh1gAHv/VBJKubPFMcxiVlAc1//TmnaJdUMFbdElEwZmj7xB2DgB5yen?=
 =?us-ascii?Q?zTattkHFtlS573456VjX36hOZehpADiTQUBu1X1TAc72+R/lHkvnxNB0An5Y?=
 =?us-ascii?Q?G8jSwKgzHckNBZwwqmdwgFVHJIm/efhW6sBcrZlSmDAiOUvJ4m8Vnh9P+nHr?=
 =?us-ascii?Q?jRGc5+8kMDZ57OCU22gJhDaE5/EktOmU+LYNs5g6gpzBQ/p2HYhwk58Flg19?=
 =?us-ascii?Q?xQ/N79/Nj5aDtd4HOWhSDFJKivqK8ITBPn4e372b8mwLvQWE4EO5jiYNQdtv?=
 =?us-ascii?Q?3ydnbRRAbfDX4OmaGi3Cg8ltGFhct07RZw0JDSARbpfYl1J3BEMr4a1cS0MQ?=
 =?us-ascii?Q?qicplYst+rUK339Hxrfpu6EhIYCi7zLDAGzl6kjf+bK?=
X-Microsoft-Antispam-Message-Info: /uZGdt9lnqJYHE5YJNPV5rmiwPJwT5JhilAHcHTkLelXUoUBzWxeQ9Jff1CODiz5Q1D/625NkWXjTLVsja93syXfc3HyxYOUpl6NEd9B6SDsnSHCALxIjqpVA1Nhf6z7LouKiWsxSM/va3yJMpAqQt9RBFQg0wmgcaDKai6zQMLusch6wZkQUwvwK55GldQU
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:cdrzZ6xJzyvuJxLWpt7PQp//ZmPuA3GOcgAdr9xaKH2J1z2W7VkiBpUQZziCEwq6cNSdZhv/HeAAADm2Efo9099X3l4zAokbItog/MvtF0doDwNgzcAAt9BNrARzlaSMtioqeOBedoT5FhZjryoQN1Z2iJxBv1xL3/x6CZ16B7Y7zdA6NoScZNvkmDZrVkP5zcBHyOAyOdcNNRZAc4G0HWmWY5aGXjYYj4KrOKhQ+30+LT802j6Eaq+W1lyAG8uMHRJMa9r8k7M9Ix7+JHM7FnSbpHIiIDW0Ycx5GcVQJN7IJaKljeAhynNy4A8+vRBYsaGGuVcbeeVUMHuU9vfn2nhuwIoXYNVDC+QP4fFlDJhrI7ScjDgxoIKHrM+AfVTsvRnxxBIwdHninTrxbAACa2ZcenvaxjrgpuUTw1DPB8QCqrE88spUNlWwl8WQJg/ItHZBDA1F4KkyBeizo1EZBg==;5:smmmVWGnUJjt+E7XmNt3LhIl6rv402GGpvngZcISOtP//92kpIR/GL5K9iKMyIAQUPLLe+ZivDI1OGaLYtjg87kFOEs+jLZun5pIJwpoDLdB1TaXp7HFu+5a2oZ/iL2YVOO7Wi5LQCfe55j4gEziistzxeH6z0vc322Qr9xGW7I=;24:qPvkwmlokqu8jdEoPyGbagQGZzZyV5TqUUUNvg5+4AUTv7dm50VDytXks6jdQJ2aHPhHnxCs3X4a2aB/xDnNAkYYVN4siKHbt9jyd2NychU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:bHzBKw73PVVCwlkb9iK10pGoKmSGMWof0117yC8aEN1Y5c6ofS73BWffnVZJT1ZlxILFk4Sgd49JyrudHWfmp8QF5zZQrEbsDG9/OHRF+yQe7AmVFC6QN2PMkrw0MUi2HK9GThvUXvj1mKeM1yLqqiHdqdS4+uF1GM4UE2osbFqYLt+lBkeTKxbk5wTfWrSr6x+W3AkvsiWI96mEQZHlaWhp7fQYGy5XYXF3NH7asQiS6co5fE4aeWnrpOprazru
X-MS-Office365-Filtering-Correlation-Id: 9d4926c2-aa6d-4e59-fd80-08d5caa813e1
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:17.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4926c2-aa6d-4e59-fd80-08d5caa813e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64186
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
index c102386..eb9396b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -201,6 +201,9 @@ static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
 
+/* Up to four blocks may be specified. */
+static char __initdata named_memory_blocks[4][CVMX_BOOTMEM_NAME_LEN];
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -806,7 +809,26 @@ void __init prom_init(void)
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
@@ -910,10 +932,35 @@ void __init plat_mem_setup(void)
 #ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
 #endif
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
@@ -936,18 +983,23 @@ void __init plat_mem_setup(void)
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
 
@@ -977,7 +1029,7 @@ void __init plat_mem_setup(void)
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
