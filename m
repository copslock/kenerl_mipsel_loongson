Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GEXtnC025058
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 07:33:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GEXt4Z025057
	for linux-mips-outgoing; Thu, 16 May 2002 07:33:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GEXenC025051
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 07:33:40 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 95FC98D35; Thu, 16 May 2002 16:34:10 +0200 (CEST)
Date: Thu, 16 May 2002 16:34:10 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: ralf@gnu.org
Cc: linux-mips@oss.sgi.com
Subject: Re: howto pass ramdisk loaddress to kernel
Message-ID: <20020516163410.A32622@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: ralf@gnu.org, linux-mips@oss.sgi.com
References: <20020507123249.A9827@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020507123249.A9827@gandalf.physik.uni-konstanz.de>; from agx@sigxcpu.org on Tue, May 07, 2002 at 12:32:49PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2002 at 12:32:49PM +0200, Guido Guenther wrote:
> Hi,
> in order to get rid of some ip22 specific hacks in setup.c as well as
> addinitrd/elf2ecoff I've written a small tool that links kernel+initrd
> as type "binary" into the data segment of the bootloader. This file can
> then be fetched by the prom via tftp(or from a CD or whatever). The
> bootloader copies the kernel to its loaddress and puts the initrd just
> after the kernel.
> My question is now: how do i properly pass the initrd's memory address
> to the kernel? Choices are:
> 1) on the commandline: rd_start=0x...
> 2) a bootparameter block like on i386 or sparc in head.S
> 3) rely on the kernel to identify if a radisk has
>   been loaded by a magic number
Attached is a patch that implements (1). Arguments used are rd_start &
rd_size. Ralf, please apply if suitable.
 -- Guido

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ramdisk-cmdline-2002-05-09.diff"

Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.12
diff -u -u -r1.96.2.12 setup.c
--- arch/mips/kernel/setup.c	2002/02/15 21:05:48	1.96.2.12
+++ arch/mips/kernel/setup.c	2002/05/10 18:32:09
@@ -650,6 +650,38 @@
 	}
 }
 
+static inline void parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
+{
+	char c = ' ', *to = command_line, *from = saved_command_line;
+	int len = 0;
+	unsigned long rd_size = 0;
+
+	for (;;) {
+		/*
+		 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
+		 * "rd_size=0xNN" it's size
+		 */
+		if (c == ' ' && !memcmp(from, "rd_start=", 9)) {
+			if (to != command_line)
+				to--;
+			(*rd_start) = memparse(from + 9, &from);
+		}
+		if (c == ' ' && !memcmp(from, "rd_size=", 8)) {
+			if (to != command_line)
+				to--;
+			rd_size = memparse(from + 8, &from);
+		}
+		c = *(from++);
+		if (!c)
+			break;
+		if (CL_SIZE <= ++len)
+			break;
+		*(to++) = c;
+	}
+	*to = '\0';
+	(*rd_end) = (*rd_start) + rd_size;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	void atlas_setup(void);
@@ -674,10 +706,7 @@
 
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
-#ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long tmp;
-	unsigned long* initrd_header;
-#endif
+	unsigned long end = &_end;
 
 	int i;
 
@@ -828,22 +857,18 @@
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8; 
-	if (tmp < (unsigned long)&_end) 
-		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
-	if (initrd_header[0] == 0x494E5244) {
-		initrd_start = (unsigned long)&initrd_header[2];
-		initrd_end = initrd_start + initrd_header[1];
+	parse_rd_cmdline(&initrd_start, &initrd_end);
+	if(initrd_start && initrd_end)
+		end = initrd_end;
+	else {
+		initrd_start = initrd_end = 0;
 	}
-	start_pfn = PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
-#else
+#endif /* CONFIG_BLK_DEV_INITRD */
 	/*
 	 * Partially used pages are not usable - thus
 	 * we are rounding upwards.
 	 */
-	start_pfn = PFN_UP(__pa(&_end));
-#endif	/* CONFIG_BLK_DEV_INITRD */
+	start_pfn = PFN_UP(__pa(end));
 
 	/* Find the highest page frame number we have available.  */
 	max_pfn = 0;

--KsGdsel6WgEHnImy--
