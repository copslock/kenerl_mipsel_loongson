Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:49:42 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993961AbeGWOspwGJln (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKUR+T8/kywV98heATw8KLQ87XT4cUb5sRjbcnw6JSA=;
 b=KGkaXV/jKj01bWhV1OeNiP/iwRG0ej7YfBM0QdBWXdAiTZdaFVXGIWdF70RT95G+xGBUAT7pQSUUQ/1IdFevG2T57PUIvFnM2NcALLYl13L2iuW1mbsQZaObP4wLpjSpQws/uzeX8stfsHUgbh9tmfxcbRQ0zJWLY81zgb6dqXY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:35 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 6/6] MIPS: kexec: Use prepare method from generic platform as default option
Date:   Mon, 23 Jul 2018 07:48:19 -0700
Message-Id: <1532357299-8063-7-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a24736-96cf-4dfc-2759-08d5f0ab5e52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:1eBcc3YsLyzcUjqesh+/VtjXSsgKzwRrHmBxyJuDmwme3BOTeDCAhgb4cCHFWthNAimWx2e0FpPbUzF1h8fhkEi72g9Ki5DMZjp76Vtk8E07ZWYsbtVkWW1QD4SVsBR1hjgdUnDJwjcts6Yeioxx+vfKD95Lf5SUwfl3SjOliSaM2A3fexEFxeJoVMB18hbRD2szgWaabT1eG10+IssEL5W/95oY1V81lX4LZrd4h7IYuRIhNaNf1zWKjxgm9/2M;25:H6Ho6lIQkuW18vpy2E5DbRhgVmhUcTdQFzJx7mISmqXO2L7qC8SGLc6kyZMRHPtd0Bcwsz/N8lnxo8Cy/vCW1XUmgoyl1YVc6mJajBVMybgUpz5jg9YuEKjHj3ymh0ujsqKM6EszWJRo5KYKa+F9jcCjle5FAoiB5nL4kK6zfFy7i/oG2HGQxKc6VCzR/mNK8EIocBugTzD9m7Cw+xtlntJzlLuxoFU+OX5ab+yzKNdmS6KHK8nY13V8QqBtkouEDjRXQHqrGEZ2BmnqQi+OQ/CaKSJpMS/LYwL4vJF3Ca1d8qfFbLWjehpFzu+Yx6SosN0FuQBNGmcL/toAi0xvtA==;31:qjxlEKL23kngqp7/SkheTE7rCHA+GUqEoyUk8ZGpC0qVqbHmi0jDi7Y9z56tAKLYbZRdWl36RxMPLeHx2W80r8WCC7NiWSB3XrMeb9w3EFKcZB48puAfqu98MykkGrNQTNTOnLcMZeF2Wvw4H1ISjaIoigoi6qknO4IoHnCydZRDCu3mp0FzpZrorO3iOPps0vMA46GOdWCmtUl2baTfy22y5TzbADo8RutrQPPGKi0=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:TZVE0vaQ6ait1F9ju2ErzMALCVh7lJuidYmrFiAo8KlgYEJ561ngeInkMZjnlRuzCEsZ1LDzijJDM2dJ+mb4FvzdFFdhFJMeyZNjT/1ISkj0ah/3Mcd/VGbu8K9uBe7hKzKp/NzBpOGlnqt1qtTgjSbyuQNY4MxZpPQyFl0LcIEaziL+Q4Jk3BXuYs+lfB8rI1EM4/lZFhPVmumJIjSJ3y5p+26iLIA5DD88o1dHPoRurh9Eek6u9hweWQvSfFIw;4:necxUcI8rXUar9a5tLU3pTIy/TPIcroGjYE+rKSXZP08twNgHaV68FBJFmTjS+TdKuVr9gGr3xrMmraV8Ior5zX1+JOjW2ArdamKQzu0Ku10s6auc2UuLfRJ3SWdA1Sl0eB+8RLhqQ/Z5m+JR2r0mC2YofaWF81rN1tALkUypd0//Rx+2AOU3txYq+Qu0n8ncL11OHdNva/SmWGbeli++c/c/zr+mCzm/J3qGv6iZNNakuEnXircD/Ono6x4cghzIgDrzVSPBKIborM45Tc7J21Z3ucAdxs7Sh/Ng+oAE7hueI6eiYXIZ17TSf1C/vbc
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21556FF7B8FEC80A392764F2A2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(14444005)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005)(41533002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:uLfzl0tfCCvrJixT14P21D7jkQNB9UbBP10l79l?=
 =?us-ascii?Q?YLnjkQe3zFeoJT12UyWhzxTwKWFcgALZIjMcZIGsN15IaRxCtnDuaQ3nsbGz?=
 =?us-ascii?Q?WQ2cemVau5zoGJTZEBod/dM0tmZKMI2os+7YPIjH74B6KNq8goNBmOy1ETbu?=
 =?us-ascii?Q?jLZKUaHIzWOkuMAv/dcoFGxqgk7CZuTpQ9APlG4TFtrz/RvbAu44DY0xJzVD?=
 =?us-ascii?Q?76Fr+JLI2yl7iTgWzSmmd/tbrOSvvQC8a5iV9A9h3ZtnHZfT9aN8+B0YNYls?=
 =?us-ascii?Q?jm8w9LiVsiksyXzev426jCVRgHsPYEhgUKCMF01nWxeAcozAoe5Hpe9koDwD?=
 =?us-ascii?Q?v9rPFmnUZTozm7m85F0rhjrVDQ3jQGt1P3uust9ZkkeL7KqkhY9fT9xOTOJe?=
 =?us-ascii?Q?j19UqkSkXB0OFmXCRDbWgNd+pPxXA+T6qZfOIaN3gaxw6YwZaMj9p0UjimM5?=
 =?us-ascii?Q?/I/3YKwIJ35wVcnCqgxJrHVv59PYI4u2h6PZOxsFq68IPUtdjf+nVrcr4qk+?=
 =?us-ascii?Q?+d20RFHbPaqbxf+IJIFgs4wlYSNnI4Vqdk4Kp1AJDti35ESGjWP5HfMI3G7K?=
 =?us-ascii?Q?XqqLc4RsxMf/OsRBgAFud8Hwj4otq10oIt/qYfkwbJZtEul8F1l0NZ9wNZFS?=
 =?us-ascii?Q?/tp1Mm6gzfsNkaP1KwKF1V7c4G5rHLzBuqw8EUcug3ppL78XupDIheUqTDAi?=
 =?us-ascii?Q?v/Bd8xQTNhZwznYOgRVv5gJiQTJSFd7Vvh0MuhLaQswXqiicgMGywRMAPYm5?=
 =?us-ascii?Q?AIb+GhNH0JlhUalkvPH6J1gcpf3cPhj++TlsFldVEW00DkHeSuKJrSc36kUl?=
 =?us-ascii?Q?L1+almi9ePVXS1TfyQ0p4KNg3WaywEkbyQbPVzYGwR3iBcQ3XIUJUmk75mVI?=
 =?us-ascii?Q?dXdXfIQCnfb0o+U5YHRuxyIxLb8Yl1cLvQuUy4mAyXUIj1qGBwoyp1DO7dWS?=
 =?us-ascii?Q?jOHJw3acZAFUOodIk53Bxtd7pPNouKFnUMdzmhrFTbGqVQ9t3dvJGNjJfQQ9?=
 =?us-ascii?Q?uK4i3SMik+Jnpz+sPcK2HLnhehrvKaxhBAoqjHSl1O9kfSu5034LNLJ47xP3?=
 =?us-ascii?Q?UPEWLAGZXBdMaR8zrsbZV1I+b06XZwOuZwA2fZW6WsTKwwZUyACMvd5zP1xQ?=
 =?us-ascii?Q?p9EkgFGqrk5dXGUhSiCxMyIlB2xM9awTg0V5AjqZ83RX73mJpxRUEoyYKaJw?=
 =?us-ascii?Q?YQxLeNKz4TAv/qSR7u5MtC02NBBgGyzsLkMvIRYIzVS5bLz6c/45JTqeQTzq?=
 =?us-ascii?Q?8Jq/7FhtHhi4HMUXLNhaK9Nyj95VCu74+ZRYTHeRw?=
X-Microsoft-Antispam-Message-Info: WScyFioNHFvb6IDlcmW8SsPgOUpUxKcQhavtDefY0rXpqsxpPe/zDTzotVcjlhNNoskpXwJhE54ptTWePvuCJy5piCP+M88Bhdzn29hVm1ZYlgHZAhQPoP4CK++eST2zyesdi9lZIbUdPaeUsRZRBElUAr02lnhzXzow1bMK2mKhsALiIGS/J25o9Cif7Q9bfwErxrtPiMOSaAtPKkP3uN7RS6VRk5AV/zlAREXRZyzuR+9JKibgG8xz1fq+BDyF8u5pYic+gy/Q0TMK30hc+Y/qbBR/RBWOhgZ9yeN4Xl5G0rjovJo0FD4JKum4+djSvzfb9KyhSBLyH286yEFKzHqJfeJgZDo8v2fHJ03xE5E=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:gw+UKzjBWq1bXIrivil9+AzZg+E6RNqGryj7E1eBM1q6mKXdtt9WE48TCvKx01UjJ0+jDV7WFIjtuqakPcJEQs65xdjE8pQMUl1n+y1VAa/Ovavcgj6aAmrHANme+Dbqbz5ebcRTLwNovdi+qwa+4T8mvNKvkPAn1h63G/PBKhm30GXG/sj+qwQrHlnz9UyBg7HrYGq5bB9dp/snMqPNla4weaTNhD28P0AgLHbb1BCo17pgTVSn5mrpvNnwhALYamW9oIPGUAJgBhDQMFMChd17nn80j+9Hm05qneAu4ZfxZuANEDccE+KV3wIzTELdtFvIMnCsUupiBn+fGoTgfUJ343H4oYfooAX9c7Pg6KjF6vNwG/pK/ex/0ir8Bx7aoxlifAdrmpFSGSIYUt7dj6zMwXA1ZSXI4Z9pl1b0qQiwSPaHkptgZmo4ULD51WaAgmwnv+3cA47yinoBvghjzQ==;5:WpIsX6GRZr1GBbRObBzwhiJj7i2MMkRQJqqX6y0zCFz1N4sfC4LoHrWNjsAZrWD7S/8D+h6rKhnymWA6VaZs3YxU+slqLuyfhFrYLBJdOMinX/TpZc4rS2Zxj97Hx4WzPJ7yCQTw40EwkiThFb1/RLyGKix1kst584zNAxq1MEs=;7:zU+MK971qKBJ1Qeq7z4DADHsgYWwQTiG4+xPGm81lfYk30R12xAgbIR9vdPRl9jpO+xhqIkJwgYq6kGqOShczBB9J4efvG2odBdpEwlo0penN1o4NxVmGqIq0dpbovr7QApItFkFMqB8IyQrZAsFItXbQVHs0tTRJBCLQrD6MW4y40av/tFaJjU7cYI/5KsUd/Tw5GeROHBBCfKqzkFUCmoorUKqJ+I2Bj9vAQB7J2FjOWG9I3YvCQsqlOO3BMsT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:35.0465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a24736-96cf-4dfc-2759-08d5f0ab5e52
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65055
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

The kexec_prepare method for the generic platform should be applicable to
other platforms. For those otherwise, like Octeon, they will use their own
_machine_kexec_prepare().

Without the default prepare work, platforms other than the generic one will
not be able to automatically set up command line correctly for the new
kernel.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* Add LIBFDT to CPU_LOONGSON3 for default_machine_kexec_prepare().

 arch/mips/Kconfig                |  1 +
 arch/mips/generic/Makefile       |  1 -
 arch/mips/generic/kexec.c        | 44 ----------------------------------------
 arch/mips/kernel/machine_kexec.c | 34 ++++++++++++++++++++++++++++++-
 4 files changed, 34 insertions(+), 46 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c5..df62764 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1374,6 +1374,7 @@ config CPU_LOONGSON3
 	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
 	select SWIOTLB
+	select LIBFDT
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index d03a36f..181aa13 100644
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
index 1ca409f..0000000
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
index 6e3f7c8..e3efb64 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/libfdt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -65,6 +66,36 @@ static void kexec_image_info(const struct kimage *kimage)
 	}
 }
 
+static int default_machine_kexec_prepare(struct kimage *kimage)
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
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
@@ -72,7 +103,8 @@ machine_kexec_prepare(struct kimage *kimage)
 
 	if (_machine_kexec_prepare)
 		return _machine_kexec_prepare(kimage);
-	return 0;
+	else
+		return default_machine_kexec_prepare(kimage);
 }
 
 void
-- 
2.7.4
