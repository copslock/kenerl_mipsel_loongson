Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:20:10 +0100 (CET)
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:45440
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992828AbdLAXSliw5Ls (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:18:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sc5x4+7n1bFa1qpRtwftYJKR0YN7Gjz+ho/gGQ2xKbM=;
 b=PgGqJ1kAsg0uShfqoNNKPdNglpl5FIV826X/LcKTnA9L9ihxScHPSJYJGs+cgJqwrUji4MC6ooUiRaYU9cqd9VMFgYngLePFJr/ftpwD2e6VQeAdVfS/6txXZPY4h1GduwgfnqF64xQbUWtOJ7pYEXc5mhFfCi4RThOvrSRSM+Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:32 +0000
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
Subject: [PATCH v5 net-next,mips 3/7] MIPS: Octeon: Add a global resource manager.
Date:   Fri,  1 Dec 2017 15:18:03 -0800
Message-Id: <20171201231807.25266-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59c8f06-8141-46f2-86be-08d53911dab2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:ZIwfSoaz0URLLYQ8um6Xa3SUdMuXAswKrSSsV4T2qGEEtPPv+0ZbrrMNzydPC8jPYRtlCOkPa7l7yYixRhvBpgunzclaKzuNUbklRwJDu20eedfTA3golEeotsDDI+0KerlQWJFG3Nhy07mSiEktWMgVFFwsEe3v+KVo1mKywSgyJL8FcPhOGiVD0zl23dQY33428GmstKXK2aIoKckkeIH3tVKe8WtoeVTWRQnBlmJGM2gVwccn+3g11ZU7/7tG;25:n0LlFee929i8sL/NxYAFVu8V9aLuZb6BBjvK2Ho9EYYBryK85JEYtzf7NemUwgbAXa4voLy+7FPXkswmzAIHiKrNW7SF5LWNjWq2piNSchZanZvDG7EK/u0+U2whEg0uSvUKTAODNcRi4s6QKwuA8cOdT7ZLLIVsJQEwLPnmOXNrxu4A4j1IsFH1PglKVcSuzuhpXveXpsejH2KdHK7VLEFL+G7YyMIoSGT8w6yPyk1wJeIBeCIrVYmgZDqOnmvScdUMG8wmDwT9IF4XvzrpWuebOyjpD9AtTK4iMkTT5n7k3WNlu6VkK3n/Or9MPyGGyAmd1FpilasJ40undbQpbg==;31:n03Hf1Nod2QuHo3GjWNPyYVURx7TjGTwg6oE/wKVpbP7marXnKT46psAD5/d0IaOsvnz/yLj+OpqYNmHrXjAwZyaWENCLPQLsdQVNJksX3emBeZFRqHZQAW/vreoAX0l+7lAbr9sXQMN85aziU9SgqqObFkI7EGwB6CDUWPAyj1rQ/8wkG+DA/dzWwMXI2m+NFmCIeSYXip9t81HDDRmBRTRkswR54cUVmy6FgDpsik=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:CCbjAqPnt2tLzwkbAy+qMYYk8adntHrrY3RhtAgIpVHVKYxZX6IE3MLAcSiUbXlOcM28iyJVOPxGryLc36kop8dy48yzbK1oQdyf3+UbodkaXBsu5xmVw4druLyMz0kz0KolGugBBpu7sMSt7E4u4467G3HbznosRlQuU1JNJ02U/orwa1tEbPJ/rZ3Wu+T5FeyKvCECBgTihLYj6eK2WKlfp3z43qLQeAEKk2ZUqt+vJHj1GvhfQqmfuM3TYkaKo7eAVmoKq2ZdXHgXLdY1ZCdnQOiR+G3jkrn5mlMnOPLOyjQpeUJiWj8Nlc5nRFaelRBAE5hxsC0Sd4agS2VJa2FfrhyQAJfSHD7KzyMm08B0SkU4X/gRbD4ox9LDEJ8esdMYoP6vavfyGH2PU0g8Cfp3FzxE+W5H9zHObn12qzxckhnugcc3fntbJ6x+/HNMdD0ITJ3gihO7h19BGzJ+kaumkpmJOlMeFnd3FW/WIeg3p8T1KJIKeOJPD0XjxPZ2;4:BQX6teNnoS4wpZLlI/qkY+MPJTkV55fNWow2MerXohrUmeQAigZ966Q/NRw/yC1vTbivE9sGSq1/OcR2weaIWJRABm0p6L2ncbVmrZjlbHZtEdiEORsM2bxTpNqP7QHz7/JJrw76eVPrw3ulPbSlNMjPF+ZKGCkoPEWeIDCUGdpajPQj+xVfz/RJzFGa1KoMpqheGiCXMujDaBnaoGHO0WSCo7fcxAcSZiIl+bn6DRALHwXJAUw7DPKy+1YLTUQEBnr4tvO98I2DWdePaoUhMQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499794AAE1D73BDCBC7434A97390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(575784001)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:KbQhU2LqQEX69N5A3JYbh8dyjluauFlcNQyktB6Dx?=
 =?us-ascii?Q?7YwtuBMnXyxnljukRxFrJG0xWsJULh7VRw4yXjNk60d7xyW0GT74TYfclWLV?=
 =?us-ascii?Q?Sk5xBfm2cRU9rqrWC7w544s6xv20b6n+4zZHSycXiDmWXv7apEQMTVNsdKBC?=
 =?us-ascii?Q?XORS/71VFbbZlsf2p82K6ycM/2ohBMOhCtbwHVSefskU5V/DfGuR2wfjpedI?=
 =?us-ascii?Q?UfLAkXru+chK6MpIJxsaPduStUVL9zo8TMDCL5DFUCYMNXnAYXhAf2QmMZjY?=
 =?us-ascii?Q?XwAdVRS3BmY/PiKLNBoo+YnV6MU5V8jObgygtj5pR7n5c1IVp8SHYT6qBOtN?=
 =?us-ascii?Q?M3GA4QtK0E4658uqc878p5VRRJSOhzLG7URT2Xt87BYoY0n/brovPnJE0FRN?=
 =?us-ascii?Q?HpEM2bNl3HPmIh3scgUsP6OgYVqMecZEGCNftt6QcIt1PgDP+XXU9edMrd2O?=
 =?us-ascii?Q?NwGS1pgVJK6qIF10C/BUvnBwGEtlMgn3UdiIo/JPBwqOAsMP547k9Ekdj/Zi?=
 =?us-ascii?Q?BWHzkixDN5Ea15NSEjpIKhvZnJxZinu54UeJBB4zBw481GDwJ2jpPtgwpzQR?=
 =?us-ascii?Q?GoV1B4H/6IRawUutkcgynJTjRQRGg1kIuBiOd1IhPxG5Plum13qpypufOQnK?=
 =?us-ascii?Q?HkfR8ABgxxQRJ1kU9fFYH7yBBhqwbuqote2MeYQrq/mB5D9akR7e1+D2Jpge?=
 =?us-ascii?Q?q5q+TEqVlC1ZheugY6hB6UqZglM16Zvg60SkBR9Tv3Chy5ualWsxoZS7lrO3?=
 =?us-ascii?Q?mP1RLlz1ct3bkMM/JXu8NaFWh2CQOOUJ3JiaItDIyxb6plv3QodAnZJsTXrl?=
 =?us-ascii?Q?84G1XPMvcwvCCNKM12toIroMOZq0OtQUHXziqKdnuJBEFDWJP66NCzFDd4OR?=
 =?us-ascii?Q?0AhzlT/Knewe/USjMv3gQol+hkbAoOFDXEVwQJXzHO+MYT6m5KuWj76etFLk?=
 =?us-ascii?Q?v1dOm+YnpYq3ia9YOl2asqdsMvTGGTRKTi8PNzGZRFkDMVr4jsCHTUqv+bnS?=
 =?us-ascii?Q?0WGKMKMwxUUczXt6ATS+iGOOIuriRwl6IC4jMvz+u8pSHMw5jSZdurJNZxEK?=
 =?us-ascii?Q?vXkVUtJ9suYy9zVIg1H+qrvJrcfrYeLNLMHxa5g7CRqbvH04eHPF3DEwMFsn?=
 =?us-ascii?Q?keHnB+Zd11CwKl+x+9PbQwqaAzphY5zegN+TfTXTCK9+Slz1+0mnDfwCmO5M?=
 =?us-ascii?Q?OMH5MBhzd8e8M48/14A3C6bg1NCJ4mJ2G9w0BShnsrzgfNa/5S34M+xJhcQm?=
 =?us-ascii?Q?mzVmyeL0s8yanXC+66IRiAq5T2L37fSLXNMlo6uTV18dBjBjrLgQfTFhYoeN?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:Xf3ODRatKxCBNc8A6Z9R2ssuB151BO4fC9yTUoQ3jc/mdzR4peYz7iT1nLoO3onh01/q2KxDJVZipbRsw+IFdHdWp3JTJuGJ9D5E2VsgbgCSjFYroAEQZrBwbT4BwhHyKd8fgDY5oVE1TG5NpfRZufMPR8PAXliUcCszywQ1puTZmwxxlcGXqUYkMGp8wLfNUGY0l9+LCXtKSpKR5BiU2PSCmeE8v+TFvhh17FTdCro6lFT6IVzD/vh3/nYq5YkR/v6B3ZFwl1Vy8NTYGTQIJ/MdqaO0DyOdPUPuZN3FLi/e6WKETUG2PcAlj9eleOhqOBIZXCzTeqPLKtN7ujGJo6IcLWSj0tG0JZRCi/bvV0Y=;5:26zdDbnwGLLwEb+rE4IAjSgQFAIlIl9+WimHwR9GLL24LZ57dTToXKpIQqdRBrwwrnAfHa5iHZXXWBfr31P1CeOXJQ1dnAgahSy+d6Cb91jBsK17RKgXPGWXehizwAOCEE+8DasoqL5XobewuE7U+bF56HR9LpsKFhumCpMoFs4=;24:Ero0VtrlnoUevIMcErDgSxbbbokFDdJ96/ADeBqUOuvlffdZaVsGozyaZPDTd7eiOY4e3DZhqC8MSPrTgTmHcYPJvqo8/86q7ZUGR2LDJR8=;7:Hlpnn+dm4V24sj1OskYWvXpF7Cxzfra5NQeLVfbLbczyywJtaduAkMe/2HVr+44QomXI52+KOF9RaLqzckYWB1GBCKrRWbjpdlIqNE6SwiNxRj8XBVNCtuqqjojufQwLGsCl3aGXiMN5ORlEMuRcmd4M7ReX/hDqklFVEWU/qy3FaMAYD3vAUoVMqXEbxsq6LBmYoI0wodCyP93iY8h4mfdZZe2T7+z7ixXHe9/NuL6YuStQrepFXoPkZugMofcN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:32.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c8f06-8141-46f2-86be-08d53911dab2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61272
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
2.14.3
