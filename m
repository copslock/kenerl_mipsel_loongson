Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:48:20 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991128AbeCYGrLEYSpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RL38Ub6ueRwznDM0kYcXPTqpgqN/BLoDeq40s6APEk4=;
 b=KJHLo3kAqWaZ+1LbooVGD0Kq8ibmKeLv57cevQhwCEg4j6XkP5mySLGyvtIqWvaCTegD5NK6Ay0R0M3MkGCyCTgxIdtpUqaSNzdYcHY/aOMKR2phH4D+955noOLJx4djFsRK/4Ytf7zKT0Lr5I5R7sVGGLxnAAwSgDXw7YUzDC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <carlos.munoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v6 5/7] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Sun, 25 Mar 2018 01:28:27 -0500
Message-Id: <1521959309-29335-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
References: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a370cc6-e0f4-42c5-f822-08d5921c34c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:aLyHuTfrwXaL0ccFdH5kJgeU0rM7rDruGNoRdTRXDsvBYsZoojTHUpfQIAFDTsAzu0A2n7vHSgw2z8uj4mM5081PtGYE8O9eNiZ5ZQwHoNuPuRFLYYx+eVwOEhrpDMCLEWvZZVPuy9APi9oVOPv0k0mmP/I5WvzV5oqA/qggE4/isSAczlhWcIDrVG5Tz77G71UzPYsa6PvSR740DZ4wyqNgCmiBwrPZzuAKhTtrLX0yjg+lS1D7FEb3hfRAkxil;25:0qHGwYBZ7+zxZ/mXnxN0SlabqiaIYE+v+imhkcON2wSVwvpp3QcUO1Wz2PVpnaqAZZUaQakNHHf63TiVTYlrM7ura88wuXcWOqw4NJiwYGevZyaldWPDPkRFfSAez2wfJs2F1KcZWnsF4Ej0ycFf/NwLLDi26XUb3hNy9WVWulHkRDBLA8bqG5cs3b94yzCYiYICwSP24GaJBauose6iFS0Yr4mhl57nNdfUmG844oyuzvQFNdKSoXgdUu9lH3fL9vmINQWde0fRCKFcpeUEdno2jsAn+LkftQwBKIIEPmp05CeBZcEmeXqHYExuhCPHEHX38IKtNQQeihZgs6C0hA==;31:DrVCduza6n4wZJtirilju097rpPzly7OstXY91eCY9Y+AR1YeDDrjCJYYw8n9HDtVXsplOPos/7r5pp8sIj5n9pkuEwFdpp/eXVB3p16UKhiVBcKJSVVsG6OOY0ZMhx1S7E7AbiQ8uC3oD444h6ueAyn5XbxjLVcEKTu1WeZ70KHpIin0P3orOxMDUjypvWJnunALYlOQ8Js7Cz/HmAXu8FG3UB5QN50ALKX4HiBVw8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:34vdYP+j2lpRwYHYk7PFMmgZf8gAs3nFxH8mEHLBshdfXnY8aG8ykp5r6tmrEGmtvVyKMhVFq/DEoF1egdvpnf5WDSeRW/4wX0wuv8YWOvDIYWCFjvqEPqvxatUiJQpI4HGLrlRO+KJIX2oyFBFeUvcFQPn5H9jzEz0chZaRL7ShlzKw4hoUUh6qwUWMI3YTT4tSgKZ4zqWRbWdBgPIAzrpOp1HiOF4js0p9iacRRSlVf4rdcEBdEbwEqqm1VsbrCmOxY0ugY4NznApymD31bnU53gK/KJz32bQGZGgylr43KIUkHvPTaikD+HJaGNwodSAfRimHBLI/KXNB1Y7/GYccZwFpJ7Ufv2O6O8hiww9nQ6w9aJ54kQjfmxgMZxuF+WgNk5+bDICT4vSj0wRvIqmFyDRgHaTeWU9FcDjyZ3ty0gLLmbi7w/g25MyzVpY8UwARaPKPpz222uum9dUk3rkb9GvbDSbXg+jkG1Z0GoL2hh2UredsZ7HMFpwbILej;4:ox4dnVpsEBZANgFq3EDV/B8Wfav5AP+Wt50EbK0P3lykH6COAvp2Vqt41szoN1JhN6Sgv+MGER5ml2oBrGB4TOQca6B9H7lO+2L70OlgnZQT4SHXOsSA/Z01+WfneB/37IcGn1UlCQyy720CyVAnbiy1LOHGy8DYIWPLwClelr+crruD6Si35hYnYX+ZxEnZZTF+PJ9VCXMH2ex/fIG3ICA8n6J7VSSMLZfYfOlfrEstPyNoBMv9Y5TVJg39CKX8++v32E5Vy5SnZWQ7xcl7pA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB36100DE1ABA4BA2EBEF05AE980AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(386003)(86362001)(59450400001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(50226002)(66066001)(316002)(54906003)(16586007)(2906002)(53936002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:kj3SHiBdwxeKitLkQQiLJ9cUTrkiN+HKU9RrYwNyl?=
 =?us-ascii?Q?ugcYxQCgJNx4rxU2zwEDOWKU+7lujlr5XxGyL56bvFB+9Z1G9y2CrHFzR3Gl?=
 =?us-ascii?Q?O63teULjDwZXImMfW8IaVWumIz87gLT8HFYqsTrYJ4IYHFSwCJ9s+xYej2e2?=
 =?us-ascii?Q?EY4FAWdIMJnk8ZEuvY+ZrSHbrFL4o+V3/MzXgKH3+OIAm5/mNKsMNUsFdapl?=
 =?us-ascii?Q?afb9gtxRLbCwVTS6sxayABoakE9ALSOdKrDgNxBnSHai5l8FBsysmrqRD+by?=
 =?us-ascii?Q?n5htxUke0Tls6xGgo/jHbkDcHmwzCgTXHGB96EogM8WhYn0RZQ7UmuCsTCNQ?=
 =?us-ascii?Q?wPd9TXfTHWsKcyMxrUGRX8hRYKhPjYMREGU02GmJ4HdC3UwjyGDsQcqX/i8q?=
 =?us-ascii?Q?az5cpsvH8BT+fIqF/KyNTrYN8rRKMjBzSHcq/6sItjLdFBpVwBbHlUpjWZuX?=
 =?us-ascii?Q?buN4h7vAV+NdrNwioxP3Od+1EmcDNTgmmaXfkUqCtd27AST4e4dhDKpHpwI9?=
 =?us-ascii?Q?dQZzOGsKJSzlrnyzpETxT5mKKiwkyJuYoaVcVECKbvUFVlVoT/1f5rplQuWQ?=
 =?us-ascii?Q?7oil6K3MR3x5QabT09CRgsW9nuiNQolnJ6MfdsZKdgKz03UUOUhTh7x8RpP2?=
 =?us-ascii?Q?N6+oVpbr/MaiwJd0ARnRsq88jF1xeETRSu0s9m0YY+A3dpLbRpUZvZ4Rg105?=
 =?us-ascii?Q?KBLb5QIC/p5p2TQIcWGVskKe5Ow/uv7WPjIh1pA9LUa6EoSxs4T8EIUGD0Yh?=
 =?us-ascii?Q?pyzuRq9LQd92ov+R7t+i7/gmkoy+ekUb8mOZYcZBl+mlfJP9TgW329KRXrA0?=
 =?us-ascii?Q?MsEHMU0N2aWYFi9XOdekk1pKvd+BnsD1JRszkB2v73mJYhf9YgzAwvdRmVqo?=
 =?us-ascii?Q?gLZ1qXHuujx7PQeGxOX2+KsaWh07fsTuyZ58YkzdfQBkR2IyKLq5LrPEXI4l?=
 =?us-ascii?Q?w4c4vKSP0Axc86kFoLcuBA94rXjvvifC7Av9EzIRzAYQWZxAwfgJCXSTGq0J?=
 =?us-ascii?Q?+LFv/b2IutS1P2DjWhoW9M68VFPBkZCSdv2hhc1SCQo0Ya6oR2dNkNEmi2Ya?=
 =?us-ascii?Q?oixeOyK80wL/UnSnkf3KclNCVZP+Du2PLoBUPpTODz2WBL7E/B/+TGjfKZxM?=
 =?us-ascii?Q?zHDGtE+b6IgI25fwC5I0Xe9P7qTahHEJtvcwmVER/l1wffXXBy/iUWXX0QTt?=
 =?us-ascii?Q?An6TpN7MYyb0V2w5UipF0krc7BvseMTm1AWrakEnSaupSqLUWHNEYuDwX5IE?=
 =?us-ascii?Q?lt4Ik38wm7AE5Sr3l6Fc4oSV1PvjJ4U0FDJIsg5aY0EHUA8xVVdm8AVUEOR9?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: dkXXvc3oxKR/dG7LOCxdYP/PN9B4qaHQbCi/Uh97MSKjGuRVF5FPcYFGIsIaSp43fMGHLNd4UAn+GtIl8lFResZhB0BpOr/j2JCSoHcpi0J/NVb8bL/6e2z7iPEh16+iQTdHS/a9BUWQQQ3isI20ULdQbmQaLlvMd3RAgYlCGUGQMzz2SqeICOYi/UTX2s3O
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:Jh30jIC3qWPmO+cpVUkSiYUmIFT8Cd8BKdJ8Y+VVI7yVBJ/bFRcdjE+EJg4C3BRJNX7ZLKUo9m5aKpFcguTTGi9VDSgOTRJ5DJAHeHSjnnMzKitd5MrJuXn6YHR/m8UQz77hSk/A7OLiMpz0xjsbwzoWeXDhnAozcVUKARGn+wrqzdw9sozDOfmebNKU6hzGnxcTFFqphBDDTdiyKJ1CgCI7wuq3tWcqNjj3LEG6ZyW61tv6vCV3PL2R6fxnJeAm79q1CSc2n3xlcHGrAQ/KeWgkum1iMJF7lH4+qfhDsWy3pn2MnYxbTsxnDrQgnXPLbyvJhhZSba437cFLnpWwGvmouxl1tZcH9AB75YBSBcQRuzN2uekJwgdnc8Y5bJ4Fts8zwYW4NvP9McepBhUsVgz15WnhnQ0vU9zsqm0rDcp8KD691g4iZuKX3pEX52l2Q39+YLS6i06DXg1V7h7WJQ==;5:ot7mbiH5Wh4hyQ7+WLcJmDnPmly837RF447i4voKtuABzpaan8ae+hmGxu5L9h5gFXrmnsNDDb/itvr5Wj3QNe7K4hb4py0fuAKabPA6bV96Yrch9n+v+/BMEKHlqhfrlVDVgSXckwvtcGkeNxOasqG9SPNmV5W/H4LLXbyibEg=;24:jMOjW9iu4QKtBDsJF6p+fTYvDmtMan/yQByJljOvc8Xe1sRdp2S5wNPc2Mpcra5E6gHn1WCM7eM4c6NjLg14IYedAjLLVbuXrvyYRnERfPA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:NDw1BfpHNjZo8wyNMG4xAVnjqnA2OsuiRkFLqxbB6ahqh3pgKXDuL4B1mqKXh5KDwKrUBOak4fuEjsGQWJGy31eIBaKWcf4ZMRi4vhmAHFVZgHxtk0kWR6bJvl3uLQz6ILgBRrGBrjfTZGupo/f5fQOzAqJfq1xqzChfWfDDUTCkme3ofGmON1263oi/dXAr12OjFqqH6SRtaty2mMLdZsF0JrKWEBj3SKU514ec8LoT6O9tGEA4+n+zuZwKS0cY
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:58.0015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a370cc6-e0f4-42c5-f822-08d5921c34c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63220
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
