Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 03:31:56 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:45310 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdL0CbdAijZZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 03:31:33 +0100
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 86B472183FCF;
        Wed, 27 Dec 2017 05:31:27 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 3svTCfDVFD-VPpGItVr;
        Wed, 27 Dec 2017 05:31:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514341887;
        bh=3phtCeKEyeZ02CFlbCewVzNgtPzuLv1w6au1XA0Efk4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Oz+v4FswoGjRYZf2A6HL5QQ5RYp57IZPOhp2XqwZSFr+kQCYmrGCdGyLUqc3zikhX
         2/h3EBiIqwnDg3fTlr+DgWXQMshP4Wyzu7MNa47QXKexY/CK06qTzhZ9aWRsx0mAQc
         5NMwJ5jettx4oT+LWt+z7j0Dhv4sT/VwxHrtPhHE=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8At41EhZ1X-VKfGTdXd;
        Wed, 27 Dec 2017 05:31:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514341883;
        bh=3phtCeKEyeZ02CFlbCewVzNgtPzuLv1w6au1XA0Efk4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=YUpKaMUtuPMcBJdC6u3xyNyAf8xV4EvWrLz4hmIGAtLYpyVNztbkghg9bM/O15jDW
         PzhjPEeE2yrljaiNmIWxAdoLkDhlt/XVznwv0NmHtI/UBXUcwYSFHg/m0GLMSznhwk
         KXsLGYpcNOdTV9gtYUAPXyQUd5Kn6xbxTRPCssQs=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: rename arcs_cmdline to mips_cmdline
Date:   Wed, 27 Dec 2017 10:31:03 +0800
Message-Id: <20171227023103.12870-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171227023103.12870-1-jiaxun.yang@flygoat.com>
References: <20171227023103.12870-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

