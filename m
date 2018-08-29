Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 20:02:01 +0200 (CEST)
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:55362
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993920AbeH2SB4SiXEJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Aug 2018 20:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaqddpmIibqASrAdCBDFoX8xnKOT8YfZBRyZWtR9nio=;
 b=KHDB7WdRM85F7eCXyY9dBpZQuNbznDUQBOUtu3N2nYOvmSiZDJd6B2FxLZdpTvHPwMD8Tbw5oqq+baIS9cJTTzsMT+pyjZCD3u5yEhYDqLNEwqNnqRhTLnV2+IZuPVpgrwVnZaq4CnbwLs8HHu3zY0S00g6H0H95mMz8Q780h9A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4940.namprd08.prod.outlook.com (2603:10b6:5:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 18:01:44 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Philippe Reynes <philippe.reynes@softathome.com>,
        linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Use a custom elf-entry program to find kernel entry point
Date:   Wed, 29 Aug 2018 11:01:30 -0700
Message-Id: <20180829180130.21463-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829175747.bo4l36aptncduyuc@pburton-laptop>
References: <20180829175747.bo4l36aptncduyuc@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:301:4c::30) To DM6PR08MB4940.namprd08.prod.outlook.com
 (2603:10b6:5:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dd8a38-6b01-4ed6-e7db-08d60dd97b5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4940;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;3:gfwtuwRAa6gcx2WVfvgFdXGJ5HT1Akom6TKg1ONDVNQK9Nn1leQOrMGw8weecjNLuVrXs5IdKdoKCi4b6RGcflD56tND4ZD/dmBdSbp2Pgw9hXcB6Pur5R/OvhhBh7OEk1CtMBGO/b62TR6Xvv5C2drDWriBxunN4CJYFb+PMroiFPxRWbQml+d/Xp1GX9XnMECLog0gQyuKWGzOvhMapJ3NsLFN3qiKZlr3eS3bS/eS0bFbaHEjYdIXLGd9KtVk;25:iORFK7i+ytZOc+YY37E44f07yyuY0+UaY826asgFyxtmiBjMmhfMJndju+6IFgOev+apGg9RQAP4fL02pcAMbZPqjSUhIgkXlwVYcE7Dfvhbn/5IRbPEcrgKh6rsyPvIIX+rdda4E5ZVypOyiMGwl8syrgz3wTDqY9qktVPGtlduEaGK0H3h+xjNngs8IMUeTPWMxGULysuj3SoLseWqb2RSMx5QzVC/sHjelSVRwvIXKOlLU4+Q8OnLzrcwdCU1ryNEmQ1TjszgiiM5jNo0r1N+AjtOj5txGC/fmiIv64llhOK2D6w1CukMhcHoqB6k14WVZTw0nDR0I0Nruq6stA==;31:1nWaNO5+Px3bhiUGWiM6PA0hZ8ye44lp371Lzkj6PwkPXztnOmE2RMubibM1RXd4gWugkcL7PwDZfs26Zre6YyBq2Q5cpOxR8Ph/cYiQu0H3J1h8uHbDc1YP4QoSfGyJZuoP7wMdeFOyU4oJs/pn3IqHbC3GgdJ0vkaMuLieR3o4kCBXUy5/+H9qHV2yx/bxTpKNdxE29LmGBoYERQo8xS6x6fRlRvfnOURZ2Wc9Mdc=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4940:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;20:BK4KzFfsbpUiqJAJBt0m3njgETEqjfnKizVLwZUEOIa/Q/y37UX7K0K6kcTmkCCCBeQ95h7l1CZd21lVkbjHgS9A6ZYu99h+b6zsYsmgUvOcaM7FfkT0jg96x3xURGnZvM3GbaJ2J01b1LH/UAMCZ80SWPX/cKpYpMvRp7BcqqYD5HDa/GfxyGrQUAByK/g0loL/ItLiofxnznoBEVGbt39XRf0IENnc5n4W5pHSL+sxSeuz40HRr5VD4/UAbHBS;4:7Xi2s/Jhpj7qm6omaIIlcZXl7NhTvRmXBJQ+aQKbPZB1ufbViLjkn4NMPJyv4kpwF/UqHy7LtMj+WCrDupXNyh1NPHhGXMw6jDe7ibYZ86vI1dbyMTG4xnkerfCcSfOM5PUS5+kL6QWD+vjS8XNo4e1OCUhcWKQ6YoyAlgBOrPQNIZPRB9pKa3HUm6F2dTfRxT6ntL/6pwaut1CDHHkjn1id7wvuRwm7Cy4X73O5+2Fs8tbYz6QZ9dOlORsOEg7jfvOrPZLMjk3aS0oOQi1p9b4J3iaPRVt3zXwpDK5t0ITzkOJlMvHXDMEIeQJgvsl5
X-Microsoft-Antispam-PRVS: <DM6PR08MB494069844D97AC9C7404B59FC1090@DM6PR08MB4940.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR08MB4940;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4940;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39850400004)(366004)(136003)(189003)(199004)(106356001)(66066001)(305945005)(105586002)(54906003)(8676002)(16586007)(52116002)(76176011)(316002)(51416003)(53936002)(6506007)(386003)(6512007)(186003)(26005)(5660300001)(1857600001)(53416004)(6666003)(16526019)(42882007)(6486002)(11346002)(2616005)(7736002)(446003)(956004)(47776003)(476003)(48376002)(36756003)(486006)(6116002)(2906002)(1076002)(3846002)(50466002)(44832011)(97736004)(14444005)(81156014)(50226002)(81166006)(68736007)(25786009)(8936002)(4326008)(69596002)(39060400002)(478600001)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4940;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4940;23:I32njiQgnnZ+PEteoeexIC+To0+Ff+zrB/D2ZSRVI?=
 =?us-ascii?Q?ovwzuLhP1jPqj+FDvAiaKclyVtkc+IWnkR9WzDCzFae1TQv4EpCBTPWZpD5r?=
 =?us-ascii?Q?QVuB1AS5xOcjFvBmeCyUkHnFBAah2uQ+yerjh7JjBodpUQFmObe+TG6ETEQA?=
 =?us-ascii?Q?KCiD4j1MScF2Lu/339sjUTjplavVcAdX7CaRqLRKP3Dettp93f5aw2RLS7zf?=
 =?us-ascii?Q?f4B7M5zczpEl4ctlUyWNRTvuVxF8TqjVKD10zQ1wmBFxWTAXjnXZWNTZ1TG3?=
 =?us-ascii?Q?n+mDQHhnoO3Qa16XqTeXMAJ2ymhLq9zHJcKg6+fFHJMm3aCP3W3GBOrJYQZh?=
 =?us-ascii?Q?sT8Lpoo6Z5GcXBMml7ppi4G7S9viR99EAlJvCQcXm2u5X5YuUNUvy+RxNctg?=
 =?us-ascii?Q?HZzJqPpDCz60kL1+nwM8erG/VPUimQCtfla08qDdIVmMkKtb7p2JIcMT8A+f?=
 =?us-ascii?Q?MvjzEGb1xinorIcPFgxowUo69eCfUrfl2z30l1ryrECqXd0FTH/ned7sJ9NV?=
 =?us-ascii?Q?YyymhLrnsqLBnTdhF0EGUXVTip57n/wIn3TPGFGRRv/2fOXagx2SP8RHMu0M?=
 =?us-ascii?Q?KpO0BC4TTaD0x5CvRgf9dMyxbG1JyEZMFCzHeYmYDZ/9W+LmP+/4cs25HJiO?=
 =?us-ascii?Q?kr/j2f7z57lWDHbQcPUisAyOnBQdjIrMkt9VC+Cha6soPFvEdRRvufDfCnyf?=
 =?us-ascii?Q?0TXhZJczjjcaFJKAp6cmJGGhXauynbeCEKig7lIPTo/cASOkclt2iSmEVDew?=
 =?us-ascii?Q?N2xdefR1O6zh77pGgFTlkgYxthnTHBKKuJ2Xp/w8uSdshT7ezLt08xIcmzyr?=
 =?us-ascii?Q?SlHV0y/PSfuuzmkvF7j6/GaJ2n9Itak35IOzdvzdAZzcuwmtAFWSm1RBd7Ks?=
 =?us-ascii?Q?NechmrjaE+O3AGo+trkaPaOd0+xa9lWqMsha+VbmGJx37zzW9ZKuTvbbxwDp?=
 =?us-ascii?Q?Q0MNmq1AThU2B+tUgjzNjPkcD8PftqgMbTMQOosrCaydJx0FGzIXEsI4NHWJ?=
 =?us-ascii?Q?5FkaVpNUGbW21Eei/qI8nym9MmgYPXgMJztw9HtLzIcZufp/M+9WJZS4WHdN?=
 =?us-ascii?Q?TOdBewgOq+Po9b9dCLc1vgp9FL6lxv3V9qkf/yv/dogGzl9R5a01l6quM7Bu?=
 =?us-ascii?Q?30KqxfQ/hQDxv9GTFhXIqqP6uSTF7//M1f0ZvLzvl7QU6ExaHp+2HHJzZcuo?=
 =?us-ascii?Q?2Psis5/kudjCK7jfu0oENJUDyM6VWT79Rm2tRVCf58szmL/kvXTSxeMtYHnj?=
 =?us-ascii?Q?0+cE+AmEVfzy+KVnx6cWRUHyl02B71Y9PHY8FPIWLQYxQ3gSQCYkY0JW+imz?=
 =?us-ascii?Q?a7/QsnfeEGu3/KTLHtKodgviGDPSZ0Ch1ZQ+U/zJtHs?=
