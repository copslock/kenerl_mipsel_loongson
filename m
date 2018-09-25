Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 01:23:30 +0200 (CEST)
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:38368
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993941AbeIYXX1Wdqs9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 01:23:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKtbefTmarZx7IBTixRGV9xTMTu/t9qleh84Ato5MXQ=;
 b=lvYjN1JW/dSKcWEXmGUjmwGdmEuok0f7tKGWSdO4YHt6GWaWYX/pAmcNWZ+d1/TtEzbaipLE/ViVa8YxAUkliPY7kCp4ziPzyxl0J7bMugYURNPeJ6ci85YGKpP1CgPv/l8XpLJwXgw8DTD6DFrOBr2F2a69sS/qdVzaBSaQOJ0=
Received: from DM6PR08MB4939.namprd08.prod.outlook.com (20.176.115.212) by
 DM6PR08MB4585.namprd08.prod.outlook.com (20.176.110.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 23:23:16 +0000
Received: from DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d]) by DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d%3]) with mapi id 15.20.1143.022; Tue, 25 Sep 2018
 23:23:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: VDSO: Always map near top of user memory
Thread-Topic: [PATCH] MIPS: VDSO: Always map near top of user memory
Thread-Index: AQHUVSa7I/DmJ5ZcX0uUBWGulwKEnQ==
Date:   Tue, 25 Sep 2018 23:23:14 +0000
Message-ID: <20180925232221.28953-1-paul.burton@mips.com>
References: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::41) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB4585;6:iuCr73sBoK+qihWU9UupR9srsnqdrT8lbVcY6kXUlo5ZFQsVDJMlCvhm9JJnAq4iY+qa4fipu9dm86IQztMMgqRIBNEYfyIbnTUeRzI8m2JQOtcvvnf+6g390Ibm/YpbvwnkW5BJSkv02NXh1SrwoTtA27cGoXqUOgWsRZeZBzrcUfA2m56nyXk/XdluXeYonn8dVl8lhYFpVXCMv3hgPCUSmXr6YkK/RQcnMZ9Gi7t2zOQZ4HN/0kO1iBUhfp2K9NNIgmFKdMafepdQQE0EJU47x4jdgAia8dw/37xvpq5qtsTaJPKod24juAQp1W9bIu+E9R0HOU29jaa/60QfzmHt5IuLyOOSHU1IBus0uNWHLUHwB1cXo2dKqAovqxdWirvtAE1nLuOMhN/SvDGDJHKpeFXDWUr9KmPoC2nenxL9Ya7QDRxd5bQFDfmPsxZVE2eSJI0FCJH4//Up2pVFvw==;5:yvc9WI22Ha3HbGzfnIHLOolFqUaRCuJ0qMJ1YsQJrOL92VMDJoq9C2ZhRyL2vPHc0GhPoyjmT19+Gv/AQY6onImTvSdm6NtG8fq+AU2/lMg/ls08AquF11qbkEmaxl+32sw3FBWjs49rb/FojxxSuYsyTYuMWuKVEVqT2FfaqCU=;7:S5N0BHT4lseKFcJI6sbmfbUyH5jfILmaaOazYr7fTpCy64rU/jSla1y4ZdgLRQi3yJxVFNjkHkPqfgMMbFeLI5tw4A+GuQ6an7XXyd/ONsUnDcJ5HIzyfDQIiEdQghyZSgkfWkOOm9er9Eobr3yAx9czbRjbMJowtVGKN4QEbFXCq25lhB3VFL/9yu1tcb/P2UGRU51RXWny3X8TzP3P0XrBWu3LupCDxG8stcc/hj50Jbx3nlj3Y3e8fh+9TXy1
x-ms-office365-filtering-correlation-id: 80ae6473-2765-499e-c7d2-08d6233dddbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4585;
x-ms-traffictypediagnostic: DM6PR08MB4585:
x-microsoft-antispam-prvs: <DM6PR08MB4585C58F3521E5E6E51EA499C1160@DM6PR08MB4585.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(10201501046)(3002001)(149066)(150027)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051);SRVR:DM6PR08MB4585;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4585;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39840400004)(136003)(346002)(189003)(199004)(76176011)(110136005)(316002)(105586002)(42882007)(54906003)(8936002)(52116002)(2906002)(386003)(5250100002)(99286004)(6486002)(81156014)(68736007)(5660300001)(71190400001)(71200400001)(256004)(6506007)(6436002)(186003)(66066001)(53936002)(486006)(106356001)(102836004)(3846002)(107886003)(2900100001)(446003)(11346002)(508600001)(476003)(6116002)(36756003)(97736004)(4326008)(2616005)(14444005)(2501003)(25786009)(305945005)(81166006)(6512007)(39060400002)(7736002)(14454004)(26005)(1076002)(1857600001)(44832011)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4585;H:DM6PR08MB4939.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ning0tqp6xTsxT/7flBdg0Ow0gh5QUWXo86OV3hz/oJwuvfKgas2KV8YHX2DW+KVqfSpKwwX98MVZ2AmtvLKltew/UQGd89NDCXHOYoEPIejmXzDZ7IsB/11xYqRxiJmXNEVPygCudFiKIbPdicQHHH2TgAMoy6Y+z8yOsvhp5xUOXDjAhX7R6t35lwflVRKWNJdL6k9GcXHR6lvQrhHji2GW0K4dERDCNswAOTadqcSgmka1ygumXipYIffLHfqiFxsIe/HTjmHwbjFW+2JxYyhUqGaV+hXonctMZw2HGgDTpPUfsklY84Cs6tcqFE68Hq4jqOmbCxOMRDeLM3FsyAAeyPsI/HNjh3RrCPgtgM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ae6473-2765-499e-c7d2-08d6233dddbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 23:23:15.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4585
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66562
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

