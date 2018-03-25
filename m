Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:48:07 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991096AbeCYGrKaqYzM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=QnmIj5OGwMtTYf19kLwELsDP8xWJ9ybH4VBH6vwVZOkHorgR7jHe5NHa8CqxADtznXqmjTdrBcZ0OdXn8WL22XowWwgJVqGuXRVzV47HyXGsS66Dja/v4ZfhQZ0f/DYFEQJ/k5XHkGXTfM92UT8eJPwml7drTaVyprHC9mj43U8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v6 4/7] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Sun, 25 Mar 2018 01:28:26 -0500
Message-Id: <1521959309-29335-5-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d21b608-c402-41dd-7e78-08d5921c3450
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:9DDgJFtpP9xEC/TbXmAMX8+pTGdfZcys+v5Sql/vZCS7O2x7szqnpmLcp8r8d4rhcls+wyEv4NnqNvsC+GhQuurDoZLQo9zX0LVH3OOUnBTSVOIwv+A8RTjTS8XEWebS2PWsUNIBbzs4rFZiZSQf9exObavQt2o2E8dOemK2MM+FeWEFOCfv7QXW5D2HYL7cFg/DPORoR40jF2mm0UQM2oco/BZx6upOqiugl4Zerq11mc+ObnLFSknJ9k/aLXNJ;25:RjJ0QqlODRWfC92n3KbX+YTvIonYaFSsFlsC3ehJcAkmYhO4i4jh4CnwJfoa0QxYQyjdY4yWuR8r77/DT+MAWGf7gl0+DvdFlEGprgayL2IZf2cpraAhKpjvWVfv8Rz3hw8B7x0o7jelmn218tfTWKk3lB7BWMhS83TdgkTmDmBgZWfMDUkLGvffItTJ/XhsxukYgJVQo+NTtUghjbtlHHN7BstmUcc1Sj7P/aDdRomQBA657HBXPOPFIK/iBbxgwHYRyNZo9VdOsTy9aIyhOiVuQmZh0UKkSLTi6JSRu3FR24MZoP4tstG7Whtybk2fgPHvY+3q2NOv89Da1tsA6A==;31:me6JpDcc3pLhKk7R9NF1kfeVdLCL5RJO7Z+FxnuHjkL/HZC45G7X+NKuMy1YLib3N+g+oYXvmycGNsmwfa4/4M3k/YxJFuBDIj967IL83fMytbYAsSdgt++Ehq4o9qmWuGpJg0f+8Wo2DffhnGi4GqsS444oXhZwejdywI+U5sAgRmdoedBNwayRQWaqW25in9GAztH0kBEKveI2AgpxvOgNWmJueA4Ggx/hoYi9Xy8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:D29vk1GZRRe8aQkyeaZ8gfPFZM9Hu1OZOHIj2+18jlHSsjdxeeGj4xNcqO2/9Qw43Og8hmoaPOHfZ71MkPxhjA3FrRotPr/RGHxpIFMYauRPuN13qUiMutRU2/Y3P0IllFyxYUg7subO86uehwdiC1T+Cy/QJ/y+wvbjrefBagx8XIa9TlEA8f7NrOPK8wzytqts0NpNQeeRtTSkSSIKVXlGfPqCRyFBZKjslgbLxdi4vWZd6nd3Cbbphk6rEBRe7tBnz8XkeCF/4dOE9LVboedTNV8/3WHQj70vHZoVYlS6yEFRZX3QhKIQ+TSwrPxiLIUQl77N9jtBt4suu2K/XcToZ/gj+Kuub14NXZsdVxfmRJopA/g2zZjhpow1djQqx2MDo5lx+maoRDrDe6U1d06fMMu1SeQZPMI/PCnZur2d88+ES1FRrYgEj9JNMvPcv+EWaMAbTGwQ7rZYj6Cg14zYGhA6uu7GFu3W680wJVgIgDEmyCqEn5v7+WX6y9SI;4:q4BznSzLzYSTnoX/mHcfWoHqdyF3XLOFN0Om4HvOeWsGRbd1Y1k0Xl4rEMt0JgUGqhPsJDDfjFdm0SmKCGrp5SuxdBb+kdUlfuYl8WYNdk9Q67taEHVQsgUGDYiaG3Hve79neemrOMsRKqH/joLezIqEymwtfyVhQMCFz3eXz8QH9/6DsniMpUqcF3ass0cEFLZXhfdra3LVOchxyUoxPoY9QtfhXkSRMRzUIBFzdjeizCt+RCkbPd/jo0GcAWBn/6urd650SQYaS2WVP1nm8g==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610ED1D4431425564EB35CA80AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(575784001)(386003)(86362001)(59450400001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(107886003)(50226002)(66066001)(316002)(16586007)(2906002)(53936002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:D/+bXmJmJcw01K6U777drl9DgeJjxYFi9OBYTZOGD?=
 =?us-ascii?Q?bMjyqRAgCua/+gjFXsXa8eW78wmQNz9IlN9BdnBd0IwIuEmH+9O35yhgRvlU?=
 =?us-ascii?Q?67dCJgQt/5+OmWuZNPNMD5NWXEDqEQTd/8RQuEN0y6c72IgF11hKKPzk8uZs?=
 =?us-ascii?Q?ZNv+nDIs9HYvZNx0HQblpTLqfx3fycdAeRnl2qXqB3Y3ozji7iHerRsjcVul?=
 =?us-ascii?Q?P8vrtij9ISHx20cHnt+3F9rRqDDhWJfqXPf7LFbXgyocf3qD1bziqQis7LJp?=
 =?us-ascii?Q?OvByrCs8nuJX0OLHq3+db+18K4ITI8xQMoFc60DltVvjP6WFKXxXzU9GbzSU?=
 =?us-ascii?Q?LAVpfh4uZNNpFsXRRjsIYcopN7eGowEoKv/kb3Xc3zabWMigUWxzuLjyshlm?=
 =?us-ascii?Q?tSa9L5ZPNrepWbydDDG3z/0sKgETuvacSrxHXVxqflR4SEh0iKZu7LwUsXQV?=
 =?us-ascii?Q?Z9GmPlKzF9KQcY8UkdJjwnmCHyYePBNaXPHKuapQsRsa1rtJ/CygAcaI2r1g?=
 =?us-ascii?Q?6NdSMqsoss/zZ4OsAWjcPds/OFH5ifmXhepMmvYHekcXJxNnuHPm8D3GlTVW?=
 =?us-ascii?Q?ai0gLS8AfUgR1x16zKXztTLX1AQ0mRacyrfqYaj6pjQa+Vaf9XXg794ahNJ0?=
 =?us-ascii?Q?fz2GETIdLUkR3pdsfneMdJ+37mlodfG84a9BYVVSrNJUF1UP4HKEvUq/IdI7?=
 =?us-ascii?Q?N7Z07g4exno1ADHhJ6a/gU3viDcurebTFPPaxnPBoOu5K7eFhDr9Mr6w0RmT?=
 =?us-ascii?Q?RfHek9mxUqAmEImtVhY5/UPpza9kT1IYF1lEXc88HE9VqYo4SVSyRbLKHDRo?=
 =?us-ascii?Q?WOZWTonqZXpMt3MF9MQJ6wQLmOWPgFQY0SgeoW3KeT8CZSX4SRf51U8ujeWo?=
 =?us-ascii?Q?R9bq6giMDyVv5lH0dIdMISxeEUr77yGVxnDlYFfYEzoN1Y2r6xo7nSg/M/nZ?=
 =?us-ascii?Q?EOURX6WbcFgOerKcuCTUxpBUYoKTrXNAwFbgbi18GyK4gv6YJ0S9IIs4ShNz?=
 =?us-ascii?Q?UGenrnQk+LN/bvbphhAv5IFXsPE59OeaoXBUBiDVVOqPoZrvHGz2MdRvEjcW?=
 =?us-ascii?Q?0MY1i+U1pL19KbBhs/SovOHSER9gyRZtlAAktqOPdePGkx+TjmHM7YE2D6Bz?=
 =?us-ascii?Q?EOVbvpdoX7zuz2w60Exe6ByIsB5OVv1btBNJXYWSiaNN4c+K2YOBGlcH7okO?=
 =?us-ascii?Q?TF4wpqqfay7iEu35+7KXxXixSvwSQ8SDhOMjXEZkrYNjVOMy92QLLEpJaA9I?=
 =?us-ascii?Q?g34LyWSAKVXHegw5sViSDMzigBM5rPL/UdsIAs6IuC78+tHkKM/6knsaOhGH?=
 =?us-ascii?Q?VZBB6HkiIPNM7FRO49xDxE=3D?=
X-Microsoft-Antispam-Message-Info: VotmIccRSFnkyzTUTsHl/0OjYWXCpzZf9X56p6+jFJWvae4NgVJqFLxAS5vfUHC6XH3333vdR+voo6mP0CmPArKJG+VgWzwbblUAr9pwfJogBil7yvWJOsc8X8dOi2L8UIscZSp0QXHb8Vq63PMzxfimlJTF6Np6vO6aFRg4q09lJjUrPiAbJu2XifBFyyC9
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:4l1+NNxtj82CxKvNMJx5ux/EvcE7x2Df4VCA0Tg1THKMHaVAWggvXcwHT4K9UHcTPVzin3udou/mUp3pjOu4GvJdutXQH6MCAD6eKN01jxkrPoTDChowv36g2OPl8J5Wy6xy0mqmp4NzujmP9x8EXvGCui/EAKTL1z1dNH/x9+6PcZ9myV7j0wNi+ZyusKVXbVJMnwn4d7CxDZTL9HyXwVoSZUMOJmyQzxz0nUrPmXvIVqdpkWVy7iRhi915SCiI7rYrXccVnV/bVU7wB99HjS/g3qSE1H025xa+Jz7IunSVLCPVBq9BturLiqi24IsAVAwlLXj3BLXj4d9RGn4g8t5I6r/iPdb+OoLgDqkR2kKablAGtET2e6//vNWLs3MJL8nL6c9BnISpqKRjtUd5PyVK6Mq0qmljwb4iobT1joY37In72yzpbrxxtjAM+Jl6+106otA5RcvRV6GVI5LmQg==;5:DRnZOHPUPI2pU8mIgr5COZtBPv2NFKUJ2mEgua8ctEpqelnflEVlFJZR/FvPtIcX2uTXwV0jFPAGjjqVjPNUSSQGNfp7VH5ol6fGhGsWjRCtzHqTQGvKdETjAkE2Wx6F8qpHl30/AJDlZ43XENqknSfTYF1H9Gxj9rvy0jxt590=;24:9A6JH2xIgV9IjIyyaMvvKtwY+ELyzArntsxkPbTu4CQG967CLkUBFNY2OTviSGXICHlgChQGHbzS6pWxHuhTLtZmf/xx3IG9pNJNlZRM77g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:4iPsXxjhX3x3aU4ruLUvIcHqzxkKfcYIgI/LJKgdgyX512PHA9fsr2XJ4IJ/0f/Hs/O1+9tiYz4uh2QrYvhYOY1Jt7eeRM3hMqkXge29Ppbqek2w2xe2c1vJk+sy/qIhWa/izcLlxGRgpjfs178ryggJbDmszigIK3JXEzldiXpKP9LMfskNYtZe9K2m13SHKmcE41vUfoUsoPfZ7vUP9IgfM+r4zcppM0KDRHEtbgqPwuoDayLeujRpr6nKnJcw
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:57.3800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d21b608-c402-41dd-7e78-08d5921c3450
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63219
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

Get rid of obsolete KEXEC and CRASH_DUMP code. This is to
prepare for adding in the new hotplug CPU code.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 168 ++--------------------------------------
 1 file changed, 7 insertions(+), 161 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2085138..46e2bb0 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -100,56 +100,6 @@ static void octeon_kexec_smp_down(void *ignored)
 }
 #endif
 
-#define OCTEON_DDR0_BASE    (0x0ULL)
-#define OCTEON_DDR0_SIZE    (0x010000000ULL)
-#define OCTEON_DDR1_BASE    (0x410000000ULL)
-#define OCTEON_DDR1_SIZE    (0x010000000ULL)
-#define OCTEON_DDR2_BASE    (0x020000000ULL)
-#define OCTEON_DDR2_SIZE    (0x3e0000000ULL)
-#define OCTEON_MAX_PHY_MEM_SIZE (16*1024*1024*1024ULL)
-
-static struct kimage *kimage_ptr;
-
-static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
-{
-	int64_t addr;
-	struct cvmx_bootmem_desc *bootmem_desc;
-
-	bootmem_desc = cvmx_bootmem_get_desc();
-
-	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
-		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
-		pr_err("Error: requested memory too large,"
-		       "truncating to maximum size\n");
-	}
-
-	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
-	bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
-
-	addr = (OCTEON_DDR0_BASE + reserve_low_mem + low_reserved_bytes);
-	bootmem_desc->head_addr = 0;
-
-	if (mem_size <= OCTEON_DDR0_SIZE) {
-		__cvmx_bootmem_phy_free(addr,
-				mem_size - reserve_low_mem -
-				low_reserved_bytes, 0);
-		return;
-	}
-
-	__cvmx_bootmem_phy_free(addr,
-			OCTEON_DDR0_SIZE - reserve_low_mem -
-			low_reserved_bytes, 0);
-
-	mem_size -= OCTEON_DDR0_SIZE;
-
-	if (mem_size > OCTEON_DDR1_SIZE) {
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, OCTEON_DDR1_SIZE, 0);
-		__cvmx_bootmem_phy_free(OCTEON_DDR2_BASE,
-				mem_size - OCTEON_DDR1_SIZE, 0);
-	} else
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, mem_size, 0);
-}
-
 static int octeon_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -181,72 +131,23 @@ static int octeon_kexec_prepare(struct kimage *image)
 			break;
 		}
 	}
