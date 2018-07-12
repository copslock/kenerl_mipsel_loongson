Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:29:40 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGLB2XxAIjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdvRMvFI1V1z2SZ/Y5vqDUdGteL/ArHbhT6wu1fFjGs=;
 b=cb3tl2qTfZZt2IERUURI0vLJf5paZZGviQ6gNpST/qicBtA7Ri6Y5ar83agjLoD0KYGv7Rahmf1jvNzCkuVbSjWr/v3VuEwGchBuWUWJUvvnokqJqX4lq7kDo3I8UxB71bN43tOdmP6/2y2Ywmb5mmgMHsm7TjLdmlfP42w9cKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:14 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 6/6] MIPS: kexec: Use prepare method from generic platform as default option
Date:   Wed, 11 Jul 2018 18:27:48 -0700
Message-Id: <1531358868-10101-7-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0bd838-12b5-4f7c-b90f-08d5e796bd18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:Q96uHWBPtD1oYRbBQSD71Hrv45OOVfWndq24m2o7qbjavtsNNmcHRQ0/WVyN/zPNQOqHFmZHsBS/jGToKPMEkosJmTsU9BBjt2JYCjllBIy5+rkEjzp0ZwWHOFds3tnbOGjqMqeYuDpbDeEkJwhN3xTcCxfm8gkjWIqJz2bkMpObMphulOZ4DJM0Hge8QY27qF55OljZqs/5iCaMPebUCfxtVZkGYl5scwdeAc/3iue+WXLgSRh+fdgZOLSNXvob;25:98zb5wx4tlPg3GQW8OlREB02EINyeNuoWX/9USs6Bf8ETRwubtXH85IXPn47jaMsd/7z1o/Yqttp/XuDZxEgd7xwfw4rBKUDk+cIpdy3/C6FDazeN/RXczBlgDA1aW8K/q/euAeikOQZslphqvKO7SmeZ22ZELu+EADyVspmUng/hi7x2iF0ZO7V1RU3seqHNst7VoAtPTNzDV6RV7LHWzoF1TYgtolr0VJ/v82Ww8bTcgoa0cyIaqjb9Xa3VpQf0ZoJl9tf5gb4CNDBupAb9qah1AT5y9nQWLPjAnwkDi35h6X6Y2WkCQDaakb2uNpn9YAqx4VnX8fxErr5GhePCg==;31:ltBUa223t7IctZszY+DcHQnD0P7+CS3bxnnRBQIvNjzQWeAHb7G9hsqKNPf41KiOCxqyKMTMZvPurc8waOk+DTpAsGn1BokQcifhzkKlrBvTTbclvSlfHQfu996R8ieSEAShTwUXoT8ZUEEOTGuhuU02+K49ZJ4xJIpuSnITFpIU50ZHlp561KTHSFnOgNNnuYGgA4ExbWghv6gQwtKEY+sPBjyPn0NU5iJF1dqGY5I=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:Ct6OmvQy/G0yXytIo1uhJTF/PZ9KvXijSDNSsLZxy7qkpuHvvOjrgbuMuR6CqPlBdaHjECWGm9mLkr78DLCd6jd4/CXuDoRnEgDnTLhbhDZJ5Pe29ETtQdyP+Pk/nUzePBXbjCgn4cy2pum5q6CNjuXtvtWYH7Lzc/inSMnkX9QsHTiM6vPcEEVSMKIxvM59ko8NhZ50HTCYYJajHwz8N2zIigTYVJjbwWa1pFC1yDRdhA0MSRBbBqowRsH2qTjW;4:QtWsiPvGzh8pVmH9qQWKNVSLCcoRhR8qmMr+NElvdSREKVub4r4Q+Oc2vxFvwQ+yhkcFbgHbDLPZ3a7nnAXa/tOlSXZ7Q/XwpGyA7xeG5IGU1EeBEFX/QljiMImsCVJd51G+6/BPdHTZ/smtoJeUld5PViIRoeC1I6BLB0mOHsSNcCfV+5hMCGOiNnesitEu0GApq79fV61IY7LaJ4/8dqcffIIZF2guNjdG+Fnjetr/40YmgkJpSYf0U5rKSXLno/dT6dzPPL9EIyrfN1FdMg==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB2151EA5593451C705C6DE544A2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(14444005)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003)(41533002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:PkTLGtrYBHx2KLNtTzCT7cD6yTY0JcUSQxred3c?=
 =?us-ascii?Q?DL+mqSCVz0mLsOhUqbV06E3W/WHmDfGI/bZchJjOaLvZhgBvmqL2SFAiAs77?=
 =?us-ascii?Q?0SWk3uAu/jjyp+vxdgvjilIjqfz928HvnKw50zFIYJjaBne9Vl5jXm+U/FAj?=
 =?us-ascii?Q?21jYdWdWNTN/IPK/icV7VpIHarXVvjrULS6HYlhl181nHrPPkfIsTfyA8IUZ?=
 =?us-ascii?Q?DHaL9ffqRSQB8hQ8RfP2Q4Rfhw7lQM+bbUTJxi/Us48fZBT32kjxeR9Byijv?=
 =?us-ascii?Q?U9BbupbmWRAKjQPLU9b2XLCbOcFH11DdjuJox4NAsoe3AvHdEi8L7r4MN8Fi?=
 =?us-ascii?Q?4+WNUk6crPSN7VOr28Q1zCYFSe1s6XhJj176OgQHpI9Dtbj54bP0H3uU6flW?=
 =?us-ascii?Q?sEioAKTSWgMLEilTyYt8Krr0bHchuaCM7SLYC8C/HHSjWSrL7UkeLhuSby/E?=
 =?us-ascii?Q?jGpB74sGF/SeRPIkkSr6l/tJTTqstXIXgUrDueeX/MOCoGunZKYsziIfDj2W?=
 =?us-ascii?Q?O8SUqTGdG0kF9H3XPCxA6M8430Xku0qVVXstQNpuBkIuVWYNe0iaOX7OsyFE?=
 =?us-ascii?Q?GnDSm3AOlP10prp5xttLLr2UBoMJikAPbFawaTELmKYnfk/kyQSf6apMA6qx?=
 =?us-ascii?Q?qRo8Fyt0nMTjq12KDTWI2VfgsmCvX+79fK8jHHW8/2an4a3hhc8T4v+lJfnk?=
 =?us-ascii?Q?9cto2sOI5bXaPsrMJn44wuXCd4sfrweGJIeQC/lpIuRQYvnnOuj9ItKHD8qU?=
 =?us-ascii?Q?lYGfix+Tta8rrfUb5k644DOV3vGxOJdNOpwBo1UJYaT4PKmLNYptuwRFHJdG?=
 =?us-ascii?Q?mZpI/swTK9ysAsNPovhPUx3aabxuJbzivVnX+ijJUDfwsb6l57eUGz6/0biA?=
 =?us-ascii?Q?FtMisfOG1+Jt27j2PF6yn/WIfrQNkRqT2oW/Ii1kkFH4YqRNrKIIDgMuWBbg?=
 =?us-ascii?Q?rE61icnWgiJU6K/OW7LJDzmLQl5LeVGYNulxQZtXDGqaMEt5sC4OWCXZ76hP?=
 =?us-ascii?Q?bcP8j65i9y67rc+Vywsn6O8aDOts1cyJzZr/rqdKgoInlG56ZfQzrcipVTRS?=
 =?us-ascii?Q?Dy+15U9q17XJtp9iMEJpX8A0wDwPpR5H7A+zKmLDNbhlW3QTq2/B/ldcRIc1?=
 =?us-ascii?Q?NGEOqDzj5J6ikDXe8+hLV9q86b5Dk58vcYi3QeGryvgmXNYhNZGnJqWdM5aE?=
 =?us-ascii?Q?tdAkKdFt9+VgKyn8oagPJpB12LE0n2BY2FAWXqrQZ9bT/656PkaqDhC21Go/?=
 =?us-ascii?Q?YoAjutIJgYjFM4IVZUa8=3D?=
X-Microsoft-Antispam-Message-Info: yW78Mde2ARPnuXWrY/RFNbMriyUhe5rgiPLorrF5uO5X2iHeVf92p+H1V0Y4t6qH+FKkT1QfC7hoSLERyMJkO0+01YghkfnMK0O8o16xaw9mZaj6KINT3Ot0W7RaxmXDXE7ZksHmXXf0LH2vd3lC8vaqDb3szc1u0g4rK7eXT6Z1g9wMp1kweEF0Bj0YcuP/gC5PzLwf0n/MgL/8pQ8eGVi5f0A9QPWXODQSTUtJICOUPO0Le2b/6FjAhCYWbaRG1LHJ0vciyjIAMarci/wtuYIpfh/O9Sa53ssGIhgm63yYzVrhOfrTJf4a5uyw4jwPJmGwgmybCnDJ92LDAP4ItOgMozYozHNtaUXPlGFMsPg=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:cWBj1FyaIoPe1WNYzRv7ZdptvUBxP/xygU+VjpaxgnSVzrv9WSyZkMmu4WJzEjx0xLKrZnS63Pa+224Je78nINpJ4ZCIp0u/xGX8PV+ny+sZdnT0rT0WVsbA80NEXUhWa3mYm/7VaEbrfcEuk1a+HV4v8I9WmdH3Z56UYme9BXC3u43lDQUKioChYR7bkgSx/ucjBmuE3PIEIcmmbNZodT1ISZV+5mViIB18TQlYY6/wxaY+MaxSMgXlRowjbzKDKOI83vr5ftwGbZdJpqcMmrD6iN/tI2fM+/x9c3Zt+uhcf3ZrvS6kcsG8WDanKmct6BH7f8tO+dCN6+1dx+8i6cOw+qNuSsiyUPlW/cJWptmURJ/1kmY+gIM59D9FryravXX2iBgb12SokwNWPG+ZYDqYmQFeNLhPyUfbQj6FpgNGPOM8y1y5jIgAj8zmDMmzxMgOYRf6Imn7SkYAXUS59Q==;5:Q2xvTuqE3WzjLa3XGH6V1dMoiJ7jU+9srUVx2uLvq8Ogit8ln9OuuSAnoCajbtHZGlNgJtefhII1clO27vVI+Tstbq6lP6LZFoYtTAaoEbawJd7WOZUXWASezyadEbSyqbnSC7mKcGn53g4yy5XZg/pNxeqXRQ3ZxdLP6VytF5k=;24:v3LQ81pHM/5UobcRrN9XvI6+C7Ba55spvsb3KpIYsuojmWaKwUBwuBp0TH8g46/VVFbpM1tsKaRf0sXNiL4XMrqpj8Nqt04kXo03188tw4k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:eG+5TkTggo3l+c//461eG7oFgT6blxBE1vDaFFgL04YXqW0PiBp79uFXKETc5p0SnheaBN0CyjbpWJuCXTSZYs6DQdDG1rGpYS9/YeYKa9fvPvdOthSmxfP+5focnwp9xfLiDbhYeicCuv6G7LZiLSM+GLpM38IDuU1BiZcfAYZz86prMWcFbJjOPV3k9B2yDSWVu4M1yVVt2XvI0XPLO1EPneUzIHhwJ9b0DnclIDkzuOSRfujH1VzFPZ8ctZaf
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:14.4085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0bd838-12b5-4f7c-b90f-08d5e796bd18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64814
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

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/generic/Makefile       |  1 -
 arch/mips/generic/kexec.c        | 44 ----------------------------------------
 arch/mips/kernel/machine_kexec.c | 34 ++++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 46 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

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
index 3ba9d96..f39f424 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/libfdt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -64,6 +65,36 @@ static void kexec_image_info(const struct kimage *kimage)
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
@@ -71,7 +102,8 @@ machine_kexec_prepare(struct kimage *kimage)
 
 	if (_machine_kexec_prepare)
 		return _machine_kexec_prepare(kimage);
-	return 0;
+	else
+		return default_machine_kexec_prepare(kimage);
 }
 
 void
-- 
2.7.4
