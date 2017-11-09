Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:53:12 +0100 (CET)
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:53732
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990490AbdKIAwDeAFDQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O2PFWuRe0Se8plBHKHSQVZzWVzK8wt6Ww/nAAZKTrG8=;
 b=A9HVOQXTMFzNV8LOtB25Zo3NygM7vhKAI+UJ6GW24A9ZspgLbHJmpHK7Xk0mj4wb7voPmBr6xXXW6LvZcFyOQk6AcxnKeqZiA5raY0ZW1RBATpXJ1E/L85l8uTfpAZUSFxjTJ9NgiAoUsFkzaChW2vIV08vZatDIJjtNUJzrmw8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:51:52 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/8] MIPS: Octeon: Add a global resource manager.
Date:   Wed,  8 Nov 2017 16:51:21 -0800
Message-Id: <20171109005126.21341-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b58301a7-f852-430c-152a-08d5270c14be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:8MtmDHuhMGEdt64ZhtMmvvy9tD4gQVxa8U2dFqdirOYSq4g6oUSLgQ9XkdL3TAajjCUmmoc61mWZ52oUmZ1BI63HYWxZl+Q2UNr4veo92MHUekiugMFs3xLv4aCLEc1e638K2SdkKINWvRMvRx3EF6v1Cso8TXUOqxGENmjbVF5dHFh54LoxPQAGBhJ8vBNp/3Dh6fA7hMMrEw3tU3AUolYsbYg+T36G3J99rs1UkLHTUcE1dYd8RhNPakZTzJeI;25:4D9k7ufWrYMHmUCO35DJMtNyFMtRG8kIef+gYk7MPk0nnSxy6g1jtU8LW3jfhTFIkkTSy5/lKh2jXPAwxhQF+tvV1xYUZGCn/yosN8YmaUVClBEEq/Y3vfFJkgrQQ5rtUQLxbSOqhn19WCEM9melehcLFAf2wEs1YpsAAwuzCgTfstPQA6djiroEf7siiLEXtOUWhwsaf2JNTYdmRwUw+APM6GvixuwI1empSRA8EthyCWHMi+dDmxkx5WR6BuHhYk4AdjBEg3D6JiSOGOsY+gxn7Q2+8BzI5bHA6sw2wqsNQro/nE/MYDtNZr5VjkGOBspGEd4CnwXNUfl0KiFGDA==;31:IgEJOSSgUequaCHOWI6hUyQR8mZ8QKqLeFKoDsBQl0l0rVqAVMzJ4oL4qCMj9b0apjdlr9nwxSc8GGhtBRfEruAVASklR15dIq3CxwF5qgAmFVDiIHnvxbXJiFFKm64Y4+ZR+vfV6w7wq1itCPFUh+HnQQuDDBSFyP+pZtmfJdiZainfbcrYUmn6tLDM4qsxDWBeCoW015uGGy8rVo8kjJeIcFEMvzgf0+24iKoQC8U=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:bf4DOw3ZS6w9X7RzS+sDTT/coPCvlRR1r+/Zyqun2pYJGgScLZEgqS6Yb94sOe6Q4jjTdEZAdvKquRsg4ENs8Hit9ezUf03TQhZPhuAfeKoF0jVYM51y6RolEIQDH9MIDAFxZJpwHPjY2/00HJjRGoKWwYN8HMbqVB2p2USgbyoncxeWdh0rpIQE4t4Jn3pvGyT3HwfLA077Yr8YVxxNAK7xfWLYpDQi4g1QmE1LGm51UBzIkL2T1w9X44LJ/R0qFTrydPArvPCkSTlVOlYHlq7O2Ob+zRGB+Jf8JSYdsFzfMhNktnY4QTVv+Z8YMFO+cEKCNluAqGhf/t7TAY6/wn0diifBQsGPzquklmSbsqIoArJzHiZqp+vkVExpcBo4WFGJGfEW3VFActtH76mm3ViN6CxKU17kJdi63EpWOkkYJ+sqNZk+4x4DdrSdlkzi17IqK4RUe1VB6gcLU4IxA3ASXKHXFKcR8oFE5tmG4JJYrBetwh6P7VVdFX7y/ErJ;4:16yq8GByrODDr9wi9qs8R9YV1S2Se5plHJXCI2kgFdMIf+AcEore6Rd8lWn6D/MU27lytFRtM3QU6UFEzpUeWg2QfyAZ5ScP7pH7agt3lbm4yT4lhYFjC2aTq+HFtCdws92aFubX9wHczNCY2CCfBj96x/40XivfN/bussxYhi2vfP68UboCaJvIYpLTcHIHDvEuMDAEthlkXU4mY0wZssxwNGiGj2ZgGfE1OF5O3nBK/zTV18S/G7JwFhC4BT4VmL2ypqhApqJPvsvZr0/UYQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34954608BB26B3A768B03A7E97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:NJb6DbdQC/StfvTvpAZlnyCfx40pABQJ25O8jiFn9?=
 =?us-ascii?Q?hLQhCGb8nEPgJUqAqoj5BOBAqciUlSRdFeP6FVd/k/Izd+yoi8P80vGP9rM7?=
 =?us-ascii?Q?DmM6c2VKv8ZgBZz8ClNTn5i7CgCvQv1tHsB0CzmbGTN6mSHLGSVaKzJoc7Vj?=
 =?us-ascii?Q?TZIhKQeJfCWsZhh7ln+fRC9hmoGHbB87Ueb3HOjjELTKCnGeubzb4ilt1WqG?=
 =?us-ascii?Q?jz+KR79vSzRBoHdmXBeebBFTw6UR4dzZ9UEqyRvWsLXnlbbDCBU6M4tJKKkF?=
 =?us-ascii?Q?f8zBcML8MiJfllZMNA7WoxibqnO7hvaJuaZUfTn1P5GkhmAuCMG5elbvMfnN?=
 =?us-ascii?Q?7ytnA2YfQooCnW/xFDs6weQ8kjhh6q2nJfl0bGt1axE3W7uqMhFXCgU2HrN+?=
 =?us-ascii?Q?jOtKpm2ZyZIAMUUnxt4JjIPArveLOrpISVdiQOvDp3Ijtjpe/bE49DEfHzRx?=
 =?us-ascii?Q?w3duPwDiGeobpBoxINLhI5bJfi0pKs5fr5+A3JMp9YwPlG/dB9Wjdioiogyu?=
 =?us-ascii?Q?V4TI5P6RhLn7Cds3TqUq6eo/PlwYjzAGw2DCRfF1GuukTe9Tq8gjFtrfJr99?=
 =?us-ascii?Q?tUMGxw8WSYhW2TRK9TRPupsQWjvLuhbACkbjRuJmZFNmAZuqjYnyUMWLkRPs?=
 =?us-ascii?Q?Wo3vTsZMxszEpi5fcMFrTk8DD5HSInjzMSrJ9Wd7EIaqWD5gVU5+vzpHokvt?=
 =?us-ascii?Q?TbWcUiZO6wJDJIuWvNCjKGRKlej7YDko7MiYY0JqWYZp7SqbT8sSnoLvmM7q?=
 =?us-ascii?Q?f+JlQa6coHc/8qk1AjWTCpPsn62NU3dEC5L93BdJRpXVev1VxTTDNP6OQnke?=
 =?us-ascii?Q?9fFkqUs0B6q9K/CpI06mmLHZ7xy2kCztRPjpZF3z19GDKOZXL+FgOVq0gXx8?=
 =?us-ascii?Q?DpIdTR6TDhVcZvesIF22fG3yiIpDvwd11f7uxp7WL85bucaaofSX2pbZ9P5x?=
 =?us-ascii?Q?CvQ83SYbxxIGrkTF+6KN3I8aKHuEJhwXQ65Ib7LXWKUHF//nNXQWqVLNwPZn?=
 =?us-ascii?Q?6WR9+sIXnnY4rJinxaneDo+tgpTbvRL6et0bP6ufBhl5PAXl6lsbu2wng3tZ?=
 =?us-ascii?Q?x8igRhpUcPYXmG/7GIcIc9AO76IA8vI3sozKBxCcUrxSvYXLOS/0j9NjZO6s?=
 =?us-ascii?Q?h81nq1yH/PB3GznS3lyRfuNTg+rzdqZcrYPSnzRGN983udlSD5lKtZFzVynB?=
 =?us-ascii?Q?lfkY+ZJ5+oz1EkGduGX/TSkjfwLc+PFQ48ALUegdZX9uEFVFASExHNlX8E5u?=
 =?us-ascii?Q?Ndu10Bv4tBOMiuHD9lbde2HA4fVVVXQjqTMhz4s?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:4gK++GAeYC8Ry2RZGHsuEZE5ZYcBhYNsNbq27L2vNGq4eMngQBpZ8Jy40G+mkcbd254s1YSAHR4omfuDWxiOVx9MhPr9hD5CKiKPaiob8/zOApo5fjrbLq5w8k5iR3wD4g9u6cWV7uBHBMIHWT/y9AtZIdosFg7SnGMNMPj2GY1uDXo/177iUljP9K+8Cg2sJ8qR5UKCgnSaflQWCPRKyUy4iyo4gbYr32BZ7tWC2COiIs1RqLy1pF7zIQSwlIFBTj8mi3HF6zQRmJe4bHYFnCdoj9/I5camBx/slNvyXJkyATLcePBzS2d/RZRe2vnxSJTG+AkwqKP1rLoOvrgu+K106gf9IBXA4yZF2kznDk0=;5:0Iv9ranNto4leHE2RrZkR45E2dcysmXKPROf+SEwLYv0+Ieqatl5l9EfBvFDP+pLpdMmt/D6KcefzvGYknRSf67o3O9rZKpNU+ED7fOiWECqcfiPyIr3yl+4PKN6uIb4yG3vfmp+Z28+Qs9bbVfJcetYB9CiyUmM28A8qwrXJus=;24:RLtuiuvFEOTIpZapWIcIXSAhIiKpyQx/6mqOeysFyuIw9eeVoR/HoPp2eVjJ31R2e7TSR4TUSJ2P1hkzEWu5u7C46en83V3XWzS9c60xj2w=;7:5uZwI0bNkjuxs5F7yCpqoqeSeeqjYU+rMmqJC/UnljDTWaAqSDo7MlJs0gBMTDxAV/ayC1O2dzF/xiqaAsP2yFVgr9b6aJcDXV8d+IQA7ScB6kbhlaO1uTvJKWgdTpG8hEP+PNUkVaGJ90W70j/9GENOmDLp2AR9km8/qLaTuhF0e0Ht6IW7PgXtUpGrslnUGei2MnHILw8CADyOiQJSjtOtBgu+WWlJSXsw/dqyNUR4rC7u73rzsZZfxSFBf+vC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:51:52.1058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58301a7-f852-430c-152a-08d5270c14be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60786
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
 arch/mips/cavium-octeon/resource-mgr.c | 371 +++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h  |  18 ++
 3 files changed, 391 insertions(+), 1 deletion(-)
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
index 000000000000..ca25fa953402
--- /dev/null
+++ b/arch/mips/cavium-octeon/resource-mgr.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
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
+/*
+ * The resource manager interacts with software running outside of the
+ * Linux kernel, which necessitates locking to maintain data structure
+ * consistency.  These custom locking functions implement the locking
+ * protocol, and cannot be replaced by kernel locking functions that
+ * may use different in-memory structures.
+ */
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
