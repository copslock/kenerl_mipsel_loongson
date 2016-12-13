Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 21:25:54 +0100 (CET)
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:1697
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992992AbcLMUZrLCVSv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 21:25:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XiVsRDxvrBi72BBPxyeXTGHz6ZCi0ITy77rinB6bD3Y=;
 b=T6/if2DzO1Q6yReKatnCPGm5eYfB9+9WFmmSu3yBU3TVIYRB1N4O5RMqTpOGjGixZAvqFRnjWOlP1vyW7o2O6S4Tk6e1uF+ZwakBGQN+cpH7AYT90CL6ow4n3xehuDIbzLF+nUvBaMtbcDOxDxt+yRrYT3s+FzcMTSwYk4EKNmM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.771.8; Tue, 13 Dec 2016 20:25:39 +0000
Subject: [PATCH v3] MIPS: OCTEON: Enable KASLR
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <086dba14-cbbf-5fb8-ae39-bfb2f725d91a@cavium.com>
Date:   Tue, 13 Dec 2016 14:25:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR17CA0057.namprd17.prod.outlook.com (10.162.85.153) To
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147)
X-MS-Office365-Filtering-Correlation-Id: 8d7e644b-12f1-48d7-b726-08d4239634ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;3:5vlx0+WNBi3QInBd4CIYgE2BCqUVbel4X54ya177M2dBOAzmQpA3QVsgxiSljUuBRktTVfcb+NzZOjOd/iABXG1UZak5Bk08j/O3WIafK//KSJTKdidaaPG6IdGEas56QIgKeH/8nfrvafkiaiHplBM23HVLBlpMCUA0QmziVpoaxTR1O+eA4i6vJ3Z/2SMLoVXuRv7lL/ZDrCk5373jHeJoJxpe3JM2ETx1VefXaZbLDwtzFyMUcL6k6zRNEV7iYOt2kPPvYpssfIWwfoc7qQ==;25:5hBM+uGdljQrbONWVKeocyoqI6pfbkhCdEOnlYhx9AZpRD26REwkfFkmFiGLIdsCVQE4z5fhsJdv7OB0k25x7RAtYgtLWPUkiJ9H4D4pZKOkOnheMDIpx++tZp/4LhUgttFI1Zx9k4k/+L3q4xUq3MT8G6O1DtEuPaKai3yXIDHv9susrL5sjx6zwQaHRdN7CKyjtRno0rFdmlo1iEJRYRbGjVSZqF2Iu7FlS4UizXdgHOotZ94MkwAukUQEBsynGqF9zY5HryoKenOK3hub8TXyLh4jsMG0ut60ralMCbnNi8Byw0gbtAn7Wd5cFeEDe2Zds2K0wUJxylZND5/scGY1TC2qOM2lOMsjbWOzT7llRJPvI6DIVmvE6ZnLjsHbMIfzXMZhch+NiVKdFlfC4ItIy4r4Rtkwdjvqp++glICVjeahG0a8KGRuwfCuHjL5n0UM0CATtohI42VcZat01A==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;31:ViK3RLgXvgfIHHpSlZp/2lkmxnplPOqvKA5d6DW0o/z678jSxNvz0MrgeFXmOAdOAazn8ITjLicNfSTj43N7M+18bDlMqv7TfpV31X8EMUA3RgBe1R88lvuPlUv2oD9p87apS7rQWFA0AKvhnHbobyFlPaGNYbAXWHAyIaFJ+9LWbAj8jO66rJ/2y7u4JF0tCfcjPz04oVmiIXfJNyvkhgivesiPAwRR3ea0AXrm63wCX5EsEf87o/fSmVup0+3QHGXYViPDwmeezbDTxvXmvVIj35t00qP4Jp2u1TvVOYY=;20:e827DzP151jRLBJ/KnkEelWttAjP+xrFyKYu/QPBKNWgPOB9jdwfahL/sGyLkHt8wY+GJ4SeoWYRTIF1/won9f1RikzGvUiCud8IZ7asbvdHQMzYiTC0GctdDrRJ39TQgb5fNgkoNx8cUsliZKApBaB09Mk6kc9Mu5GyUfDttYHZrxEDH3Q3q4sMCh8PS+1W+y4qeWXCQZHaY1ElX9iUM+sZuzicnTwZ/aVGWXmba3eS8kjCmUzprTWYcp3RNFhqyrnQ6c0zCCP9yHi7ET1vD1U9oH3mFoj+OmaYZe/d4CW0QrsUEkixu5r+2mXAvn2QxqH6Ne56IcAR9SRITrF9DJWaWECaiN8UUMMpjNppa3hHhcgR+kqPfpGqQV+QA3Nk+cKaBngcObVzvPDtbVn2gZ84bu0R6KMT905xO4ivGfWglFyCBgDZn0qNipw3bHB1gHt65tuGcUMc59elqISFA7/7mYssDsEp812+29tFxnZ/9ymP0f2iDEdenAucDiB2
X-Microsoft-Antispam-PRVS: <DM5PR07MB3209E89E505C6F7AC72ACD1B809B0@DM5PR07MB3209.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123562025)(20161123555025)(20161123560025)(20161123564025)(6072148);SRVR:DM5PR07MB3209;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;4:pNxUZ2fZk20WrcOyIRXjf8H/H2SWBRqYt7O4XyvV3ZkErEe89j9ySOIAn1Lvj/1YqF6jb3lFw9Ugwn9hgTeqyaUbSa0u5n8daBEgX7dvpB7WArS191oB1q6gjon5n2Qv27bY7T4iQRfZ2hjf3F6sq0+JSjF5kNEvCKX3wFQTKSzIxREtAV38c8VzqiLXTuOS8uOyBNOSZMJRVfh0xfyP38zjEBUJiyhDNCD1ktASWho8p/VuF92Bjgt1UFq62B93Sx2U1FsGwAJFGLJcy+aNeM/HyHf3krcqF0QLD6iQe8kaTIbTqDw/4jnO8wXqf0/ZE6man/zXeSHB8jyzvC/ddoN2pniutGBMzDnJpbj5zLKYCCeAWzWkuz6Fw7ZCxI8Dnh4dks0tORDXU7vZwVlPj1ezz/d9GFwDuyNdT494VWMTD/jqs7S8czr5eVClEGY6pQLos0wLfoS8mGTV3NPfZKvjKoe/rBL3NywuUyVwYmp7jgQgqDxUQE9xWPaZL4rBei1uTjvKMEA68D9jQO+1DO1CMaY/Kc0FDRH5my2VRqDgFnxvCDAgAVG4HEvYAqK7
X-Forefront-PRVS: 01559F388D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(39410400002)(39450400003)(39840400002)(199003)(189002)(110136003)(2351001)(305945005)(6916009)(23676002)(86362001)(3846002)(38730400001)(83506001)(230700001)(450100001)(65826007)(106356001)(6116002)(31696002)(105586002)(33646002)(65806001)(47776003)(97736004)(54356999)(50986999)(65956001)(4001350100001)(66066001)(8676002)(4326007)(6486002)(189998001)(7736002)(90366009)(2906002)(68736007)(36756003)(81156014)(64126003)(92566002)(77096006)(5660300001)(50466002)(81166006)(42186005)(31686004)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3209;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzMjA5OzIzOjdPZmRWVWRRY3ZNVlRMMWJkdkJBaGdaNzFy?=
 =?utf-8?B?Y0dVUEhBb2YzaDV2aU5nakhyOCtEdVV0WGFGRWtMMVJiWGNyZzlGcmVXTXVz?=
 =?utf-8?B?ZHp1WFhQTFRobmEwWmhwT2pBMUVPMlFBM3pZYzRDcUhVODhtVDl4c2VzOWhZ?=
 =?utf-8?B?ZkQ5S0VqeVc2QmNkOWhWaVQ0YXFQUXc3bTdPampHcWxsVDZVSnpmaCtwQ2Zh?=
 =?utf-8?B?S0JlNWh3c25LU1BnRzJmVXJGak94YW5uTXhBQW9mQmR3d2pkNjVPNk1zMWN0?=
 =?utf-8?B?VU1pcjJJNVluOWl4bDg4dlVLdnhGckczTlpJQWcyRGRMemh4K0ZobGcrOHdo?=
 =?utf-8?B?dDRaUjN1dEpMYnhjYzhYS0RXNUpKL0ZSVVl4emZxMkZWa1Y4WjJySWVnSXBC?=
 =?utf-8?B?Zm5ma0kyckNDeVU3NmcvUTlTTlhIK2I4c1hvb3J1dFpjcExFWTMvaE1WMk5D?=
 =?utf-8?B?THBNaEUrY3hDbjJXcVJWbzdaM3orbzNoRHcrL0IrZEVVWUtGTHJGUnJBcm1U?=
 =?utf-8?B?ZEk4bGo4MDMwVWF5RVJCNCt0RVBHWExEUzdKOGQ0QmEvZTE4UEIvTVBtZ1c1?=
 =?utf-8?B?NFJOMUtzcEVsYlVkb3V4U3MxL1dIT2FGWThQZzFlTmQrVHFKcUhDdEFkVnlF?=
 =?utf-8?B?N1FSaUJzMDlFVU9DbGR2OXErVjMrR0VOWndoekxVTlZ3V2RGby8zMkdreE9D?=
 =?utf-8?B?cnpwYmpXS0VYeWZmRi9WMldtUms5cVlxRHhKUUJPOGtaK3NxK2Urc2ExOXhQ?=
 =?utf-8?B?MXRHQkRFSmpsOEpFcDZ3STkrNFY0cFh4Vk1nK1IrWHgyNEZHQlIwYzJudjR5?=
 =?utf-8?B?ZitEdlI0VW1BTlNZTFg0U3VsQVJDaVdhb3pJUlhUbDM5K0pFd0ZzdEtta01o?=
 =?utf-8?B?N3RnYW1UdFQ0SDNoSXZYZm1XRmpMUnZqZ2xvQUNSVFRkWlBhS3JnNzNrTTc0?=
 =?utf-8?B?QWRwbWRsWEkrWHRIck85TW5hUFB1R3d1dkh6aUlyUmlzeHVwU2hMMVY0QVRy?=
 =?utf-8?B?Q1dsUERzZEkvQkNFd25FandLYUpjd0lGY2R4S3E1UEh1YW8rRmU5eUVwSDBI?=
 =?utf-8?B?SkJhaklabUN1bDEyUEd4L1VCRTJJU09DaTNhOVRFSUdwR3JuR2Z3c3dySHZQ?=
 =?utf-8?B?Y3pCcUFWejR6Y1NQK3Z3dXpqd1Qza0tIek1hMkFGY3lwellDQjQ5M2xXdk5i?=
 =?utf-8?B?M0Nxa244V1hkV1JmbEo4WENkb2VDdDdSY05BbDBuanV6bGNhclNKMzM1Q2I4?=
 =?utf-8?B?YTEvU3pPM0R2RGUyWi9WZ1NDOTBmUnFVbk1PUTZUams4T3l1Y3h2Qlo1TmhH?=
 =?utf-8?B?SytJRWV6bHJlRTY2WTgvNGNFYWU4YTZlWWhjY0VTd3dtajZhdjgvYWJoTElp?=
 =?utf-8?B?N0llckxVby9ZU3E2NHdRU0FxL2Iya0x1ci9iSW91NFlxVFJCd1J2N21reHZa?=
 =?utf-8?B?UEtzaUlqMnJ3ZzZHTGRuRUlyNkMwcW5ldDVKRkFEaEx2Y055U0VlOFlWVDhw?=
 =?utf-8?B?bXlWZU1wYkU5T1ZxWVNrL2NmZE82NHFyM2xTTjVVVEFaODJLZDRTNnNUZ2Rt?=
 =?utf-8?B?WkUrQ1VEQlgrK2RqOXVvVWZZTVJqcWhEVG1WalB5NHdBWnNIY3RiK1dkYy9R?=
 =?utf-8?B?V1ZpeTlKTU1uQ011aXpKY0NHOUVvZ1U0Unlpak5Ga01rL0tKTFoyZEtaMGdm?=
 =?utf-8?B?WkthYytkc3haU0VVenI2VGt1ZHNKWU1KTHVDT3h6ZExoaXVtaGQ5MEZQQ2VS?=
 =?utf-8?B?d3hNRlZhdmI2YWxLYXlLdz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;6:FXjvYsCbrEBn4tY1T0tTjCoGPMq6sxuwmcYX2fQjyaZIJwV2tTtekXhztfKDrei8y7LoVO1SBauUY46f2Xf6fIDVmKYzGmG8K57MhzkZIvu5BxRuTd7PZ3T0gGZtiUpNXXZBuOIlwXc6RQQwAliEwTP5oT9MK9uG2gxmKkSxrUEpDkP7JyC2my9CfJKTIj4dngQ8asp33zOtiGV6pUrg0cZYx71Rkst82hJmze+CYYMKeE0I8X34fI2cPfGcAfm1K91RJH4MWKUoXGWMdlN+td1jsXqaF8V/EyjwvdlyGdIZP3s+WAUfF2OJhTUQoBZpVFEyaknhkVP6g8NX4tpRV8Xk0d11TQ4a/re6LaLT3UphkTu3ZeS5hqX9vDZrNtinmWmHXVu21iPuffUJXNohf/WgUUhA+icWAY1+Go0Mn4A=;5:Q5EdkDQyk5q+rnTJhEuaAljEEypwXaWEp+S2j9YqgZ9mwdGZLSdOhKSKKuLztfJgcDSta9u5AB6Y74Mmc8etY58KVXrGqimF/nQjvJsbrwfF63B+x9yjKIfPPAeX1bZs6bqeokQEAUAlrTKLZcSAyw==;24:2BkZRhMGRJ9/DIaZxXRZdyZ1WY7vzspJHKDOeC2oKkQ6aVwOYE4jsJ9eaPL7eKGycX22PfgKTOuXqLg76D2aksz7Jq6jXgkrcf95vuwkwtU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;7:iqssRbLs3M0enA/cekTAWXGWgyNSIp4Hb4KMOi/tejzLWofNce8hrDmepTruPOLOe2SFdmUC5iNf2W9GqURnUU904Q4uJlWgLz0UGT4XoWcVLh/kJ/D+6W9WG5+rSOqYgY7udP8dvooTpt49P7OjCixmHXmIurF0fMVwkBHU0Pzgx7uHjISyd+cF9KGqREZm/tuVA0oMNW5LGKmAWMRFAPElMaGnfwMy5WuKtdeTz24M510MWnfdLfvVAQWFloUG3oQ3MHNkkH+JwCvBrCnipXQRteydYRTuwTUa/Ou6mK9FPuVgS88naGEVDEKNJziEI72GLSMl/E3Pj+Q+hb43JtfV6osf2870oEcwKu/N2O/f4UVVRTPFWVWCY8iRON8SG6YqCIkDZHG6sbGSTJNd5ikt2JKSdiloVgnBfkHtr+KDKV6O6OirAvz2C6ll5qzA7Oo0WxYzGREuRcqOjSTYdA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2016 20:25:39.8281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3209
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

