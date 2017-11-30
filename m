Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:18:40 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990596AbdK3GQOD7tNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xFHc3Y5+Lv5NSbXJWIE+OVcgRPKP9JhhztgatNl+3R4=;
 b=FsMwEyvs3f38zpTrIvmPaTr41AfSUzoUrB8W55ePInlDZASCx9YaVUmmwI5NNGmo35XVzaw09XUh5Cs0MBjGRRTmcfLktanou0YyX5GQU1cglrtAqfofHU206uLycuv7sAJRiYOEbpTFRBhdlWSBKwJfhfRf/+vU2xIPONM3eEU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:06 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v4 7/7] MIPS: Octeon: Add working hotplug CPU support.
Date:   Thu, 30 Nov 2017 00:06:21 -0600
Message-Id: <1512021981-15560-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f715794-6938-49fa-15cc-08d537b9d7f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:F2eRr1kRr08P1aKp5Tg+KYn0D2KPkUP42gijE32Szd4d8nb+3YRnf3btnZ+hL4HCLBC0sjH5GOIdnAlhuuyV3uACD9IokY1u5Xb8dCgLJCuktMncEVjEwGrFh/2qe2WrbaV4qG7cLlz2bESJyYIe6qIFrk5EB2kPqZPeU3QvnqQVcDXLuktXyLTTlkAFuO0OlhzdhgmS3EBTI2w0Z2DT/Z+cqXvtQTGL127UB0sTcc0ksLnqoFfrjRlqC3t1X3sO;25:ytny+82R8OeZaqUJ/L5WrK/87z78yiGSAjAYoHESKes7jCGQj3i8ltvVmObR82jZcskXMGqOeXpa0ZBNhvUGNvc0AM4En4cDGSZIwcRvFJ6dD3qmf2tXxUbNfpUp6iSVjtLBisaC9R6Ev3fBs4jJyZPBHM1ONnNVdkJ+UUbbgjzynvyenSllUCfbkfgjfdWFcRTUJRUopAXpthBIoXoGa12GBi8u4LNjhqjzl9d3QMaxYCjyI/jHcSC8hkMqFZfFyE1w2yxzHqfcy9E+6k2piINJwm+ruQ5xpwxzR8Z08SPP/oHafGS8MBYm7Ras89OrVuiM56ZH2hRcD2nUKn4K/Q==;31:tujdisAOg0ay/RhOgDOj9ZmDm6NLauJO24J8jNzaJDDoVFT2PTZTxP9ow+5nKJoKoRfFXjK49SJGBhsQ8SOp6cGzI8KEAEyhz+8c+HFG/qCbYOhSeEHBef+S6QA8mYtXTJi/yCvCR/0etZLUplyBM1RVGgLJx8HUUDmjACQovwXb6LTjHY6fSf+1AlXANGeRRaoLI9emwtIAvg5llfRisq2Lvz08Va+LVodjxo2ZToo=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:Oh0CZLC45vTIvq+B9gJXLXiAQar84lJ+9ppMDebljeMtwIi0/mEOBumOHBCKVr41wYXbcKZEgv29Ed93b562KgX6xWDwk4qSCPoB1Nstjniee4IaTtBFE1T/K4xqcoeEE9RgJa4u6+2q2FgeeQ5b3OJUyhzK0aaLUZqoySMV3Qam/nOuyqHrcI+gS6LcPEsF4lgeH/4sCJWTVoJDniPj8Zwz6v92/FZkTLCYDB5TiRP32UNI0jhem10kDO5vCDj83TsJZ96Lfp9SJAdxKWH3Bu52pRqF3kW2VRbNkIp0H2HUdQ+mSzTqvma+h5A3mblYA5JmMNd7Y2C+78N64BO8EunwKL1ogprODhuZ7LhR/HZyspNigsu+/mPQqpgpyMKwnGaljgU7QLiEkr4mIeII58G7DMfzPMmh1gNwSYeza6dqtVXrsiswiiQFHYebepCgaozwx/ZK8FsFsByzGtU9HwFhc1/P0svUTnZuGYuLJOpdiXN826qsK4Vv+eTUT4Bu;4:O9YuFvCr5k+DAYHtntL06uDqwqHpgUDae9uuljSIlXwWol5j/vlpr2vuKh4NPVIufjodBftXBkECxphmeEh6bIMca+7CvqfDhUCJAr4exPMi+omZQfhj2FDUF9i6IGWLRGpnTb5vjsm+xZAPFd1PfgogC9AHb3K0uUZ/Y5ksDwHtS9aOyOwkQJA7n14/gYPM75/EOqaKGoSBHrkxSkaslAraaNSU6azw6JTGRt+dXSaJzakn6ev1H3/kyM0MwuS219hGfjmk1Eb5OYnkKfUJ7Q==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803C5C56E0A22B87F23882780380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(5890100001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(575784001)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(54906003)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:is/EPiZ6oCrqcWHrwPlMs7nQ4fQ+CLU8CfZ5vqC?=
 =?us-ascii?Q?7dzfZ7epJ0D0FWUIcCjPmnN7aNWVLJOgR59bNG3z1yOgnoFint7Pi4rsJDYn?=
 =?us-ascii?Q?gnLpYvC3Uqdx4GeTxqfSILZ08lD7CZN9odY/DiHoorL1VwpyGlL9GwMtuRL7?=
 =?us-ascii?Q?9HXifBLXYeuvT+8FjVYAlec52cDLJVeSNWXjsIfdVNgpUB/LkLpjlb9M4Dte?=
 =?us-ascii?Q?YDmwF+ydHqkK3oBFVJxiWNEjeokdR6G7NyL39wg2/5CqRThdbta3tKwYjVx+?=
 =?us-ascii?Q?8gtlXL4/mOZ19/358OoZnqDVRviy0aPbA6+ixGA6wsWQZuGLvlNZNg04qj/y?=
 =?us-ascii?Q?cPNavDrcs8LFml9U+a5pZELHo/3N1YHWjz9qkHdAzXGt9YoAbJzrcZMs3e4u?=
 =?us-ascii?Q?wTtd79Qy9GjhBv9aUEKNgViD82lr8O76Vhxt+1GO3oGRRi6DFllQSYE5aAd2?=
 =?us-ascii?Q?B1cGGip3YQ1GkOH+qlBEmGlq0kRGJccA8yznlxJhtP6/n+VKsyeaCTEkHAbm?=
 =?us-ascii?Q?UwRNffz1sqtL/RakOZua8nwv5czIYb1Vqf5Ga2w4nweXAEDTYwkE7YmCpnqu?=
 =?us-ascii?Q?EvfQGfk6wjv3amjNEMDvPH1dQu9VCNEnR5ID+BzOxf9xjOdAJDS8HPDRJ0PR?=
 =?us-ascii?Q?BWyW2GTkB81s5+fr1DHP7/txDfB8YrqsBQ08iIub3/KzJ5NuO+sCGXGdBmK3?=
 =?us-ascii?Q?Br1FalHewk85hHdtktAaAFsUNlJ7RzgfzN6M0aZ/93xKL46+PUUTs3Iw13OG?=
 =?us-ascii?Q?arI00t3bw91YRX/IDPDfMSux7U2gMaakOtGWC1PPi4fai89O8agfo8jJnFkB?=
 =?us-ascii?Q?LMPFgFxeug9oQ7/8S3Cyfjsh3xBHUjuERn9zfzS7PYaXTk0hkpxljztWnQMx?=
 =?us-ascii?Q?xv+Oyya3Pi320fZ7DAfIYZb4rFvFDt6ux8dIrxAwJFobhPWEyJh3n64Rk3yf?=
 =?us-ascii?Q?hiisaxMR7uUZMCwJvDZ1Etjcs8dDRFD4HIdQKX/+yhtJWSb2qhvCQt1nfJhd?=
 =?us-ascii?Q?Yi63Xtu94W9M7dbiW1jJTUx7qJ9sRXAWnMtwZSgEWv8B+zSangKyv/J1UrJR?=
 =?us-ascii?Q?XQtPDajr008c0fa/bTlLstSePlesf5PVYh8Uz4Q88PHH79725qguXRqFrdcG?=
 =?us-ascii?Q?g+M5vR2kzmXY9RSUONHf80WQj9fVFjx0CUshAUTUxyfglYBQh7zOYnbyDSHr?=
 =?us-ascii?Q?URN/HJc+MGCGy6CLFc0TYqA4UCoJfEBI7ltfejAlT9SdjeHOmZrNN29+Q/Ut?=
 =?us-ascii?Q?DqHhk1lcjvtpIF5cHIa6h1V+3ZPnXCfxG+XBETsZ38teugMM0gqyymyefs+K?=
 =?us-ascii?Q?XiQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:3UFWHjoSmeB7G3vvDyTlUi7SHdGxYwPKjY1vFFID5pYEwX/7+dmDnc8Cas+6N1t225ag7vd8QvkOt9k6Ncl/BF17lzRLJERY2TAcBIAaweXvVWgiK4MW4cXPd6v6FY5KVZZzTyDp0PqvRLMrFNobI59VrCg15loBYa4gI7Uq0AqasMthBpLim+3IQdgtB/39jzsIYCMp+0OGBOafEIw0njBmv5Uda7CmiJL+oihOa45N+/QKABW/iIqHQF8gNSg6S9eIrzFqHbULg7ISXNKecQY/zgWfRzixT3UnyefDW2/fIQuEIJPUn1cKuKpd/ry9Fz6zNQLavoyAeLOIfuX7/01Fj6C0vZevB1sECAR6fGc=;5:KqWKH9GHU8+TMsfv59K6zXk0Hyl6T7u05bncKvv7tGIGIo8tIhps7iZ9tdH63hJcAFJqs7EiGGBrvfmML67W9EfQMRWhUlNCgsc5xLp3mZ28V2lpV/XMDlKQ0f1Rs4guvwSpET6ns+kcz0cV3pLo8JHy4g9iYJY7U+caKS59AqE=;24:4YY0pcLw5dSVMKPXlqloQ4iaI4vqchvXY2+WNtHW8IDgyL8MB/xujjtVV4xWAC47NTY4ZlN8WJXevMsg1l82TXvp6B5GTN3UJsZIBXnzJao=;7:L+TYVXNAROh6XVomKBP0gfubkQ19h+B0dcPaW2+5oGEyxhovuksGIUDZjj0pe/8ydnLY4WmryLOPyTr2JWBQD9/1lC0EeO1ch0H/v5KYmHeQC7pzLrbeNUHChYclG70jq1r23I/OTnTM9vmt11Fu0YtRxCicZ9lrcCywDscR3R93AtnlzUhrXYVdfSsKVVtgPdOdH/cLllWZ8PUWeWv4l5oWhvkG0wV1XtjI2/5wvswTulHO13+9Nw5d+vYYd407
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:06.6596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f715794-6938-49fa-15cc-08d537b9d7f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61238
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

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/cavium-octeon/octeon_boot.h              |  95 ---------
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/cavium-octeon/smp.c                      | 233 +++++++--------------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  58 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx.h                |  22 +-
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 9 files changed, 182 insertions(+), 259 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990..12c0d85 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -884,7 +884,7 @@ config CAVIUM_OCTEON_SOC
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select HW_HAS_PCI
diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
deleted file mode 100644
index a6ce7c4..0000000
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * (C) Copyright 2004, 2005 Cavium Networks
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#ifndef __OCTEON_BOOT_H__
-#define __OCTEON_BOOT_H__
-
-#include <linux/types.h>
-
-struct boot_init_vector {
-	/* First stage address - in ram instead of flash */
-	uint64_t code_addr;
-	/* Setup code for application, NOT application entry point */
-	uint32_t app_start_func_addr;
-	/* k0 is used for global data - needs to be passed to other cores */
-	uint32_t k0_val;
-	/* Address of boot info block structure */
-	uint64_t boot_info_addr;
-	uint32_t flags;		/* flags */
-	uint32_t pad;
-};
-
-/* similar to bootloader's linux_app_boot_info but without global data */
-struct linux_app_boot_info {
-#ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t labi_signature;
-	uint32_t start_core0_addr;
-	uint32_t avail_coremask;
-	uint32_t pci_console_active;
-	uint32_t icache_prefetch_disable;
-	uint32_t padding;
-	uint64_t InitTLBStart_addr;
-	uint32_t start_app_addr;
-	uint32_t cur_exception_base;
-	uint32_t no_mark_private_data;
-	uint32_t compact_flash_common_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-	uint32_t led_display_base_addr;
-#else
-	uint32_t start_core0_addr;
-	uint32_t labi_signature;
-
-	uint32_t pci_console_active;
-	uint32_t avail_coremask;
-
-	uint32_t padding;
-	uint32_t icache_prefetch_disable;
-
-	uint64_t InitTLBStart_addr;
-
-	uint32_t cur_exception_base;
-	uint32_t start_app_addr;
-
-	uint32_t compact_flash_common_base_addr;
-	uint32_t no_mark_private_data;
-
-	uint32_t led_display_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-#endif
-};
-
-/* If not to copy a lot of bootloader's structures
-   here is only offset of requested member */
-#define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
-
-/* hardcoded in bootloader */
-#define	 LABI_ADDR_IN_BOOTLOADER			 0x700
-
-#define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
-
-#define LABI_SIGNATURE 0xAABBCC01
-
-/*  from uboot-headers/octeon_mem_map.h */
-#define EXCEPTION_BASE_INCR	(4 * 1024)
-			       /* Increment size for exception base addresses (4k minimum) */
-#define EXCEPTION_BASE_BASE	0
-#define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
-#define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
-
-#endif /* __OCTEON_BOOT_H__ */
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2855d8d..068787d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -756,7 +756,7 @@ void __init prom_init(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
 	    OCTEON_IS_MODEL(OCTEON_CN31XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
-	else
+	else if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
 
 	/* Default to 64MB in the simulator to speed things up */
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index f08f175..4904db2 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -3,41 +3,39 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
+ * Copyright (C) 2004-2017 Cavium, Inc.
  */
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
 
-#include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/cvmx-boot-vector.h>
 
-#include "octeon_boot.h"
-
-volatile unsigned long octeon_processor_boot = 0xff;
-volatile unsigned long octeon_processor_sp;
-volatile unsigned long octeon_processor_gp;
+unsigned long octeon_processor_boot = ~0ul;
+unsigned long octeon_processor_sp;
+unsigned long octeon_processor_gp;
 #ifdef CONFIG_RELOCATABLE
-volatile unsigned long octeon_processor_relocated_kernel_entry;
+unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
-#ifdef CONFIG_HOTPLUG_CPU
-uint64_t octeon_bootloader_entry_addr;
-EXPORT_SYMBOL(octeon_bootloader_entry_addr);
-#endif
+static struct cvmx_boot_vector_element *octeon_bootvector;
+static void *octeon_hotplug_entry_raw;
 
-extern void kernel_entry(unsigned long arg1, ...);
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
 
 static void octeon_icache_flush(void)
 {
@@ -99,57 +97,32 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 void octeon_send_ipi_single(int cpu, unsigned int action)
 {
 	int coreid = cpu_logical_map(cpu);
-	/*
-	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
-	       coreid, action);
-	*/
+
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
 static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 					unsigned int action)
 {
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		octeon_send_ipi_single(i, action);
-}
-
-/**
- * Detect available CPUs, populate cpu_possible_mask
- */
-static void octeon_smp_hotplug_setup(void)
-{
-#ifdef CONFIG_HOTPLUG_CPU
-	struct linux_app_boot_info *labi;
+	int cpu;
 
-	if (!setup_max_cpus)
-		return;
-
-	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE) {
-		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
-		return;
-	}
-
-	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
-#endif
+	for_each_cpu(cpu, mask)
+		octeon_send_ipi_single(cpu, action);
 }
 
-static void __init octeon_smp_setup(void)
+static void octeon_smp_setup(void)
 {
 	const int coreid = cvmx_get_core_num();
 	int cpus;
 	int id;
-	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
-
+	unsigned long t;
 #ifdef CONFIG_HOTPLUG_CPU
-	int core_mask = octeon_get_boot_coremask();
 	unsigned int num_cores = cvmx_octeon_num_cores();
 #endif
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
 
 	/* The present CPUs are initially just the boot cpu (CPU 0). */
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < num_possible_cpus(); id++) {
 		set_cpu_possible(id, id == 0);
 		set_cpu_present(id, id == 0);
 	}
@@ -159,7 +132,7 @@ static void __init octeon_smp_setup(void)
 
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < CONFIG_MIPS_NR_CPU_NR_MAP; id++) {
 		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
@@ -169,15 +142,22 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 
+	octeon_bootvector = cvmx_boot_vector_get();
+	if (!octeon_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return;
+	}
+	t = __pa_symbol(octeon_hotplug_entry);
+	octeon_hotplug_entry_raw = phys_to_virt(t);
+
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * The possible CPUs are all those present on the chip.	 We
 	 * will assign CPU numbers for possible cores as well.	Cores
 	 * are always consecutively numberd from 0.
 	 */
-	for (id = 0; setup_max_cpus && octeon_bootloader_entry_addr &&
-		     id < num_cores && id < NR_CPUS; id++) {
-		if (!(core_mask & (1 << id))) {
+	for (id = 0; id < num_cores && id < num_possible_cpus(); id++) {
+		if (!(cvmx_coremask_is_core_set(&sysinfo->core_mask, id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
 			__cpu_logical_map[cpus] = id;
@@ -185,8 +165,6 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 #endif
-
-	octeon_smp_hotplug_setup();
 }
 
 
@@ -209,26 +187,51 @@ int plat_post_relocation(long offset)
 static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int count;
+	int node;
+	int coreid = cpu_logical_map(cpu);
+
+	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu, coreid);
+
+	preempt_disable();
 
-	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
-		cpu_logical_map(cpu));
+	per_cpu(cpu_state, smp_processor_id()) = CPU_UP_PREPARE;
+	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
+	mb();
+	/* Convert coreid to node,core spair and send NMI to target core */
+	node = cvmx_coremask_core_to_node(coreid);
+	coreid = cvmx_coremask_core_on_node(coreid);
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
+		cvmx_write_csr_node(node, CVMX_CIU3_NMI, (1ull << coreid));
+	else
+		cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid));
 
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
-	octeon_processor_boot = cpu_logical_map(cpu);
+	/* This barrier is needed to guarantee the following is done last */
+	mb();
+
+	/* Indicate which core is being brought up out of pan */
+	octeon_processor_boot = coreid;
+
+	/* Push the last update out before polling */
 	mb();
 
+	preempt_enable();
+
 	count = 10000;
 	while (octeon_processor_sp && count) {
 		/* Waiting for processor to get the SP and GP */
 		udelay(1);
 		count--;
+		mb();
 	}
 	if (count == 0) {
 		pr_err("Secondary boot timeout\n");
 		return -ETIMEDOUT;
 	}
 
+	octeon_processor_boot = ~0ul;
+	mb();
 	return 0;
 }
 
@@ -256,11 +259,24 @@ static void octeon_init_secondary(void)
  */
 static void __init octeon_prepare_cpus(unsigned int max_cpus)
 {
+	u64 mask;
+	u64 coreid;
+
 	/*
 	 * Only the low order mailbox bits are used for IPIs, leave
 	 * the other bits alone.
 	 */
-	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		mask = 0xff;
+	else
+		mask = 0xffff;
+
+	coreid = cvmx_get_core_num();
+
+	/* Clear pending mailbox interrupts */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), mask);
+
+	/* Attach mailbox interrupt handler */
 	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
 			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
 			mailbox_interrupt)) {
@@ -275,6 +291,8 @@ static void __init octeon_prepare_cpus(unsigned int max_cpus)
 static void octeon_smp_finish(void)
 {
 	octeon_user_io_init();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+	mb();
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
@@ -283,9 +301,6 @@ static void octeon_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -293,9 +308,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	if (!octeon_bootloader_entry_addr)
-		return -ENOTSUPP;
-
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	octeon_fixup_irqs();
@@ -308,108 +320,21 @@ static int octeon_cpu_disable(void)
 
 static void octeon_cpu_die(unsigned int cpu)
 {
-	int coreid = cpu_logical_map(cpu);
-	uint32_t mask, new_mask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-
 	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
 		cpu_relax();
-
-	/*
-	 * This is a bit complicated strategics of getting/settig available
-	 * cores mask, copied from bootloader
-	 */
-
-	mask = 1 << coreid;
-	/* LINUX_APP_BOOT_BLOCK is initialized in bootoct binary */
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		labi->avail_coremask |= mask;
-		new_mask = labi->avail_coremask;
-	} else {		       /* alternative, already initialized */
-		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-							       AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-		*p |= mask;
-		new_mask = *p;
-	}
-
-	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
-	mb();
-	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
 void play_dead(void)
 {
-	int cpu = cpu_number_map(cvmx_get_core_num());
+	int cpu = smp_processor_id();
 
 	idle_task_exit();
-	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
-
-	mb();
-
-	while (1)	/* core will be reset here */
-		;
-}
-
-static void start_after_reset(void)
-{
-	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
-}
-
-static int octeon_update_boot_vector(unsigned int cpu)
-{
-
-	int coreid = cpu_logical_map(cpu);
-	uint32_t avail_coremask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-	struct boot_init_vector *boot_vect =
-		(struct boot_init_vector *)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
-
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		avail_coremask = labi->avail_coremask;
-		labi->avail_coremask &= ~(1 << coreid);
-	} else {		       /* alternative, already initialized */
-		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
-			block_desc->base_addr + AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-	}
-
-	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume, that caught by simple-executive */
-		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
-	}
-
-	boot_vect[coreid].app_start_func_addr =
-		(uint32_t) (unsigned long) start_after_reset;
-	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
-
 	mb();
-
-	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
-
-	return 0;
-}
-
-static int register_cavium_notifier(void)
-{
-	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
-					 "mips/cavium:prepare",
-					 octeon_update_boot_vector, NULL);
+	local_irq_disable();
+	while (1)
+		__asm__ __volatile__("wait\n");
 }
