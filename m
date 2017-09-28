Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:40:04 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992338AbdI1RjHW9HnF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=noMv9nDD9kAs4XScsezM9c+xVB0JMldinyTTSfnqH7o=;
 b=QHpYXLSfCENboq9jnans2xR5RO4wM5n9fDMAPcQnm5vbDA70L+9/0gyTGWqcAXQ7Y5tZHVnGrroaQIKMk5KJiAtypx/Ov4HhIS3T/LB63xZpGk8kaV2aVv73o2bZajOYzyeu9xmhWXYPqEHHT3+SPxllj6DRTH7+9wszUg0U7x4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:38:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 03/12] MIPS: Allow __cpu_number_map to be larger than NR_CPUS
Date:   Thu, 28 Sep 2017 12:34:04 -0500
Message-Id: <1506620053-2557-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb288db-d815-4bc6-2169-08d50697ccad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:a+TPiakTW1n1FLqDCwi4UeDJmLWINn9lgcB9mPXOQBqlWzoIeGkkVCWNRSw40v2zV+JWLoZdtW9iWJtZJ1O+G0ZSi32NgdiS7oPNfB8vqhxOP08d3AcMQ8LAR2DdlsN73oEGBY8b+b2SgzaZ51HKqbqewFcbkieZX+9TSHL6sFT0XtjDFMnNgqoFpxUSShVhxCTLQoaLDGlqjDUEXf4KAFyVBj49cB6VhBugX8ZsWXyXLF+05GfE9+9mjfX6deOS;25:sFvN26JQ3N3dF9C5Nq5hZjriq14SVb+I+1s6zIU6Yos++tQaeDBJHcyERbJA+2QSpQz9BDa1UspJFZhC42+HiPz5yIrbiyyVcgc9T4nmnJFdWdwJyppac+wK0KIVY/SswiIR71h0GCgLpC8DYfo553k4X0K6d+RSlekX4/+lgUTyoPlHR5hdA2QNruehtBE2FEDFrK9A+W056BqSQxc+7+RlaJLrv9/+LPgzfSR/JDDSKU21rJ41cSopjekA39IFwssEWwiJDnlF5RHZUW9Mo0+Tl/UQlXethLUoBoRyyOj8Umfi7b1VBYwCoAScVYmrEgoH/+GTH1K8L25NTnxC8A==;31:KO9Faitu1j2XPvcTb4K3Y8Z5+RrTptZr7i22L1locVX4M2WBhgoopGK4jvygf3cKIrg880iHb+LnIv+1LRrbmOPTOuUbJylikkrcTLTT4WT5bm/1zBjSwnvNXdp63OYhdAVx4bsqR1rHyFLeQ8Xo1ORj1okjqbSfsF/CYhjlhSw+CfS2dndfEeDPSF083GnqGO5MvCJ2FPTuTy6Q3PRUhEapwuCw6IRA/EjZxVjiCX8=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:LnkPT0qNn6pXf7iki54HLaJNmwfv8qwyoA1BJm/5l2cQSnBIuGpipOiiX3FNsXerPpiA5xjrNLcwMj8y2frEo+25liQ6gY/DxyWcbgQM8VGkmh5hnwbmn2bNBaVOUluoZ1kT20+J7vuUsU4noJuzPUIOz49lOS+fdawlVnknNGSfhCDnYmWR6LrIfO8pdQ0lUE5X7aA+jiucjRd0s9VhwL/5+zobhINu3mg0P9evjhTdQZs2ThPbTef+P3FxYMjPVPIaPEmykJi62J+0V0rPRpNtrHsu4Fl9NBY2ifSqDOwqT9yg+tySr0fbJ9k9oFrzld3ono9OxJNt0Y9Bohg7aiEfcg4tRLcPfZXaZsnScLibeiDQQ6+z7jPyuHIGB3xT/ZNgbU5cuKiBHYMUDFMeMANjyJzCD0lxv2I3lCvWd6K9cngrsV7mU2g6blKqTK8UT/I1qYVbGfO/pXCoQKcF7pdtv+d//VSULRuMH5txHflYT12opy1oSmg6sF8rWU27;4:5LRKaCMreFdNzidXGnvGB4p3w4pk7wTaveePUSJCVSOxnjAnTu6OyleZDjMdWVMhKOboGXvid3dJ9Hu/YKJ4GwVbPudOdzmeQ8WbkkKkLrE01JlNyz5neY8NK72Op1zz1JiAjl0BCswuNPEl64dd5pyW2o6/S9m26qH4xqaOteZeNq7M0uUHUlBl7dvYo66qXKTZsP/wCMhYE4dlifoEjfl4q6r2uALRhFGsHhUliUbRZJw9jakNDiKTbD8ctbjU
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807331536D15115A199C93B80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:BDSkSR+3YvhDf97wv0SiEREupSlp2PK3I5PltET?=
 =?us-ascii?Q?Z5HcBhKIphNlL36tBd78GHxPayTdXxAK9j5ll3VolwtcKo/+pHiAC7RvHrD8?=
 =?us-ascii?Q?5FZctYCFtW9WRis/Gu8M7MHYZgWMw5TlYb+q5pzaantSTOGavfCKrc4G1JOx?=
 =?us-ascii?Q?UouoEJy+z0cNCA62fgj1HDVJvXJEQvXI73/T03mFBSXtYsxsO2J7zfVv5+LG?=
 =?us-ascii?Q?B1R2FiCo0BCbusNY/EHB0ioQPiBPHOTQW8/v630KZKrrO12oXpsr0CnzonxG?=
 =?us-ascii?Q?fbt04hZLaMHQgDjdKCr5MBmVU6czob6Pk90LvDfvK4cZQ47o1khz6nzX7lSB?=
 =?us-ascii?Q?3leKbIfRPVmx2R+aSGDZNKutZxU7pUeg5vSardiMMMrq7KdX4sEXaQQtrBez?=
 =?us-ascii?Q?ORv4u96vl6PS4yoj8HrA5D0fA4Q+5lwB2y95Hk7VvP/PC5FWrHIbfSr6NXP9?=
 =?us-ascii?Q?GA7lU/moDmtq7EdemmiuNoMqgjzyE7AjYFegciqSgjKRovftzJKeG+61z9BB?=
 =?us-ascii?Q?k0zipF9Q2U3ACHaORHWU3VtcLpEFH2XiAW6FibO4gL3rz9wRPWAPFlsDpTse?=
 =?us-ascii?Q?X2i3Ei3ZT0TNgIolRju1Sh1ml3PckJAp41uXGhL+9gUBNkYdtZkNwsgZWyq/?=
 =?us-ascii?Q?8Mv/M0uRbysYjs6C/Ediul85AdUof912KlnS2Johd3R/exHvLtJH2HFYV0S8?=
 =?us-ascii?Q?k0rHnT9+YQXBowfFQFmmXLg+LN4YPE33YPBoe7eZpxqQ16Pr7EbCm8ezzQ5p?=
 =?us-ascii?Q?uj87hdIsOYeoiHGceWPULk6Tgt6kr7tb8VSS8qSl8wTN3lQdcDI50ekcVEE6?=
 =?us-ascii?Q?QdjRtttg+QMB9DCJ9k7JgLvYZMinKQJOOHGrYPlY3Xi/5X0YQDqoHHbYSZn5?=
 =?us-ascii?Q?s+Gvx0IGPfYk9HE+pUc1yIB/LLXlBQRgxiRKEm++1OVD/l3Rx3IIqvR+Cra2?=
 =?us-ascii?Q?omUrjKi5ZRmiCJ0K8JueQlvdPPRmuSJNeWpc7+bKY8lfQpHwm6gVwiztkOZY?=
 =?us-ascii?Q?cn6XAMN5m/FLbnvK9XbJ1IKIiuUv2Bc/omcxTjCpoer580y1eLB7ZUDBAVOJ?=
 =?us-ascii?Q?LvhV5ytEijQ4wg5UFfC/QNrZ3KzbMZpd70MFqoWHeAXUQ+MO4IYzzbS/EobQ?=
 =?us-ascii?Q?rvU3c3O7JYwHm/MC87wj3ne+aAfCGT4FQJdcpWDgvctShmLiGWgUEeOh7V74?=
 =?us-ascii?Q?qrYRccElwiERbZLA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:u8E3bMTqo55Pk09zXG05dWdOJ9w6EXBADbZRQ2KSrrab++5YVwVA9wIsGAd24e6ZQawBx63O1nZ81zXLsAYQPkVMA5oBD1slAuIrAwwdlXKlOvYmIvcmvX5Vbq7xTkT284WC1uYdkLeC8wqdbON2dXOhch7ISdoyaudgBZM02qoxDqd66fCgM+7z9N0Z3fE8AEddwpzbWTUF5H3zA7Z/2RZJjeEM7VxvH7tlA8cvfEfOHKEp6k8UTDk7hmvXAnlKPCjQ8Ugzt+pCQYSXOJilV0t02Qwl2PcrGPPxAYJaBP0+iOfHQ3sq+o6wiVbw6Jx5Gdt4Is0Xueiot9IRmcSyjg==;5:KI3ED0kUFfP7YcOklIWTBquxbQ28VQa51WGFyr8bvr2he9Rdxqh70uRCMd0g1o6XMjzSwATwoZiQJcCJirUcGkbFBqobeXrmrEtiEswcYgZZ0OALBhCYg/znSnmu14dd/rKze6nyMIUsffvxSHy6ZA==;24:ApZHjm49bf6We658YhO6NrBGEWqNxa+j8qJzNhZu6tu5q0ZtCsi7wUR8G8CBeoLoDQvjr3yFWNnDGUk0RuCdJv9BpaQQfDyt0isvfyA0UNk=;7:7/o2bMCwjBp80hXeSFVn9cVOBapI9PK3XYy8OfRO+uUEBrGNZVoc8JJWBev2mKGj5abSX6pFLx2SiI+OGxtfwrHOhKlC5rb6XFJKQ04JZQAOtVN+aVrEePsMRfXT3Vf0gZBPYFfzKVYUKdmWfGPGwi3++vjAhtQ55sW3WSdtXa9ehvgauKAWP6lqd7J7+xhkJk3asbbDjtwfqD9q6VxO1f+WlF5NyfqRmeRyc8Vb6Bc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:38:58.3394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60187
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
 arch/mips/Kconfig           | 11 ++++++++++-
 arch/mips/include/asm/smp.h |  2 +-
 arch/mips/kernel/smp.c      |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4..da74db1 100644
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
@@ -2725,6 +2726,14 @@ config NR_CPUS
 config MIPS_PERF_SHARED_TC_COUNTERS
 	bool
 
+config MIPS_NR_CPU_NR_MAP_1024
+	bool
+
+config MIPS_NR_CPU_NR_MAP
+	int
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
index bbe19b6..5576888 100644
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
