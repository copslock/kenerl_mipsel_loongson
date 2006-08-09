Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:56:08 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:35046 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20042398AbWHIOxb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 15:53:31 +0100
Received: by nf-out-0910.google.com with SMTP id o60so206825nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 07:53:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cuQ1Iag9A0pGqqSIAlmJfjjiZCSNyYpOB6HCePME3HZpryfS2XxndeagPNO7Nn/KC+kc2oSnfoz3WmSm8PMNrzDjCvh+vZrVxxRQCH484Qy8/WMaGJExwZw6zE/SKI1YUaFmAph0z2gFdvnawm+C4bMPzYSdjXq4XOrRtQLUxZU=
Received: by 10.48.48.15 with SMTP id v15mr1458153nfv;
        Wed, 09 Aug 2006 07:53:25 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id p43sm1369463nfa.2006.08.09.07.53.23;
        Wed, 09 Aug 2006 07:53:25 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4A4C423F774; Wed,  9 Aug 2006 16:52:40 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 6/6] setup.c: use early_param() for early command line parsing
Date:	Wed,  9 Aug 2006 16:52:38 +0200
Message-Id: <11551351592752-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12255
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

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |  186 +++++++++++++++++-----------------------------
 1 files changed, 67 insertions(+), 119 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 895a357..7dc643c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -135,138 +135,54 @@ static void __init print_memory_map(void
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
+static int __init rd_start_early(char *p)
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
+	unsigned long start = memparse(p, &p);
 
 #ifdef CONFIG_64BIT
 	/* HACK: Guess if the sign extension was forgotten */
 	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
 		start |= 0xffffffff00000000UL;
 #endif
+	initrd_start = start;
+	initrd_end += start;
+	return 0;
+}
+early_param("rd_start", rd_start_early);
 
-	end = start + size;
-	if (start && end) {
-		*rd_start = start;
-		*rd_end = end;
-		return 1;
-	}
+
+static int __init rd_size_early(char *p)
+{
+	initrd_end += memparse(p, &p);
 	return 0;
 }
+early_param("rd_size", rd_size_early);
+
 
 static unsigned long __init init_initrd(void)
 {
-	unsigned long tmp, end;
+	unsigned long tmp, end, size;
 	u32 *initrd_header;
 
 	ROOT_DEV = Root_RAM0;
 
-	if (parse_rd_cmdline(&initrd_start, &initrd_end))
-		return initrd_end;
 	/* 
-	 * Board specific code should have set up initrd_start 
-	 * and initrd_end...
+	 * Board specific code or command line parser should have
+	 * already set up initrd_start and initrd_end. In these cases
+	 * perfom sanity checks and use them if all looks good.
 	 */
+	size = (unsigned long)initrd_end - (unsigned long)initrd_start;
+	if (initrd_end == 0 || size == 0) {
+		initrd_start = 0;
+		initrd_end = 0;
+	} else
+		return initrd_end;
+
 	end = (unsigned long)&_end;
 	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
 	if (tmp < end)
@@ -282,25 +198,25 @@ static unsigned long __init init_initrd(
 
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
@@ -437,8 +353,6 @@ #endif	/* CONFIG_SGI_IP27 */
  *
  *  o plat_mem_setup() detects the memory configuration and will record detected
  *    memory areas using add_memory_region.
- *  o parse_cmdline_early() parses the command line for mem= options which,
- *    iff detected, will override the results of the automatic detection.
  *
  * At this stage the memory configuration of the system is known to the
  * kernel but generic memory managment system is still entirely uninitialized.
@@ -456,19 +370,53 @@ #endif	/* CONFIG_SGI_IP27 */
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