X-Microsoft-Antispam-Message-Info: atbUqNw0pT/BTBbxGelZZGplJ+X6LZWl68L8Ka1dgXrXPXCo2tr80CV9me2lxqiIFFRi2tRAdFQ3Q/i3kU5oYB6fYT3P22Qka1KQjC4N1GR3fPO/hWQEeo3alv5d67urnssf2HdFHhkWyRJOV1DmBbkohV9x8up+o7JworJBptoAm3qFFzPfC5UMiG/1yPKjF2ovXgsAcZL/raEEcwLvRRXBJxWs2iv403noZOSzB2c4h45L1rZhm8h2qvqMxxpzf3xhndvzhdvXUHi4sOF0x2RhZyQV8Kzf5CJkO/FO38hn08hbHPrzwwi7OSpVtMorvXDN5ogC5z/L/cMRPgVLUGeztwceiexcfFxgNYHT4RA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;6:lR2xKl75DgPriSyBkOTJ2J11NCIdpc9bSMZPbvOELz2FLR471jCrc5Ci9F+H9Sz000hKPcOPA9RGnc7y/8UlfOJJ8fzZYkExVUW3Za0/sCvfS66QWSXQzdjM/sa9PCkVd7/bCCfhIv7X0a5Xjz+devmxWHYYZNxflpvcq1/9w1fitUQqD9mHcZZ6CqO/kt8Jeudro/SLAc9LFn7BB6gjRLSNod/dCBVTMZEeTRgqx6R/sIz4yj8APHFAHjdcOExDVsSSyo/wS23Tmlah/N3Br1lU9CsNEkw3ulTZqZCxGSVRLChbxuKPLnn6Uy3W6jDNtmU5m/1CdExH5/0LYDA1CyOPnr6fSXXkWRuZ7o2W9uChArMEaMkPlrUeS7pTg7/OHq1eYqPXg6RvsmyfvPxr9ceV3eq7Egw/Sy84F0lE2ZTbqDkD9XhBQuU3srlxlOou6NptwpRRSp1LqjlyVCurbQ==;5:yppkOdvigMUIzNjMq/1Tz2qYUGAjJCJ+8nsy9XNyMk9doDEU5Vi9nEPW8/KwfyJ3uZR2e+bBLpiJ8aCsf5tlkzGd9vyKRQ1JK0/fxTuohdKOykPxgxb2bwhrEi9o5wBeQoJQNSyChaggwrJo9895qbp+6l9xUQ/2b8+qtImEdMs=;7:k9yMMx9N0mB4QyiZWOfyHFPM7PInJ9PPnFG5v/VAxM3K+pK20YaF3G1LPhLfqLPKnlhaoLKD406jj1HKmlkJHuJeYRprCyDeCDFlmfUtk03wBLua1dCA/9H9qL6avfRYRwENaorUQzyYBvAP1vREYaHG/KyGONz5cFU2/jHzhioWxwy61TPRsqfHsHpJmz/e47exXCtiLAa9EYK65L+eh3rccW4EsU8cx0jJpxAgsel2RZy8XoaRHixik6gq4QRv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 18:01:44.4318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dd8a38-6b01-4ed6-e7db-08d60dd97b5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4940
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

