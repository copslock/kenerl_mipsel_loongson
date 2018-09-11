Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:51:15 +0200 (CEST)
Received: from mail-by2nam05on070e.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::70e]:27336
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992871AbeIKVumXL2Cb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s36KzIFUHC8JUYn07GbAsCqopYy8LVbEi4cO86fFu6Q=;
 b=VdF4SpzOOefqsKZ90KBaGLxKeWsr7RyjA/4i8sY1WcR5wuWAfqi+jKVAtp9w5KgUqA4M7jodLK3ibl/VlsiFTOvyMSGVRd5jRsVf3YUnbYMp9n/1Mjov1N2eomt9PpVa5EXTjKWJ0ZWv+tZ/33MEMl661AMKVkdndsWm7+X2Yh0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:58 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 5/5] MIPS: kexec: Use prepare method from Generic for UHI platforms
Date:   Tue, 11 Sep 2018 14:49:24 -0700
Message-Id: <20180911214924.21993-6-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e69961d-4580-42a4-b42c-08d61830852e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:ehF/4A9XrmtyapVOGP7OgsnnGShWD/0ul8/Hvs88tlsZHDrG8lK7ujV4Ibd4+1no0fYZVyggvggAQdCS62uQ2LrC1UHRjHjRDjqxJbNoJipfat3Mo2sNESr1yKjLwvRKrZUoohVM2uwpDt3MhheOokny0Tmuv9/d/3WMOTA8zOnDLgzjDjvSykDi7Rx2bFYSLT4o3E8w2nKb7JE2OSp8w4QQtPNO79qNLIOtbnG3ob9ipbjFxaqgtWH89D/EWlcn;25:d6BebVJcWlpRfZ4dXIMcteUYNWjZNV3M0N9p1N7xjytmWpNsrZZ4KylgoAPlE8vjD51omZA25ZA4bJSJk/BJJxO7KU8l9PY88+5su9NAdhx4WAm/72Wfmv4nHvOPhvsTE3GstyhHLt+eO8OUzbYyIeP/dE2lLOom3pcfhdC1gWb2WYsA8UtvoyYtUlW/zKRRKAnmPRj9kKh9hQbnF+DSMqKsqW2fxhpj3lQ2pD50zprsz2z0oD/AJ+ggyRSMRU73LOajDx7ZRyiFovtkLLOH2QOQZELqDhPeuFFIV7taTfcc2yFIAnEAI0GMYxma913FxoRkg2YeVnNGjiKVFF5wLg==;31:PIDYdnftUGFqmLTYsXOxviFESQSXv9G+5JNeVOqKhSFBOj4f0GAIylSn2A8ePs1dkkRYA/X0VcWUg2BdxLUFfZyq6wbPNJTigLTmPIVbh3f6FPFkS4JmihPjuq2gugMvpNJaI9Rsp1eDTe536na6Iqdjzm+G5RwGa3BcpvFUpVQrq+BBzVxS6tYSs/510GAZsn4uGOG6LRIDkJ5/GqFBgIFdlJGQlOe2TKraYZ9Uc14=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:T8GqNKY1mSEahqZBMPo2KTHKL/1zWkPXaH6UtrQvEys5dV6bACsy/iaxYar9ofDpjbrf0fZL+ed5i3Q/kwGLuCDPGlqQDwAYORHkxnIcAUHjM40igreG3nsTOutZ6x27D1eqIRoxBqQzHesAdSLdu57KjvcLijTXzx12JomheKMEYaDxnhUmvOeMR8FS7nbp+z4MD+JyyjjiRHoZ9I/RFq9IAnreoDByVTOGQIRo8nuBKpRfVSwJ+1dKSYy3zKtS;4:d1nXivFjGCptipKbe2nCQJd2AVWqcxnY9NSM4jV9WMavRHhRqaARnf6xb1OAegYK2hgVmiJGc1s1Fvs8fFOCgHDldDBw54RPCIkNJNmx9IIjfSeQ3nB8m6TopJcwYMCm0bGVdnhdvSso7X5mHS/nvL3lLVNpLbDmF2CcwapKbMWKJXXbnGI9agKq3mIyUXvMW5K61QPoTztoBUnYho+6gqm9MlI97quwjUdXWBdLdtqO4arFKZjB7x1hdSKql8mkIQj8OMcUWp32DNfpXij7V42+i60UzkUnvf9tQuFifLxXc3wUAylB1PGphFx4kr9UvfQlpkTazMT0mc3miZ3kktaP3jScl/XLeyVwi5wxyVs=
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2145B8E78A070C72499B7D7BA2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(76176011)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(11346002)(446003)(478600001)(107886003)(486006)(956004)(14444005)(476003)(41533002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:iCPftPJridkqlcKZ3kRF8C+DnNXwk3LH9ySKaJA?=
 =?us-ascii?Q?GvtAo247TgiJIhaMDYVEr65HkN9b9vUfgjKJhPxZr5E0NX33arv6FTOPCFT+?=
 =?us-ascii?Q?DPJG1vi41vt6lpuTJL8rQKTzOW4/k8r2D3WrSV1tREoavvX0hRPq2N1QabtQ?=
 =?us-ascii?Q?rmbRvLEmtqj9Z4bn4MgD0TH71wQDRhCTQBj5XF79JKd0pokiDJewSgsfF30u?=
 =?us-ascii?Q?ZJIzdX4bUIJR+B9UPv/7c1fOKUqbunA2az7GCYaG0FcwhacQdCa3yOkmdgbN?=
 =?us-ascii?Q?b0bW86132esBqNiwGZKKSjjYVSEA1Q2ClxMmAzUGcPzP8Lk5CHpZDLPZjdXO?=
 =?us-ascii?Q?KOaAQo4v2nMeowFrnMURGyr6t1NvOr9Kr9o5XaQQ56dKSPv1W05K+bf4X+C4?=
 =?us-ascii?Q?EyVgxBOBaX/g0jpJWa8eMNjoNg6odvrd/Dy7OmvBOHNIXLFj9Fo0LeUdfiYC?=
 =?us-ascii?Q?btHyKKjhh9GbmHr/WtJzH29VvVsSv45TkxB2/LtcjD5UeE/+0x+GaLM1mtmO?=
 =?us-ascii?Q?6Z2HXqw3NqcKGSrtFrvenO4AZuzkqEUMl+rb0v0CNg/XgdHpJ1oTO+ar+ADv?=
 =?us-ascii?Q?nd20I1U8w2gnY/XB1riB1TOmCpztgfKYVacyE1U58h9O7I33iEYmoSfS4jog?=
 =?us-ascii?Q?JDpy1Tb4nkSp7KdHLytweU3M9GPPzkR8LDVKo5MjkenpWzTBdOmceGw/vBex?=
 =?us-ascii?Q?DpZMHYmXY/tm7/6JFJ1adL50JXBzlYTe2THwmCRaYHTbCSDzLC+wC2uJdpAS?=
 =?us-ascii?Q?wLqEUTvjIpLruf0GufG1j8LuGtMlC3Pv4pjkZgUt8LZVbFAnbwuZrffrS1ah?=
 =?us-ascii?Q?L7OKulUh0CP0fSmnTJDnRSqOh+NrgQ7oW60EeQey4j1955Zg0M8gYcnDpPA2?=
 =?us-ascii?Q?6HMaQy+Cy92RRiqt4kulLTtZsKaEh/c4/qV42guvgVykHmb/T+IXqAHbozRc?=
 =?us-ascii?Q?xNe444D88oKyUZ4LmsXeUlAoRHvOynqrt3uVNY+owFbR7pkxXvpYnYezDvia?=
 =?us-ascii?Q?stlmattDAc15btmoe556T4bEFYf883pz9fqbkfBs8PHW/FrMRX0j884irO7b?=
 =?us-ascii?Q?HzuvkddJ1+tlsnvjyibr27AM0l7wOmwvX7YojHeAF9/JDHcPuOupVJ+GkLHi?=
 =?us-ascii?Q?CaLEGxTxVeYLAeg5NmCfFVmLPH8fknbLVXQY7EAkTqKHg99nfK2h5e7AmCfB?=
 =?us-ascii?Q?SDHNFbJeLVRsNjQ+uLPQSrsEenUtymusCScxvcSgTUvTtCx3rjvK/oW+y92h?=
 =?us-ascii?Q?SphML0M39ZjjZA+/WJoM9MAIdoAHGzsGePV49hbu3vaK+sDMCgHwHC3W21i7?=
 =?us-ascii?Q?OLg=3D=3D?=
X-Microsoft-Antispam-Message-Info: OxrFepXF6zVRF/Slish+TBHYyiiEz7PPuBow6AaZ5+ck1M1bTKzlTfWatevbSsx69a+s9f69eYhAOemP40CEa/JMIbKPjC5oRXys4mUXAoEYiQDvUJCd3VZ/QueWfick4nSWJMShYTBDqHPTbmHpFxXpuMMDsafATLmVzBUw0SKN3/VNwo7yYcKnn7dXLW0gX8W9+p69L5hyhffhdRfUoR1I1be2s1KvenqaSM70mFRYWE5I3pn+rHVAogKD0FzXM5+ll1pXqPIZJOjXpOhNCA9EzvgQd6EwlXAwX7OiWeNkdhOQmSCTvBiH7pm5HumTj3rxCgwG63IXQKpRldTEjKdD7/NrLYlY4YvZo5W728s=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:LR+7Rbn2LDevBKnZm0ALUuQ4MC+hF8+ck3q7j8V6DXODc94MmzaGmBlJc7auRnngIwaGjbFlhKpmIx8ZuJ23xkP9X/6BIuTQGWzBtMjWvVHg8R4lP9jBXcOU+X5FtSP39OpmzdqkmtclMkOzVRvGvMyO1enZbn4XTjjfZQJlWMxhaBKdrciu7NPSm3F6PxjLsvmAHZERK60F3uZ+jrXlgEzEGHV3trSU90JXfq2Tho3nj2lk/At4+3wzuoAeZHfrflop3Ka4FQ8Ahb/2FJRciFPRJx1nzg9S89yeIMVZWuBQ1sf+H+caH5RFFnosFXC3gparJhlv1dy1avgrOfdwcf2x06rnb8Pr9y5Ul+7rsZSBWnOcwcD6snUtpKNGTDp0q1hvoasMkJTZLAblHmVpxFIqSEXdvIDIxgY4Xfx4rLBYGsdOiACsqLJF4fHn8hwieTLyhcFYagp3XtPLGgF0KQ==;5:lEhF8sQh9U+0sNfv+JgBQ3aBtqJLnJ/ndarQnC8i/j7eljumpLidS5ELmU4wp+s2IPGTcTZuGwvE9T4sVe01Teqt4f3X73yisAyJs22+62P6W4D2zSXUM/4tFedpFyHzhmXckFFhdoObcWE+xSLRtjVYdWRIwCRSyt1DDi7e120=;7:m2sP9Cho50fTeVnQtbL29B+ecpSgCIAMYmGOA8//ycUbACHbHHml50Y7tU0pk0vCp65lLnTTbciU9H2VQZ19uXaIJCaFTcZut4BjW+GSr6BgWC4d5kdfsSdF707EStFolVYdGlFBToonRXkqSkjNfH42acwsN6FPVtcbbLdS8DiwWxsx24jcJ75a0clpUDLiBpTtY9btxM6wGsXaZnsCHNYZtpjLgSTYa/3YWWGEWmJziL+3LF3I1rXVTKZsv71X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:58.5656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69961d-4580-42a4-b42c-08d61830852e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66210
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

Out-of-tree platforms may not be based on Generic as shown in customer
communication. Share the prepare method with all using UHI boot protocol,
and put into machine_kexec.c.

The benefit is that, when having kexec_args related problems, developers
will naturally look into machine_kexec.c, where "CONFIG_UHI_BOOT" will be
found, prompting them to add "select UHI_BOOT" to the platform Kconfig. It
would otherwise require a lot debugging or online searching to be aware
that the solution is in Generic code.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/Kconfig                |  4 +++
 arch/mips/generic/Makefile       |  1 -
 arch/mips/generic/kexec.c        | 44 --------------------------------
 arch/mips/kernel/machine_kexec.c | 42 +++++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 46 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..71afb3593cb6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -132,6 +132,7 @@ config MIPS_GENERIC
 	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
+	select UHI_BOOT
 	help
 	  Select this to build a kernel which aims to support multiple boards,
 	  generally using a flattened device tree passed from the bootloader
@@ -2898,6 +2899,9 @@ config USE_OF
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
index c63c1f52d1c5..93b8353eece4 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/libfdt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -28,7 +29,6 @@ atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
 #endif
 
-int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 
@@ -52,6 +52,46 @@ static void kexec_image_info(const struct kimage *kimage)
 	}
 }
 
+#ifdef CONFIG_UHI_BOOT
+
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
+
+#else
+
+int (*_machine_kexec_prepare)(struct kimage *) = NULL;
+
+#endif /* CONFIG_UHI_BOOT */
+
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
-- 
2.17.1
