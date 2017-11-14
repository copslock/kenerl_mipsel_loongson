Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:39:56 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991978AbdKNEjEDE3v3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+i1OKG4IYvkQHZPrWrYTFn61+pYeiXJQ8fg+fZ8sg+k=;
 b=BbR7lHdXIDrZ5xxEIV1J8GNNNkKdqHKyxNOYAIxGGMVgnYUOhpVMUF5CN7nAudy0yNOuz2VmK2V18LF+wB02Al9iet5sWkdfHgCsVoPvLb+R6Ts28JEDySI9nw+nau8cGLh032ORhsp+MkM6Gkxsh7I46WuiC/dUfDIFmEsiy5w=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:54 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v3 03/11] MIPS: Allow __cpu_number_map to be larger than NR_CPUS
Date:   Mon, 13 Nov 2017 22:30:19 -0600
Message-Id: <1510633827-23548-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f71dcf-e2a7-4457-ca80-08d52b199d2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:8an9OpDq1hPwVwgmYwN49Ewy3hW1NiQjpf8GFwRcYBJcnbyxKe+XTqIgQyQj9W2bEtmiIWvzXkdmqhwpz12WOCSt9ORBfcM/YOdP6E+4dsCij2A9hLbeod4h+SH6JTtza1MQDOlXmyqWjDjScOsUqqY8MnkD9E5ySMO8pJUpA3qm+J++0dJUSczxoi+ulW7g+ndJ3+/9Q6aQFpm6PgXzonlnV/P04HLtn6n4DuH39JRONHuhe/uoBoFxXxn9biMY;25:K5WdDIQlPkz4mPnaR2cJdn1+iFGnzM4wQmAnb5TXQvr+tI+2q65NbUNB9TzGpEwg4ScL2zPpsRXTfU95BGzQvJTyg2rvOyuz5Oh5xaHBY66Ww0aS/RETNS3F6uKNlcpE+YaDljIJQZ62SnFUhS72t3ZaX8f32ui121VbW/4hzvACZass8kFmd55CAqq3Icj/XUj/UfUhVq4A3jxIaFM+/iLOWFMwi63d+Go2RTotSy0ZQgnkUxGFAbk1A34jQezXrYCI3h6SPrNXVeO0ypmYSrTqZx574T4hF2JoliuKgYQ07m4+kh0fyCK0lSQCKJ/LXC8jWSznQgHWP28qxoihiA==;31:Q7N6CJYFlGG+1C3Pk0oKruy2yYzUXEP1JBNkydteQp2tqMPOAJhkCaT5PncPDwETddSOAfM2yeY+m2HZea5BkGKljN2FMFzvdw7bM+ujzDG4wqxITC7mFmGLU95ZvDBnvTvTYUqQnASiYy0I5QFhSOt4U3fNyBB6ejpXriBzOnAUo4eti71d8XlaUEDDC7MzLhvRSC1Q7IVAU+w2mK7JFQOcNBGBwg+pYHakaIjf/P8=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:uEV5HZ3Lb98btOT1/RCRgpJUbwxs1xG+eos2Sx1a9eppnv/qfpliuPi0+Nj9PGVw062EI+1DXPhwCUSalp8BE7zndkkk4EJT0Y+uY7cJJp+MdRtMIGlK4RkNPz0nFu/YvPQZzsesED0Cu/idKdIuFWFAI2YKroaWt/VB6yT/9ukFQIV5nVMZl9BOSpajARgOWahtxkkJ2uYBuyIY+mX5Jq4hJfCANjbf1hAFFSIS0+xC/9GK4n+t4jUnMBNvEZCAo5/w2wgR53Ye2iU/FwIJZsrmJQHLMSvaMmOn55eiKPv3R4VNdvkI7tezy8fEC5PIXkR97jpuGqJXQnr6AL6549aIuXnagMt/XVWLkcU39F40SIQ9+i8PnkAYlVt0YTgyG2RY00Pk8T6bzVGz4QoVWJ7H+KEAFh7xBEIB4XU9wng2dkMkKyr85k4+bn6Qzp7ljnmRf1P07PObFlkbwMsZSL32dU2hDuiS54tqWhdc1Kwz7KyXQr7G0sJtgi755/Ch;4:OWu4P2XGOyPxUAGdDbLe2bPI5wFZEIGVf7jTrxXgr9blXDahk3+h9IC2oEcn2ExLB8GrTgj6XWccQwqLDbZVa9ygOCucy4+jjwLy2Rdzl2flL6/6fNqHOUHpEl64AYxcYwLMxeq4b5eqfS2929ZMpN5biq1e/28vhseiC57a1WGij17Q+iHo9RT3vZCBTMc6tWnxWz2aYxzw9LQ26zforaCaMY188QjOXZeT8RiCJRrN/Q+biO1SAXTCaW+c0795ioRPrDCC09JF4l4+/bMF5w==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38069C190ABF25F20ECCD9F780280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(54906003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(107886003)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:Fbk1GhUaqvU7iwshZpMF6OkuKJVWINM9YEIRa/k?=
 =?us-ascii?Q?xtfo1koWVcerszsQYJBFDsoV7YfsUJKHkqbfkW3QLZm3WAz0PknO5Txe/3Rm?=
 =?us-ascii?Q?2fnTU/xYX551qtuP7/gr/YvErvVFYfCP/9AAMKVr7lgIy/1yVCcOBdMPmazU?=
 =?us-ascii?Q?qKrnW8gzDkw0NX5gx8vq1of6CPtuLQRveCg65nnq/1TtGGqYJ0zKljHfssui?=
 =?us-ascii?Q?cozlOP4DwUx1e0Lleb3sDpcSr6rc0Ar1c9DkBmLGaOnt7uxn3+MZpNeV0DEv?=
 =?us-ascii?Q?rhma6ufP/h/rrwELMH7hu1q4fifuS8tqObsWFoYvkU7P+i3JZBmIyTf8UIrB?=
 =?us-ascii?Q?dkVOpE6CeQJZJ2oSARU3i1aAI63poDF3NF8FsnatBjLH4xixT6aRKTKm3E70?=
 =?us-ascii?Q?PgcDWaQFrH3OOd+t5flPr84bvnla6lyP+Q4wbDUYxmGCYXu22/YI23nHRwJS?=
 =?us-ascii?Q?FLvZOaXmRJ28+3sd4rvwrnW7B6SfgwTIb0pP0vuHtY2hpNXPDW3Y3t4MryyX?=
 =?us-ascii?Q?B1tzl+ut8vjQw/p3sTJC4u+L+L4EFX3S8K6PV2EyB/b8xrhjKTRpPC9uXFIE?=
 =?us-ascii?Q?HZkzfbAoeDCTa08t3uSgIFhVXy/FrHMPfs+8qJUUjtl4dSxD3B3bBqXYenOq?=
 =?us-ascii?Q?iyjP9kTPNohFQL2JsO2Q78BqspkCBAQmq4m9LS+kRnTQTGrODMR81cnK3gxu?=
 =?us-ascii?Q?WnmgDdprhYlhqLbsFvr49khd2mPSwXfN9D7vEvKVyKtF26KqnE7AZzde78Fa?=
 =?us-ascii?Q?OheVOiBzwVPShHTP+NN3wE7BxYlmPjQrtQ9oRyKrSud9yRCXPsnHRqF9/drG?=
 =?us-ascii?Q?AEifbkXCpBbt6xWkAygjAvhbVSK4RGotQENa3aaSJdJcJmnop42i8FtNYZm3?=
 =?us-ascii?Q?U7ILmRosUyWNLTu/38k4lfTx0TrXhfa7o5IviCCJTiGxFxh8x6jtaXDjpMPH?=
 =?us-ascii?Q?GfrOxXl4SvkSRqCf0Cr38wnN6I4okcbDLs+0RVlO6hCqhsKddusuzVQd/DM2?=
 =?us-ascii?Q?PFDkGqYPL/tXW5bKrUfgEukcYiENP0NbVXxMv+N77b9amHTxJN4pI4mq6Hxs?=
 =?us-ascii?Q?C3tF2EXxhfl5Py6aNfEiBJJUfwU5yKss2vpY/frOHYcgDHXC0GhN+v1iswcs?=
 =?us-ascii?Q?v+NKvRx5vMRXoHTuqqBy6oFQpIw1Ba7NWvbyxRkaxrt+F9PWzcf4in6yU0Fa?=
 =?us-ascii?Q?hf2AyV1PQdaOfUL8f/0PDArSaIt0VeeJyx2QXwMYP8IQaJf6be5BP9fGwKw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:xj0iSl/2STI2yEy18AUAIFXagPgAA73mNWrIiCPbab8KeiQVqYV4dgkO66pC9nNeRrtbrjsB87ZgX5cA0rAzq8Bp+dXhzD32N/7ADTb7ZebCuqwWIDFWhpqs0OjcE/sFKJCCsXvYr0apPUwOi3K0yMNHj/VlVHuds3HgO8c/jrV1kAtg+CiySNTiZoLJcCS5eBNsyA53PqiOX8omU46sG1jwHFad2S2g2Xl+xFS5VJO4BHrkM78DboNaqv37BvgQCyMIUSpQgtNTseRPgk0Cie7zM7gLoW8alGTR2fFBs5gKWcs/9TGrPaqYP1+lIrEnNaAr5P3+nSEiIYNjjvO7hYhK/9CofzpbBSs6fLU5dT4=;5:bDVyLtXm6haRLKA68KfxKW342laMvCWPQbF015gn8rCfVfDfges37HNHXi5DluYoovE5sktDJrbrm+xIeVTMKWRlUlFySbbNZN/c4cOaglqeXXzDUgHk0pRAru7O15qDjBaOrAmC+f2mE+bEB8OSqlcE78T44iu2hTeky9ycQ+E=;24:AJcbaZBwBICBA1VJWPr/PJwTckKeFEYEoSJ26FjGSp6DbJCA09Lk7U/02c+L2ujeqVKXINhJCotdDdiZC3b4LKrVzzjwof2K3B1+q0kMpoU=;7:TRv8qUbuC1D4U/X0H6vCU+tJ5MAlfGJaKmyleLLWp05tQwIb0sPA/KFFdw12mvShfjzywh1sSu+XfFVbv+WefpGH80PIr2Gsuvqtk1BQ3yHyGby1a6R9JU+XUicUz6XvoulQSRhy31xO9BdXS2tweg7AGz+uS5aLHVNyIweESAwjRh7psa7CxQjo2cE1zD5ylptQNf+ubWbAbwJWg7U5dHQu+mT00jLhBQ6CUB8AG3cBEHn+6jjXgfh8K+9LCYtV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:54.6897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f71dcf-e2a7-4457-ca80-08d52b199d2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60894
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

In systems where the CPU id space is sparse, this allows a smaller
NR_CPUS to be chosen, thus keeping internal data structures smaller.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/Kconfig           | 12 +++++++++++-
 arch/mips/include/asm/smp.h |  2 +-
 arch/mips/kernel/smp.c      |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5d3284d..475239d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -916,7 +916,8 @@ config CAVIUM_OCTEON_SOC
 	select USE_OF
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SMP
-	select NR_CPUS_DEFAULT_16
+	select NR_CPUS_DEFAULT_64
+	select MIPS_NR_CPU_NR_MAP_1024
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
 	select SYS_SUPPORTS_RELOCATABLE
@@ -2726,6 +2727,15 @@ config NR_CPUS
 config MIPS_PERF_SHARED_TC_COUNTERS
 	bool
 
+config MIPS_NR_CPU_NR_MAP_1024
+	bool
+
+config MIPS_NR_CPU_NR_MAP
+	int
+	depends on SMP
+	default 1024 if MIPS_NR_CPU_NR_MAP_1024
+	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
+
 #
 # Timer Interrupt Frequency Configuration
 #
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 9e494f8..88ebd83 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -29,7 +29,7 @@ extern cpumask_t cpu_foreign_map[];
 
 /* Map from cpu id to sequential logical cpu number.  This will only
    not be idempotent when cpus failed to come on-line.	*/
-extern int __cpu_number_map[NR_CPUS];
+extern int __cpu_number_map[CONFIG_MIPS_NR_CPU_NR_MAP];
 #define cpu_number_map(cpu)  __cpu_number_map[cpu]
 
 /* The reverse map from sequential logical cpu number to cpu id.  */
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 88be966..d84b906 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -48,7 +48,7 @@
 #include <asm/setup.h>
 #include <asm/maar.h>
 
-int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
+int __cpu_number_map[CONFIG_MIPS_NR_CPU_NR_MAP];   /* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
 
 int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
-- 
2.1.4