This patch enables KASLR for OCTEON systems. The SMP startup code is
such that the secondaries monitor the volatile variable
'octeon_processor_relocated_kernel_entry' for any non-zero value.
The 'plat_post_relocation hook' is used to set that value to the
kernel entry point of the relocated kernel. The secondary CPUs will
then jusmp to the new kernel, perform their initialization again
and begin waiting for the boot CPU to start them via the relocated
loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
Changes in v3:
  - Remove unneeded instructions and correct spelling.

Changes in v2:
  - Add missing code to set 'octeon_processor_relocated_kernel_entry'
    which was forgotten. Mental note, don't submit patches at 3a.m.
---
 arch/mips/Kconfig                                    |  3 ++-
 arch/mips/cavium-octeon/smp.c                        | 20 ++++++++++++++++++--
 .../asm/mach-cavium-octeon/kernel-entry-init.h       | 15 +++++++++++++--
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..65d7e20 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
 	select NR_CPUS_DEFAULT_16
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA

 config RELOCATABLE
 	bool "Relocatable kernel"
-	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
+	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 256fe6f..889c3f4 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -24,12 +24,17 @@
 volatile unsigned long octeon_processor_boot = 0xff;
 volatile unsigned long octeon_processor_sp;
 volatile unsigned long octeon_processor_gp;
