Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:04:02 +0200 (CEST)
Received: from mail-co1nam03on0080.outbound.protection.outlook.com ([104.47.40.80]:16910
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992036AbdIORDiIVrQH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gpeDUG5N2X+RNMhlQDXiVuItxOY/5sRUi5cSpdjL4Ok=;
 b=Pn5zKpSwZTMh7UGqLS5gbrmSk65JmaGLYStabESyZ6APTTbj9rDqqlA1f97s/tVnOHKX3gZaxvwEfdaHZNFcHvS4nAwcOA1I7WIxpkL8deIRKQ2yBHzZkP+L7ksQhYhEVJdo/FOuXeN1B2ZunkvLuur5oNygPD9rdpEFHp9RQPM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3805.namprd07.prod.outlook.com (2603:10b6:803:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:03:25 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Allow __cpu_number_map to be larger than NR_CPUS
Date:   Fri, 15 Sep 2017 11:58:13 -0500
Message-Id: <1505494693-22732-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0004.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::14) To SN4PR0701MB3805.namprd07.prod.outlook.com
 (2603:10b6:803:4e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70346db8-9c6f-46dc-ae19-08d4fc5bae29
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN4PR0701MB3805;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;3:VbTIiHXF65UqoM1tp5ofAcf7nWQJv8PgWtbL4UMAZcGInoCtVajnxXAEYANhwlddSEzW/G9AkgvMCRKRvRWtaqIgr6GpjrdGSNWEGtqPZK1r7uVz/pokz1pFTlzAXiYXB8KBA8UgYtU9UGZF8VOniLx2UQsROA1zf716egIPgDdyZqLIKcjuCXyN355+p9ZaO+IBKYeuwYbVEDdm6jYLP/hqYCTbZPzbpDULUbfeHncToUm2Ju9s++9KOhZUi+bH;25:oLj9lXpdbWCwFF/6ocKxZks3no1WJEJbNWthcehqUbj94kMYQEp9QCjhP+8aFy8346lFN+9oaq44Td2RXes4Rf7FBNrf36pc6Kg5DPfddsTqgXGl6/8IgBq1yXHfhwSyDQQFvoCGTPXml8t0v4z69lR4vtqFbl2f4tQYnpWLvkQqG6mBvG7BziEIey757hk4+jPGH3aPK6gikavYCstWd4O4IsQnguXJqow0Go90fuuPxTAIR72dCZZFXbj/Le5tYXLXKSnWj3Q6tzAXZ59aSL/OLV2Z7jI/i+gBLioL6yTpP+YQsJVK4D68QmqnElzDcnRo6J6oBHh3h8XQkSr0XA==;31:nc4nDPIO656jzanNjB9Xr+sZzaqhpCMdKPIqrh/u5O0w3x68dUoldgVkJsfAQWNQBgUVf7Ktth3p8myoiYp5sDxZlCd+p9WdLC0+nJHScZdCuYhgegDG61Oh86MD++orqCGwr0zPDAQyqSamSx7680RvracqZyBFYpfmwLx+K2ZTJ7hsY+T89hdt/Gpjg2lONASDrgE9d2HZ9TDeeg7ZGBBVMKUqQDs2mBhpSJk+EL0=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3805:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;20:k3mdnqCq2e0oQzU0EpsTdayEBKVZjpxxBpfMrUGpiSEsE/vc/AN8SBdisC/uzKi6yibboDhkKEIMCDCcOTEA4HYD6O+IkvjZHfMUQq+n0eu/ua0NB3tZulBhk+D8zXMAkWX2TWyGgpAILvxeDt/PftfRmpglv70so5ntkZ7fiFUpS/W5dLmiorIDUApkb3P6ovcNrIoH47rTqvubMtABKr6hUiN7rcfYN/Bu/XzrdnpT7LDqZ5QxqfdkTGOlUYXUYKi9JbU9ZVql6mmAtKeCKnXGX9ZMMUZpvlFCRGv3FVrjvvVEDLMjBBHhlesa65kAxX4qrn62laJDJ9347teS5n8D4JxQDfOIRZmRXUaFdU20hLp31LSLs3lf/zTZUa6EQez9c3039ZxXBIYzsnpDCZ3asP/ZL9g8//t85D/5s3P0QALnFpFVhwp8y3FsaxDH+V9wG/K6UI4bTyRZFuoiRUq7StvrGl2knJ5shBXuRN8iRiz323UtgqLIeKL581Nm;4:6e1LAhEuZYippW2Kty2tJyKBxDRFmifYHoISVPITklyAGlFm/aZzwR7334q282Lno0LQMNwps4u54K6OmzURVYMf2B7SGH+GyHeyJtD94nk05/UymIkkVaySvywgCVf0Y4nwbBzyHYrCiq/SPGfF9OxugqUdGDDpRImEobxzol1wNtFAiRoqBwArQdVWGjQB+DiNJCslGWNgjbvbo+F/BImOSYPhFQFwvO2ngonmcgPeITnV7iKnCqnZvRv5TMe7
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3805599F267DF7475F4AAE35806C0@SN4PR0701MB3805.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3805;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3805;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2906002)(97736004)(69596002)(316002)(16586007)(47776003)(25786009)(16526017)(66066001)(36756003)(72206003)(478600001)(86362001)(6506006)(6486002)(81156014)(305945005)(50226002)(81166006)(8936002)(5660300001)(7736002)(53936002)(8676002)(48376002)(6116002)(450100002)(6512007)(50466002)(50986999)(3846002)(2361001)(53416004)(110136004)(68736007)(6666003)(6916009)(106356001)(101416001)(2351001)(189998001)(33646002)(4326008)(105586002)(5003940100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3805;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3805;23:i5euJVMAkNI3GF3vbAMW19HI5SP8kBeru67wSS8?=
 =?us-ascii?Q?EC8hoWyKj1vZFiL8M51Smg5gYI2S/L8jlHeR/jMwG+gIiJs3QQ9g5nZ3bG8z?=
 =?us-ascii?Q?OGQyLQMN4Gn00kXulgQflsELoKbnAy7qKf4GxGK+XNmuskvPgNXH4NDHNzcf?=
 =?us-ascii?Q?1xsMoIIvY33Xdv/xaHBvLApt4r/eqYiC33EXtCL4MQ5lWgN1pU6BsPQj8Wym?=
 =?us-ascii?Q?McmvOu/9IGvHT1wjbjh8NVkcwuWuvKPq7HSSH3UzB/sP5pcsK3gE5ZzhTBmU?=
 =?us-ascii?Q?Q0bVoODXueIqwztkJeFYjc/PkKGBxHNwwHWnju5veCvx/XWBl2B+qPL3LYBT?=
 =?us-ascii?Q?+vSHzVl6/F7r/nVLXu+UIpv+T6rIVzzV/Dabz9g+hEMmwTdiG6oS81c/+Nfs?=
 =?us-ascii?Q?7w7le8RgjVbZw8sQ8jWR3odcpdo+rwoi0XYPwPVLIdovVmAK6rJlOneUe0rE?=
 =?us-ascii?Q?+JXK9prAvDWOqPzLi3rc1hGphWTvMGokU0CLoFUJjS3cZkeL5AX59z42/je6?=
 =?us-ascii?Q?kj0fvtO6h5VaIFM7dYUeqq+SgYw0CIARMIU7qgf5eXfmLf4hZR51WD5e4Cjo?=
 =?us-ascii?Q?OD5S5OqNG/fU7RaKTW6vikrPJN6TbuN17SdpUzGQ17NDQGN/a1IJpL/9YDMO?=
 =?us-ascii?Q?izVnn1eEdYMJN0WFlkxUNcF1RmOKAkzN8nFRXQnoSfaC6faM2Y/b5gsIXFa6?=
 =?us-ascii?Q?e6tBy46ZREoJ76XHZtgC9QpLldFgEnO3DLrWWiJS4ZYEUgQP0AckLCZEGRf7?=
 =?us-ascii?Q?bpBGWWqOn8Td63VpONgJlYF0lp4eyVuppTnds845ww6FWCXpYneDLzEni31w?=
 =?us-ascii?Q?VW9r4Md9GB4j6eVAuCiOcIXuK9Sd+uWzqjPriATXgGrY/Bl1iV7oLv5mbWHK?=
 =?us-ascii?Q?h2b94CybQAC/bUpr5fu8PKTY7b2v1U149XVVeOjuXBHZ0KBferx/J9Ui8+Yq?=
 =?us-ascii?Q?algFz+/J8dF1Fg5sE0dvjEUJuj7PWzKcE1W/qnKi37OB68ynU1HG6QIoVTDo?=
 =?us-ascii?Q?5w6cn7LEss9WMx5aJuw/SaRdRMqmY0VNR3hEDVmCevtIkze4PS/Q16ZVCQ0O?=
 =?us-ascii?Q?zFmyFu+kumZRy0eFbqybjC1Hpo+dituWtC6RifTgUU2ZfeAv84Iu4QzCeFIE?=
 =?us-ascii?Q?kOO5qMTR6Oq8vasNkhXA8k0n4kbLJj17vBGt8arh99E+jrOeiqQcKTw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3805;6:itsNJTQccNVIn8n/M22CcRq3eDsSOhK6koSeMFyhlfF3Gr1F7rsaspamsamyYQtQejjV/VhQCF6UIter+oVLjAnb6PaegtB56zphHZ5UGJXYfX6GB3yXywK63ytc8UWEsAptx2tGtg0TAi/wrrnEdVE1JcryQ1LKSNoyD8CG+WwhPj2qMt3qRjRgpPJ1FEg6cMAx6U3JFopRuDa4yTGCBQrMkxJn+MzJdKPs0UYI98WycStIoD5/jUQyHRGT1gOBbE+ZOsMHDdNEIFYxz6rt/j6Q/toi0NjHJbNzeG15oQQIKYn45TjL3C71Y00DpF7zw5eY9dLv5m3tCwIeczJESA==;5:BElEE7bzT28ezDEZ8wcZqLiHoRIoJ8BzyeTj2jgjRYopM/pYHEJfl0UjD97nauNNi8nx+ze+Ea5gLobTZTyeEnrnZalFHDr4VyOTJNa+USvs4GXEpi+5EW1/Xnu7FUeEoYagriaFME45dhPugBsqcQ==;24:eLbj02SvK0xCYu6mrECTui7ZxUXurl0/6ak77G2hWnmrQVO28HYP/g09Lo3dSelSDhRC2HKgp0oSZ7rUKaE6INLjlf3TgyO9YtM8l3p7/E8=;7:n4FtjDaUzdGW6Y60Wb4sv9bLfhMVsFhck3osygGtA7ioRgZGOtIuHEXfrlRYogTRebkPdYtAkrGMGuiyHNfsxSq8uR6uiJOJPJThSPCvCXbAcccy7FoysHf/ojenUXcLXdl1cvVa2soUAyHf1u9Gii9vYvUHUYVBQa4blX+q/t3nFlLsQVFHRCtsytf7x5tRgPHd2f5wzaVmZA2gCWcL32xyQ45HMbTzSbJFWtCcqCU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:03:25.7171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3805
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60011
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
---
 arch/mips/Kconfig           | 3 ++-
 arch/mips/include/asm/smp.h | 2 +-
 arch/mips/kernel/smp.c      | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 48d91d5..ed35fd1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -915,7 +915,8 @@ config CAVIUM_OCTEON_SOC
 	select USE_OF
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SMP
-	select NR_CPUS_DEFAULT_16
+	select NR_CPUS_DEFAULT_64
+	select MIPS_NR_CPU_NR_MAP_1024
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
 	select SYS_SUPPORTS_RELOCATABLE
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index bab3d41..5fa6c85 100644
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
index 6bace76..aea84b9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -48,10 +48,10 @@
 #include <asm/setup.h>
 #include <asm/maar.h>
 
-int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
+int __cpu_number_map[CONFIG_MIPS_NR_CPU_NR_MAP];   /* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
 
-int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
+int __cpu_logical_map[NR_CPUS];			   /* Map logical to physical */
 EXPORT_SYMBOL(__cpu_logical_map);
 
 /* Number of TCs (or siblings in Intel speak) per CPU core */
-- 
2.1.4