-late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38c..cfcf4f3 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -3,11 +3,13 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2008 Cavium Networks, Inc
+ * Copyright (C) 2005-2017 Cavium, Inc
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 
+#include <asm/octeon/cvmx-asm.h>
+
 #define CP0_CVMCTL_REG $9, 7
 #define CP0_CVMMEMCTL_REG $11,7
 #define CP0_PRID_REG $15, 0
@@ -26,6 +28,60 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+	b	7f
+FEXPORT(octeon_hotplug_entry)
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	move	a3, zero
+7:
+	mfc0	v0, CP0_STATUS
+	/* Force 64-bit addressing enabled */
+	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
+	/* Clear NMI and SR as they are sometimes restored and 0 -> 1
+	 * transitions are not allowed
+	 */
+	li	v1, ~(ST0_NMI | ST0_SR)
+	and	v0, v1
+	mtc0	v0, CP0_STATUS
+
+	# Clear the TLB.
+	mfc0	v0, CP0_CONFIG, 1
+	ext	v0, v0, MIPS_CONF1_TLBS_SHIFT, MIPS_CONF1_TLBS_SIZE
+	mfc0	v1, CP0_CONFIG, 3
+	bgez	v1, 1f
+	mfc0	v1, CP0_CONFIG, 4
+	andi	v1, v1, MIPS_CONF4_MMUSIZEEXT_SIZE
+	ins	v0, v1, MIPS_CONF1_TLBS_SIZE, MIPS_CONF4_MMUSIZEEXT_SIZE
+1:				# Number of TLBs in v0
+
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	dla	t0, 0xffffffff90000000
+10:
+	dmtc0	t0, $10, 0	# EntryHi
+	tlbp
+	mfc0	t1, $0, 0	# Index
+	bltz	t1, 1f
+	tlbr
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	tlbwi			# Make it a 'normal' sized page
+	daddiu	t0, t0, 8192
+	b	10b
+1:
+	mtc0	v0, $0, 0	# Index
+	tlbwi
+	.set	noreorder
+	bne	v0, zero, 10b
+	 addiu	v0, v0, -1
+	.set	reorder
+
+	mtc0	zero, $0, 0	# Index
+	dmtc0	zero, $10, 0	# EntryHi
+
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 6b1f1ad..31f34dc 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -633,6 +633,7 @@
 
 #define MIPS_CONF4_MMUSIZEEXT_SHIFT	(0)
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
+#define MIPS_CONF4_MMUSIZEEXT_SIZE	(8)
 #define MIPS_CONF4_FTLBSETS_SHIFT	(0)
 #define MIPS_CONF4_FTLBSETS	(_ULCAST_(15) << MIPS_CONF4_FTLBSETS_SHIFT)
 #define MIPS_CONF4_FTLBWAYS_SHIFT	(4)
diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h b/arch/mips/include/asm/octeon/cvmx-coremask.h
index 097dc09..625cf94 100644
--- a/arch/mips/include/asm/octeon/cvmx-coremask.h
+++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
@@ -29,7 +29,6 @@
 #ifndef __CVMX_COREMASK_H__
 #define __CVMX_COREMASK_H__
 
-#define CVMX_MIPS_MAX_CORES 1024
 /* bits per holder */
 #define CVMX_COREMASK_ELTSZ 64
 
@@ -86,4 +85,29 @@ static inline void cvmx_coremask_clear_core(struct cvmx_coremask *pcm, int core)
 	pcm->coremask_bitmap[i] &= ~(1ull << n);
 }
 
+/**
+ * For multi-node systems, return the node a core belongs to.
+ *
+ * @param core - core number (0-1023)
+ *
+ * @return node number core belongs to
+ */
+static inline int cvmx_coremask_core_to_node(int core)
+{
+	return (core >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
+}
+
+/**
+ * Given a core number on a multi-node system, return the core number for a
+ * particular node.
+ *
+ * @param core - global core number
+ *
+ * @returns core number local to the node.
+ */
+static inline int cvmx_coremask_core_on_node(int core)
+{
+	return (core & GENMASK((CVMX_NODE_NO_SHIFT - 1), 0));
+}
+
 #endif /* __CVMX_COREMASK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 392556a..06f9258 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -53,6 +53,17 @@ enum cvmx_mips_space {
 #define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
 #endif
 
+#define CVMX_MAX_CORES		(48)
+#define CVMX_MIPS_MAX_CORE_BITS	(10)    /** Maximum # of bits to define cores */
+#define CVMX_MIPS_MAX_CORES	(1 << CVMX_MIPS_MAX_CORE_BITS)
+#define CVMX_NODE_NO_SHIFT	(7)     /* Maximum # of bits to define core in node */
+#define CVMX_NODE_BITS		(2)     /* Number of bits to define a node */
+#define CVMX_NODE_MASK		(CVMX_MAX_NODES - 1)
+#define CVMX_MAX_NODES		(1 << CVMX_NODE_BITS)
+#define CVMX_NODE_IO_SHIFT	(36)
+#define CVMX_NODE_MEM_SHIFT	(40)
+#define CVMX_NODE_IO_MASK	((uint64_t)CVMX_NODE_MASK << CVMX_NODE_IO_SHIFT)
+
 #include <asm/octeon/cvmx-asm.h>
 #include <asm/octeon/octeon-model.h>
 
@@ -83,7 +94,6 @@ enum cvmx_mips_space {
 #define cvmx_dprintf(...)   {}
 #endif
 
-#define CVMX_MAX_CORES		(16)
 #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
 #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
 #define CVMX_CACHE_LINE_ALIGNED __attribute__ ((aligned(CVMX_CACHE_LINE_SIZE)))
@@ -339,9 +349,6 @@ static inline unsigned int cvmx_get_core_num(void)
 	return core_num;
 }
 
-/* Maximum # of bits to define core in node */
-#define CVMX_NODE_NO_SHIFT	7
-#define CVMX_NODE_MASK		0x3
 static inline unsigned int cvmx_get_node_num(void)
 {
 	unsigned int core_num = cvmx_get_core_num();
@@ -449,7 +456,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
  * 2) Check if ("type".s."field" "op" "value")
  * 3) If #2 isn't true loop to #1 unless too much time has passed.
  */
-#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)\
+#define CVMX_WAIT_FOR_FIELD64_NODE(node, address, type, field, op, value, timeout_usec) \
     (									\
 {									\
 	int result;							\
@@ -458,7 +465,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
 			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	\
 		type c;							\
 		while (1) {						\
-			c.u64 = cvmx_read_csr(address);			\
+			c.u64 = cvmx_read_csr_node(node, address);	\
 			if ((c.s.field) op(value)) {			\
 				result = 0;				\
 				break;					\
@@ -474,6 +481,9 @@ static inline uint64_t cvmx_get_cycle_global(void)
 
 /***************************************************************************/
 
+#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec) \
+	CVMX_WAIT_FOR_FIELD64_NODE(0, address, type, field, op, value, timeout_usec)
+
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6..0980628 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -355,6 +355,8 @@ extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
 
+extern asmlinkage void octeon_hotplug_entry(void);
+
 typedef void (*octeon_irq_ip4_handler_t)(void);
 void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t);
 
-- 
2.1.4
