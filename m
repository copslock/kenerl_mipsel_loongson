Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:50:52 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:25310
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994698AbeFEFtcvOw2B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCGjDi0PIBqaBexjMEp5d1tP1DrhAwdvz9nTIIomDbQ=;
 b=m++f1rV7VLSI07KU78vPueQxs3vZwMG4yezSC8xtGU388BCtg1WmKKHeTxosJbPty+6MohM7SPArICK3a5sYwqAQsNesVRITvUBwYz+hVG4AqaX399WrApvLCXQpoAtU50/x01bYJf4gIqLOzrjE01xIrkxb+KF6XOIqEH6cA/k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:16 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v7 5/8] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Tue,  5 Jun 2018 00:24:54 -0500
Message-Id: <1528176297-21697-6-git-send-email-steven.hill@cavium.com>
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
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:aT0Zx5or7gCPGRhkGRcFZf3X1XfgFNppkngegH/r9rz2FODcKk256nXAEHFuaK0tw0ZdPqkc0ymcgUjiBb8wL2cRXvDnMC+nK0fVzmTVUJiS4mjt6EGoOK6Bzc+IBjX1xWSb4FgnRMUK7CwqXe0WGzqIGl8LzAwr1mmlCs0eeWPxxvnl/rfBUQSBOkBwbvwVLttQqMjd4bIvvGfVabRp62bKv/Il7vdT7ifqxuVQ7XWfe+7UW4pqz8kVK3B/EZ0F;25:f0NaRayznQxXFAhfHUmqfq6TJ3RHhBkaBPrmqPG1RawPYTTVOMGKed7w+A1ySHBpmafrk0vJ3pz3cl55l4sEZESw+sI+Mv0PAi8qGqieSQN+cnJb6/I9dIql0OZULbW7d5MiWlIq06Rz931ULnM8/QSenF4vvWYpdn3xKFleBilrueOmw4+hU8ygC3KaYsrR+/JeHJnbagMHy7bka1EhREcAP+jrwBDWAfUwaqY5i8BMd8POfTBR23EdTuJL0rHJleW3e2Ftt5bdo+g+Zck09Cu/0BMWhFDMkRR7ZwWX50XSV34OrHZy1Ku1cvFmlRH9Qvl5TzuqtlUtrxR+2ntgsw==;31:EtJ17R2OiBFY7l7bQOj00deLkoxf3OxcpR+QOWDVpRCO8h05P9EEQ0hWc6Ke0/DyrPnryE5wOpMDJklLyUShWx9/8LRt+ul2dSz9xp3kL7+P5jEh4dJheb9HcETiyL8aJWWLYJkTL4jzBsENSTKTn5u2Uts/LE2dplqZrh64f1Ftr8plEUDvGuwcyZTAQfjDP9NgEeT4Bw0jSFl3pvDDcmX9dXbx/1Q42hmnhCzENjY=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:LYvx9SEt1H9thP9XcdrSXx1sTGn2jBXAwSehBEdtfRst+odqpHVaz9o5JB8A4LUJlJOeMX/pHWaY8rBt77xJlnU1JrAgCCy7el3Hkz0saYAbuXsbKBHU+8lELABbJT5o0cHWU5uyTpKBE9oWRFuVffoGNz7O2H0HTtR4WLHFCC7f5afIsoBeJyH2SAC+6XGdGvq6t8ITFroRxOk0asFrxRzH6mL312sC15sC9N1Liq0IWtAzYsVHfPTmlzPao/ikBvzicJCcZtnzDlk+joZDNufL3vEzbUHIgCQiblBDNi49BY1j2UBO1YU+W1RBc+jrgjokNJrjd/IcIJhR9NbCP8TMxSdKmaBO1ps7rdpL/oCQXVBNonEBdJ7PjFLIEscyOrSfMd8Ry9qs0e34GGfgPBKEM176iT0xjK6NttwU0Qwx7rr1U1xWi4D35fnMJY+aRJFNXY5LI9y0uZCaXvvX1RIGXLbC/lTF27nZ9A/nDBuRrlnGbqoyTWq0Psf0GUAm;4:saeBe0wlXUfHTLs+s0XBFdc7YIj/w6KUS9lk4t+E3ZFg6PEUSu02SdN1DuiBoMfR5PJqYXc69UP38ZLXY5NLpQsWrXwFT67kTz3ZIdxRIG91XTOFu+lLcQ+izHuQW3bAZzxdZUFF2aRUNdzxXyuI9yGdz+ghRG8gqDQof9dfwvcTUGviAKb+lQ/2EDjJQvQVknjSflN1JFfFQIdgIhzsHewZpUwsjzyngHjFRBU3tPMtUxW/wGItGd723m1T23y6H5WKygEIFkBNKhRKJ76u3A==
X-Microsoft-Antispam-PRVS: <SN1PR07MB39662C24FB75DF66F77DFE4480660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(107886003)(305945005)(48376002)(6916009)(7736002)(59450400001)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(575784001)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(4326008)(51416003)(68736007)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:83b9fgho2JNff9REp70Wm+Fj5Yh4oYRUOyrnAO/Fe?=
 =?us-ascii?Q?0WdP8S3zFS2NSd76N7r8Qz95/QSOIQF1/f5WupFY867dE4DxgLwG7zEN6AED?=
 =?us-ascii?Q?iFesdd9/JP0cOOpkqPIoG1MgdkQvQXQCvhCgXpQC5239b9qeeb+nTeQOFvW5?=
 =?us-ascii?Q?IJpxCeEpO1LZ1SffWZ3BihdNC2svd0C7tHPuu9FArICoufGoNYndGi2wd61l?=
 =?us-ascii?Q?+JIkMzrEkezfRm/5FQO9EmPWVW9eqV8N3qfyzeTLEkWFrBpLnkTSH0+Ts5fi?=
 =?us-ascii?Q?9x2ifBRriepU4WZAu0zTNItZ/nvMS3BSIuKwxZGIBkZxdvaCtnzvdwLmu9ev?=
 =?us-ascii?Q?3EpDlPKM2BFDobYak8QLddLRqc7Xen1z7uPzd+ZziLyRmfa/6v3FCNSu3uB2?=
 =?us-ascii?Q?RFtHNdQKSECZ8b51mgK0Xeul9Y8YfUo8a4By+16qw2MHXU+VAkjAP1Md1K9z?=
 =?us-ascii?Q?QLmvB1v3CiPoYKNvTE7pMaiWA4liWAyIBZ116LHZgo+oYzwZ6cR4z/b1xHco?=
 =?us-ascii?Q?SP9wxkAEzh3aBaJFq4j8EKXaBDJyVum5ZVEXZH9kQimWSR+Mf0ZxGYZYvKcE?=
 =?us-ascii?Q?kzHTplIDA+lfnQqBtVBHFXTt4SK8K9FdXYtOU6YD3Fj4y+IT9RE4PD/shRKi?=
 =?us-ascii?Q?IlZrXiY0ToD53RHHqSvvfM7zgEB/dY7eRBXgErn6kSEaaIF8LmfWsun9sXfI?=
 =?us-ascii?Q?rPjB0LUwX1hHk/dMwYJArPN16wtniS6CmL+Dp5dXqrMVJm3mmvHoRDibY4Wp?=
 =?us-ascii?Q?IuHIIEwc+P9o46VFwNSJH5w/sv++7iKW6RhH9dCkfPcvWFVK/bcm7CQhLd69?=
 =?us-ascii?Q?Cho314i/88wBOHDubqCCCDXRLjmo2SwnFe5yqeFI694OkWJySjM/OhVk1aD+?=
 =?us-ascii?Q?Ai6xSGrWGCdURUp4tLAHYKDA2W7s4KdLtgkiM2VSTXldeFvwq7mOJG5WXaWh?=
 =?us-ascii?Q?CHzBgvZK3HgErhYIvYEd0hL8W/25gKKtYygQ0UdctQGvqMVqyhD1xpc6rYS+?=
 =?us-ascii?Q?rOQi0JFoOqhpDGm7ULzwKZddwnqcXecoHthN0RqbeMnVao8YuZj53cW9+chF?=
 =?us-ascii?Q?I3FACZ1acJP9h3ApXmUHkPjzFSp8ZiRx2GMaIp87ckZeFv6f9cymYzSJF60U?=
 =?us-ascii?Q?jV/IdmOm8dzsUYmtR8j3vdqMLUL1xs8LU/BtV+qLGWL6jzBe9ZxZ2SZOpgHh?=
 =?us-ascii?Q?puG9pImRSN5WnRl7AIvg4GUA/zzxsJI2T/FlWZ4vjZMC9M4LZkiH451ClMF6?=
 =?us-ascii?Q?+dV2PV+681dN1qsTDXFbnejpy+uwxXwL4E5v8D3hj+PV4s223bKUbvsCRVP0?=
 =?us-ascii?Q?9W9e6/vcgjsywI+36PhBB5mnCYwWufwJ/fRXTQRDBpvTkBW6Uzl0YN6aSKW5?=
 =?us-ascii?Q?81uXA=3D=3D?=
