Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:02:27 +0200 (CEST)
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:45312
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994647AbeIEQAWXH8ZO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hbUvdQi4coNpNCtVIqF6cx9X9eLsXxwA7X0H0+9/l0=;
 b=XVf4VSA8Y6B35D+6grf6dgEmCtYvRXnHRxRoh24or6jNxd2x1P3HlhdYhJZGHGfc/FyS5Gp3XLmRk5BzuG+y+8mcRAKUvnstELz0YVqr3HMT55Ul42Q+dB6no76cek2bRfV1bG+hHHfZ7vU2fdpLAcLphA6Kozw4enEHYG2rGiw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:00:04 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 6/6] MIPS: kexec: Use prepare method from Generic for UHI platforms
Date:   Wed,  5 Sep 2018 08:59:09 -0700
Message-Id: <20180905155909.30454-7-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfa14f7-08ad-465f-bc8d-08d61348a557
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:IzU7La3+uCH0USBt/k0SviFe+KW0TeeFVazklb48ZKPEDCVQIc3plWLXGcewbDbvAKqZWo9j7q3BPP7LHQK3RntsiaSBSWzxDaqDFlV/adOUaXfdl7seODRzln/jgCOr8CXff6IGmsC3VVJBwAzZvVYKfdOQE2rucYTRyaTXy9KdkYRsNHgKIu7GFW30lfhkQnHpouGHQyTcmxR8GfTRWYaNY2K7GzK9ZzPcZJUlbquwJL38VKlmb0RmreYaiJIq;25:T+7PsAqbEf+lvAlQL1+N0vOGeHWg2FrxnCEmVxRLAMW9K5uULtk+Y5uX6oCiKMjB8RVUxOEG4PA4Y3HcfXBthTPHupFmjJPSLc64hM6fwVXO2+3dZUisytaTwRUfLAgOdkCcuYWzd5QHuFI3XUrhqSTUQZzdFHHYOklPnDtbsi/PeNTHIgZoW+YoXcgVCgv6j/Dl9yEjd+29Ig5De4iEnngxWsJVE/QaYKXOjiFprOc/80FN6MgHv+GNG9kwRks/NoH0lDap9YW9jdrpGeEv6FdoBit5y/9y/wfUb0cpWseyjaF3HZhKBDYSN4XXTKgCzg7gNPgQPfh9VBOtJUim5w==;31:qtWGl3pU6zQ2H0ayP1jUWyH6wNqXDgNzdkccHYMtv1nWxGDXCesvP60HCL1ilge7EU6MTCwIytoF97kL8e/+6+o14eXXBlElT4lhgXQwFTTGOtVHwdoeLyn3vFJUJbrdt1tBQ3Rz48gL+33YJXPj3D8pO3gQiaDB/fkIByphgrfqmAxOl571e1/zWMcGIc1qR4SQ2euBBmaIJfc5f/7l03Gz3FmXF9AESwynOitBlCo=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:K8+e5XVyWRYRwRBYQ4X/NGofM4ckRWujcAEBcfXRGXk35PmqyGI/Dt4+AbIHsvc+RxjlLGd3R1QpiiM3uzbAT6Gbcrhz03yQSX3+9GijGsgXxemUZfNAutEYxJRS1y1E/CzjpCB8kTEovUahvvkINqY1Mr1QNfCRohelHLBRaeRv+mH8wehidUSWxn64Kl9toMDMsAdKMromovsUS9YrGS9civs4Ybh6UaG/vKurX5O+fJuNEDSe8dppEoTmWuqd;4:72ZnnRtHlJPcUaH6eqkooHwvMnLYm6lBYRYKf9mgFI3uF3deP0Ms3TrqfpSVSVwOaijTUQzCQWY00AT9sy2Pq/LpvhWRS1C/JriAOtMgJZwhZ63mQfuZdqbvqCqawAyVKQarI6ZSBq6LxDpcpzAY/uuBG4vdGyrwmWtgJ1QiuCG2HBp19dAgAUvYBmHGLli0DxWikVUdsmyNHhIsOkWdXAW7V08T3gdjDiOKjbTwKok2cwomwClj7P5ClLBCuiKvO3Qqz4BoSnQniqXKd6Wvn6uKKR2Kk0wW7r0bErrQTGRxLnsSr0EKiyzCblxzj9bp
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21457574BAFF1A9EAE41C924A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(14444005)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002)(41533002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:uL0IBWXofqPTEpvB360w816K8IRaU4arIM2aE6D?=
 =?us-ascii?Q?1lNVtcVCsKSYwLHiLkSwaMFIrXwYPyiQ2LGa7ujFrB1Q86bqNnFixsTVKaZ/?=
 =?us-ascii?Q?yksPUYjJtUAXHltNMN46Hmdf8KsmaxIqQWp9VJ/4wkCnW6/xRHUknuKGv3cW?=
 =?us-ascii?Q?+Ce3Xi7dfwxZEqiV7JP06GxGVd8JwoNUXke9pzBJOhp/mYiiruAM3F6Tx692?=
 =?us-ascii?Q?/DvnhzR8+WPWQj230hWDN2dEk1RwgN5YBGbt/q6E9VklP2PKmyPJbT0D0Giu?=
 =?us-ascii?Q?EpSgtwQgHzf54rg2/3fJfWNRcuSCA4JPXR6bwfsWQnUC9NZeFkCveAXZBUBE?=
 =?us-ascii?Q?psKolF1ngVtQ8nmfzSMKu6Fc7xY8sWhULpsysNffQ1lSGkB4D5b6v9Mek8XA?=
 =?us-ascii?Q?OGDs1nYaPip/EpkK+ol8mIxHrxB6Gb0LajQCP0DXAjZmu7ZQB+ikKuPd3f6G?=
 =?us-ascii?Q?2flpigWrz9HdPju5KoDrTeQXaxXpzD0kJNz69DWPiVEZP2kIkvBNoEg73COQ?=
 =?us-ascii?Q?ACcbZtuiuwU/AKIggQvXHjsllIPYwqnBDTheE14YMROosu3gEq/QfU+aK2/+?=
 =?us-ascii?Q?fq7xkRFbmzdDws2a18E/Sbc5FtJjf835MgsNakURYB5m46CsK6g0bh7Mj73f?=
 =?us-ascii?Q?9yo8meAp/00JD5p6c/uCGl7IecizRu4b3RujWuKteOfmWEuHpkc1cOr3yqzz?=
 =?us-ascii?Q?PV2ToJtntMLhbb+Ybpox1QdjUI0oXTBXiV4NZ7YVSNgpK+XLICiBjZAMD02H?=
 =?us-ascii?Q?cx6S0TSZqPGiX40+KT4T90xi6WhfbvzmTwu25wg+RsaAuS78O+MUzjCqXb/w?=
 =?us-ascii?Q?Yfed0AKDJtB/GPwNzhMCUl5N3uTiSqXA7v0Io5ZKerRMj/1M4/Fc7X4Il9QA?=
 =?us-ascii?Q?OVnYaOSMntdILhRVSuQW9zt+G9QVNaHVREHFjswF/CUQQR67LdDrWIRFYWKS?=
 =?us-ascii?Q?uKIUuMDDLR3yTLi7O2XwcLErv2GhfBDTzNR7pSnTHhPr91Gz1gRrUV+pG79R?=
 =?us-ascii?Q?vs6sX2YhrdhFge25RFIZLygS3NyTJzLbdZ+UUCXucYRM3MpVUdtp1QnTbxhD?=
 =?us-ascii?Q?YhVT9gD9RDv78Nh4+Pg3SMSn1ns/GPBhO+J/nXngDzLDe1tBqcjegiOiclBp?=
 =?us-ascii?Q?sUAJ22f3wTuiCn3d0tPPof1mQim+p5unjpPW+vdD+xamlHgJ+NLJcBUTzQqr?=
 =?us-ascii?Q?ND6QG8sHtqV257vOD44iwJ+WFOfNIdhU0RudP0A0khm8ZyM0ZRhYpXcTEY5o?=
 =?us-ascii?Q?RDZBcfD5XpCiH1jJPfw8TulOOslAY9cDLtFBcl2KH?=
X-Microsoft-Antispam-Message-Info: UOJ+mq6DWRnqXiYYeuN8UnCXGnde7te1dbefhtH2rTuISMzxCdYp059Yx4as9mwv6JTvkSzDP5D69AGsAShLOC7ME51wmVlxNvz9bsSqFJIUappaUNFuDSiqR0IsZt3Jinrs5HrTaLx5Cy3i9gZNo+qP79xsIPysn+BDIpEabDPciI0pjiXzyNuqrdC7Sg23ibOxNewP6XwWymgG3OL1joDEIyH71PQlpA46Ckaw6tc7qy1nLDwcR/ISdMIpXbqg9msO/DpWMkF2KnLZTU1XON3+33VN6kKD4B8Aabl66gay9eobUTg8RalwdtjQUbzMxl69r3RGfufT9tJuZIcsBfmGAJ4DIXCAh1fB3DWpgmw=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:Wv4Xy4axFuUh2tlcJvZJjbVsnRWJwHvzbri0BU/YFIs/2IXDXcW4FK4D0erO9ZDaefS/DkUXUFStnWDcKOG3kKIoY9WW7VhZWTAUPRecYCsm4lKffzOEH5iO62vlv9r801vxDv74MSK5VBujlx9e7exkxVDwe+a0lTGaIhpHNvGXCewudGvxcl7v+PsyMubuiVg7udj0OvQBA4TmeL1HBp6nUKumQTA80B4fqI/0zkItjkvOHvEooIYtVKwfmy3hPAnG5RWCSCvbxnPCzLbldHipLvpDoiVjG9ZMED4XhDcPaFVJQ7jP/+U6Hqr2ljQaKhaezpcXIceHeEZTahQJTM3u9qPIaAN2pUfwJtuJdJW3bMFZ4/sr7pgs3nfJ/TyMHwcVsd2bOm1dL8VVvdsCVEo1d11+ZXT9o4jB+rmhcaVLD6zUeIVaw//lZ2heCmT2hrMU5dWRpUF5JQOsexTLGA==;5:VPAQqqYg3ekBjmfrm/hGauukvm+lb4/Q6m6zSu6zckNprI6S7xL+zSkBNEB2MHlCKqNCts7NbakDXxgvpaIXIY7iuHPmfcsDISjjRjncT8UOC1gD1TnoUFgdacv5grctxpDuTcKvyoSQa1MGd4LMW4+Ovvp29Q5Y40rHOpLGKeY=;7:XC2v1C/qY2wV4feqEVhTtDf1wquF3xzzOdT+G5h5KFhrR51uTLw+mG77/Oc6l8OiBpU6DfXce9vFu32gqlU6YPuvBObrN1yjl16ZrhgzdBRaSuECfwSgP5Phy6FMrQUIJRYCsigmZw1to5y5/LE09PL/D21/7808frTlnX0cl0wD/eXG7SqiFiY6tLe1EOUKV4anQBTBP4BtIeRV8jaDm8LtnhHP8PFlDaT1+nPC4oXcnl2kunboRDpxNAE+45Gx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:00:04.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adfa14f7-08ad-465f-bc8d-08d61348a557
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

The kexec_prepare method for the Generic platform should be applicable to
others using UHI boot protocol. In arch/mips/Kconfig, "select UHI_BOOT" is
needed for such platforms.

If the platform has its own method for _machine_kexec_prepare(), that one
will be used.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* The kexec_prepare method for the Generic platform is defined as
  uhi_machine_kexec_prepare() for all platforms using UHI boot protocol.

 arch/mips/Kconfig                |  4 +++
 arch/mips/generic/Makefile       |  1 -
 arch/mips/generic/kexec.c        | 44 --------------------------------
 arch/mips/kernel/machine_kexec.c | 38 ++++++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 46 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..260f2ee083ac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -129,6 +129,7 @@ config MIPS_GENERIC
 	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
+	select UHI_BOOT
 	help
 	  Select this to build a kernel which aims to support multiple boards,
 	  generally using a flattened device tree passed from the bootloader
@@ -2907,6 +2908,9 @@ config USE_OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 
+config UHI_BOOT
+	bool
+
 config BUILTIN_DTB
 	bool
 
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index d03a36f869a4..181aa1335419 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -15,5 +15,4 @@ obj-y += proc.o
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
 obj-$(CONFIG_LEGACY_BOARD_OCELOT)	+= board-ocelot.o
-obj-$(CONFIG_KEXEC)			+= kexec.o
 obj-$(CONFIG_VIRT_BOARD_RANCHU)		+= board-ranchu.o
diff --git a/arch/mips/generic/kexec.c b/arch/mips/generic/kexec.c
deleted file mode 100644
index 1ca409f58929..000000000000
--- a/arch/mips/generic/kexec.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (C) 2016 Imagination Technologies
- * Author: Marcin Nowakowski <marcin.nowakowski@mips.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#include <linux/kexec.h>
-#include <linux/libfdt.h>
-#include <linux/uaccess.h>
-
-static int generic_kexec_prepare(struct kimage *image)
-{
-	int i;
-
-	for (i = 0; i < image->nr_segments; i++) {
-		struct fdt_header fdt;
-
-		if (image->segment[i].memsz <= sizeof(fdt))
-			continue;
-
-		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-			continue;
-
-		if (fdt_check_header(&fdt))
-			continue;
-
-		kexec_args[0] = -2;
-		kexec_args[1] = (unsigned long)
-			phys_to_virt((unsigned long)image->segment[i].mem);
-		break;
-	}
-	return 0;
-}
-
-static int __init register_generic_kexec(void)
-{
-	_machine_kexec_prepare = generic_kexec_prepare;
-	return 0;
-}
-arch_initcall(register_generic_kexec);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index c2119e448490..209196b195c5 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/libfdt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -23,7 +24,6 @@ static unsigned long reboot_code_buffer;
 
 typedef void (*noretfun_t)(void) __noreturn;
 
-int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 #ifdef CONFIG_SMP
@@ -65,6 +65,42 @@ static void kexec_image_info(const struct kimage *kimage)
 	}
 }
 
+#ifdef CONFIG_UHI_BOOT
+static int uhi_machine_kexec_prepare(struct kimage *kimage)
+{
+	int i;
+
+	/*
+	 * In case DTB file is not passed to the new kernel, a flat device
+	 * tree will be created by kexec tool. It holds modified command
+	 * line for the new kernel.
+	 */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		struct fdt_header fdt;
+
+		if (kimage->segment[i].memsz <= sizeof(fdt))
+			continue;
+
+		if (copy_from_user(&fdt, kimage->segment[i].buf, sizeof(fdt)))
+			continue;
+
+		if (fdt_check_header(&fdt))
+			continue;
+
+		kexec_args[0] = -2;
+		kexec_args[1] = (unsigned long)
+			phys_to_virt((unsigned long)kimage->segment[i].mem);
+		break;
+	}
+
+	return 0;
+}
+
+int (*_machine_kexec_prepare)(struct kimage *) = uhi_machine_kexec_prepare;
+#else
+int (*_machine_kexec_prepare)(struct kimage *) = NULL;
+#endif /* CONFIG_UHI_BOOT */
+
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
-- 
2.17.1
