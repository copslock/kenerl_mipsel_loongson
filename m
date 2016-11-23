Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 13:26:53 +0100 (CET)
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:16944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993008AbcKWM0qOdCYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2016 13:26:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WFoG8zf8aqeLP3CPvXNjCpbduGeC80GD2PzCoIzzvz0=;
 b=dP7/h9ZwEGul4U9Av+lejZvaO5XvcPITzHIdI1NGafzWROqxMWixSpDuzspTPFk6svZS9NF2sJFUKk8PpZQG+3OGNVAb/EcD/k+oXk+nC5Etmf/QWtt6YjK55Pmg/p3cXEdelHwnLmSeJKuaqktpmmdZAfkun2uNcpz32Wk2qXM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Wed, 23 Nov 2016 12:26:35 +0000
Subject: [PATCH v2 5/5] MIPS: OCTEON: Enable KASLR
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <d760ef90-ad22-dff7-14b6-2bc6af5a6745@cavium.com>
Date:   Wed, 23 Nov 2016 06:26:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR14CA0060.namprd14.prod.outlook.com (10.163.209.156) To
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147)
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;2:Qhcxixr8RYqYtp3C9Zt+O/e7rgCgTjWrNVP5lOzTGYO1DUTAGV+CSarxJ6I9ADfASVor2XEawlN1/gESVa+UFs6VhAHE+WBWyWECJ6ASyyqnUPVaNzaOsgjxqR89w6H7IF1e3vYg2ahmrnM2tYCdrG71Q/iU4yYgr3RyC1lg1bA=;3:6Y2MUx2jTYmzRzW0kMBHracNR3ZjKXQDMCGimE58YdYPcOAcCb3EqAhM3YzBPruZrjSpSuVfcLKA33lTF/fb+d4F8OJxB7zsmEOqhwkm/LHWa8XrPVVWQ9y67WdCWOe7gZrsQIrmmF8/H7iUT2pBIFE++/TTPjOe0I4jdkZ6oXY=;25:KKtUvHN8FJdVeftgy774nrfgCLxKA7vHjOZP7ENO23y9vXRoymYlWwUT/frNN3Vcr8nymGnG57P0pWoZUshOvZlFC0/8QpWyEeaKVeZaHEJmj+PT3cMzOPOdC3LyrRCTPC655eSsno/VpcIb3Uwx8XBCoS4jqCD7L/YuJP2suRpwUklxTlj6rVfNsZh1kHHquHZf4BnzOF6cEk3Fmd9ww46v0hbY2jArSsgNSTqs6P0ciBNz0lTx9v9uTB8r5AOJl4mYdm3/wd36FoMiilfs1+7/6FnvIQxb2NDPnCzrRbdm2HaOoy+IiPVAuMOAY6vn3cC3P9HNeeE/MpobrG6GcOVlJpWD2k19KDLX3rK8/JSZbiJNCYLKrtrBnltLwjFz5zZlhKrjV3gqwXXm3H/JfEG2ug0DVkj14yREcDAZtEiPL8nHG7CSFFOrdHiXT7j58LDZGlRXpRLznyZQk9lorg==
X-MS-Office365-Filtering-Correlation-Id: 5c6b5e48-cf5d-46a4-5196-08d4139bf756
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;31:Pfkz/lHDYimiL9gUYLVpVAUHS5B0j7jg9OwzZdfWXunaSaWqJ+pizyDb3jQcXJSo9JpL0NvBMOtfh6WCATwv7q0fb+zT3brn0dEescXPXCb2aI/3kInzO7H0wHVVPsmVHFH9pBjM3oMmx8KQnVs6r6E1itIee/IygGt8sYCNee5WRukY5Snespmo2pZ+JY8M+icMiCm1GwrHpIyVttZZ5JvZQTD7ZkppgaMy6pya+TBguZ9cI/b4VQrwbB6kmv5OlktfNHvEn/oM/gKEy+DM+A==;20:NwMMQNvoeU6zdmo2AYJKix/pSX0mD2pXfeOGOXuEIcV36cUwZ0QWmEvX6AtiaFRFpt7s0MKap5oqfLgQbsj1gBbStwFJjQhAzLPndPOaja/qf1hv6eumsEkq5trO1hw3lrtDPBtfHQz0lcfPObGHoS0Xnw93ghPgo3A9p8XPBzgiSHrlUK1KZ6UJHflTBqvYSZWxytCwI/hPVIiW7mP+p2IrF3+n6Sismc2N4PnKeZjVxyt2ZYiOImDw3fvys8WXbMwMX4wiy6IJmOhJCAXGAodv3X2Li6f2LZnJXoprbDBe7uuXD53ABmIZx2uBnjQx4bRxw/ea6dcviPHhFGuZMbp6i92E0+o6rgESSzw+/L14Qf++sKcNg5enCch/a9BNzUl+Lyi6GvM4eBtpxFQtBcUyw2SIR8B03x/Dy/TQEa9IZ0ODG37olAc2HjOv5G4NQLzg3e8Af/0Dzq7rjjhwd190XYCpHGADyjux/U1CrsrR07nXVlcfeX7umwjESqL3
X-Microsoft-Antispam-PRVS: <DM5PR07MB3209DD19B1F4D5681AF8EA5980B70@DM5PR07MB3209.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040307)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6061324)(6041248)(6072148);SRVR:DM5PR07MB3209;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;4:vc+Tp+0NrKQq4YoRjfniv0GlpmB37ttc707wGXkZU8PL8D1kv6mSCxllxtfq0crMibclN0aD5N4ZRwz1zSxCkkE+JPDT/Sk3sg0xd+bvn/gx+zcBUt0yJFiwdVU65IfELL0leJyQgyni1Rw2tyT2E9JfXyeDayo6CP1GB+GvqJamvek2MP6sa45xFWFA80/Iih24RSfsBdufevgWVYdR1HM90nnAlcnSpSWR1eU3kvD44m5GDSUf+vwCEwucpqq8ZNud3I2FdhfC3VKRn/t4WDDOKn3N2wQFKp/AkmZ8jU52RSPMRRWmndanA/gShkrfZR46WLEwEIZPBQM5nwM2THYu+truJrAEGGcZATcC8askO+/A0NwR8q2XTMPIip8mqtfupyArO1fV0oUVobsJLnBG9jxzAKl9p0XUP7ueZTfPO41b7sxEjuQPqm0UjZhP0pHcNXO0HqnoorjO/lUgizgBOXcbyf44h7FICzjPb0myf52XbibtbsfNOt6SWO/lUDm1nokAl6sskN1YL5iGhxKQrheDFb6EjUcx4WHg/kk=
X-Forefront-PRVS: 013568035E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(189002)(189998001)(83506001)(47776003)(65956001)(65806001)(66066001)(4001350100001)(97736004)(86362001)(31696002)(2351001)(106356001)(50466002)(54356999)(64126003)(50986999)(450100001)(36756003)(101416001)(105586002)(42186005)(92566002)(77096005)(31686004)(33646002)(230700001)(81156014)(81166006)(6666003)(6116002)(3846002)(7736002)(7846002)(8676002)(110136003)(68736007)(6916009)(65826007)(305945005)(5660300001)(38730400001)(2906002)(23676002)(4326007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3209;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzMjA5OzIzOi9MRWVTL1JhaTA5YWZCdW1sUGZiRFN0WTZr?=
 =?utf-8?B?SExxTkV0SWZsdE02M0pTVUtlU3RpNEFQQzd2UHpJcU5RWmwvb0pQYzdRRmVL?=
 =?utf-8?B?akFkZG5hRTluNHZqNzhTWkdmMHRFMXdPRUgxbktxcHBnK05hNFgxRGRHS0Q5?=
 =?utf-8?B?bHl5bTBBYU9vTnc3YUJJM0t1a3lDVG05QUhEM0t0bmpYNVVyREkzaTVYcUww?=
 =?utf-8?B?VXJLSEd5eHMvTWRyYVhVNFRxanpObFd5eGhMNmwwejNkZ1Z6SExGTTFmTFhX?=
 =?utf-8?B?ZUh2NS9tV29IYWJKRXZVZklKQTlTVGNNY3UzcjY5dllscFpzeUd3eE1FZVQ2?=
 =?utf-8?B?eXBuczdPSGVVTkEwYjBJWmE1cTdIWnU1ZjhhM0hZY0pOS0ZtK0NYaWZQeDdn?=
 =?utf-8?B?d2g3YzcvcDdyWDVTVEc3UzVHcTdhdm16OE9ienNZUVl1VDZpTE02OHVOSXk4?=
 =?utf-8?B?Q3RFNGpjSS9lbFUvOEwzVGtVVzhGb0htSUtmZTV0RlN4T0lVWVpad3VuZmgz?=
 =?utf-8?B?eWQ2WXNpZGV5c0FHTklWZmJwTUFFUTVmVldXdGJRZjgvejZDMGhVVTJxVFpH?=
 =?utf-8?B?amFOZnoxekdkQ0N3d3J0OVpsMk82YlpRTkdpUzJXVzd4SWxhSlE3c3NVVmpK?=
 =?utf-8?B?QVZlMEEwRVBUaGI0YWdGYVlkL3dBY3drUWFrd0s2Y0lIenk2Y1c3aWlpbGNJ?=
 =?utf-8?B?SUMvem9WMG83SU5FQTBMdXQ1d1Q1dTUvS1JxbWgzSUhSRUpHcXNzS0VOamJa?=
 =?utf-8?B?ZUZ5aGxDT0F5UEtIbnlvWkFmTkQwM1FxTWROeGVNRE9GV2Q3Y2k5aVZIcEMr?=
 =?utf-8?B?c2pEMmVKbW8xazgrc0Z0MlNYS2VmcmZQc1c3c3RwZWw2UHZ6UXduc3NPZ1lV?=
 =?utf-8?B?OUN6b3BVTTBnay9rVjdIVjhqZXJWNVZWNGFiUjVKTkNwWEJaekU0WVlSNmZq?=
 =?utf-8?B?Wlg1YmlsaWlxU2o4ZzVkUkR2aURSamFhL0JtNmExQTk5cFIzTUtvaW1ZeUxS?=
 =?utf-8?B?Y2VoYm54ZHBTUWU3YmVUcVFMMkRNSldPR2VUMlU1SDdVMnczb3dMaEZydGFh?=
 =?utf-8?B?RWVqUmMvOUp6V2hDSUFBVWpaZFJXRVMxdng1dEtOdzVtejZOTWZqcTIwdXZs?=
 =?utf-8?B?QS9ZZWRWN2hyZGxDK3grdzhhbm5zYWNMbnVoQ0xlaSt6WDlEYlhqK1VzVHpM?=
 =?utf-8?B?cU1DVkM1TDRXSCtkcmljRjJPWkdZa3V0Tkh4Z1pFRVorajlOWWFsUDloUTR1?=
 =?utf-8?B?NGlENU56UU9VbS80UUZNY3NlN2FhdXhQUE1lM0hYT2dTb2poOUtudUVMY0Nq?=
 =?utf-8?B?cytuTWpoUVlhRW9SaDF6dkNaZkh1NG1sWmg0VlptcWRPbWREUlZNaC96QjFE?=
 =?utf-8?B?ZEdRVFlEN1RNMVI1UEQ4c2tTUHhJVlRwb3Y2aXhjZkVmVUZKSXY0Y1lRRkxi?=
 =?utf-8?B?dENXcUdubmVzYUhnQ29BSHpjTW5SNzdmRG1sOHVSRW5ubXZueXV5RTVDMVVq?=
 =?utf-8?B?TDNvS1RLdGRHRGxIeERoWnhTVkNiM0ZQY21kNTM5dSt2U1ZoWHZtdWgybWFt?=
 =?utf-8?B?WTJnWHc1bkNxY1lxeGN4d3R3Y20wQU5hekZBeElVMXJ1MUplTTc5MldrZ01w?=
 =?utf-8?B?NmJpVjQ2Vy9wSU9lMENGWC9sMDJkbGJVWmlhelY5VkltU3l2aWt1VXVRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;6:Uad2GwKYjZ+Z4YOf3QbdkQf/AWrjJSDe9lmktJe3VOqZ/x0hfiY3lVnkOlp/SHjmJd9Fy3m8wh5VVJ8n9k2SVvfkLE6PQ7jVQx78lwM2PE4yntD+MN+RHpR+WowGLBWG1emDONVhxrFilkGOeT1dI8LGGYBOBDz7vqm+mVsP9k3bXP43ljJeVoGZYMWyZUMqbdFTYMBc6ed1Z6j2zTLLcYQnlE2qyqN7BiYAOB4PzK/LpgoMu3aWLv7ulPIBMENmu6o3O+NwK/RbRsnxO+jeTqpP2LVkznw7Fl606H8lJMzrMhZ//8YTkJTeuf8KBVfAIxxUvnySDq+HTZHLcF0Mu9dU1RnDWbFfPIOv/3Cqbo8=;5:jASvAHW8q/0HM22u96RUJiSp43dofnjeAXBik5ZH3RnGDrrFD4zVp1sSuZOxq66PwzkHe9onNnxWfzQcNzYp5ADBnVFLyFDnj06L6P8tBSX01SXMekZuYyf3/laHOTlbkvHe4ZVXDlmcTn0BaYQWtA==;24:2f5ek0a/FgJH+kA6stNRuLlIjdX7lBoHhvDtfj6orY4A5Otar8/8JBOj6sdAe5XpREGjF0f1tK3Ggg7o/xtJ9gDQdtP9Fbz6An+LdSAHtRU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;7:TrPvVrSZnZ+PHNfOJuLbKHTv7tw0R9Wu9IfiW2Sui/54PPFJy9ZoHSE0g9zRMDvjpBLFttl34eQw2fvY5VfEVZsKgw43QWj5o4p2O6eBKb2593kXP8Twgbh7osJ6dNxyuS7ypq8az9OlMg2Xmff8kMDtsYt59BuexKpk1mBE86rQTVqrIhd/u8Q99dR/eG2nncqzREtVy4CNihpApwtDZQMic+Ypdb5HAJMMQ1PFTgFMZ9euBeM1w/OUVcGTwtYol7SZjuzBcqD2h90Hr77LSd4eSveRtqWUF9EGwhSrACQGChcb9Q3a7Zu3PZlMTcgJt1Z6nz+S9OwwfBJlpAdjw7wHsZuIfCAreB2jjIb+3to=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2016 12:26:35.2877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3209
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55870
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

Add KASLR to be selected on OCTEON systems.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/Kconfig                                  |  3 +-
 arch/mips/cavium-octeon/smp.c                      | 42 ++++++++++++++++++++++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  7 ++--
 arch/mips/kernel/relocate.c                        | 17 +++++++++
 arch/mips/kernel/setup.c                           |  4 ++-
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2638856..323d51c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -892,6 +892,7 @@ config CAVIUM_OCTEON_SOC
 	select NR_CPUS_DEFAULT_16
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -2535,7 +2536,7 @@ config SYS_SUPPORTS_NUMA

 config RELOCATABLE
 	bool "Relocatable kernel"
-	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
+	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 4d457d60..4ac97a3 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -12,10 +12,12 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/bootmem.h>

 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/sections.h>

 #include <asm/octeon/octeon.h>

@@ -24,6 +26,7 @@
 volatile unsigned long octeon_processor_boot = 0xff;
 volatile unsigned long octeon_processor_sp;
 volatile unsigned long octeon_processor_gp;
+volatile unsigned long octeon_processor_smpentry;

 #ifdef CONFIG_HOTPLUG_CPU
 uint64_t octeon_bootloader_entry_addr;
@@ -180,6 +183,23 @@ static void __init octeon_smp_setup(void)
 	octeon_smp_hotplug_setup();
 }

