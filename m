Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:12:24 +0100 (CET)
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:62912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991526AbdLHAKO364gA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ToX0XFkodJPEskvjYmH/sfsiaWp675ikHiLFNxjahCE=;
 b=a2i5xlcUxvfG6kYUQc6GEa2UfflIrUh5XEMWBY3NQzTcIAajUV9Zu/sNnHL686jFKaNanpo5WmZ3HW2lMzD3unKbG8TVjRm00Ble2IOv7DsiS9DtLzJ8HifGkhMBICakagSVpPeefSXX7dKORzEoykN+nb+87vSuOY1Z2DXQbXo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:58 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6 net-next,mips 5/7] MIPS: Octeon: Add a global resource manager.
Date:   Thu,  7 Dec 2017 16:09:32 -0800
Message-Id: <20171208000934.6554-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7a627f-958d-4fd7-00e6-08d53dd007e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:Tn9T2x/yraqOHMRynC5FuSBFiRXY6FLqkm12+DLU3DRaj3zB9+HNh85nNIETYOJ+fYtbladejvJ71JIcRK4ua2WYK3uT/gbDi6pu5njAor5v7qnk4X4MKdwtEkevLgyidFAXb3y5/nfVOzFyhhLsVVM+QP9960YoXJcYjqp6naam3heBbe/sA1EFpVWveV0IN8ozeZf3zMZ+9NDmuA4obWTW1HLVp6E7lRTANcw3TsSS84hD3ITPXNJEArTmILBP;25:4Ty+9qMVxxGXNHxrc7kvR/sdi0qSaxpDq2VgOu+yAGNQgkFFAid/uR5OaA8miZm2/7fPKEKXELNpBmAHs9hrrKwmu4iJK6IohUGHEpaakf2ifmOqkOukVgu1zPIYGQGjhTGz69UXXrEt6crYkgHdGta6RuHWFkrzb1i/7bzc6gn2txX42C8Uh6aDGA7/JSydxnvJqicoYqow7LH763MCwqL7yagB9Wy7bj4cnEXCta1dMfTfXnFZCZHCedzLpUJ0ioBH3YYJdUgZb+kb0Zo2HyNhWca/ncS0SdIBYzz0X+CXgBjB2UjwMF9Fn/KqEK7a3TaB49pk5D0rpYkVmMrgiQ==;31:kkkJ2CvWiXQHUfdcAuxcnqrhAg+pqk6GFeEirZEwB1V07QJAoWAoN3TH9CoV1wLLEr+5FDChZ1hxTwMiR5xN8Tb2KmDtFJwdtEcrWMJPvop3s9itNJPbhSuKQfFbhQZUR6qR4tsaMImjssJ11Q5ag6pXKgncWL85HpFa03N+WrebR7evuK/frnXK9bmm1ehUzFlM3BczRIrJPCNirQS3xzCz60xloEGe41Hdkj8bMcg=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:ULAPN0fmSxUhyLpXdCIbUORaRb5kPWNr1gmNekjbsDt0nRpy3ywocPA78iE3QX+G6B9WI8bKPaLKKSK0nx0tiaReY9KmRPWGyvjkwJHbIg5ZIc4MPH1P8OUpnYw3F0gSY2+x7KZNpkg1oEZWdHnV6Al5bdqZ0Flho9ZZgdjfxuuwHVS/jfd30fj95k4LRI1SZTnY96W+2xNlHe7BGTr+ydzrTgubfGc33gwnD8Z/Gf+hgNKN/ko/6SwOyvGUxaHwhSXOm+2bwt7FvGefjViOP3OVbN6UZG7fDzzlAgoqYADqfUWuFC26neoCeSudJXOmwR+BBYUwAqD7nhtQwE2sR1JXdrTLEdrNj6VMxKIz2GVhuF4g92VgMUPiUKPhrzp6GzYiuBaKcRTynATMJ1NUKVCZUFqDgtnCCoD3BvCqk1hPAi0hYAY5d2JUFq4QbT006bgrL3fTPlD1PQsN+d3IxbpJjzk8LE5NhFZa+QQChpv4RLZBe6ZpvigKExxKt9MW;4:uRKkOyFhu5QURhDIWIMzkkescbo1BRgzsBoNwSscKrqfzmpWifOIbni0fSnd+BI96ggHFMQ3mteBMmI70H8ZIFUEsen6TdnVAI2xuIoOQcwtoi9uhgjWYl0hP3E/BrqaOVHZcSkgAgCcve2GmNjFfI/M7/9ncXwS+0OXqyxa/YR4AG3PGeAFL7CPZw57JRPjOZCopz9bykFLhqeYGDBYhg7w+V0HJkdRHU3tH64cs8Mt4NK22BUernRmciGjcmYbWFpz+FIvHAOttG6Ne1upzA==
X-Microsoft-Antispam-PRVS: <MWHPR07MB3504D6396BC14724DECF8DFD97300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(575784001)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:ImyE3B3uAxUmxz3WHsuEL2u6RfsN8MKbfiiSQSi1X?=
 =?us-ascii?Q?BlEDPTgi3dCdST90bVXOJOS+qBLl5QJsaKM4+IUiB34koMk5TZntrhDtiS1b?=
 =?us-ascii?Q?7epm8Vn/rJpsuJYpfICa2xhPzqwz8s8PjkgCghTaIO2qfVkJ6HVqCJwaT7Qq?=
 =?us-ascii?Q?vZlxn53wHHBZCHJbm9Q0b9qSrmqZa5jzd1Sr5fzTC5fr+6MBLjM9q1T/bFq3?=
 =?us-ascii?Q?8S5sa+YeZtZuUpU+djHp7SRTDHyZxOTUYKWc66mdAFx73gWrWUlczXfTMHWq?=
 =?us-ascii?Q?ZBQyLeXFDEAiL8sfyZvrxEQDuY/5RNGWtUC6H4+xJ+XQ6lb/h18BjEwd66bg?=
 =?us-ascii?Q?V2U4hAiKO7b46s3Z1+269Adkn+eFbFQJsWxmsPCQU5Vfp9k+0mXcVW+7hqpb?=
 =?us-ascii?Q?Cr8Zleq1KkadGP1QymY2cUCV0oYlE/dztL4JbtKTIWuhG8KdjPE/3EShliSq?=
 =?us-ascii?Q?40B1BgopG/QyMxyGInkwnza4w6w2NAA8fOtYNnxR3wSyBkTO3hh7YFE3/srV?=
 =?us-ascii?Q?9hfK28puSHN/2RPSgvmMjSe5CiWNgCDPZOyPtGhnYNvtEsz4pS8OEHVxCu15?=
 =?us-ascii?Q?ErOSxfEfT6h+MGj4if78DNj7rxYLozCJVBC0+JKBzDAjZv+DJd0X2IpppISL?=
 =?us-ascii?Q?EZOx9dt9Vkoict2czT9K/SvvA70Xb6H2hBhzhi4fngbnzIi+agkl9cocdhKn?=
 =?us-ascii?Q?9r6BHFzDstPY2KvLMQSzX6mM/CVPv9eejKI4bvzHYyO7EMKU4F1Srh5Sdhpt?=
 =?us-ascii?Q?pdvB5zWtL6W7WZzzrC5KoUfO84WUtE/ThWb/1omYMRKCN5wmytxX+xF3KR/I?=
 =?us-ascii?Q?qqEj2DzO2HtAJDppQw7WRH9YfqeELOZssxpuzv8saMN7+WYx/FJ1FK5Dui9X?=
 =?us-ascii?Q?Pn9vcwdvSOJVXIwojOVyhFeHJiwfo9UPOpBnSq7LiyBQi+TZNA+E17+KAfqN?=
 =?us-ascii?Q?pciFtrZaWWmn18iO8Xx3jytFf6yDtSRqqD09bFqmQyL3+YQSkc+Bt+/r0RNW?=
 =?us-ascii?Q?HXiV6dk1fQY8PkNWyVFebCGAwIpfiRz/79dhDYu4Jxl8LjSE9OdEC34oQciI?=
 =?us-ascii?Q?WJ7lwTMgjq457N5tdgz0noFQzZ0DXa/MDlgLTiyxxx4Zn1WWFCpDFXKg06LN?=
 =?us-ascii?Q?5CZ8IHsehdnH+FbCMF33n3KjF9VoDjU39FUEiGcq5jlDf1Kf0j0TGLGOvGyD?=
 =?us-ascii?Q?Q7pF02dJQxsmkf5erCBAXkbTixBY78oRta9jSBzXPUt9cY8GaxZM2anjA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:HLpeT9HjI1sZOBNEDY7yJIK+QCllsfYxzKOlGTbj+/yiZj2zZwi4Kf6yDRWPVaDFfXrr5kADL3JnIqJAoFTNRum1okUu952ukmdRhz13J7ygLMUzkVYsQKIWRfItMfQem5yshFoKk/2SY1l1s1FnEbebuIz+7xmOYRDIR/LdebwSZIfRpEjQ+acxOArRBiTzdZfbzBpvl2ar8lRteXwKHlDL0lFOvlcXBIIi7WC4Exj62kUo5b48JmGcoVmUzeGrg2xbXKF+ilcJpL+WaORJGyi6TK3dOEkVKKu9gq0BH5ssBe94EN/GePcVncxdDeLnShh1HLxOuyc92MtwjpOUim6M6YcJtCoX9gFb49+vT6w=;5:qzY7MFwXSXvfwC6PuG6cd9BEO3sIRfaDsRKfvd5N2vKVXP6iM/PSInjPbjze5GB+QecEp2iHJRILrFAvz8zbZ5ToDF4ycWeORKCG8RbckpUjzRHew07cmG3/u6ZqBuwH7+GuHMVEjyzS1Jn/uwtMJJXgz8tc4IgNpfO07lSDXRk=;24:QTz7SwgJ7v1DhadPATok9KOyeRjSqUgDffNdxllXg0Z5ROJAz66yRVULONf5/Vlt6awAmnahxpakTzyIINJ3cRdtuiF4GBKKzzDgrZMoQio=;7:qix53R+lAbw047TH9udt7odkFMthvMiGi6jJzk9pwFAKkzN3FLn9j8BtqtQJ0Lb3bWkbwZ0o7RlOAPagez80SDt4lvV8P4vB8AKuNwbVo7dttC1Np4Jz+RVs+VlIeWUhAyn15ceIGetPPJerixqYCC1toGrEUbJTaNBSqYuFfwv8AQVkzqFwStrSFy8W9C/K4qCZki2/GXcpnQe03J4TWoVFVTeoWpsTwMfpjjcevs0eZmtgebRL9xw3A1oyT6Bp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:58.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7a627f-958d-4fd7-00e6-08d53dd007e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61347
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