arcs_cmdline refers to boot cmdline for all machs, not only arc systems.
This patch renamed all arcs_cmdline to mips_cmdline.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/alchemy/common/prom.c           |  6 +++---
 arch/mips/ar7/prom.c                      |  8 ++++----
 arch/mips/cavium-octeon/setup.c           | 30 +++++++++++++++---------------
 arch/mips/cobalt/setup.c                  |  4 ++--
 arch/mips/dec/prom/cmdline.c              |  6 +++---
 arch/mips/emma/common/prom.c              | 10 +++++-----
 arch/mips/fw/arc/cmdline.c                |  6 +++---
 arch/mips/fw/lib/cmdline.c                |  6 +++---
 arch/mips/fw/sni/sniprom.c                |  4 ++--
 arch/mips/generic/init.c                  |  2 +-
 arch/mips/generic/yamon-dt.c              |  2 +-
 arch/mips/include/asm/bootinfo.h          |  2 +-
 arch/mips/jz4740/prom.c                   |  2 +-
 arch/mips/kernel/relocate.c               |  8 ++++----
 arch/mips/kernel/setup.c                  | 14 +++++++-------
 arch/mips/lantiq/prom.c                   |  6 +++---
 arch/mips/lasat/prom.c                    |  4 ++--
 arch/mips/loongson32/common/prom.c        |  8 ++++----
 arch/mips/loongson64/common/cmdline.c     | 10 +++++-----
 arch/mips/loongson64/common/machtype.c    |  2 +-
 arch/mips/loongson64/lemote-2f/machtype.c | 14 +++++++-------
 arch/mips/mti-malta/malta-dtshim.c        |  2 +-
 arch/mips/netlogic/xlr/setup.c            | 20 ++++++++++----------
 arch/mips/paravirt/setup.c                |  4 ++--
 arch/mips/pic32/pic32mzda/init.c          |  6 +++---
 arch/mips/pmcs-msp71xx/msp_prom.c         |  4 ++--
 arch/mips/pnx833x/common/prom.c           |  2 +-
 arch/mips/ralink/prom.c                   |  4 ++--
 arch/mips/rb532/prom.c                    |  8 ++++----
 arch/mips/sibyte/common/cfe.c             |  6 +++---
 arch/mips/txx9/generic/setup.c            | 22 +++++++++++-----------
 arch/mips/vr41xx/common/init.c            |  4 ++--
 drivers/platform/mips/yeeloong_laptop.c   |  4 ++--
 33 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index af312b5e33f6..99dcb69c1cc2 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -47,9 +47,9 @@ void __init prom_init_cmdline(void)
 	int i;
 
 	for (i = 1; i < prom_argc; i++) {
-		strlcat(arcs_cmdline, prom_argv[i], COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, prom_argv[i], COMMAND_LINE_SIZE);
 		if (i < (prom_argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
@@ -111,7 +111,7 @@ int __init prom_get_ethernet_addr(char *ethernet_addr)
 	ethaddr_str = prom_getenv("ethaddr");
 	if (!ethaddr_str) {
 		/* Check command line */
-		ethaddr_str = strstr(arcs_cmdline, "ethaddr=");
+		ethaddr_str = strstr(mips_cmdline, "ethaddr=");
 		if (!ethaddr_str)
 			return -1;
 
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index dd53987a690f..eb536ae30f16 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -55,9 +55,9 @@ static void  __init ar7_init_cmdline(int argc, char *argv[])
 	int i;
 
 	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, argv[i], COMMAND_LINE_SIZE);
 		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
@@ -203,7 +203,7 @@ static void __init console_config(void)
 	char parity = '\0', bits = '\0', flow = '\0';
 	char *s, *p;
 
-	if (strstr(arcs_cmdline, "console="))
+	if (strstr(mips_cmdline, "console="))
 		return;
 
 	s = prom_getenv("modetty0");
@@ -237,7 +237,7 @@ static void __init console_config(void)
 	else
 		sprintf(console_string, " console=ttyS0,%d%c%c", baud, parity,
 			bits);
-	strlcat(arcs_cmdline, console_string, COMMAND_LINE_SIZE);
+	strlcat(mips_cmdline, console_string, COMMAND_LINE_SIZE);
 #endif
 }
 
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..a59ce7066328 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -853,7 +853,7 @@ void __init prom_init(void)
 	if (octeon_is_simulation())
 		max_memory = 64ull << 20;
 
-	arg = strstr(arcs_cmdline, "mem=");
+	arg = strstr(mips_cmdline, "mem=");
 	if (arg) {
 		max_memory = memparse(arg + 4, &p);
 		if (max_memory == 0)
@@ -862,7 +862,7 @@ void __init prom_init(void)
 			reserve_low_mem = memparse(p + 1, &p);
 	}
 
-	arcs_cmdline[0] = 0;
+	mips_cmdline[0] = 0;
 	argc = octeon_boot_desc_ptr->argc;
 	for (i = 0; i < argc; i++) {
 		const char *arg =
@@ -879,26 +879,26 @@ void __init prom_init(void)
 			crashk_size = memparse(arg+12, &p);
 			if (*p == '@')
 				crashk_base = memparse(p+1, &p);
-			strcat(arcs_cmdline, " ");
-			strcat(arcs_cmdline, arg);
+			strcat(mips_cmdline, " ");
+			strcat(mips_cmdline, arg);
 			/*
 			 * To do: switch parsing to new style, something like:
 			 * parse_crashkernel(arg, sysinfo->system_dram_size,
 			 *		  &crashk_size, &crashk_base);
 			 */
 #endif
-		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
-			   sizeof(arcs_cmdline) - 1) {
-			strcat(arcs_cmdline, " ");
-			strcat(arcs_cmdline, arg);
+		} else if (strlen(mips_cmdline) + strlen(arg) + 1 <
+			   sizeof(mips_cmdline) - 1) {
+			strcat(mips_cmdline, " ");
+			strcat(mips_cmdline, arg);
 		}
 	}
 
-	if (strstr(arcs_cmdline, "console=") == NULL) {
+	if (strstr(mips_cmdline, "console=") == NULL) {
 		if (octeon_uart == 1)
-			strcat(arcs_cmdline, " console=ttyS1,115200");
+			strcat(mips_cmdline, " console=ttyS1,115200");
 		else
-			strcat(arcs_cmdline, " console=ttyS0,115200");
+			strcat(mips_cmdline, " console=ttyS0,115200");
 	}
 
 	mips_hpt_frequency = octeon_get_clock_rate();
@@ -947,10 +947,10 @@ void __init fw_init_cmdline(void)
 	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
-		if (strlen(arcs_cmdline) + strlen(arg) + 1 <
-			   sizeof(arcs_cmdline) - 1) {
-			strcat(arcs_cmdline, " ");
-			strcat(arcs_cmdline, arg);
+		if (strlen(mips_cmdline) + strlen(arg) + 1 <
+			   sizeof(mips_cmdline) - 1) {
+			strcat(mips_cmdline, " ");
+			strcat(mips_cmdline, arg);
 		}
 	}
 }
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index c136a18c7221..691b2a12f48a 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -107,9 +107,9 @@ void __init prom_init(void)
 	argv = (char **)fw_arg1;
 
 	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, argv[i], COMMAND_LINE_SIZE);
 		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 
 	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