For a long time arch/mips/Makefile used nm to discover the kernel entry
point by looking for the address of the kernel_entry symbol. This
doesn't work for systems which make use of bit 0 of the PC to reflect
the ISA mode - ie. microMIPS (and MIPS16, but we don't support building
kernels that target MIPS16 anyway).

So for a while with commit 5fc9484f5e41 ("MIPS: Set ISA bit in entry-y
for microMIPS kernels") we manually modified the last nibble of the
output from nm, which worked but wasn't particularly pretty.

Commit 27c524d17430 ("MIPS: Use the entry point from the ELF file
header") then cleaned this up by using objdump to print the ELF entry
point which includes the ISA bit, rather than using nm to print the
address of the kernel_entry symbol which doesn't. That removed the ugly
replacement of the last nibble, but added its own ugliness by needing to
manually sign extend in the 32 bit case.

Unfortunately it has been pointed out that objdump's output is
localised, and therefore grepping for its "start address" output doesn't
work when the user's language settings are such that objdump doesn't
print in English.

We could simply revert commit 27c524d17430 ("MIPS: Use the entry point
from the ELF file header") and return to the manual replacement of the
last nibble of entry-y, but it seems that was found sufficiently
unpalatable to avoid. We could attempt to force the language used by
objdump by setting an environment variable such as LC_ALL, but that
seems fragile. Instead we add a small tool named elf-entry which simply
prints out the entry point of the kernel in the format we require.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Philippe Reynes <philippe.reynes@softathome.com>
Fixes: 27c524d17430 ("MIPS: Use the entry point from the ELF file header")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Makefile          |  9 +---
 arch/mips/tools/.gitignore  |  1 +
 arch/mips/tools/Makefile    |  5 ++
 arch/mips/tools/elf-entry.c | 96 +++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/tools/.gitignore
 create mode 100644 arch/mips/tools/Makefile
 create mode 100644 arch/mips/tools/elf-entry.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b3742fa5d..053e1c314f9e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -13,6 +13,7 @@
 #
 
 archscripts: scripts_basic
+	$(Q)$(MAKE) $(build)=arch/mips/tools elf-entry
 	$(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
 
 KBUILD_DEFCONFIG := 32r2el_defconfig
@@ -257,13 +258,7 @@ ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
 endif
 
-# Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
-entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
-			| sed -n '/^start address / { \
-				s/^.* //; \
-				s/0x\([0-7].......\)$$/0x00000000\1/; \
-				s/0x\(........\)$$/0xffffffff\1/; p }')
-
+entry-y				= $(shell $(objtree)/arch/mips/tools/elf-entry vmlinux)
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
diff --git a/arch/mips/tools/.gitignore b/arch/mips/tools/.gitignore
new file mode 100644
index 000000000000..56d34ccccce4
--- /dev/null
+++ b/arch/mips/tools/.gitignore
@@ -0,0 +1 @@
+elf-entry
diff --git a/arch/mips/tools/Makefile b/arch/mips/tools/Makefile
new file mode 100644
index 000000000000..3baee4bc6775
--- /dev/null
+++ b/arch/mips/tools/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-y := elf-entry
+PHONY += elf-entry
+elf-entry: $(obj)/elf-entry
+	@:
diff --git a/arch/mips/tools/elf-entry.c b/arch/mips/tools/elf-entry.c
new file mode 100644
index 000000000000..adde79ce7fc0
--- /dev/null
+++ b/arch/mips/tools/elf-entry.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <byteswap.h>
+#include <elf.h>
+#include <endian.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#ifdef be32toh
+/* If libc provides [bl]e{32,64}toh() then we'll use them */
+#elif BYTE_ORDER == LITTLE_ENDIAN
+# define be32toh(x)	bswap_32(x)
+# define le32toh(x)	(x)
+# define be64toh(x)	bswap_64(x)
+# define le64toh(x)	(x)
+#elif BYTE_ORDER == BIG_ENDIAN
+# define be32toh(x)	(x)
+# define le32toh(x)	bswap_32(x)
+# define be64toh(x)	(x)
+# define le64toh(x)	bswap_64(x)
+#endif
+
+__attribute__((noreturn))
+static void die(const char *msg)
+{
+	fputs(msg, stderr);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, const char *argv[])
+{
+	uint64_t entry;
+	size_t nread;
+	FILE *file;
+	union {
+		Elf32_Ehdr ehdr32;
+		Elf64_Ehdr ehdr64;
+	} hdr;
+
+	if (argc != 2)
+		die("Usage: elf-entry <elf-file>\n");
+
+	file = fopen(argv[1], "r");
+	if (!file) {
+		perror("Unable to open input file");
+		return EXIT_FAILURE;
+	}
+
+	nread = fread(&hdr, 1, sizeof(hdr), file);
+	if (nread != sizeof(hdr)) {
+		perror("Unable to read input file");
+		return EXIT_FAILURE;
+	}
+
+	if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG))
+		die("Input is not an ELF\n");
+
+	switch (hdr.ehdr32.e_ident[EI_CLASS]) {
+	case ELFCLASS32:
+		switch (hdr.ehdr32.e_ident[EI_DATA]) {
+		case ELFDATA2LSB:
+			entry = le32toh(hdr.ehdr32.e_entry);
+			break;
+		case ELFDATA2MSB:
+			entry = be32toh(hdr.ehdr32.e_entry);
+			break;
+		default:
+			die("Invalid ELF encoding\n");
+		}
+
+		/* Sign extend to form a canonical address */
+		entry = (int64_t)(int32_t)entry;
+		break;
+
+	case ELFCLASS64:
+		switch (hdr.ehdr32.e_ident[EI_DATA]) {
+		case ELFDATA2LSB:
+			entry = le64toh(hdr.ehdr64.e_entry);
+			break;
+		case ELFDATA2MSB:
+			entry = be64toh(hdr.ehdr64.e_entry);
+			break;
+		default:
+			die("Invalid ELF encoding\n");
+		}
+		break;
+
+	default:
+		die("Invalid ELF class\n");
+	}
+
+	printf("0x%016" PRIx64 "\n", entry);
+	return EXIT_SUCCESS;
+}
-- 
2.18.0
