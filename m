Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:37:45 +0100 (CET)
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:17835
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993156AbdKBAglBVCAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2XFbtnSmlKSpf3h6VZ3hBX2HnzD1O7G90/PpCzMuewI=;
 b=GgnzyrA0QPCukTf+S0MuiwIwznjoAtZ71JIgqOHpOUsaCQiP6VwJ+mbet8Cq7FXd0q7PMPmmypXaKsivdgFREBj6IQNNqu63TwWM9tAs79oXhhrfXZFAHuBpIp/4VpiGk+o49w1taZei5iHi7OzxL0hRN7TAvA3UJp53ooBfAL4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:30 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/7] MIPS: Octeon: Add a global resource manager.
Date:   Wed,  1 Nov 2017 17:36:02 -0700
Message-Id: <20171102003606.19913-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f51fc90-c44a-426d-ceb6-08d52189c637
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:hdD5JfFp2hbD+u+h/RmOUs8KO5IvbqAqoYMxM+/0z/lsPg4bXjkNCTU+HZgOZSbEl/K8X2DzU9pZF7zeBBo95NH5azpz0UVFJRcnTJaf8tgiGD0S+5Xzr8ARZWfGwarBwxiyBDKCYwUV1zXlV+PxLB+b7H1ilaSTxW4zEstvS3UCItgostjOxmVElZ1cYfoAh0ckHDOVvyGsF3VEZWbWq9RYuVMuw+/UvqdgWtHO7fFVkqIpCOpcUCCpIVu3VVoM;25:IZTITbrsa6MEhgTLbL/UlxEa0X565KMkbrATyo5dFY5jL4JKQdM54sMEEeyGtKHJ+87zjzfxPq4DjC/bgEzGuI153K8zoTtxUI/lAu9Fx7Jnmcq9d0OtHGMk3q8WlQzgoTpXoLZoKSVOu93TzRFLdm2NfbJgp/ttiwNIOkizno2Y9kwf0tGrfZLMQOZs1A0fz5LaQguPBTUG+X29bPX9i205viHUzqDf6zUlUZU1+6FrjSkT4zSvRFX11Z/frKWXMjwPhAY373Yj93j38605Czq8Dqj1a0rUjtNfEhTk0rGJ49pFC28nwqo2ZLwYcCGNJpnT4r35or7BbBBXkL3Qwg==;31:wpPSL4QD2ph2fvwBz0od7MqC2xipHh09OiGjKncT4xeMrdWzp2od1cIX06msqcxvjgNyJ/4Prb8+WIAUZchhn1EamqRk1NR7RpmW8cEn28e7ggnzwcdGdlvt3MAGl+oluv/c0g0H2F+ZX4pNucUeqRW8nT3OHTip0SVTQUwgRLtPVkgdz5xcdwLvmlesfKTrKBF7tKA92IslFp/UUiyaAQKhUDoIBiXn9Nt4KvbIAFw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:p/3onoxTkbIjACf8EhuJ+yc6/3vvFHi3eckaL4z+mR4BSxKPiJpJHbpja67xPiXfV4t7ImCSbSypGQivsAZNgrGWqZq9XIlSmscS0qvn4Vmiyzy7gnFBIRzWBxFPn4PkYw4MGgq9oErMVVEEzYmYGsIaepa6SOEm3UHxv+SjFmyNkpiVeMAKjoMr0L7R+bBXdFMZvYb1dSsYxoybEGTKWMjQLOM9JgEIB7nM/7F3ma6jIwcT4kcupzQ28GJpgb0eY+0zTsuC3ep5WJfRNW+x52hjDKc9RvCdUZDnQq6umQlOWd+m9apYZvgusUxBa4IrCIloq3q5vHenE5jk8Z9RgEg3LVSnR1L1RQvSazaZ3/rhoVFGwMt93aVqq3h+KziW1TnR+9GGwu2El8XrPKADcr88Yl4TTnmRYBFmvCvN6Y6lXgfSesftjZl5mn8ebw/A1ZFzCRzv+cgCWaRPF4nbJ9fycO1Yqhwp7PALeahDuSm65SsqqgXf5n/lCQ0cL/nL;4:5SXvS5Zh408RJCWLXmHeBY1uK2omfyWRq4PiTSsxVl2ukw2xN66nSswTWwiYS7qf5J8oZX2h9M92dIFd7DQvieboURyOIxa5eAvKOSVcUkMIixRE4cfh53Q47SvkwK69oasHlBMmvcEEQ1X1gVu3Fc8qQGlGeY1A8bUa3g9GepQl/e0cN07KZy9aMsuaFDHcMwv+9ny9/YG1YM+h4mFvXoZpgU4w86KCvoCD5Fr/w9SQqwsLoKvXOyNHfmPFQoMQcpRrJ2ZHKPTw++4gR49tDg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34964F5B2FCAD2F6113C3934975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(76176999)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(575784001)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:O8GAxr7mVLOwp2UOZU688MWxCJwq482wDKlkiiDwp?=
 =?us-ascii?Q?o/gQdpw51XZKljrnD490uP/FokxGrZpnEw3rvnIDw3I9zW82E6BfdSG4xLvc?=
 =?us-ascii?Q?i/ZpkY8ok4CctVaRGI5KpcgGldoxgCnSXbPpFeR/kNuz61ojTzU217gUwbXA?=
 =?us-ascii?Q?CWuajsBQ6wRVt/E7x/4MdgTVznZ1CERThss18Q2Ldug/d3diWcZFUgPOAJ7U?=
 =?us-ascii?Q?QdYN1ukaJvdA3s8V2syDeJESPy0rFbaasG0RsfDyrXUckbsbr8vcejCLQ+t8?=
 =?us-ascii?Q?UeX4atpAK4msx4lzM5/o6pudK7Q0UD0tS6IpbTmP1GT1BX0E+XoztIqQF+eL?=
 =?us-ascii?Q?WAOxh0sATkbpRwflcVxnryeZYggF7O+F/BvkMKKc22+dHqg7jYiYzmy0YX5X?=
 =?us-ascii?Q?huktn+vX12a228Oa+rT5piyXDa5hYSrdsh6DlQk0v5QOFV8HtFEdeOp/G/OP?=
 =?us-ascii?Q?kY8oSGYbNYyeKZ/13FPTcMvEQK14hCZTp6jn2+jzjA9V+bWy/fSM/FpMg6aW?=
 =?us-ascii?Q?QY7OO6KBr2U/jm4Co0dMEwkYRdDPC3ZeCYVc8GEUW5ilfRoL4WETLURmXG2o?=
 =?us-ascii?Q?iZuSZ1knGgKVSIu6uJ8haHtggjoxJXDUnSKD4jKFeT4fwbi7OrrnLkv88L4V?=
 =?us-ascii?Q?jzH3bMFSpk0MWd4GiboD4wgW3ceC2z9DvEImrVVabPL2jY40lCAlslBQR8Zu?=
 =?us-ascii?Q?KwmceXZF60+qz1KNzMoY/qaTjn1HjvOWf+7PPhRVKISnLNxcAue8DwTIeg2a?=
 =?us-ascii?Q?rFGUkAcGiLHZLWG9wIKrZNfMhbkzSIB++5PW0c5P9oNeDsHerRotKSbg/so8?=
 =?us-ascii?Q?9RyG4lmi0ch70MMz4X8BD1MkWKwxBU/80nTR4bhZKVxvXRDDSW6QFaK3tOQu?=
 =?us-ascii?Q?4ryl9ll+WmXkGVfRkU+aZbfhfLlMC3uNVZwj+Xk2Xz01U3ERBeLanAgHec66?=
 =?us-ascii?Q?7xoXpXh6VZcsaV2/9H+y0hX7Ht60G+5RzNuetfTiBUcGB0ZX2CzQPLIkT7pj?=
 =?us-ascii?Q?rCkTh/NljxP4LrM1pWvli8AThnXa6uzmIv/EtZS9e28VSeYj3N864K7YtxH+?=
 =?us-ascii?Q?wrpIGt0rWLTao8jMSHguj6Xrt075uyobO8syrBmbZW2t25EpbQkyDpULlz31?=
 =?us-ascii?Q?6Lsp1ZOV4fQa8sOLwGBjFPnvNfUkFsHxVvmPbmHsqBfIKm9f1h7ISd9pr9Vu?=
 =?us-ascii?Q?X7jcXPDVUdqoXVi0iArue2BV6TeOdeujrFe?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:wzGHo+nwy1gvqzNkCTe+ZLLF0jVXftd3QyQHaI0W/CHShRhttNJFvCGaIzkszo+3NqWVd8pmwXp0IDkOKKVmux4Mbh/Z60ycffOFoUbGQWPMEFDW+BMz8mUtuxACKfUmh8406BxRC/W2i7Lepb5vMqgFx0mZC10SXkZe/di33pUTukYzHCUxq0dMT6BzOEjVy9/bgZ0AFNUlC3j4wgnKHIxLticrE8NXcMXLwppppeCCytZpy64rkFEJgqte8D+OXbcyIFRvvIczV4qNdAtyJUi+Q0GdEn5x9moyeMzythGwTNY9TBWXP82W/+3f8HWpqEnybdMeT3twINm2+J4epsGVWrNfkqtoXVWD53/ZliQ=;5:uRZw76Y6EYtjmjsCpXgww+O7F7fW5n9EmwEqHP7hvdqX3AVprO4G2b/BZ03w1UUZiyzNhrUGENCLDl6sAofgcDd96+dJDnHSn9H5JiNhVJRErhly2QtyAPSGXax7S7DHEYaXGuxHodoy3Or+CKKSfYI+G8hf0rTzKg3Q8VpKNmY=;24:kHSAwWUTkLLWP/vUnZDPJjNAiE00PZ9CatMGCLbzsv6ZY4JIgFxP6RbSZrp4ONe1iA24zRaGcbs3e7YI8wqADXaHLML3VjbgeQhqV7AyGVk=;7:D5db1nvV7nckbtmTxiqD+1CQoAH0l4ba3lSZxDnq8/6dkwWUIrMHS43TUJhiloVliLFd+xpJd7+5PUe2jp3ZptRwMMo5QCOSVx2bgQ/7sNm76YGa0aeJ3Kvox2JTEUWA6YmB0SXHk23Y0lm6FRcqSZFSBI2+uhYFom3H21sx4/BjjjSBfh7kqjEGlZKxOrfI+t6XZ6I2b8B3JdIS3+l9a/cmrgvVS9AW6CGIjgPovcwtRSYr6tc0xfy07Ga2W3Tr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:30.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f51fc90-c44a-426d-ceb6-08d52189c637
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Carlos Munoz <cmunoz@cavium.com>