diff --git a/arch/mips/dec/prom/cmdline.c b/arch/mips/dec/prom/cmdline.c
index 3ed63280ae29..7465e8baf0de 100644
--- a/arch/mips/dec/prom/cmdline.c
+++ b/arch/mips/dec/prom/cmdline.c
@@ -29,12 +29,12 @@ void __init prom_init_cmdline(s32 argc, s32 *argv, u32 magic)
 		start_arg = 2;
 	for (i = start_arg; i < argc; i++) {
 		arg = (void *)(long)(argv[i]);
-		strcat(arcs_cmdline, arg);
+		strcat(mips_cmdline, arg);
 		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
+			strcat(mips_cmdline, " ");
 	}
 
 #ifdef PROM_DEBUG
-	printk("arcs_cmdline: %s\n", &(arcs_cmdline[0]));
+	printk("mips_cmdline: %s\n", &(mips_cmdline[0]));
 #endif
 }
diff --git a/arch/mips/emma/common/prom.c b/arch/mips/emma/common/prom.c
index cae42259d6da..24f046fc5b29 100644
--- a/arch/mips/emma/common/prom.c
+++ b/arch/mips/emma/common/prom.c
@@ -46,15 +46,15 @@ void __init prom_init(void)
 
 	/* if user passes kernel args, ignore the default one */
 	if (argc > 1)
-		arcs_cmdline[0] = '\0';
+		mips_cmdline[0] = '\0';
 
 	/* arg[0] is "g", the rest is boot parameters */
 	for (i = 1; i < argc; i++) {
-		if (strlen(arcs_cmdline) + strlen(arg[i]) + 1
-		    >= sizeof(arcs_cmdline))
+		if (strlen(mips_cmdline) + strlen(arg[i]) + 1
+		    >= sizeof(mips_cmdline))
 			break;
-		strcat(arcs_cmdline, arg[i]);
-		strcat(arcs_cmdline, " ");
+		strcat(mips_cmdline, arg[i]);
+		strcat(mips_cmdline, " ");
 	}
 
 #ifdef CONFIG_NEC_MARKEINS
diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index c0122a1dc587..598d16436ab0 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -71,7 +71,7 @@ void __init prom_init_cmdline(void)
 
 	actr = 1; /* Always ignore argv[0] */
 
-	cp = arcs_cmdline;
+	cp = mips_cmdline;
 	/*
 	 * Move ARC variables to the beginning to make sure they can be
 	 * overridden by later arguments.
@@ -94,11 +94,11 @@ void __init prom_init_cmdline(void)
 		actr++;
 	}
 
-	if (cp != arcs_cmdline)		/* get rid of trailing space */
+	if (cp != mips_cmdline)		/* get rid of trailing space */
 		--cp;
 	*cp = '\0';
 
 #ifdef DEBUG_CMDLINE
-	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
+	printk(KERN_DEBUG "prom cmdline: %s\n", mips_cmdline);
 #endif
 }
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index 6ecda64ad184..b5778d48ba32 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -36,15 +36,15 @@ void __init fw_init_cmdline(void)
 		_fw_envp = (int *)fw_arg2;
 
 	for (i = 1; i < fw_argc; i++) {
-		strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
 		if (i < (fw_argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
 char * __init fw_getcmdline(void)
 {
-	return &(arcs_cmdline[0]);
+	return &(mips_cmdline[0]);
 }
 
 char *fw_getenv(char *envname)
diff --git a/arch/mips/fw/sni/sniprom.c b/arch/mips/fw/sni/sniprom.c
index 6aa264b9856a..bdc1bc8ec0bc 100644
--- a/arch/mips/fw/sni/sniprom.c
+++ b/arch/mips/fw/sni/sniprom.c
@@ -145,8 +145,8 @@ void __init prom_init(void)
 
 	/* copy prom cmdline parameters to kernel cmdline */
 	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, (char *)CKSEG0ADDR(argv[i]));
+		strcat(mips_cmdline, (char *)CKSEG0ADDR(argv[i]));
 		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
+			strcat(mips_cmdline, " ");
 	}
 }
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 5ba6fcc26fa7..b9d13270b4b3 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -111,7 +111,7 @@ void __init plat_mem_setup(void)
 	if (mach && mach->fixup_fdt)
 		fdt = mach->fixup_fdt(fdt, mach_match_data);
 
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	strlcpy(mips_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	__dt_setup_arch((void *)fdt);
 }
 
diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
index b408dac722ac..75949a55c6f0 100644
--- a/arch/mips/generic/yamon-dt.c
+++ b/arch/mips/generic/yamon-dt.c
@@ -114,7 +114,7 @@ __init int yamon_dt_append_memory(void *fdt,
 	/* allow the user to override the usable memory */
 	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
 		snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
-		var = strstr(arcs_cmdline, param_name);
+		var = strstr(mips_cmdline, param_name);
 		if (!var)
 			continue;
 
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093bb17a..9bd21011b544 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -120,7 +120,7 @@ extern void (*free_init_pages_eva)(void *begin, void *end);
 /*
  * Initial kernel command line, usually setup by prom_init()
  */
-extern char arcs_cmdline[COMMAND_LINE_SIZE];
+extern char mips_cmdline[COMMAND_LINE_SIZE];
 
 /*
  * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 47e857194ce6..235cf9a776e3 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -26,7 +26,7 @@ static __init void jz4740_init_cmdline(int argc, char *argv[])
 {
 	unsigned int count = COMMAND_LINE_SIZE - 1;
 	int i;
-	char *dst = &(arcs_cmdline[0]);
+	char *dst = &(mips_cmdline[0]);
 	char *src;
 
 	for (i = 1; i < argc && count; ++i) {
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index cbf4cc0b0b6c..d30cd811629b 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -241,8 +241,8 @@ static inline __init bool kaslr_disabled(void)
 	    (str > builtin_cmdline && *(str - 1) == ' '))
 		return true;
 #endif
-	str = strstr(arcs_cmdline, "nokaslr");
-	if (str == arcs_cmdline || (str > arcs_cmdline && *(str - 1) == ' '))
+	str = strstr(mips_cmdline, "nokaslr");
+	if (str == mips_cmdline || (str > mips_cmdline && *(str - 1) == ' '))
 		return true;
 
 	return false;
@@ -313,7 +313,7 @@ void *__init relocate_kernel(void)
 	early_init_dt_scan(fdt);
 	if (boot_command_line[0]) {
 		/* Boot command line was passed in device tree */
-		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strlcpy(mips_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	}
 #endif /* CONFIG_USE_OF */
 
@@ -327,7 +327,7 @@ void *__init relocate_kernel(void)
 		offset = (unsigned long)loc_new - (unsigned long)(&_text);
 
 	/* Reset the command line now so we don't end up with a duplicate */
-	arcs_cmdline[0] = '\0';
+	mips_cmdline[0] = '\0';
 
 	if (offset) {
 		void (*fdt_relocated_)(void *) = NULL;
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..73ad1a4bc1f7 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL(mips_machtype);
 struct boot_mem_map boot_mem_map;
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
-char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
+char __initdata mips_cmdline[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_CMDLINE_BOOL
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
@@ -848,14 +848,14 @@ static void __init arch_mem_init(char **cmdline_p)
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
-	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
+	if ((USE_PROM_CMDLINE && mips_cmdline[0]) ||
 	    (USE_DTB_CMDLINE && !boot_command_line[0]))
-		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, mips_cmdline, COMMAND_LINE_SIZE);
 
-	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
+	if (EXTEND_WITH_PROM && mips_cmdline[0]) {
 		if (boot_command_line[0])
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, mips_cmdline, COMMAND_LINE_SIZE);
 	}
 
 #if defined(CONFIG_CMDLINE_BOOL)
@@ -865,10 +865,10 @@ static void __init arch_mem_init(char **cmdline_p)
 		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 
-	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
+	if (BUILTIN_EXTEND_WITH_PROM && mips_cmdline[0]) {
 		if (boot_command_line[0])
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, mips_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
 #endif
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 9ff7ccde9de0..e46d220e063f 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -57,14 +57,14 @@ static void __init prom_init_cmdline(void)
 	char **argv = (char **) KSEG1ADDR(fw_arg1);
 	int i;
 
-	arcs_cmdline[0] = '\0';
+	mips_cmdline[0] = '\0';
 
 	for (i = 0; i < argc; i++) {
 		char *p = (char *) KSEG1ADDR(argv[i]);
 
 		if (CPHYSADDR(p) && *p) {
-			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+			strlcat(mips_cmdline, p, sizeof(mips_cmdline));
+			strlcat(mips_cmdline, " ", sizeof(mips_cmdline));
 		}
 	}
 }
diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 17e15b50a551..d54b9d6f72fb 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -101,8 +101,8 @@ void __init prom_init(void)
 
 	/* Get the command line */
 	if (argc > 0) {
-		strncpy(arcs_cmdline, argv[0], COMMAND_LINE_SIZE-1);
-		arcs_cmdline[COMMAND_LINE_SIZE-1] = '\0';
+		strncpy(mips_cmdline, argv[0], COMMAND_LINE_SIZE-1);
+		mips_cmdline[COMMAND_LINE_SIZE-1] = '\0';
 	}
 
 	/* Set the I/O base address */
diff --git a/arch/mips/loongson32/common/prom.c b/arch/mips/loongson32/common/prom.c
index 68600980ea49..cc6f2be7829c 100644
--- a/arch/mips/loongson32/common/prom.c
+++ b/arch/mips/loongson32/common/prom.c
@@ -43,7 +43,7 @@ static inline unsigned long env_or_default(char *env, unsigned long dfl)
 
 void __init prom_init_cmdline(void)
 {
-	char *c = &(arcs_cmdline[0]);
+	char *c = &(mips_cmdline[0]);
 	int i;
 
 	for (i = 1; i < prom_argc; i++) {
@@ -67,11 +67,11 @@ void __init prom_init(void)
 	memsize = env_or_default("memsize", DEFAULT_MEMSIZE);
 	highmemsize = env_or_default("highmemsize", 0x0);
 
-	if (strstr(arcs_cmdline, "console=ttyS3"))
+	if (strstr(mips_cmdline, "console=ttyS3"))
 		uart_base = ioremap_nocache(LS1X_UART3_BASE, 0x0f);
-	else if (strstr(arcs_cmdline, "console=ttyS2"))
+	else if (strstr(mips_cmdline, "console=ttyS2"))
 		uart_base = ioremap_nocache(LS1X_UART2_BASE, 0x0f);
-	else if (strstr(arcs_cmdline, "console=ttyS1"))
+	else if (strstr(mips_cmdline, "console=ttyS1"))
 		uart_base = ioremap_nocache(LS1X_UART1_BASE, 0x0f);
 	else
 		uart_base = ioremap_nocache(LS1X_UART0_BASE, 0x0f);
diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
index 791588474d80..1f9b54c6b4f2 100644
--- a/arch/mips/loongson64/common/cmdline.c
+++ b/arch/mips/loongson64/common/cmdline.c
@@ -31,14 +31,14 @@ void __init prom_init_cmdline(void)
 	_prom_argv = (int *)fw_arg1;
 
 	/* arg[0] is "g", the rest is boot parameters */
-	arcs_cmdline[0] = '\0';
+	mips_cmdline[0] = '\0';
 	for (i = 1; i < prom_argc; i++) {
 		l = (long)_prom_argv[i];
-		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
-		    >= sizeof(arcs_cmdline))
+		if (strlen(mips_cmdline) + strlen(((char *)l) + 1)
+		    >= sizeof(mips_cmdline))
 			break;
-		strcat(arcs_cmdline, ((char *)l));
-		strcat(arcs_cmdline, " ");
+		strcat(mips_cmdline, ((char *)l));
+		strcat(mips_cmdline, " ");
 	}
 
 	prom_init_machtype();
diff --git a/arch/mips/loongson64/common/machtype.c b/arch/mips/loongson64/common/machtype.c
index d138130c561c..91d55c93314a 100644
--- a/arch/mips/loongson64/common/machtype.c
+++ b/arch/mips/loongson64/common/machtype.c
@@ -45,7 +45,7 @@ void __init prom_init_machtype(void)
 
 	mips_machtype = LOONGSON_MACHTYPE;
 
-	p = strstr(arcs_cmdline, "machtype=");
+	p = strstr(mips_cmdline, "machtype=");
 	if (!p) {
 		mach_prom_init_machtype();
 		return;
diff --git a/arch/mips/loongson64/lemote-2f/machtype.c b/arch/mips/loongson64/lemote-2f/machtype.c
index 2f0f11811d45..f216aa6a995e 100644
--- a/arch/mips/loongson64/lemote-2f/machtype.c
+++ b/arch/mips/loongson64/lemote-2f/machtype.c
@@ -26,18 +26,18 @@ void __init mach_prom_init_machtype(void)
 	 *		 LM6XXX		Lemote FuLoong(2F) box series
 	 *		 LM9XXX		Lemote LynLoong PC series
 	 */
-	if (strstr(arcs_cmdline, "PMON_VER=LM")) {
-		if (strstr(arcs_cmdline, "PMON_VER=LM8"))
+	if (strstr(mips_cmdline, "PMON_VER=LM")) {
+		if (strstr(mips_cmdline, "PMON_VER=LM8"))
 			mips_machtype = MACH_LEMOTE_YL2F89;
-		else if (strstr(arcs_cmdline, "PMON_VER=LM6"))
+		else if (strstr(mips_cmdline, "PMON_VER=LM6"))
 			mips_machtype = MACH_LEMOTE_FL2F;
-		else if (strstr(arcs_cmdline, "PMON_VER=LM9"))
+		else if (strstr(mips_cmdline, "PMON_VER=LM9"))
 			mips_machtype = MACH_LEMOTE_LL2F;
 		else
 			mips_machtype = MACH_LEMOTE_NAS;
 
-		strcat(arcs_cmdline, " machtype=");
-		strcat(arcs_cmdline, get_system_type());
-		strcat(arcs_cmdline, " ");
+		strcat(mips_cmdline, " machtype=");
+		strcat(mips_cmdline, get_system_type());
+		strcat(mips_cmdline, " ");
 	}
 }
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 7859b6e49863..036b25253008 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -182,7 +182,7 @@ static void __init append_memory(void *fdt, int root_off)
 	/* allow the user to override the usable memory */
 	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
 		snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
-		var = strstr(arcs_cmdline, param_name);
+		var = strstr(mips_cmdline, param_name);
 		if (!var)
 			continue;
 
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 72ceddc9a03f..7308963be7f0 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -99,39 +99,39 @@ void nlm_percpu_init(int hwcpuid)
 		xlr_percpu_fmn_init();
 }
 
-static void __init build_arcs_cmdline(int *argv)
+static void __init build_mips_cmdline(int *argv)
 {
 	int i, remain, len;
 	char *arg;
 
-	remain = sizeof(arcs_cmdline) - 1;
-	arcs_cmdline[0] = '\0';
+	remain = sizeof(mips_cmdline) - 1;
+	mips_cmdline[0] = '\0';
 	for (i = 0; argv[i] != 0; i++) {
 		arg = (char *)(long)argv[i];
 		len = strlen(arg);
 		if (len + 1 > remain)
 			break;
-		strcat(arcs_cmdline, arg);
-		strcat(arcs_cmdline, " ");
+		strcat(mips_cmdline, arg);
+		strcat(mips_cmdline, " ");
 		remain -=  len + 1;
 	}
 
 	/* Add the default options here */
-	if ((strstr(arcs_cmdline, "console=")) == NULL) {
+	if ((strstr(mips_cmdline, "console=")) == NULL) {
 		arg = "console=ttyS0,38400 ";
 		len = strlen(arg);
 		if (len > remain)
 			goto fail;
-		strcat(arcs_cmdline, arg);
+		strcat(mips_cmdline, arg);
 		remain -= len;
 	}
 #ifdef CONFIG_BLK_DEV_INITRD
-	if ((strstr(arcs_cmdline, "rdinit=")) == NULL) {
+	if ((strstr(mips_cmdline, "rdinit=")) == NULL) {
 		arg = "rdinit=/sbin/init ";
 		len = strlen(arg);
 		if (len > remain)
 			goto fail;
-		strcat(arcs_cmdline, arg);
+		strcat(mips_cmdline, arg);
 		remain -= len;
 	}
 #endif
@@ -195,7 +195,7 @@ void __init prom_init(void)
 	memcpy(reset_vec, (void *)nlm_reset_entry,
 			(nlm_reset_entry_end - nlm_reset_entry));
 
-	build_arcs_cmdline(argv);
+	build_mips_cmdline(argv);
 	prom_add_memory();
 
 #ifdef CONFIG_SMP
diff --git a/arch/mips/paravirt/setup.c b/arch/mips/paravirt/setup.c
index d2ffec1409a7..192e9efb9529 100644
--- a/arch/mips/paravirt/setup.c
+++ b/arch/mips/paravirt/setup.c
@@ -49,9 +49,9 @@ void __init prom_init(void)
 #endif
 
 	for (i = 0; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, argv[i], COMMAND_LINE_SIZE);
 		if (i < argc - 1)
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 	_machine_halt = pv_machine_halt;
 	register_smp_ops(&paravirt_smp_ops);
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 51599710472b..7831b1448827 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -60,12 +60,12 @@ void __init plat_mem_setup(void)
 
 	pr_info("Found following command lines\n");
 	pr_info(" boot_command_line: %s\n", boot_command_line);
-	pr_info(" arcs_cmdline     : %s\n", arcs_cmdline);
+	pr_info(" mips_cmdline     : %s\n", mips_cmdline);
 #ifdef CONFIG_CMDLINE_BOOL
 	pr_info(" builtin_cmdline  : %s\n", CONFIG_CMDLINE);
 #endif
 	if (dtb != __dtb_start)
-		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strlcpy(mips_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 
 #ifdef CONFIG_EARLY_PRINTK
 	fw_init_early_console(-1);
@@ -77,7 +77,7 @@ static __init void pic32_init_cmdline(int argc, char *argv[])
 {
 	unsigned int count = COMMAND_LINE_SIZE - 1;
 	int i;
-	char *dst = &(arcs_cmdline[0]);
+	char *dst = &(mips_cmdline[0]);
 	char *src;
 
 	for (i = 1; i < argc && count; ++i) {
diff --git a/arch/mips/pmcs-msp71xx/msp_prom.c b/arch/mips/pmcs-msp71xx/msp_prom.c
index 6fdcb3d6fbb5..a2e841040cec 100644
--- a/arch/mips/pmcs-msp71xx/msp_prom.c
+++ b/arch/mips/pmcs-msp71xx/msp_prom.c
@@ -311,14 +311,14 @@ void  __init prom_init_cmdline(void)
 
 	actr = 1; /* Always ignore argv[0] */
 
-	cp = &(arcs_cmdline[0]);
+	cp = &(mips_cmdline[0]);
 	while (actr < prom_argc) {
 		strcpy(cp, prom_argv[actr]);
 		cp += strlen(prom_argv[actr]);
 		*cp++ = ' ';
 		actr++;
 	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
+	if (cp != &(mips_cmdline[0])) /* get rid of trailing space */
 		--cp;
 	*cp = '\0';
 }
diff --git a/arch/mips/pnx833x/common/prom.c b/arch/mips/pnx833x/common/prom.c
index dfafdd732ca1..8008f70766f8 100644
--- a/arch/mips/pnx833x/common/prom.c
+++ b/arch/mips/pnx833x/common/prom.c
@@ -30,7 +30,7 @@ void __init prom_init_cmdline(void)
 {
 	int argc = fw_arg0;
 	char **argv = (char **)fw_arg1;
-	char *c = &(arcs_cmdline[0]);
+	char *c = &(mips_cmdline[0]);
 	int i;
 
 	for (i = 1; i < argc; i++) {
diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index 23198c9050e5..a8969d5c8864 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -54,8 +54,8 @@ static __init void prom_init_cmdline(void)
 
 		if (CPHYSADDR(p) && *p) {
 			pr_debug("argv[%d]: %s\n", i, p);
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
+			strlcat(mips_cmdline, " ", sizeof(mips_cmdline));
+			strlcat(mips_cmdline, p, sizeof(mips_cmdline));
 		}
 	}
 }
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 6484e4a4597b..bc2195abd425 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -108,15 +108,15 @@ void __init prom_setup_cmdline(void)
 	}
 	*(cp++) = ' ';
 
-	i = strlen(arcs_cmdline);
+	i = strlen(mips_cmdline);
 	if (i > 0) {
 		*(cp++) = ' ';
-		strcpy(cp, arcs_cmdline);
-		cp += strlen(arcs_cmdline);
+		strcpy(cp, mips_cmdline);
+		cp += strlen(mips_cmdline);
 	}
 	cmd_line[COMMAND_LINE_SIZE - 1] = '\0';
 
-	strcpy(arcs_cmdline, cmd_line);
+	strcpy(mips_cmdline, cmd_line);
 }
 
 void __init prom_init(void)
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 115399202eab..fda9f22ae786 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -287,7 +287,7 @@ void __init prom_init(void)
 	 * boot console
 	 */
 	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
-	if (cfe_getenv("LINUX_CMDLINE", arcs_cmdline, COMMAND_LINE_SIZE) < 0) {
+	if (cfe_getenv("LINUX_CMDLINE", mips_cmdline, COMMAND_LINE_SIZE) < 0) {
 		if (argc >= 0) {
 			/* The loader should have set the command line */
 			/* too early for panic to do any good */
@@ -301,7 +301,7 @@ void __init prom_init(void)
 		char *ptr;
 		/* Need to find out early whether we've got an initrd.	So scan
 		   the list looking now */
-		for (ptr = arcs_cmdline; *ptr; ptr++) {
+		for (ptr = mips_cmdline; *ptr; ptr++) {
 			while (*ptr == ' ') {
 				ptr++;
 			}
@@ -318,7 +318,7 @@ void __init prom_init(void)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	/* Not sure this is needed, but it's the safe way. */
-	arcs_cmdline[COMMAND_LINE_SIZE-1] = 0;
+	mips_cmdline[COMMAND_LINE_SIZE-1] = 0;
 
 	prom_meminit();
 
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1791a44ee570..c83ae80f16bd 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -127,18 +127,18 @@ static void __init prom_init_cmdline(void)
 		argv32 = (int *)fw_arg1;
 	}
 
-	arcs_cmdline[0] = '\0';
+	mips_cmdline[0] = '\0';
 
 	for (i = 1; i < argc; i++) {
 		char *str = (char *)(long)argv32[i];
 		if (i != 1)
-			strcat(arcs_cmdline, " ");
+			strcat(mips_cmdline, " ");
 		if (strchr(str, ' ')) {
-			strcat(arcs_cmdline, "\"");
-			strcat(arcs_cmdline, str);
-			strcat(arcs_cmdline, "\"");
+			strcat(mips_cmdline, "\"");
+			strcat(mips_cmdline, str);
+			strcat(mips_cmdline, "\"");
 		} else
-			strcat(arcs_cmdline, str);
+			strcat(mips_cmdline, str);
 	}
 }
 
@@ -251,9 +251,9 @@ static void __init preprocess_cmdline(void)
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	char *s;
 
-	strcpy(cmdline, arcs_cmdline);
+	strcpy(cmdline, mips_cmdline);
 	s = cmdline;
-	arcs_cmdline[0] = '\0';
+	mips_cmdline[0] = '\0';
 	while (s && *s) {
 		char *str = strsep(&s, " ");
 		if (strncmp(str, "board=", 6) == 0) {
@@ -277,9 +277,9 @@ static void __init preprocess_cmdline(void)
 			txx9_ccfg_toeon = 1;
 			continue;
 		}
-		if (arcs_cmdline[0])
-			strcat(arcs_cmdline, " ");
-		strcat(arcs_cmdline, str);
+		if (mips_cmdline[0])
+			strcat(mips_cmdline, " ");
+		strcat(mips_cmdline, str);
 	}
 
 	txx9_cache_fixup();
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 23916321cc1b..42ea5ba6ddff 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -66,9 +66,9 @@ void __init prom_init(void)
 	argv = (char **)fw_arg1;
 
 	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		strlcat(mips_cmdline, argv[i], COMMAND_LINE_SIZE);
 		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(mips_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index dc2189e1df26..6f37ace28216 100755
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -30,7 +30,7 @@
 
 #include <cs5536/cs5536.h>
 
-#include <asm/setup.h>		/* for arcs_cmdline */
+#include <asm/setup.h>		/* for mips_cmdline */
 #include <ec_kb3310b.h>
 
 /* common function */
@@ -40,7 +40,7 @@ static int ec_version_before(char *version)
 {
 	char *p, ec_ver[EC_VER_LEN];
 
-	p = strstr(arcs_cmdline, "EC_VER=");
+	p = strstr(mips_cmdline, "EC_VER=");
 	if (!p)
 		memset(ec_ver, 0, EC_VER_LEN);
 	else {
-- 
2.15.1
