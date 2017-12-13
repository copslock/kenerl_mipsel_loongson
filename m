Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:50:55 +0100 (CET)
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:11024
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994630AbdLMAtUSmLsl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 01:49:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ToX0XFkodJPEskvjYmH/sfsiaWp675ikHiLFNxjahCE=;
 b=lmvTdzLVy5FHPhANMDewgs6oPyLdW1x+kWS+fuycdNvR9uDAHY4Z/V7ObrcbqO8nrtX9HbMcMHsXTXyWb7Gqqm88Ya7F3FJ44TtrUkqbmLxWbK1FHXfVoemrK3Oe9wWUvv4B0O9ihipcbvYbDS2Rn0yooID+InBxhthF8l/iWpw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Wed, 13 Dec 2017 00:49:07 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v7 4/4] MIPS: Octeon: Add a global resource manager.
Date:   Tue, 12 Dec 2017 16:48:48 -0800
Message-Id: <20171213004848.15086-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171213004848.15086-1-david.daney@cavium.com>
References: <20171213004848.15086-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4bc92d3-f558-40df-d577-08d541c35418
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:TS5cjHU7oz3It+bByYJoJXvpiTmGV9nGkIcWldvVHvzMU0InwcxMd6FqBVOgHiRExGaT3Zlmvi6ibW2ViC71vqk5wwhjkmepHDdkLj0a1yXP+J5HGGnn12rYh6qlVvArf4IjjCuvxwVGUz18u/vbTfLW+jjvmBN3giN0ScLT05IpqBr21RWUqBtPL6T+K+Jyi2WVZczSx9IU7EX3Ehc9KIU7OblvbMAQ+w1IdQpy03gK3Kwi8qngmcopyt2zjiE4;25:+enXZZjuj9S2cfnhtgw+I8woNGRs9DpYuKYMxWOgcaIoVYHKVQbcArf+u/D0MDA83snyJWV6cv+RXE6sSVONkW+E8eOcl9ap2nN+As9Nde9JapHVpinXB8dHa4JbasXnSPuNodKUM3VxfSHTRoTmdFeRsVbXnnGJv0h8X2xjyERtFASGbqYNNcJz3Qoh1Kl4NcxuvOzbKamzEmCO0fg2OIJ7RS2kO61ZLoQvRn5oL3z3pKfzyyVYHfYKoghZBJGX36Un4ta2xFQyOpyDD9dQoRgtg5bqhEaLMkH1XkFwFvntYeyT0E+h61ats5gOI2MCXq7I1sdTb3MLAFuvmKeb2/0dvXn/Cp7og+n2Kjv3/Fg=;31:6NDYneT6b7X/VsR4J2pCmD3KHF8sGHpvOZkipiibVD1M39Nio7/YMxjuDg2aEc9N9R+sHQe2F57bQVVkueIdlmzn5ioZ70x/D6eaosem2FUI4b6/kSWOJ1Y6ltKNCZMwkTUQeoV/HiaOhGJfmKlpmNh5Y/LQT4m1Ys558vDYpus8vgOJgWegjrn9KiC768LnJPmQgM4I2DwgwiPDXR5dTFjWWtmy3bUpX8q9ilEoit4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:YyWxp638CD8gAOVPWggv5FXiIXCss0QZ9kS18SX7mABhULVTcvBHmrUTABYZgPJoKb60IJZ+HbAJw4ES0RqQAXAbUFT662i6rLDf21JYDqeEtJV2tfqevvs1zeRbQZHu7MHTZHkYZJMNIqktq50AOHbLqaLquVp+Mr1ucHbSBPedR1C46/JPcjnlBH4Uo0kNluzkDLWkdUVIl4KFhDURTAGNZCpgLQoSvpK5ktOyw8Kt3EZFAlFzSyilUbXmNDnwXy/odPpWOp+4W1DOXCzSaUe34ynO6lrqgQqXewJxCQHXox+c6d5b8GLjN++H3A1x/29pwqdnuJFzpTar83eB8YV0o41O9XeOUsQDIlyOZ2LIG4KOLGE5qB0QgslukCAAzeHRZYxwNjjeE+UhSxVDfJPUkJER5TfKl4Uz6IHm3CIgcO8nxSxrayV7Id2tmlckG9acYuP/HrbuMBzq3p9PSDxyPBwt9qjDguCK9ebJ+U0PdC6N5G1hTImU4hj0f17a;4:ecfx4OAOvZWIqkJz1R7Wm+4YjtIfUCHKBdNZ/qYwat1dboX/QsfXhUDgg8ZAwi+NDcZ9cXrg6xfbu0kYvwhoiVNvx/2Tx6/TcVw9tieTUFHf0kdUgrc/Bf7PhMmW9z/zQPPFf3w/GUgtp/oyJoVH7Ma07NvuYNDO1cQyiDO2fEYsrqYQ1LE1+0PBe96yBHONYwqKl9xCwYf/cCBt6vRhNbwzMsLFKmEhy9nkNEbL07hlcOEOT2Htm7KSLnXCYLXIp52+AlnkNZN2qwIwjzBrfA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495CFB790CC07F09DEA857497350@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231023)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 052017CAF1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(199004)(189003)(106356001)(52116002)(105586002)(53416004)(16526018)(6512007)(16586007)(107886003)(1076002)(4326008)(53936002)(47776003)(25786009)(6506007)(386003)(54906003)(3846002)(2906002)(6486002)(316002)(66066001)(6116002)(59450400001)(69596002)(68736007)(81166006)(5660300001)(6666003)(72206003)(2950100002)(50226002)(36756003)(305945005)(7736002)(8936002)(6916009)(51416003)(81156014)(8676002)(97736004)(76176011)(86362001)(575784001)(48376002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:1GylmxRC5TpgwiDGi6gCa56WzrEgoqRVG/YK61qUE?=
 =?us-ascii?Q?12nY+KFeFoDaxhn3MB0B6Lt7WcFmU+n8nRTqLYUwD9YZm2d+7qspQ0uhKblz?=
 =?us-ascii?Q?mKkn/d88PiUq1rRGF5szJFMOWrv9y1zNfWpdA1mMryxCBYEZlcDob/8qigML?=
 =?us-ascii?Q?RO3hET+slDIlPTeWXjvz6xs6uHXGLhM/+0Ui3FCr07LEyzB8mEmyo/jCjNo3?=
 =?us-ascii?Q?9schWYccBuMc1fBzxu+qK5n3yqRSi//zf3xoQ4rxyugn8733jLocm9Wvrs/W?=
 =?us-ascii?Q?d+1FueQmsnfrX2LpOytdB9vbb/hbAYM07G0TmUbZJvpMGadbozxigAbKMVBx?=
 =?us-ascii?Q?m/tgQ9yRwXlnGkbnY6/UyWhJoZSiAsc43QYBr60++wE3kjpPm2o5hgJrf0XH?=
 =?us-ascii?Q?3WyjLYJ9xA21p3uY3A/6p123wdl0blHWqv+zx3CikOZKR+LFdemAu1UDW7uu?=
 =?us-ascii?Q?u1tqzH+SNLxN9r7967KrTBM8c1CEttrEh9sNWq19dvCWtKQCOP/f19XJtpv0?=
 =?us-ascii?Q?zXmN7YxxnvxPprzFzyFE5nzCD2dyenyfIJhQ721dAwnUwFVBA5Tcxntf/KnN?=
 =?us-ascii?Q?2/kdMqMvpiOju3+X95rG/i1+l9/l+6uKl7P2DQnZFyb2H3hQBIByr0J0CtTN?=
 =?us-ascii?Q?aSiSKO+MJtKxYYVS5CUC9cN6+Uv3CuyN47FSCFsLA6+CxJpCosYJx+Hl6Sbk?=
 =?us-ascii?Q?dAId9QB3NQhDx9tGE6pt6w49fETonHgYwrOn7zTzbyNOWsaAtQpkxQmjncFQ?=
 =?us-ascii?Q?t2rNZiTkHA2YgYr/2j1jY9H2KXxCb9OYajwq2mUyJtRUdqvfMcY+wAVRbF2n?=
 =?us-ascii?Q?pi8bIw31EO+At6eTjsltsybSoC81sFsJeIoy1+SPEaWVe44+GkLVGqQrcjkn?=
 =?us-ascii?Q?39nEI44qBZ5qEg9IUktFQOICSom7j+SyUxRQGSiHeKmCjXszNkVE7mH4D/Z0?=
 =?us-ascii?Q?/ouJiHU2ocG871R9Hzkxms9UdqUmK5lD766C2TmwLU3DVHMJWQTLN+n3K+Fe?=
 =?us-ascii?Q?CD/z2ljreSuq624AAMMewIFCJJwmFLqXoLvwfItPQNNnGsmfDlC/tnTwB7SG?=
 =?us-ascii?Q?AmDV5lPPLuNBcPYLSlutqWzHaxgB46blPGVzFx9VsnWUmRU7kUAbGNG0f88c?=
 =?us-ascii?Q?QAacbK37CnpVVFDSkHtN1eJDPRBbBt7nBJoRw0N5PMELIvKQdS4S0fgNrf9q?=
 =?us-ascii?Q?hu9sUEMQ+/c4cA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:vbMUKJ+GgIhsbIn7gH3SK24D1lVDXB7D+ppJs9Xl+87lSsSXn+0YBKFn6KM0ybSBVhGfSy7XhvZ64Thb8sJvUGJ4RQsP3z5mpZf7bUtH18gwzuU/63v/XJvOYztBsst7d+KXaDwak8sH3Od1ZsLkOjEC4C2ZZsK+cAOr4hceZTjSclTjiUOSgzfQtuAcNwxhNEDVthwJGgdBQ4CmlU3QoLBPmLQ34kMG3SNiGDwZoTXR+C0U+M5qVNuW1uEEr9HcnDjGL2N3ARTxhOMnSg+xpfrSSDuq6YVe+LMjGWowm3Lo+vLEv1Tc8lj47f8Zb+RzMIW6IKlnBV1pdSk3THWLhn3gljpuJ2DSDnerY2DE4s8=;5:enbfFAOQXvK2S5mpJdiposRMLekvIlICQlriCV4xWur68/kBYKKmfkNxANQIZaM0sMuAPWSlJJuTLuXbeDXtk6ZaRIjNXOrp1n5YGwJbFQfxCR0KRix4iBgmmucqdgpGSGcgJcpBHp58GlpE11nIVW0NyGmeE6h0JGn77zy7XM0=;24:vScJv8moCL3Qo7e8eAB6U4W0H7snJ9gb7RBmUt6Varr5Zq0GJAe3iGUFa/lk/vkVGDJjwo84x/p2bIlmDLPlIj9V4fkaU6oj6E3BxicDnCk=;7:sgLFr9U0GMyFJvguXUkwnJ0+dAOxiX2dj07LBLT+tdwwhE+5rVoxylVm23ci0l45JB0R3zaU5l8lZuWZ42FefA4Aa5PBVj3Q+w8PbMFdh+/hBimZNpVACbg9yUQSPCDK54I5htAoeZyLpVzR9Gjo1frJiJeGpoE1gZvsLJpGQBXo7IhccvMJdrHXq+VVUALSwdyzNpME7AK6BpLkG+aGyGdrZntGSj4wbnlZE7tpVmLDfrt8MbI828cDzZlddaRI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2017 00:49:07.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bc92d3-f558-40df-d577-08d541c35418
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61461
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
 arch/mips/cavium-octeon/Makefile       |   1 +
 arch/mips/cavium-octeon/resource-mgr.c | 351 +++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h  |  18 ++
 3 files changed, 370 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 7c02e542959a..28c0bb75d1a4 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -10,6 +10,7 @@
 #
 
 obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y += resource-mgr.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
new file mode 100644
index 000000000000..74efda5420ff
--- /dev/null
+++ b/arch/mips/cavium-octeon/resource-mgr.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resource manager for Octeon.
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
+	while (cmpxchg(&res_mgr_info->rlock, 0, 1))
+		; /* Loop while not zero */
+	rmb();
+}
+
+static void res_mgr_unlock(void)
+{
+	/* Wait until all resource operations finish before unlocking. */
+	wmb();
+	WRITE_ONCE(res_mgr_info->rlock, 0);
+	/* Force a write buffer flush. */
+	wmb();
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
+ * res_mgr_create_resource() - Create a resource.
+ * @tag: Identifies the resource.
+ * @inst_cnt: Number of resource instances to create.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns < 0 for error codes.
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
+		rc = -EEXIST;
+		goto err;
+	}
+
+	if (res_mgr_info->entry_cnt >= MAX_RESOURCES) {
+		pr_err("Resource max limit reached, not created\n");
+		rc = -ENOSPC;
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
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	/* Initialize the newly created resource. */
+	*res_addr = inst_cnt;
+	for (i = 1; i <= inst_cnt; i++)
+		res_addr[i] = INST_AVAILABLE;
+
+	res_index = res_mgr_info->entry_cnt;
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_entry->tag = tag;
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
+ * res_mgr_alloc_range() - Allocate a range of resource instances.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested start of instance range to allocate.
+ *	      Range instances are guaranteed to be sequential
+ *	      (-1 for don't care).
+ * @req_cnt: Number of instances to allocate.
+ * @use_last_avail: Set to request the last available instance.
+ * @inst: Updated with the allocated instances.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns < 0 for error codes.
+ */
+int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
+			int req_cnt, bool use_last_avail, int *inst)
+{
+	struct global_resource_entry *res_entry;
+	int res_index;
+	u64 *res_addr;
+	u64 inst_cnt;
+	int alloc_cnt, i, rc = -ENOENT;
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
+			if (*(res_addr + req_inst + 1 + i) == INST_AVAILABLE) {
+				inst[i] = req_inst + i;
+			} else {
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
+ * res_mgr_alloc() - Allocate a resource instance.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to allocate (-1 for don't care).
+ * @use_last_avail: Set to request the last available instance.
+ *
+ * Returns: Allocated resource instance if successful.
+ * Returns <0 for error codes.
+ */
+int res_mgr_alloc(struct global_resource_tag tag, int req_inst,
+		  bool use_last_avail)
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
+ * res_mgr_free_range() - Free a resource instance range.
+ * @tag: Identifies the resource.
+ * @inst: Requested instance to free.
+ * @req_cnt: Number of instances to free.
+ */
+void res_mgr_free_range(struct global_resource_tag tag, const int *inst,
+			int req_cnt)
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
+ * res_mgr_free() - Free a resource instance.
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
+	block = cvmx_bootmem_phy_named_block_find(RESOURCE_MGR_BLOCK_NAME,
+						  CVMX_BOOTMEM_FLAG_NO_LOCKING);
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
index f01af2469874..4dafeaf262b5 100644
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
2.14.3