Add a global resource manager to manage tagged pointers within
bootmem allocated memory. This is used by various functional
blocks in the Octeon core like the FPA, Ethernet nexus, etc.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Makefile       |   3 +-
 arch/mips/cavium-octeon/resource-mgr.c | 362 +++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h  |  18 ++
 3 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 7c02e542959a..0a299ab8719f 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -9,7 +9,8 @@
 # Copyright (C) 2005-2009 Cavium Networks
 #
 
-obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o \
+	 resource-mgr.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
new file mode 100644
index 000000000000..d31b72d56c31
--- /dev/null
+++ b/arch/mips/cavium-octeon/resource-mgr.c
@@ -0,0 +1,362 @@
+/*
+ * Resource manager for Octeon.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2017 Cavium, Inc.
+ */
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootmem.h>
+
+#define RESOURCE_MGR_BLOCK_NAME		"cvmx-global-resources"
+#define MAX_RESOURCES			128
+#define INST_AVAILABLE			-88
+#define OWNER				0xbadc0de
+
+struct global_resource_entry {
+	struct global_resource_tag tag;
+	u64 phys_addr;
+	u64 size;
+};
+
+struct global_resources {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u32 rlock;
+	u32 pad;
+#else
+	u32 pad;
+	u32 rlock;
+#endif
+	u64 entry_cnt;
+	struct global_resource_entry resource_entry[];
+};
+
+static struct global_resources *res_mgr_info;
+
+
+static void res_mgr_lock(void)
+{
+	unsigned int tmp;
+	u64 lock = (u64)&res_mgr_info->rlock;
+
+	__asm__ __volatile__(
+		".set noreorder\n"
+		"1: ll   %[tmp], 0(%[addr])\n"
+		"   bnez %[tmp], 1b\n"
+		"   li   %[tmp], 1\n"
+		"   sc   %[tmp], 0(%[addr])\n"
+		"   beqz %[tmp], 1b\n"
+		"   nop\n"
+		".set reorder\n" :
+		[tmp] "=&r"(tmp) :
+		[addr] "r"(lock) :
+		"memory");
+}
+
+static void res_mgr_unlock(void)
+{
+	u64 lock = (u64)&res_mgr_info->rlock;
+
+	/* Wait until all resource operations finish before unlocking. */
+	mb();
+	__asm__ __volatile__(
+		"sw $0, 0(%[addr])\n" : :
+		[addr] "r"(lock) :
+		"memory");
+
+	/* Force a write buffer flush. */
+	mb();
+}
+
+static int res_mgr_find_resource(struct global_resource_tag tag)
+{
+	struct global_resource_entry *res_entry;
+	int i;
+
+	for (i = 0; i < res_mgr_info->entry_cnt; i++) {
+		res_entry = &res_mgr_info->resource_entry[i];
+		if (res_entry->tag.lo == tag.lo && res_entry->tag.hi == tag.hi)
+			return i;
+	}
+	return -1;
+}
+
+/**
+ * res_mgr_create_resource - Create a resource.
+ * @tag: Identifies the resource.
+ * @inst_cnt: Number of resource instances to create.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns <0 for error codes.
+ */
+int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt)
+{
+	struct global_resource_entry *res_entry;
+	u64 size;
+	u64 *res_addr;
+	int res_index, i, rc = 0;
+
+	res_mgr_lock();
+
+	/* Make sure resource doesn't already exist. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index >= 0) {
+		rc = -1;
+		goto err;
+	}
+
+	if (res_mgr_info->entry_cnt >= MAX_RESOURCES) {
+		pr_err("Resource max limit reached, not created\n");
+		rc = -1;
+		goto err;
+	}
+
+	/*
+	 * Each instance is kept in an array of u64s. The first array element
+	 * holds the number of allocated instances.
+	 */
+	size = sizeof(u64) * (inst_cnt + 1);
+	res_addr = cvmx_bootmem_alloc_range(size, CVMX_CACHE_LINE_SIZE, 0, 0);
+	if (!res_addr) {
+		pr_err("Failed to allocate resource. not created\n");
+		rc = -1;
+		goto err;
+	}
+
+	/* Initialize the newly created resource. */
+	*res_addr = inst_cnt;
+	for (i = 1; i < inst_cnt + 1; i++)
+		*(res_addr + i) = INST_AVAILABLE;
+
+	res_index = res_mgr_info->entry_cnt;
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_entry->tag.lo = tag.lo;
+	res_entry->tag.hi = tag.hi;
+	res_entry->phys_addr = virt_to_phys(res_addr);
+	res_entry->size = size;
+	res_mgr_info->entry_cnt++;
+
+err:
+	res_mgr_unlock();
+
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_create_resource);
+
+/**
+ * res_mgr_alloc_range - Allocate a range of resource instances.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested start of instance range to allocate.
+ *	      Range instances are guaranteed to be sequential
+ *	      (-1 for don't care).
+ * @req_cnt: Number of instances to allocate.
+ * @use_last_avail: Set to request the last available instance.
+ * @inst: Updated with the allocated instances.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns <0 for error codes.
+ */
+int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
+			int req_cnt, bool use_last_avail, int *inst)
+{
+	struct global_resource_entry *res_entry;
+	int res_index;
+	u64 *res_addr;
+	u64 inst_cnt;
+	int alloc_cnt, i, rc = -1;
+
+	/* Start with no instances allocated. */
+	for (i = 0; i < req_cnt; i++)
+		inst[i] = INST_AVAILABLE;
+
+	res_mgr_lock();
+
+	/* Find the resource. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index < 0) {
+		pr_err("Resource not found, can't allocate instance\n");
+		goto err;
+	}
+
+	/* Get resource data. */
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_addr = phys_to_virt(res_entry->phys_addr);
+	inst_cnt = *res_addr;
+
+	/* Allocate the requested instances. */
+	if (req_inst >= 0) {
+		/* Specific instance range requested. */
+		if (req_inst + req_cnt >= inst_cnt) {
+			pr_err("Requested instance out of range\n");
+			goto err;
+		}
+
+		for (i = 0; i < req_cnt; i++) {
+			if (*(res_addr + req_inst + 1 + i) == INST_AVAILABLE)
+				inst[i] = req_inst + i;
+			else {
+				inst[0] = INST_AVAILABLE;
+				break;
+			}
+		}
+	} else if (use_last_avail) {
+		/* Last available instance requested. */
+		alloc_cnt = 0;
+		for (i = inst_cnt; i > 0; i--) {
+			if (*(res_addr + i) == INST_AVAILABLE) {
+				/*
+				 * Instance off by 1 (first element holds the
+				 * count).
+				 */
+				inst[alloc_cnt] = i - 1;
+
+				alloc_cnt++;
+				if (alloc_cnt == req_cnt)
+					break;
+			}
+		}
+
+		if (i == 0)
+			inst[0] = INST_AVAILABLE;
+	} else {
+		/* Next available instance requested. */
+		alloc_cnt = 0;
+		for (i = 1; i <= inst_cnt; i++) {
+			if (*(res_addr + i) == INST_AVAILABLE) {
+				/*
+				 * Instance off by 1 (first element holds the
+				 * count).
+				 */
+				inst[alloc_cnt] = i - 1;
+
+				alloc_cnt++;
+				if (alloc_cnt == req_cnt)
+					break;
+			}
+		}
+
+		if (i > inst_cnt)
+			inst[0] = INST_AVAILABLE;
+	}
+
+	if (inst[0] != INST_AVAILABLE) {
+		for (i = 0; i < req_cnt; i++)
+			*(res_addr + inst[i] + 1) = OWNER;
+		rc = 0;
+	}
+
+err:
+	res_mgr_unlock();
+
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_alloc_range);
+
+/**
+ * res_mgr_alloc - Allocate a resource instance.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to allocate (-1 for don't care).
+ * @use_last_avail: Set to request the last available instance.
+ *
+ * Returns: Allocated resource instance if successful.
+ * Returns <0 for error codes.
+ */
+int res_mgr_alloc(struct global_resource_tag tag, int req_inst, bool use_last_avail)
+{
+	int inst, rc;
+
+	rc = res_mgr_alloc_range(tag, req_inst, 1, use_last_avail, &inst);
+	if (!rc)
+		return inst;
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_alloc);
+
+/**
+ * res_mgr_free_range - Free a resource instance range.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to free.
+ * @req_cnt: Number of instances to free.
+ */
+void res_mgr_free_range(struct global_resource_tag tag, const int *inst, int req_cnt)
+{
+	struct global_resource_entry *res_entry;
+	int res_index, i;
+	u64 *res_addr;
+
+	res_mgr_lock();
+
+	/* Find the resource. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index < 0) {
+		pr_err("Resource not found, can't free instance\n");
+		goto err;
+	}
+
+	/* Get the resource data. */
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_addr = phys_to_virt(res_entry->phys_addr);
+
+	/* Free the resource instances. */
+	for (i = 0; i < req_cnt; i++) {
+		/* Instance off by 1 (first element holds the count). */
+		*(res_addr + inst[i] + 1) = INST_AVAILABLE;
+	}
+
+err:
+	res_mgr_unlock();
+}
+EXPORT_SYMBOL(res_mgr_free_range);
+
+/**
+ * res_mgr_free - Free a resource instance.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to free.
+ */
+void res_mgr_free(struct global_resource_tag tag, int inst)
+{
+	res_mgr_free_range(tag, &inst, 1);
+}
+EXPORT_SYMBOL(res_mgr_free);
+
+static int __init res_mgr_init(void)
+{
+	struct cvmx_bootmem_named_block_desc *block;
+	int block_size;
+	u64 addr;
+
+	cvmx_bootmem_lock();
+
+	/* Search for the resource manager data in boot memory. */
+	block = cvmx_bootmem_phy_named_block_find(RESOURCE_MGR_BLOCK_NAME, CVMX_BOOTMEM_FLAG_NO_LOCKING);
+	if (block) {
+		/* Found. */
+		res_mgr_info = phys_to_virt(block->base_addr);
+	} else {
+		/* Create it. */
+		block_size = sizeof(struct global_resources) +
+			sizeof(struct global_resource_entry) * MAX_RESOURCES;
+		addr = cvmx_bootmem_phy_named_block_alloc(block_size, 0, 0,
+				CVMX_CACHE_LINE_SIZE, RESOURCE_MGR_BLOCK_NAME,
+				CVMX_BOOTMEM_FLAG_NO_LOCKING);
+		if (!addr) {
+			pr_err("Failed to allocate name block %s\n",
+			       RESOURCE_MGR_BLOCK_NAME);
+		} else {
+			res_mgr_info = phys_to_virt(addr);
+			memset(res_mgr_info, 0, block_size);
+		}
+	}
+
+	cvmx_bootmem_unlock();
+
+	return 0;
+}
+device_initcall(res_mgr_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cavium, Inc. Octeon resource manager");
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 92a17d67c1fa..0411efdb465c 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -346,6 +346,24 @@ void octeon_mult_restore3_end(void);
 void octeon_mult_restore2(void);
 void octeon_mult_restore2_end(void);
 
+/*
+ * This definition must be kept in sync with the one in
+ * cvmx-global-resources.c
+ */
+struct global_resource_tag {
+	uint64_t lo;
+	uint64_t hi;
+};
+
+void res_mgr_free(struct global_resource_tag tag, int inst);
+void res_mgr_free_range(struct global_resource_tag tag, const int *inst,
+			int req_cnt);
+int res_mgr_alloc(struct global_resource_tag tag, int req_inst,
+		  bool use_last_avail);
+int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
+			int req_cnt, bool use_last_avail, int *inst);
+int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt);
+
 /**
  * Read a 32bit value from the Octeon NPI register space
  *
-- 
2.13.6