When using the legacy mmap layout, for example triggered using ulimit -s
unlimited, get_unmapped_area() fills memory from bottom to top starting
from a fairly low address near TASK_UNMAPPED_BASE.

This placement is suboptimal if the user application wishes to allocate
large amounts of heap memory using the brk syscall. With the VDSO being
located low in the user's virtual address space, the amount of space
available for access using brk is limited much more than it was prior to
the introduction of the VDSO.

For example:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00cc3000-00ce4000 rwxp 00000000 00:00 0          [heap]
  2ab96000-2ab98000 r--p 00000000 00:00 0          [vvar]
  2ab98000-2ab99000 r-xp 00000000 00:00 0          [vdso]
  2ab99000-2ab9d000 rwxp 00000000 00:00 0
  ...

Resolve this by adjusting STACK_TOP to reserve space for the VDSO &
providing an address hint to get_unmapped_area() causing it to use this
space even when using the legacy mmap layout.

We reserve enough space for the VDSO, plus 1MB or 8MB for 32 bit & 64
bit systems respectively within which we randomize the VDSO base
address. Previously this randomization was taken care of by the mmap
base address randomization performed by arch_mmap_rnd(). The 1MB & 8MB
sizes are somewhat arbitrary but chosen such that we have some
randomization without taking up too much of the user's virtual address
space, which is often in short supply for 32 bit systems.

With this the VDSO is always mapped at a high address, leaving lots of
space for statically linked programs to make use of brk:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00c28000-00c49000 rwxp 00000000 00:00 0          [heap]
  ...
  7f67c000-7f69d000 rwxp 00000000 00:00 0          [stack]
  7f7fc000-7f7fd000 rwxp 00000000 00:00 0
  7fcf1000-7fcf3000 r--p 00000000 00:00 0          [vvar]
  7fcf3000-7fcf4000 r-xp 00000000 00:00 0          [vdso]

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Huacai Chen <chenhc@lemote.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
---
Huacai, could you test if this fixes your problem?

It takes up less of the user's virtual address space (only 1MB for
MIPS32), takes none at all when randomization is disabled, and doesn't
make assumptions about the size of the VDSO.
---
 arch/mips/include/asm/processor.h | 10 +++++-----
 arch/mips/kernel/process.c        | 25 +++++++++++++++++++++++++
 arch/mips/kernel/vdso.c           | 18 +++++++++++++++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index b2fa62922d88..15917ee42f9f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -13,6 +13,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/sizes.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
@@ -80,11 +81,10 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-/*
- * One page above the stack is used for branch delay slot "emulation".
- * See dsemul.c for details.
- */
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
+#define VDSO_RANDOMIZE_SIZE	(test_thread_flag(TIF_32BIT_ADDR) ? SZ_1M : SZ_8M)
+
+extern unsigned long mips_stack_top(void);
+#define STACK_TOP		mips_stack_top()
 
 /*
  * This decides where the kernel will search for a free chunk of vm
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8fc69891e117..1b699a367c45 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/nmi.h>
 #include <linux/cpu.h>
 
+#include <asm/abi.h>
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -39,6 +40,7 @@
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/irq.h>
+#include <asm/mips-gic.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -645,6 +647,29 @@ unsigned long get_wchan(struct task_struct *task)
 	return pc;
 }
 
+unsigned long mips_stack_top(void)
+{
+	unsigned long top = TASK_SIZE & PAGE_MASK;
+
+	/* One page for branch delay slot "emulation" */
+	top -= PAGE_SIZE;
+
+	/* Space for the VDSO, data page & GIC user page */
+	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+	top -= PAGE_SIZE;
+	top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+	/* Space for cache colour alignment */
+	if (cpu_has_dc_aliases)
+		top -= shm_align_mask + 1;
+
+	/* Space to randomize the VDSO base */
+	if (current->flags & PF_RANDOMIZE)
+		top -= VDSO_RANDOMIZE_SIZE;
+
+	return top;
+}
+
 /*
  * Don't forget that the stack pointer must be aligned on a 8 bytes
  * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 8f845f6e5f42..48a9c6b90e07 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -97,6 +98,21 @@ void update_vsyscall_tz(void)
 	}
 }
 
+static unsigned long vdso_base(void)
+{
+	unsigned long base;
+
+	/* Skip the delay slot emulation page */
+	base = STACK_TOP + PAGE_SIZE;
+
+	if (current->flags & PF_RANDOMIZE) {
+		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
+		base = PAGE_ALIGN(base);
+	}
+
+	return base;
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
@@ -137,7 +153,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (cpu_has_dc_aliases)
 		size += shm_align_mask + 1;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
-- 
2.18.0