+#ifdef CONFIG_RELOCATABLE
+static long relocation_offset __initdata;
+
+void __init plat_save_relocation(long offset)
+{
+	relocation_offset = offset;
+}
+
+void __init RELOCATE(volatile unsigned long *addr, unsigned long val)
+{
+	unsigned long *p;
+
+	p = (unsigned long *) ((unsigned long)addr - relocation_offset);
+	*p = val;
+}
+#endif
+
 /**
  * Firmware CPU startup hook
  *
@@ -191,9 +211,17 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
 	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
 		cpu_logical_map(cpu));

+#ifndef CONFIG_RELOCATABLE
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
 	octeon_processor_boot = cpu_logical_map(cpu);
+	octeon_processor_smpentry = (unsigned long)&smp_bootstrap;
+#else
+	RELOCATE(&octeon_processor_sp, __KSTK_TOS(idle));
+	RELOCATE(&octeon_processor_gp, (unsigned long)(task_thread_info(idle)));
+	RELOCATE(&octeon_processor_boot, cpu_logical_map(cpu));
+	RELOCATE(&octeon_processor_smpentry, (unsigned long)&smp_bootstrap);
+#endif
 	mb();

 	count = 10000;
@@ -204,6 +232,20 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
 	}
 	if (count == 0)
 		pr_err("Secondary boot timeout\n");
+
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * The last present CPU is now running in the relocated
+	 * kernel code. We can free up the bootmem pages.
+	 */
+	if ((num_present_cpus() - 1) == cpu) {
+		unsigned long offset;
+
+		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
+		free_bootmem_late(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
+		relocation_offset = 0;
+	}
+#endif
 }

 /**
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c4873e8..981d072 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -113,6 +113,9 @@ octeon_spin_wait_boot:
 	# Get my SP from the global variable
 	PTR_LA	t0, octeon_processor_sp
 	LONG_L	sp, (t0)
+	# Get my SMPENTRY target from the global variable
+	PTR_LA	t0, octeon_processor_smpentry
+	LONG_L	t1, (t0)
 	# Set the SP global variable to zero so the master knows we've started
 	LONG_S	zero, (t0)
 #ifdef __OCTEON__
@@ -121,8 +124,8 @@ octeon_spin_wait_boot:
 #else
 	sync
 #endif
-	# Jump to the normal Linux SMP entry point
-	j   smp_bootstrap
+	# Jump to the normal Linux SMP entry point (smp_bootstrap)
+	jr	t1
 	nop
 #else /* CONFIG_SMP */

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index ca1cc30..250ff9c 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -31,6 +31,20 @@ extern u32 _relocation_end[];	/* End relocation table */
 extern long __start___ex_table;	/* Start exception table */
 extern long __stop___ex_table;	/* End exception table */

+
+/*
+ * Declare this function weak so the platform can choose if they
+ * want the kernel relocation offset.
+ *
+ * WARNING!!!	This is a potential security risk if the platform
+ *		function does not zero out the value before getting
+ *		to userspace!
+ */
+void __weak plat_save_relocation(long offset)
+{
+	/* Do nothing... */
+}
+
 static inline u32 __init get_synci_step(void)
 {
 	u32 res;
@@ -316,6 +330,9 @@ void *__init relocate_kernel(void)
 	arcs_cmdline[0] = '\0';

 	if (offset) {
+		/* Save the relocation offset value. */
+		plat_save_relocation(offset);
+
 		/* Copy the kernel to it's new location */
 		memcpy(loc_new, &_text, kernel_length);

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 36cf8d6..582c711 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -501,11 +501,13 @@ static void __init bootmem_init(void)
 	 * between the original and new locations may be returned to the system.
 	 */
 	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
 		extern void show_kernel_relocation(const char *level);
+#ifndef CONFIG_CAVIUM_OCTEON_SOC
+		unsigned long offset;

 		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
 		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
+#endif

 #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
 		/*
-- 
1.9.1
