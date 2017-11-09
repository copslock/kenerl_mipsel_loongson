Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:31:05 +0100 (CET)
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:34944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbdKIT3tkAgBL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:29:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O2PFWuRe0Se8plBHKHSQVZzWVzK8wt6Ww/nAAZKTrG8=;
 b=edWIRlvUXpt8XT3VVYgFBnoLm3o+0POEWhKYn/18MW9m3ihGcPmX8+/7eL/JNarllDvwzuHBrIyhj/ogaFzQnRPLyG1+kosTEWh7xF3o8MpKqy4pPWPHqmck3qRzI7d0VYXhRyi5gh6p+cR9S+YExO7i1WNCWk0cvF34FXVPBEY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:37 +0000
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
Subject: [PATCH v3 3/8] MIPS: Octeon: Add a global resource manager.
Date:   Thu,  9 Nov 2017 11:29:10 -0800
Message-Id: <20171109192915.11912-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1d9ebd-41cf-4861-5898-08d527a83add
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:/sBMTnIxIdItOBn13Uci+wAMX7VPuMB7ed29IIzJJrj8wX1vENSk7uDlIX1wtxLHkBfsOp0xrsleF+Ipk2wcmjDLhv/XfEmguRrn1nReDenEpBrornvvSlSe/9mApl4x2MQIGYh2VIxW+3Pzc76tnZ5tbaE3nYXUyk0EhQ6wT8ec/V/TMUk0MLcMTh6HF9YpFFqh5WYBKeC2WpS8BKZiBVV8GK/pnQxqcr5DHDnrC/+9iSnEH8qfg2U8y4KmWhdV;25:TpoXDuhk35FP6TMxTy9K7xWtMJcLbJpleoxegzIb39UfT1J61b7rweBcf//4PTgQVUWtIm+miY+oxIXRhel58swtJ/Jg6SRogQ9XK/NPfPWj7i5V9VNFZS2Pi6wh6JhIua9ytC8gFl+a2ho8GJJo/00gyyEX4p65faKJFNdJVUyjP54MIt/7vY9spt1+UbkXcobRGHfb7sbyvOp4+yyF6V74f7x4E9WoonkDN+hUxwsG+LYIxk5/I35cAh1NdYW4b2VGvx9w0u8bT1viNJbW5rWnBesQvUphhcijN6MMk8oENI4sJSSVAcDXGoLNSf0EceAVT/PlD1P8572t3Jjv+g==;31:MKdHbeUVYtq60cfRwPDQZuxK9ULC9IRE30f678py3Qc1euaaTb5QlHMeC2Wd/D6Tvffj/CyLdY1qDpeYISJOHGHOXb9omRzPD55LnBGWKM8IBSbU/UassR3wAUnrD5fJehcdKaHFCnZ4C/mudi5mNmzGNvrbi132NNo3IB5HDuR8PJ8PAwpIJaDEldxtbkp9sZUck6bVME1AQo/zQe5yv57CwOHxJxEBLb7Sj9zPyJ8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:1OTxyXBREjkvZqXh4CZCgUu0W/B9KCLJrjh2WaxnUoVUaQLihMaLOoXB6SMfavGEDY0mnjUdvP8WSz5VsyGRu9Xu4npGpYMcybGjw0qIlGJ2AQYUKjmCXOaqXkaN1/tsPhwV2AecW9UGBqBRW7vFqtdStREOv8ovVpCLsCTMpBw43hFIAd7bFBcRHoTfZDfFF5rcAaFiGM6fI8edQcRLNv5Z2O5zSAMbZCLNPeq3w9itWEMKpIdk5ye5ViulxORp1sDN+VWwOZja9AWvQXz3Qk4UBR8RSKT6gSU0G3ezZCzJq/i63S3oLHB/7A1VfwG5uYSqI44VBf6I4jkwhFhqyeYem1eGjXaSBRiaRecpH9+ze33L9NsrjhKTjL/Ge7sT75vBj2RJopTiPd7HJi4klbohoVgiGfUlblOeTOPX5XlMNdjmgIawOKW6ULjVxmPTgsyAlXViobjwVk5BUrs7KowH4nE5pJ7YpSbm8oqxa27vEMHHluxtBIJgj2xGmkMh;4://sJyest4VkvMmpqCouMmtNrqRfRuoyQZChHBRpskyq63NGgXAQGjdivgy3Twn+8GUgVW13ZjnpIEDLaJHsXDF8ezAE44Rgwh3iCQSV7rZNUF5nPMBP3s220r9fHrBHou5njWBuSW3X0/GWRgfT6oJCjNegSoIjDPC+EWo3sv7g7uIKBOP2veF06EkHskrYe4yeI/5KYN+jSdqDIXplxKNtcxCA+fW+slfXa8wKEw2oKN+lQ8YRQzCwcYgM0Z7gI3wlDxusIekoXdS4hIonZ8w==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34964DA554C85C8BDE4BCABE97570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(575784001)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:AOQDPaqPgAC4ydIPs31xC5icAjrTppZvOhfCscHLl?=
 =?us-ascii?Q?2k/MGm3HnME5CU8X5uXkwVDhjFUX5+iuhBv00G+G6CdSpjt+FfCyqgDaf9VE?=
 =?us-ascii?Q?6gOpM4FCS0zRCS6GHPeueu+J4SpllAiPtXl33/BTBuTEYwu/8s/rmvx92SOj?=
 =?us-ascii?Q?KupIdqyfN9vAVQmaJ4pbJBNOb1BBOh48nkIk8Q/rctsu3KlHiYfxgibV3QFe?=
 =?us-ascii?Q?CGQs2Mb0jXSS3I/MizyAC19MlpxTgT5JeKjwf37U73ociJ1a3SjxSGM+icim?=
 =?us-ascii?Q?nNzGHKqQXbxRM84TbJaplzfLwQIIfaingJjLJf5vd7StiPeMn/BCQnyX/4kp?=
 =?us-ascii?Q?NRil2SxsCt8nFGalpgNJLMO/vkNLoMYhdE9ytDqirUNkcCb1gP/pZttDfLnx?=
 =?us-ascii?Q?G+prXTYcRi1xqs85j7oqOTlPmVZvh/fZskrVfGgmk1/mHjsBabQ7ACN9jT94?=
 =?us-ascii?Q?LvX/Mjg5vZRyANYGoE1WojhGHT5Jci/O8b9+dmepjZmARqD5IFNSQDFKKdoN?=
 =?us-ascii?Q?sG0GP5lqFHE2PMDs6a2ZO9Pat695X6m2yQD4GkyUsKt0F5wmA2kWJWICs9BA?=
 =?us-ascii?Q?fdvJYGEc+FNSzB+UypbviJYuoauyzldah6E0ZpRNa7ne284Nac1AFb83ZnX4?=
 =?us-ascii?Q?/8BzvrOZxM+19QAKGtSpKmR98EQ3w8eowqTyUK3wOrt1QNXO6+B+/j2uEMT+?=
 =?us-ascii?Q?TVUdnxk7xj4swnZnM65Qc3zKCivwxx2+4eQyBbXuIg6gno45/i8gYdLafsAb?=
 =?us-ascii?Q?T2Kd0YXAFdy9wSHSqcJNauqt/GO+PVVZTx5O4vpjk0gvjO7NGDjwWQ6ggaPc?=
 =?us-ascii?Q?TYhHa3ewB61PsqPx5XPPT8c7vYUWLhETEWp4ptL76A5Z44JH6aV6rQpGIh9r?=
 =?us-ascii?Q?o5EMU3mreXE/x9flZ2pd3VuAKOZMWqp/W7FXwaZfWUZEszlKuihVC5ZtAsJ9?=
 =?us-ascii?Q?RAfEgaBtXF1aUzRQkjdDigIpsm+SDYLCCWxQDZGaNSWZkIhzRLzBmosQ5S5T?=
 =?us-ascii?Q?AvsGMvAfKXVkuq3WasrTdr1oEYK2o3W7xPen2raAci77c8q73UHi2nnuw1J+?=
 =?us-ascii?Q?Utid4EQxcTeBog/803JaXPp3QCT0ihxxgdaMfMcDIIZ/7Ld0hcG5WPZxc5WM?=
 =?us-ascii?Q?YPKCVXdy+hzdEYHoBm2KgGqWZPQLWVqr5pUH1tZCJrjTqRCXT2Xvy69M6jGi?=
 =?us-ascii?Q?to4xpOR0sJJNhHbAoPa0dZEZjRIfxo7mKgTgy2AvfPD9mKTcFTNCt2nkM2Xm?=
 =?us-ascii?Q?0JLio3H5VeDJgbOxh/EHJh1FBVR5mJ3rbeFHtO2?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:YdpFU+rnt9tSkEGZlf7xQ1Zqu/wAgumK2Uf+/pY4mV4RkZtr+IBhL7IpGEmTTitF2Z88It7bnXWBcGb3k5ldmJSswk7QJcTv2ZqnuKlxkWCJqe3+dZMHsx8s5AmuQKDBKkUM54ubW3C3b5zceeUFIa1wKi/P8uVH2bvyPlTEGJjceAeZwHczQFLTtEsVp/xaR96rOs/OISsVIS8H5M7U0yn4HpoZ/fOyDVlVEDwEPHZPjYQD/iUSGUlUPuyQulLI4TSPhIJ3cqEDjWpJkpxppH5bLG7K5HGvdAudqbpi6oxBMlimZ/WnhlwwPo/ooFMfD5uOc7Sus/qi0stm3fe58a57GyAZkxPxD8F7CO53Ox0=;5:DqPea6QAVayx7LYtuGaErVwVs2GZO+AbGpKq+ksshOOp9BnylS3sH4GonvN3qddG/hvBuNJWhJDYQy4esMMuK14UyOp5BNewKMXDLa5OPfn/20lZWfRhAKSqP+Wyh8o0jthAZtf3bzEVsPmvsJOQeWqMExuzZ6RbOZo8JH7w3G4=;24:QwQRtayccnMtOELhAD1paMlIETlkhK51UpNmh/lyO+/Y9oJ5d0aWJClNhkCN0PpYK0e7nAIuIe1hxwSoXn4VGQM4UfoGPPDnhv2RW5YLK2w=;7:VPe/vK4slCNJp95F/c48q6Zw0wucFgKHSZkOstkRQkafBWQ2aS/kT3HVWFIOW8PBgMTP5Az2DUkaDDHMlWSXSv4FxAhGoouiDMU/iZ22IkpLZ4Vwyqd4RH9ReHY/Wu/t9EYUoG26S016e9qSE8QHuqFmNpx0dHkCMWFMDGEKMQ20uWtZ3HJ3IxNJQD1jVzFSVyEgBuMwcZofymQiDp+qpLagZSEGW/peOW7C/gdx3qCSb03gcEqITgONfQsrCvle
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:37.9303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1d9ebd-41cf-4861-5898-08d527a83add
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60818
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
