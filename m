Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:50:18 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:48823 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041140AbWHHMtU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:20 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240932nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hkX9HfSKAj5MbeoXvT2IRE1WqmG+2WThQAaj63tKOJ67vgQoMbILLtP2ZqpbA6BDivvXPT+s9pfzNHQaCEkZo6iHpq7kcd0iSULGAjXDwguPVQ06VBHa6bZRG8sP+lnT5JmsxW7kUckJ2+1n9CjYlvtoQ4fEyhsuYcfBAuUNOSs=
Received: by 10.49.29.3 with SMTP id g3mr400342nfj;
        Tue, 08 Aug 2006 05:49:17 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id h1sm760161nfe.2006.08.08.05.49.15;
        Tue, 08 Aug 2006 05:49:16 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id C5EA623F774; Tue,  8 Aug 2006 14:48:33 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 6/6] setup.c: use early_param() for early command line parsing
Date:	Tue,  8 Aug 2006 14:48:32 +0200
Message-Id: <1155041313139-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

There's no point to rewrite some logic to parse command line
to pass initrd parameters or to declare a user memory area.
We could use instead parse_early_param() that does the same
thing.

NOTE ! This patch also changes the initrd semantic. Old code
was expecting "rd_start=xxx rd_size=xxx" which uses two
parameters. Now the code expects "initrd=xxx@yyy" which is
really simpler to parse and to use. No default config files
use these parameters anyways but not sure for bootloader's
users...

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |  173 +++++++++++++++-------------------------------
 1 files changed, 55 insertions(+), 118 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e835737..ec459a1 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -135,124 +135,29 @@ static void __init print_memory_map(void
 	}
 }
 