X-Microsoft-Antispam-Message-Info: yX12VWkbv9dlUvQrU8Ik9nKzb/2SnxJrYepBnG9EcZ85aSKDsVBptpdclC+sKCO2xXJG0lqXFElohXnfO/iVD3i7PnjNjzoHiHvLT9kPnBZYy6lvQ8cw3oHmL5nNQS9LC+AqruHJDjMGgrEIuvFw6bxCV0Fe0at6OxZzMas4gAKILbUIqgfsvKnh27300+hg
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:ffXyMWZR3lIeX7vSRB7XcrWhLfgpBy2XhY66dN0BToHaJ3x7xAReGLrvSjk994HYqgUraztgzyyveNDbsI0CWmbq1UokYoBDo8nuzS6ORaYcbazIiPlC4tzuF5Af0DVwoFGcxD2OJyWmGsFeH4y8hTmy1GgQSYOMH8uSGPO9vGKHXs6sUg/Ai8MJTb8GXAXcNL+F5FhlxcGiR2YlU1uloJS9NLPAVWldEGvWZd3cJQ59wGpIGeL0b7NduKZzo3v0WTPbtQ0XZh+xkzhDArKg8Xg70Sc07WWVfYWxUe4W8SewCY34iT9QSUdsQRBMxZ6/BlIHWZP0QbcMIrYc+Llr+hu5MSQtzifo84xWde0Dg7wSUdmQSxIV0i+pnJ6iyWep2GfEKh6ziJpnY8QZDx00J95Jx0nWY9AKqhJed+H/BqL1FxyVJDGo0t/oJWoC+J3/h5bLLuL2dVe+kXNuwL6ZKQ==;5:ESlozWJ+ve5x9pzkkB2GF0S7p1gJpZztS/clrzQN+wSPKHRT7UaBYzlSqdvDzK6bhcVld5Sd2tUDOyw6yI9ACrXL4FrBiBle2rO1AO1t9XJWv0BWXgxQrJhyPpNfcuEtqmsV5YkA6hdsN0zrHfRdkDUAlQqKiZ8Zrg7pC4upv8U=;24:3kmMO/mmCC66SCbjI8PyhxcaMfIwchpiGk/QnQx+yixEHw0BTh5Q+cw27gSItp/OGZU5k12HMbVuPfOKnh/NYqXEuUgpjzoedJMBhMXGJQs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:ekQGpWkGE5txUWyALzR6rhsggM7RMbYenI1XJBfOVsZMHMv86SXfn9EXKsJ0eepR8gm9EcF33ZbpwB/j5aBbuSU/Iii40daqceUIMgupqokXfXFLweyRpW3xHvg+G/RqLZ8hF56avI0lDWnXi3YJesTIyeRITVUBH76z1Awp8DXs3uok7bKr99/cIyLcNjT5rTLNSRWAwOXAl278zsDG3NKGedh77SLSD3XYjm8o92PxUDMYZrVDKnnthhym8+LZ
X-MS-Office365-Filtering-Correlation-Id: 5e977a61-7358-4feb-67a7-08d5caa8132a
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:16.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e977a61-7358-4feb-67a7-08d5caa8132a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64185
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
 arch/mips/cavium-octeon/setup.c | 163 ++--------------------------------------
 1 file changed, 7 insertions(+), 156 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 4a6bf71..c102386 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -101,55 +101,6 @@ static void octeon_kexec_smp_down(void *ignored)
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
-		pr_err("Requested memory too big, truncate to maximum size\n");
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
@@ -181,72 +132,23 @@ static int octeon_kexec_prepare(struct kimage *image)
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
 
@@ -1007,8 +909,6 @@ void __init plat_mem_setup(void)
 	uint64_t crashk_end;
 #ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
-	uint64_t kernel_start;
-	uint64_t kernel_size;
 #endif
 
 	total = 0;
@@ -1050,9 +950,6 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
-#ifdef CONFIG_KEXEC
-			uint64_t end;
-#endif
 
 			/*
 			 * exclude a page at the beginning and end of
@@ -1065,66 +962,20 @@ void __init plat_mem_setup(void)
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
-				 * kernel's memory, ignore it.
-				 */
-				continue;
-
-			if (memory > crashk_base && memory < crashk_end &&
-			    end > crashk_end) {
-				/*
-				 * Overlap with the beginning of the region,
-				 * reserve the beginning.
-				 */
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
