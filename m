Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 03:06:23 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44551
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224989AbUKUDGQ>; Sun, 21 Nov 2004 03:06:16 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVi3L-0004p2-00; Sun, 21 Nov 2004 04:06:15 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVi3K-0004rZ-00; Sun, 21 Nov 2004 04:06:14 +0100
Date: Sun, 21 Nov 2004 04:06:14 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Improve ramdisk support
Message-ID: <20041121030614.GL20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

there are currently two methods to use an initial ramdisk in the
kernel, either by compiling it in via CONFIG_EMBEDDED_RAMDISK or by
tacking the ramdisk on the kernel image via addinitrd. A third method
currently under development is a compiled in cpio archive handled via
initramfs.

There is, however, no way to add an initial ramdisk after the kernel
was built. The appended patch introduces "rd_start" and "rd_size"
command line parameters which allow a bootloader to preload the
ramdisk and make its location known to the kernel by feeding
appropriate rd_start/rd_size values.

Debian used an earlier version of this patch for several years now.


Thiemo


Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.171
diff -u -p -r1.171 setup.c
--- arch/mips/kernel/setup.c	28 Jun 2004 21:04:12 -0000	1.171
+++ arch/mips/kernel/setup.c	20 Nov 2004 16:46:39 -0000
@@ -194,6 +194,68 @@ static inline void parse_cmdline_early(v
 	}
 }
 
+static inline int parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
+{
+	/*
+	 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
+	 * "rd_size=0xNN" it's size
+	 */
+	unsigned long start = 0;
+	unsigned long size = 0;
+	unsigned long end;
+	char cmd_line[CL_SIZE];
+	char *start_str;
+	char *size_str;
+	char *tmp;
+
+	strcpy(cmd_line, command_line);
+	*command_line = 0;
+	tmp = cmd_line;
+	/* Ignore "rd_start=" strings in other parameters. */
+	start_str = strstr(cmd_line, "rd_start=");
+	if (start_str && start_str != cmd_line && *(start_str - 1) != ' ')
+		start_str = strstr(start_str, " rd_start=");
+	while (start_str) {
+		if (start_str != cmd_line)
+			strncat(command_line, tmp, start_str - tmp);
+		start = memparse(start_str + 9, &start_str);
+		tmp = start_str + 1;
+		start_str = strstr(start_str, " rd_start=");
+	}
+	if (*tmp)
+		strcat(command_line, tmp);
+
+	strcpy(cmd_line, command_line);
+	*command_line = 0;
+	tmp = cmd_line;
+	/* Ignore "rd_size" strings in other parameters. */
+	size_str = strstr(cmd_line, "rd_size=");
+	if (size_str && size_str != cmd_line && *(size_str - 1) != ' ')
+		size_str = strstr(size_str, " rd_size=");
+	while (size_str) {
+		if (size_str != cmd_line)
+			strncat(command_line, tmp, size_str - tmp);
+		size = memparse(size_str + 8, &size_str);
+		tmp = size_str + 1;
+		size_str = strstr(size_str, " rd_size=");
+	}
+	if (*tmp)
+		strcat(command_line, tmp);
+
+#ifdef CONFIG_MIPS64
+	/* HACK: Guess if the sign extension was forgotten */
+	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
+		start |= 0xffffffff00000000;
+#endif
+
+	end = start + size;
+	if (start && end) {
+		*rd_start = start;
+		*rd_end = end;
+		return 1;
+	}
+	return 0;
+}
 
 #define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
@@ -205,30 +267,45 @@ static inline void parse_cmdline_early(v
 static inline void bootmem_init(void)
 {
 	unsigned long start_pfn;
+	unsigned long reserved_end = (unsigned long)&_end;
 #ifndef CONFIG_SGI_IP27
-	unsigned long bootmap_size, max_low_pfn, first_usable_pfn;
+	unsigned long first_usable_pfn;
+	unsigned long bootmap_size;
 	int i;
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long tmp;
-	unsigned long *initrd_header;
+	int initrd_reserve_bootmem = 0;
 
-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
-	if (tmp < (unsigned long)&_end)
-		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
-	if (initrd_header[0] == 0x494E5244) {
-		initrd_start = (unsigned long)&initrd_header[2];
-		initrd_end = initrd_start + initrd_header[1];
+	/* Board specific code should have set up initrd_start and initrd_end */
+ 	ROOT_DEV = Root_RAM0;
+	if (&__rd_start != &__rd_end) {
+		initrd_start = (unsigned long)&__rd_start;
+		initrd_end = (unsigned long)&__rd_end;
+	} else if (parse_rd_cmdline(&initrd_start, &initrd_end)) {
+		reserved_end = max(reserved_end, initrd_end);
+		initrd_reserve_bootmem = 1;
+	} else {
+		unsigned long tmp;
+		unsigned long *initrd_header;
+
+		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+		if (tmp < reserved_end)
+			tmp += PAGE_SIZE;
+		initrd_header = (unsigned long *)tmp;
+		if (initrd_header[0] == 0x494E5244) {
+			initrd_start = (unsigned long)&initrd_header[2];
+			initrd_end = initrd_start + initrd_header[1];
+			reserved_end = max(reserved_end, initrd_end);
+			initrd_reserve_bootmem = 1;
+		}
 	}
-	start_pfn = PFN_UP(CPHYSADDR((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
-#else
+#endif	/* CONFIG_BLK_DEV_INITRD */
+
 	/*
 	 * Partially used pages are not usable - thus
 	 * we are rounding upwards.
 	 */
-	start_pfn = PFN_UP(CPHYSADDR(&_end));
-#endif	/* CONFIG_BLK_DEV_INITRD */
+	start_pfn = PFN_UP(CPHYSADDR(reserved_end));
 
 #ifndef CONFIG_SGI_IP27
 	/* Find the highest page frame number we have available.  */
@@ -341,21 +418,14 @@ static inline void bootmem_init(void)
 
 	/* Reserve the bootmap memory.  */
 	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
-#endif
+#endif /* CONFIG_SGI_IP27 */
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	/* Board specific code should have set up initrd_start and initrd_end */
-	ROOT_DEV = Root_RAM0;
-	if (&__rd_start != &__rd_end) {
-		initrd_start = (unsigned long)&__rd_start;
-		initrd_end = (unsigned long)&__rd_end;
-	}
 	initrd_below_start_ok = 1;
 	if (initrd_start) {
 		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start);
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *)initrd_start,
-		       initrd_size);
+		       (void *)initrd_start, initrd_size);
 
 		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
 			printk("initrd extends beyond end of memory "
@@ -363,7 +433,11 @@ static inline void bootmem_init(void)
 			       sizeof(long) * 2, CPHYSADDR(initrd_end),
 			       sizeof(long) * 2, PFN_PHYS(max_low_pfn));
 			initrd_start = initrd_end = 0;
+			initrd_reserve_bootmem = 0;
 		}
+
+		if (initrd_reserve_bootmem)
+			reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD  */
 }