-
-	/*
-	 * Information about segments will be needed during pre-boot memory
-	 * initialization.
-	 */
-	kimage_ptr = image;
 	return 0;
 }
 
 static void octeon_generic_shutdown(void)
 {
-	int i;
 #ifdef CONFIG_SMP
 	int cpu;
-#endif
-	struct cvmx_bootmem_desc *bootmem_desc;
-	void *named_block_array_ptr;
 
-	bootmem_desc = cvmx_bootmem_get_desc();
-	named_block_array_ptr =
-		cvmx_phys_to_ptr(bootmem_desc->named_block_array_addr);
-
-#ifdef CONFIG_SMP
+	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
+	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
 	/* disable watchdogs */
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
 	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
-#endif
-	if (kimage_ptr != kexec_crash_image) {
-		memset(named_block_array_ptr,
-			0x0,
-			CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
-			sizeof(struct cvmx_bootmem_named_block_desc));
-		/*
-		 * Mark all memory (except low 0x100000 bytes) as free.
-		 * It is the same thing that bootloader does.
-		 */
-		kexec_bootmem_init(octeon_bootinfo->dram_size*1024ULL*1024ULL,
-				0x100000);
-		/*
-		 * Allocate all segments to avoid their corruption during boot.
-		 */
-		for (i = 0; i < kimage_ptr->nr_segments; i++)
-			cvmx_bootmem_alloc_address(
-				kimage_ptr->segment[i].memsz + 2*PAGE_SIZE,
-				kimage_ptr->segment[i].mem - PAGE_SIZE,
-				PAGE_SIZE);
-	} else {
-		/*
-		 * Do not mark all memory as free. Free only named sections
-		 * leaving the rest of memory unchanged.
-		 */
-		struct cvmx_bootmem_named_block_desc *ptr =
-			(struct cvmx_bootmem_named_block_desc *)
-			named_block_array_ptr;
-
-		for (i = 0; i < bootmem_desc->named_block_num_blocks; i++)
-			if (ptr[i].size)
-				cvmx_bootmem_free_named(ptr[i].name);
-	}
 	kexec_args[2] = 1UL; /* running on octeon_main_processor */
 	kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
-#ifdef CONFIG_SMP
-	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
-	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
 #endif
 }
 