-static void __init parse_cmdline_early(void)
-{
-	char c = ' ', *to = command_line, *from = saved_command_line;
-	unsigned long start_at, mem_size;
-	int len = 0;
-	int usermem = 0;
-
-	printk("Determined physical RAM map:\n");
-	print_memory_map();
-
-	for (;;) {
-		/*
-		 * "mem=XXX[kKmM]" defines a memory region from
-		 * 0 to <XXX>, overriding the determined size.
-		 * "mem=XXX[KkmM]@YYY[KkmM]" defines a memory region from
-		 * <YYY> to <YYY>+<XXX>, overriding the determined size.
-		 */
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
-			if (to != command_line)
-				to--;
-			/*
-			 * If a user specifies memory size, we
-			 * blow away any automatically generated
-			 * size.
-			 */
-			if (usermem == 0) {
-				boot_mem_map.nr_map = 0;
-				usermem = 1;
-			}
-			mem_size = memparse(from + 4, &from);
-			if (*from == '@')
-				start_at = memparse(from + 1, &from);
-			else
-				start_at = 0;
-			add_memory_region(start_at, mem_size, BOOT_MEM_RAM);
-		}
-		c = *(from++);
-		if (!c)
-			break;
-		if (CL_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-	*to = '\0';
-
-	if (usermem) {
-		printk("User-defined physical RAM map:\n");
-		print_memory_map();
-	}
-}
-
 /*
  * Manage initrd
  */
 #ifdef CONFIG_BLK_DEV_INITRD
 
-static int __init parse_rd_cmdline(unsigned long *rd_start, unsigned long *rd_end)
+static int __init initrd_early(char *p)
 {
-	/*
-	 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
-	 * "rd_size=0xNN" it's size
-	 */
-	unsigned long start = 0;
-	unsigned long size = 0;
-	unsigned long end;
-	char cmd_line[CL_SIZE];
-	char *start_str;
-	char *size_str;
-	char *tmp;
-
-	strcpy(cmd_line, command_line);
-	*command_line = 0;
-	tmp = cmd_line;
-	/* Ignore "rd_start=" strings in other parameters. */
-	start_str = strstr(cmd_line, "rd_start=");
-	if (start_str && start_str != cmd_line && *(start_str - 1) != ' ')
-		start_str = strstr(start_str, " rd_start=");
-	while (start_str) {
-		if (start_str != cmd_line)
-			strncat(command_line, tmp, start_str - tmp);
-		start = memparse(start_str + 9, &start_str);
-		tmp = start_str + 1;
-		start_str = strstr(start_str, " rd_start=");
-	}
-	if (*tmp)
-		strcat(command_line, tmp);
-
-	strcpy(cmd_line, command_line);
-	*command_line = 0;
-	tmp = cmd_line;
-	/* Ignore "rd_size" strings in other parameters. */
-	size_str = strstr(cmd_line, "rd_size=");
-	if (size_str && size_str != cmd_line && *(size_str - 1) != ' ')
-		size_str = strstr(size_str, " rd_size=");
-	while (size_str) {
-		if (size_str != cmd_line)
-			strncat(command_line, tmp, size_str - tmp);
-		size = memparse(size_str + 8, &size_str);
-		tmp = size_str + 1;
-		size_str = strstr(size_str, " rd_size=");
-	}
-	if (*tmp)
-		strcat(command_line, tmp);
+	unsigned long start, size;
 
+	size = memparse(p, &p);
+	if (size && *p == '@') {
+		start = memparse(p + 1, &p);
 #ifdef CONFIG_64BIT
-	/* HACK: Guess if the sign extension was forgotten */
-	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
-		start |= 0xffffffff00000000UL;
+		/* HACK: Guess if the sign extension was forgotten */
+		if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
+			start |= 0xffffffff00000000UL;
 #endif
-
-	end = start + size;
-	if (start && end) {
-		*rd_start = start;
-		*rd_end = end;
-		return 1;
+		initrd_start = start;
+		initrd_end = start + size;
 	}
 	return 0;
 }
+early_param("initrd", initrd_early);
 
 static unsigned long __init init_initrd(void)
 {
@@ -260,7 +165,7 @@ static unsigned long __init init_initrd(
 	u32 *initrd_header;
 
 	ROOT_DEV = Root_RAM0;
-	if (parse_rd_cmdline(&initrd_start, &initrd_end))
+	if (initrd_end)
 		return initrd_end;
 
 	/* 
@@ -282,25 +187,25 @@ static unsigned long __init init_initrd(
 
 static void __init finalize_initrd(void)
 {
-	unsigned long initrd_size = 
+	unsigned long size =
 		(unsigned long)initrd_end - (unsigned long)initrd_start;
 
-	if (initrd_size == 0) {
+	if (size == 0) {
 		printk(KERN_INFO "Initrd not found or empty");
-		goto check_ko;
+		goto disable;
 	}
 	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
 		printk("Initrd extends beyond end of memory");
-		goto check_ko;
+		goto disable;
 	}
 
-	reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
+	reserve_bootmem(CPHYSADDR(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
-	       (void *)initrd_start, initrd_size);
+	       (void *)initrd_start, size);
 	return;
-check_ko:
+disable:
 	printk(" - disabling initrd\n");
 	initrd_start = 0;
 	initrd_end = 0;
@@ -437,8 +342,6 @@ #endif	/* CONFIG_SGI_IP27 */
  *
  *  o plat_mem_setup() detects the memory configuration and will record detected
  *    memory areas using add_memory_region.
- *  o parse_cmdline_early() parses the command line for mem= options which,
- *    iff detected, will override the results of the automatic detection.
  *
  * At this stage the memory configuration of the system is known to the
  * kernel but generic memory managment system is still entirely uninitialized.
@@ -456,19 +359,53 @@ #endif	/* CONFIG_SGI_IP27 */
  * initialization hook for anything else was introduced.
  */
 
-extern void plat_mem_setup(void);
+static int usermem __initdata = 0;
+
+static int __init early_parse_mem(char *p)
+{
+	unsigned long start, size;
+
+	/*
+	 * If a user specifies memory size, we
+	 * blow away any automatically generated
+	 * size.
+	 */
+	if (usermem == 0) {
+		boot_mem_map.nr_map = 0;
+		usermem = 1;
+ 	}
+	start = 0;
+	size = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
+	add_memory_region(start, size, BOOT_MEM_RAM);
+	return 0;
+}
+early_param("mem", early_parse_mem);
 
 static void __init arch_mem_init(char **cmdline_p)
 {
+	extern void plat_mem_setup(void);
+
 	/* call board setup routine */
 	plat_mem_setup();
 
+	printk("Determined physical RAM map:\n");
+	print_memory_map();
+
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
 	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 
-	parse_cmdline_early();
+	parse_early_param();
+
+	if (usermem) {
+		printk("User-defined physical RAM map:\n");
+		print_memory_map();
+	}
+
 	bootmem_init();
 	sparse_init();
 	paging_init();
-- 
1.4.2.rc2