+#ifdef CONFIG_RELOCATABLE
+volatile unsigned long octeon_processor_relocated_kernel_entry;
+#endif /* CONFIG_RELOCATABLE */

 #ifdef CONFIG_HOTPLUG_CPU
 uint64_t octeon_bootloader_entry_addr;
 EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif

+extern void kernel_entry(unsigned long arg1, ...);
+
 static void octeon_icache_flush(void)
 {
 	asm volatile ("synci 0($0)\n");
@@ -180,6 +185,19 @@ static void __init octeon_smp_setup(void)
 	octeon_smp_hotplug_setup();
 }

+
+#ifdef CONFIG_RELOCATABLE
+int plat_post_relocation(long offset)
+{
+	unsigned long entry = (unsigned long)kernel_entry;
+
+	/* Send secondaries into relocated kernel */
+	octeon_processor_relocated_kernel_entry = entry + offset;
+
+	return 0;
+}
+#endif /* CONFIG_RELOCATABLE */
+
 /**
  * Firmware CPU startup hook
  *
@@ -333,8 +351,6 @@ void play_dead(void)
 		;
 }

-extern void kernel_entry(unsigned long arg1, ...);
-
 static void start_after_reset(void)
 {
 	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c4873e8..c38b38c 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -99,9 +99,20 @@
 	# to begin
 	#

-	# This is the variable where the next core to boot os stored
-	PTR_LA	t0, octeon_processor_boot
 octeon_spin_wait_boot:
+#ifdef CONFIG_RELOCATABLE
+	PTR_LA	t0, octeon_processor_relocated_kernel_entry
+	LONG_L	t0, (t0)
+	beq	zero, t0, 1f
+	nop
+
+	jr	t0
+	nop
+1:
+#endif /* CONFIG_RELOCATABLE */
+
+	# This is the variable where the next core to boot is stored
+	PTR_LA	t0, octeon_processor_boot
 	# Get the core id of the next to be booted
 	LONG_L	t1, (t0)
 	# Keep looping if it isn't me
-- 
1.9.1
