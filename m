Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:38:52 +0200 (CEST)
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:30624
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993918AbdIOReHQnbjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gpeDUG5N2X+RNMhlQDXiVuItxOY/5sRUi5cSpdjL4Ok=;
 b=etir2nJlo5IUSxxpztEIfcnhAty6xIy9H2qtyyg8tCuEAstGOBLGw6QTqcYNbteYREyKnE5jpfloqijF1MhAOvogeKPuCy5GX08gkno1Kl6QcpinGat4vAx4AmIsGMF1Xl0co02mrkV3J4cQYsVtKGOMENlby2JR8l2kNul3vLI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:51 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 01/11] MIPS: Allow __cpu_number_map to be larger than NR_CPUS
Date:   Fri, 15 Sep 2017 12:30:03 -0500
Message-Id: <1505496613-27879-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f5d81d-77f9-4f97-bc63-08d4fc5fee7b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:Btxx7J2T8XwfLM1Ph2Qhr7t2n9ZML3OCq3XzOK8biL13DR9gmmBHz+pE1c8rwojZXn2m3H/u2Cm4z7JZWSVc7fu834zBmZDfUfK8orAXR8fs+DrY8teVSoh/JoSVyHzGra09ZjmQSxE0rEaK8UqLejAMMHRtt73hhfdCv/AepHFSBCI5RwXyF8UNDslJ5Adg4uMJ3ERabDD45kp+ohLgT8GdCs2aom6NLYdd6dUT+rvhkUF/40CCzIfBgD0+L2O5;25:jNtpig7U96bncSsxURE7OipRxMHhkQa1TY5Do02u7WteXAnVjEbml/xRYesvW9TiDMAiCW6KabONvISunaXCiyPADy9G8Mbu9GhEIeGV1IozKFMfD/OPatyhIVXqk49l0Ci0zN4goY67mDwrMEO0IQlitpDfMd451VhtqvkEFGO1UgYZ8dgWW9EkgNkUyX9pYVkJwMGbFUAoW7bBR0j3x2TKKoqIA+AKPJoz6mKq865QMD6nEvES5pd4yXdh5EfdYZ+Wca65+WXTy6zEWZbaRfdi9wCT401XNcEUKgYXRhtG0sYtkgk4hXxci0W/fd+ZyJYFBdAIzHBsWQx6MCQZSQ==;31:IUQFJWjomAbwF/l/Z6VW+CCGUedE2CTchWGMdH9HmknM4vAQlRJbK5OSbgIOGebmMSqYDcU2t8xixXlY91wkzFrhttrNtmuoUmBZWJ6f/taOTBctafZ+BOFSRqYNgwNL6wyE0qNhEedbT+U90lQR+/yf31m2Ur9N0UJBDNvfa3Yo5EL+XmkHGMROa88As4jOTzejmX60a8Y1JRYa1Piaa+6hOxW5OMJiL6xX+BOIiKE=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:9sIOqkdohzb6XLZ65FYbq1siC213iUTc9bz7PFdsM7TlYH17vgJNbvc12+QZHQx1WG+hXL8/FG/UeWuIGviKGchgt+frpBkI+DjfyXineA7jVlLSd377VNuhsr1BOZroXz5E+cOTLpSwmSU22M/eosr8QH+R1d01XWvl7I0K1VDk0EryPUPMn3WIp/bXR47NujSkAmZMW1IGwxBHjSrn+kR089hd/CS75OAxYzQa0KzNkvhmEy3oHPcedj3lS5EO2C4k/PP4yV+jev+CeWWDcCankRh6WowjO6mgYH3+JYn5JIOyl5TMF+n0+t6UV7UoWszBdOl5wuKzp+RBWLh6GLxB5kIXDuDapSbFJc+IYCd05GmyP3LExPOD2p8qFQfv8LUwHsXKrOQOs6RWGHpptcdzne8AodcVA4mAZwkq4qG3YoAdYf3e1aioSblbqDAkwbNYbpKXPT0mGVn0wqsPeSkjFiwU7zF53lv6BK3kQ3ZwcN20gjdbtxkBgevYcynj;4:zDA64tNW1NjQuyR/cS1jPvRJfNMYJjxPSqogaOpM4Ko67j7Fqln2z3HyMT+ITPqdCQoa7PDrEzyvY21ZfRaIfCA1Eb1Rx9FiVxfNXkTKehKsvkdmSxkIoZdEUVvGRzryzKBAbUgQ1SXYsnaGe+9pVzPb/QVE614boQXEHsiFZmQqNwq7A+ivx7uovHr32j11aQI+8pd8vnsZnebMO3sjmPl39B4C0HGYKyZx9D1RA6XxF5oytchqShzZl5/gsra9
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800BB48420C14B472A8D5E0806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:iMGC5v3u6DtOh/21X8wYj1C9wecuV0AHYjCY1PJ?=
 =?us-ascii?Q?oTyPWmQOFT8G6UbpJuRdN/HCtu/itVD5ixDlwu2fiT5erfC+gwR0vE/XrdmL?=
 =?us-ascii?Q?HpVrdfWM3rQIf3bItOIH9qdbACoDG3LqLM/30mhwGoAq8sVyPKk5xiIen2MU?=
 =?us-ascii?Q?fu0+cyvudVi0rGScutFnPUkeu8S9vMPLWxmVAOUXapYM/VCK52UEo8GuF1Bf?=
 =?us-ascii?Q?6NW3HLYYBn3c7zLsyyGEEDayFUbOsjYm72cQo9eQcDB230qQZm7h4zwi8Gj3?=
 =?us-ascii?Q?jwQDlwo+AZLHt3G+itnPE7kWgROf81dROW29Ep3yJPzJdy4zuud1z9YprKfU?=
 =?us-ascii?Q?LlPqDZgExTl0QcNco4zooHm9bJdq4PmAMO7XdsStJcAHSNVIX3BBwQgrfnH0?=
 =?us-ascii?Q?0KmtNP8MVICFZNCKUPMQDWJD7r062LS2m6DsxgPx6LRQ9s8vEVD/VsZYM6au?=
 =?us-ascii?Q?6USShjJpUBNM9XElBeQWWBxffWLLjmEAYhdSgVZ1+hp0mlamOaY6YK5ZeM7d?=
 =?us-ascii?Q?w+nikwMCXHIaSlOvgq+Oe8MsQ66cEEX5jB6JQ8RIOD9oSf/mKseCn45/6Jwo?=
 =?us-ascii?Q?/xkfHctVICuEW5qQkADUwd4Fb+3Nd+XFtHtE45JzJqlAey+PAZwRaR5cQQWj?=
 =?us-ascii?Q?RAdYza6BNhkIZYzDmIYlow/n5jECejilSIQtSJ9KZismRG/q3BYXzpQvYoo3?=
 =?us-ascii?Q?NRiSlwCYC2rLZMfE+H4QjN4qGPAfeuxIvTP9rLwznp1CpOPcdh+ZP79ZqMrN?=
 =?us-ascii?Q?CGFtrGbTBQLSVRCMoEbc6XHMDcvtIVkrfeqvjcHH5PDCFWZlR7ELMIzgPnjC?=
 =?us-ascii?Q?/AxXcQQ0nfSJu4sOMLW9ka/ocNmfWFcdflmZJ3acJw7g75iYGWgyubHRon1k?=
 =?us-ascii?Q?/Ry92Qct7ChXlRZefarj+iCVdKndQYnvG3yFpJiaDHc0FkgZtdpN7+ie9fbj?=
 =?us-ascii?Q?JC1BN0v8Z8AdupAVX9sGZtjcgQ+aaYxgzHiKCNgyHwvrJOxj2F/iZFGIH23I?=
 =?us-ascii?Q?EXPmJEHBK32t6+aWAFVpVmrDAvYW8Sx7IyIX9vxtHxJkQfyyFycqRnBOzXf+?=
 =?us-ascii?Q?ypzFTP9IznBzkBHzy+SZ48KSYjTQhWqYyRE9cQic8zbrlNix/dVd1SO1MrG/?=
 =?us-ascii?Q?hn2E3UlrrsFlH9p8dW1imoFdqhUgTJu3zJn3y9XDzR+oBfmGdJwIhkoripTW?=
 =?us-ascii?Q?tsa5OJSh85zcET55fVo+PC04BVORz3yR/OtmE?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:2z0+F5Xf38uzck6Q5P9DLnnD0CIgzDfYekicoVKlCRUt+Yo3cwYGdhivZa7uTzxl11t+6zEwvQQfsyWXLm8216tCUIS4e2Y3/IIygEKJojB3CqSgh7DBLi6Ni2if9ssdOVWynSHj+YNyw6vz0lPf9nK6VErfo/FjAWYdtEKPoB5Deu7Y1UYHLERyK6ituMU5S+mv5S/xrp2LJlnxky+rqJ9jVTiAzof9KCpkeFJ6rRKx4SfejoCP3o2dbWTlcLssCng3Z1NdUlAST7tRDG2dQTAkdgC5fFtr9KfbmYG0IDZDV8Dvbr7MV8V7KJhUcJrcRJ8EYrEilrmth9A0NFaa2g==;5:1QQmbQ3NHg09i9vK0B6mrC16/VLmkJhvKPyioUouR+Ouj3kiy2AdaPtscmwXrHe/NkHFaOAB0qTYXvKIvoHxhUhCE2Kf8D8d7SuNVhCr48iJvGZ6K2rB3+YgavJemNPCFcbndLtHIPI4/c3x1ulbXw==;24:6kaR8kW7/rxhV7nLjxeVW+TslxwwcQNDNsI6hXfa5FW+kUpoV0sbOmrs7c+5fhDzlvEHgktZSxl3FvmFdmYuDiDUn3j7ttk2gbw9+2JK2PI=;7:YFBlBi9FvCO3EzPijR56A2zxw38NRqyZpKurR6ip/2l13feiqfxa6DQwENHe2BVRJfcgeZdF4RHx6PtqjFAzSLBaJmbusr4rBY2J7N3EVecCJSiv7Z45ZbYNIzjiEEWRv0KfHCx31FPveCAZ/LJ0q6On/4mnyI6JUVvDga/3WTa+0cow3mLg3NUyYQTk8EMZmkVnpNVTS/t23tuotU5sZo657fZ+LTMf/JW5Lzth0Ng=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:51.5980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60024
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
