Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:58:30 +0100 (CET)
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:46912
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990557AbdK2A5UsgJgi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mvop/gh2X09lH/pHwXFuGG9hNFYkfRhAFs6tVnwDAnQ=;
 b=eO8bLXuucSmk1FHRv5fojNPPsHPLFou3bj42rpBRvTjdFcyThCWgd53njLgnsHPzmgCbPraM3DWb+5iBPx6SD97wfbDs07zd5KJz9Sg9z4wKLxfVLGLi3qNPg2pvqVrHkF1lArZbPz5XAFtvKfftrdCiNx6OnEzf9OcatpBwgic=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:12 +0000
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
Subject: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
Date:   Tue, 28 Nov 2017 16:55:35 -0800
Message-Id: <20171129005540.28829-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd12fbf-017f-41a2-a971-08d536c42387
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:1iMC0HqD0MBaBX4aB8X8GtBFrHwnCbh3fRDErSNzkTZaB28gTqcqj3Wu/6pjK2COBl/Cmu9X1U8LIwHn4mdEuVLZpMPCYuc1DHkg/oLc2jSBfg287VEB2QjJ6RIN2KTumJDFb5/unt8hOLmRp5n+olAv7FuPG5mFrne0v26aUv2kM4qq2ujHXHQbTRcFzeLvvdQ+rtDc7ZaJJdzGnwfKkaqi0DbTVOkg2trzH+p8Pxiakerb9kLdP4U90/ozLg3G;25:Ix5xtxa8SuJle9IANR+xPSaY3ZfTg9y0efsxNpbdZ4RcqqRJ8AWZnrCOafx+Mmt/fMbdra9H+1QoYhrHKY+6qfNvOvBulzZaab9zQWP7Z47P0c/hNFDFuMtEG1a26lgBMRL/B9vzWw51CqIVK0bZs/PcW2b86AFBOcUkLar4qVtcD9UZ1ZNr76cYc9cpm0r56SFdi8Q/tVlIhtYQe6EdF6US5/ylfhAdNx1/of7VuBNe48QiCLWE+bVjGZkdovDkYYncy31TFOhJiFSW+0ABu3xsuVlMJuFAmSmWkeQN4G3KDkrBCmcP6BJ5zbgHeTcEwp7aTnRoUh4Ztn8tCEiTiEkypCQD2Xzfs6dewtAk78k=;31:b0AqfLVMRT3iBlTpgjllHhHBPc5Lpt3540LRbp2gifzd3w5ZeUDViOACUZQAVca/fqi7dSaLv5Cqag59Pmi53mOb6VFgvPqvvNT/vUwXKTAdQjOaByc+qpMe5K7d4twFdkzSSgomC9R2qclktLZ915R127pl2X62C+rzgGO8hraDPKETzIPozndNFoWv4SrmRTfg4vWF4OgRR3HEgFPyyskrW0ybH+mlKMiiEazPMqk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:ccfwzE9iGkvRx6kxDweQYbay6PDGjbvLFlz6kT6alfGWlKvMI5tvCSXn3ja/s5g+HzpTOsFnhDbuQ5NHjYL97ov89e1+hRuog9294d3pSeDuneYmVKuE4p2U4Ei/3eSQgCII79bcFvP9wqos3MnSzx700zbfH2EL9CBX+qjwLHFiK1rMivZydldZTgAt7J4btHvP7Qft3SgKc/f/t5w/80hNWc/I7KpraIy5fAZt0e5BBI1avoyITlX1jlKIOUnA67RPXz1sZSNNyVIIrq43OS65ohjCux/tyBBAxTuFnOLh73flokv/FbJnlLcGbugJ3KCsYqmUMqCsKDzHf9ErC8ajG9S2dZt6Q7IrbB2fTEfo35sPhMXkASnbL4VnwHkFhs2XBgqlTEAqbKuKVe0ilTrdHDfhyG7GcDlNlCyjwAatI45z4qawDyTxrUqIV5hujQq49WizlDX2FvIayCSt1samOaTfuDFabLvjjRyYFFiRDkBooyTRSZ/wlpIK7zpN;4:NYpLdKKKQGv9Dfe5RNps3eYq4gQ/f3GDVtHjfmLjE6Dto75bbMqLdgBZ538HbkfZ/PwEKkMYz7D+acxPVs+wAHkqXBujlRVwQzhUxafY/aY4o8zBxaS0pdCZuuTaOs7kUJRTMF36JiaL2C4XseChWNdDwFloSjcNF3BCWcuc1Y+qKlbj4tm76yL8KER72ggBPpaOS7AVNvYcdMYatZnRYFODEo3qmfLCgpr6ZEL6/qC5FWhJ+QcMmqUL+utd9ujSXLNuWQiVsK1GRKCheI1CYQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34958B0949CE3A052D1070B5973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(575784001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:2BR7/+kdDurdkZbMvU7MpPibHbqrYtJt6G6ZpzUqp?=
 =?us-ascii?Q?vy5ntUMc5ELUCy2lxxJvR6rpnmiQ5aWHNncDuZ42lQV74macCn+DlydPmTsi?=
 =?us-ascii?Q?vVMNVniKX/MlJqcmu+UjzvwzUSnn1vqGSH4vG0tCT2G17jGT/ABVUmv67MVD?=
 =?us-ascii?Q?JGeHTxB8003dB4mFFjK++qNGEs+Dpp+MEh66RdniZA1b/zJRHymOWmQv1ryM?=
 =?us-ascii?Q?kmZKEqTGB+NJYwfS5+akqdcIb403LYTs2XMqSQ8DgDIB4j2kcLGz+2VQX+g7?=
 =?us-ascii?Q?M46KL3uxnMgsBVOs+nEtWAj7BGHbnQQjT5aE8HALJgIGqkvWsOZYlEXCUZw6?=
 =?us-ascii?Q?Ey10l4hZfSBGsApItmeX9DKfL8AyqlOzMJXDwuVjAbw4QB+mgrHTnWwZ2hJR?=
 =?us-ascii?Q?8zll5uISlWPfNMEgP/xv/WnjpRVcnvcq8wG//pLRXBhES0jiPZMizapdz1F4?=
 =?us-ascii?Q?6cI6PbKvfnVIHM9nPTweZ/5b7Y2R0XQz+Hi3B35Jjyu0NGGfgtMJZ+5v1Sgq?=
 =?us-ascii?Q?SXPSDxyZJZdzaJFihk9KgjRGeBcmi+ZHse80Ms8F3e30P9sKKjIHGPAczUaI?=
 =?us-ascii?Q?h/cYDG/KrlHYOjG8Nk4fKx/XkQynXOePNUMhtITCwRzhXdrkb58bdKoxhGpf?=
 =?us-ascii?Q?HrdbjnInvF+Cnbi7BU1QJKIYcecjeUUtC4aM3pVskG8hsUcWnVyxD1NeEtG2?=
 =?us-ascii?Q?JaAyq71AsImslHYchPzT9nJpluzEVus/T7Zoo9mRFG8Np//exrxj634vNZab?=
 =?us-ascii?Q?NKtMByLCjdTKJjffrvEf7swpQbQ2SwkI/AYBXE0ptpDzq1pO+g5NkcAVL2c9?=
 =?us-ascii?Q?1vglcX4D5JbqtodmHIokv9T7oTYeI7/sMZ7XlgS9F6TsajX0NI3iftCa0tf4?=
 =?us-ascii?Q?9OxbiIPBBgUDhA34vdKgkWO2d/Ym0g1qzAGFC8vNqnPgRk70ZaxZ3+XoBQ7J?=
 =?us-ascii?Q?WPrDnFNnxOOtnxRGvu2QFSizLU4oIyapD+OUDXMzINXdjd7/1Xs6Z8q95qKj?=
 =?us-ascii?Q?p3jE13pZM2KMu796aEpwqVX97JX1BR0hcMiQmDWbStNEleGVMvMlcYe7ROfL?=
 =?us-ascii?Q?RoaIgheiXejTMgpNqifPqYov6jQOkG2iuIT7DIIJGp8NHH4aOHxEhNX7p4Zh?=
 =?us-ascii?Q?W88gz+RpzHlEvpUqguqobqiSKLnTUEgBzBXlotrXxuGHFR8IP/JbPiJKwbdh?=
 =?us-ascii?Q?2m0liKBHzV0gfwcKd/6beLjVQaZ8Wwa3nbAVYW9go6zSPqLx1ULFscN4u1tC?=
 =?us-ascii?Q?KIdT7zcFfRMGx5zR3y5tEdXhpaHzVtCnpLQZLHBPG11yCPDC7+/8vq/40+qK?=
 =?us-ascii?Q?DEmrTWAGQb3ilJJspTc68U=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:oJqj9JqiIzVhy8X5UNkXyeUwzBLLlYNQ/uayQNPap4jzHl3vcL3I7dX8apMpEqDe65022m0O1I9MAmTxDIMjZFy6kQmrQnm0qkBesuwosS70UTKU94JYx930aSyaiCpR3mJ8/7JyYalZWhV0GRGFUmfanITy6uCCWZ/jbVN30Ei9mbPASdWEs1Ii9s6Tlnj4I1vxiRBECRAYNP7l3EmLSd4+eHe1/lxJEhLf60HgC1x40oknDiMJHbVAqGDTGnJI2J7Zk1AEAuCHy0BqjQp9wQgpSBnUudOrGFoyyMBGCeBmfnYaISfVWfUENK9RY+vMxTZ6y8LbvR3Z+vN4Oe/7yoZK19Qi9oss2RASDZVgrjA=;5:gsZ+2M2wwn4vPWfpmk3yczv4SRm8suRBMcwsq/5geIF1BM66EeCJYwrMK9ByndE3bqAXHnNd0cDr1Tb8TH/29vC5wDYOSJYk+bi9BYpbM6uWsqx3JNIUZlG/dSr8fBpvLS6psD1NCfamBzFxoMrTtFLUpB9n3bPIk8VP3olswAk=;24:v8hUV6mpD1/fxXYE/ODxeAIRDIjoPB5aWXiwCHRy7GTm+KyEBx5Du/99mHHi88mYZu2B18mTn2Dfrb015vc2vG4JS+Jvzoyvg1FchuBbVXw=;7:VLMVAneElDsKNmHjonB9U2Guv3gnzd+YyOU7UDD6UOCi9Y4M5sCYltlYrSjBgQnLSRcqIi8TpYsW+t91mgrYHlMXOKElP/YHOn2z38XSr2WS5ahMnAsJw6XySHvjpVpgd/CdNVq8WZvSzuo+MKC7z0SUTh94AgWzVROY4QMBh3DPvoS+Py3Od6bNWQKMwoLlHFs/7gOn7lh9xR+g+tr6N8RJkkD/+lrAsRgPaHA6fK8+uW0f+0MzjAxWUuLe2hZX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:12.3981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd12fbf-017f-41a2-a971-08d536c42387
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61173
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
2.14.3