@@ -928,7 +829,6 @@ void __init prom_init(void)
 }
 
 /* Exclude a single page from the regions obtained in plat_mem_setup. */
-#ifndef CONFIG_CRASH_DUMP
 static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
@@ -944,7 +844,6 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 		*size -= PAGE_SIZE;
 	}
 }
-#endif /* CONFIG_CRASH_DUMP */
 
 void __init fw_init_cmdline(void)
 {
@@ -975,11 +874,7 @@ void __init plat_mem_setup(void)
 	uint64_t mem_alloc_size;
 	uint64_t total;
 	uint64_t crashk_end;
-#ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
-	uint64_t kernel_start;
-	uint64_t kernel_size;
-#endif
 
 	total = 0;
 	crashk_end = 0;
@@ -1020,9 +915,6 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
-#ifdef CONFIG_KEXEC
-			uint64_t end;
-#endif
 
 			/*
 			 * exclude a page at the beginning and end of
@@ -1035,66 +927,20 @@ void __init plat_mem_setup(void)
 			memory_exclude_page(CVMX_PCIE_BAR1_PHYS_BASE +
 					    CVMX_PCIE_BAR1_PHYS_SIZE,
 					    &memory, &size);
-#ifdef CONFIG_KEXEC
-			end = memory + mem_alloc_size;
 
 			/*
-			 * This function automatically merges address regions
-			 * next to each other if they are received in
-			 * incrementing order
+			 * This function automatically merges address
+			 * regions next to each other if they are
+			 * received in incrementing order.
 			 */
-			if (memory < crashk_base && end >  crashk_end) {
-				/* region is fully in */
-				add_memory_region(memory,
-						  crashk_base - memory,
-						  BOOT_MEM_RAM);
-				total += crashk_base - memory;
-				add_memory_region(crashk_end,
-						  end - crashk_end,
-						  BOOT_MEM_RAM);
-				total += end - crashk_end;
-				continue;
-			}
-
-			if (memory >= crashk_base && end <= crashk_end)
-				/*
-				 * Entire memory region is within the new
-				 *  kernel's memory, ignore it.
-				 */
-				continue;
-
-			if (memory > crashk_base && memory < crashk_end &&
-			    end > crashk_end) {
-				/*
-				 * Overlap with the beginning of the region,
-				 * reserve the beginning.
-				  */
-				mem_alloc_size -= crashk_end - memory;
-				memory = crashk_end;
-			} else if (memory < crashk_base && end > crashk_base &&
-				   end < crashk_end)
-				/*
-				 * Overlap with the beginning of the region,
-				 * chop of end.
-				 */
-				mem_alloc_size -= end - crashk_base;
-#endif
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			if (size)
+				add_memory_region(memory, size, BOOT_MEM_RAM);
 			total += mem_alloc_size;
-			/* Recovering mem_alloc_size */
-			mem_alloc_size = 4 << 20;
 		} else {
 			break;
 		}
 	}
 	cvmx_bootmem_unlock();
-	/* Add the memory region for the kernel. */
-	kernel_start = (unsigned long) _text;
-	kernel_size = _end - _text;
-
-	/* Adjust for physical offset. */
-	kernel_start &= ~0xffffffff80000000ULL;
-	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
 #endif /* CONFIG_CRASH_DUMP */
 
 #ifdef CONFIG_CAVIUM_RESERVE32
-- 
2.1.4
