Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 08:48:17 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:61583 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20021510AbXCHIsO
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Mar 2007 08:48:14 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Thu, 08 Mar 2007 00:46:56 -0800
  id 0045019D.45EFCD80.00001566
Message-ID: <45EFCD73.2010404@jg555.com>
Date:	Thu, 08 Mar 2007 00:46:43 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-5478-1173343616-0001-2"
To:	Jim Gifford <maillist@jg555.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 64 bit kernel on Cobalt
References: <45EB53D5.8060007@jg555.com> <20070304232731.GA25039@linux-mips.org> <45EFA92C.3070203@jg555.com>
In-Reply-To: <45EFA92C.3070203@jg555.com>
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-5478-1173343616-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's what we isolated it to.

The problem looks like this

inflate: decompressing
elf64: 00080000 - 0037701f (ffffffff.80326000) (ffffffff.80000000)
elf64: ffffffff.80080000 (80080000) 2957446t + 151450t
net: interface down

If we apply the patch that's attached we can boot all the way up, but we 
do get some errors. I'm hoping one of these errors might shed the light 
on what the actual issue is.

VFS: Mounted root (nfs filesystem) readonly.
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff802adc60 0000000000000000 0000000000000000
$ 4   : ffffffff80089eec ffffffffde020000 ffffffff8008c588 0000000000000000
$ 8   : 0000000000561024 996bffffff40b050 0000000000000000 000000000000f6f8
$12   : ffffffff94004ce0 000000001000001e 0000000000000000 ffffffff80300000
$16   : 9800000000387df0 ffffffff80326000 0000000000000000 00067ffffff80326
$20   : 00067ffffff80326 000000000000002d fffffffffffffbff 67ffffff80353000
$24   : 0000000000000010 ffffffff801768d8
$28   : 9800000000384000 9800000000387dc0 67ffffff80326000 ffffffff80081e28
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff80089f04 do_ade+0x3a4/0x4c0     Not tainted
ra    : ffffffff80081e28 ret_from_exception+0x0/0x1c
Status: 94004ce2    KX SX UX KERNEL EXL
Cause : 00808010
BadVA : 996bffffff40b057
PrId  : 000028a0
Process swapper (pid: 1, threadinfo=9800000000384000, task=9800000000381828)
Stack : 996bffffff40b050 ffffffff80326000 016bfffffe40b050 00067ffffff80326
        ffffffff80081e28 0000000000000000 0000000000000000 ffffffff94004ce0
        9800000001000000 019ffffffe00c980 ffffffff94004ce1 00067ffffff80353
        6800000000000000 9800000000381828 98000000013e9a40 98000000003b3000
        ffffffff80309758 000000000000f6f8 0000000000000001 ffffffff801b9388
        0000000000000000 ffffffff80300000 996bffffff40b050 ffffffff80326000
        016bfffffe40b050 00067ffffff80326 00067ffffff80326 000000000000002d
        fffffffffffffbff 67ffffff80353000 0000000000000010 ffffffff801768d8
        ffffffff800fb5ac ffffffff800fb5ac 9800000000384000 9800000000387f20
        67ffffff80326000 ffffffff8008c4d0 ffffffff94004ce2 0000000000000000
        ...
Call Trace:
[<ffffffff80089f04>] do_ade+0x3a4/0x4c0
[<ffffffff80081e28>] ret_from_exception+0x0/0x1c
[<ffffffff8008c588>] free_initmem+0xe8/0x218
[<ffffffff80080688>] init+0x248/0x510
[<ffffffff80084420>] kernel_thread_helper+0x10/0x18


Code: 00431024  5440ff77  de020100 <69230007> 6d230000  24020000  
1440ffba  00051402  08022760
Kernel panic - not syncing: Attempted to kill init!

patch - at http://ftp.jg555.com/revert.working.diff


--=_server-5478-1173343616-0001-2
Content-Type: text/x-patch; name="revert.working.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revert.working.diff"

--- linux-2.6.19.2/arch/mips/kernel/setup.c	2007-01-10 11:10:37.000000000 -0800
+++ linux-2.6.20.1/arch/mips/kernel/setup.c	2007-03-07 20:59:28.000000000 -0800
@@ -145,13 +145,12 @@
 	unsigned long start = memparse(p, &p);
 
 #ifdef CONFIG_64BIT
-	/* HACK: Guess if the sign extension was forgotten */
-	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
-		start |= 0xffffffff00000000UL;
+	/* Guess if the sign extension was forgotten by bootloader */
+	if (start < XKPHYS)
+		start = (int)start;
 #endif
 	initrd_start = start;
 	initrd_end += start;
-
 	return 0;
 }
 early_param("rd_start", rd_start_early);
@@ -159,41 +158,64 @@
 static int __init rd_size_early(char *p)
 {
 	initrd_end += memparse(p, &p);
-
 	return 0;
 }
 early_param("rd_size", rd_size_early);
 
+/* it returns the next free pfn after initrd */
 static unsigned long __init init_initrd(void)
 {
-	unsigned long tmp, end, size;
+	unsigned long end;
 	u32 *initrd_header;
 
-	ROOT_DEV = Root_RAM0;
-
 	/*
 	 * Board specific code or command line parser should have
 	 * already set up initrd_start and initrd_end. In these cases
 	 * perfom sanity checks and use them if all looks good.
 	 */
-	size = initrd_end - initrd_start;
-	if (initrd_end == 0 || size == 0) {
-		initrd_start = 0;
-		initrd_end = 0;
-	} else
-		return initrd_end;
-
-	end = (unsigned long)&_end;
-	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
-	if (tmp < end)
-		tmp += PAGE_SIZE;
-
-	initrd_header = (u32 *)tmp;
-	if (initrd_header[0] == 0x494E5244) {
-		initrd_start = (unsigned long)&initrd_header[2];
-		initrd_end = initrd_start + initrd_header[1];
+	if (initrd_start && initrd_end > initrd_start)
+		goto sanitize;
+
+	/*
+	 * See if initrd has been added to the kernel image by
+	 * arch/mips/boot/addinitrd.c. In that case a header is
+	 * prepended to initrd and is made up by 8 bytes. The fisrt
+	 * word is a magic number and the second one is the size of
+	 * initrd.  Initrd start must be page aligned in any cases.
+	 */
+	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
+	if (initrd_header[0] != 0x494E5244)
+		goto disable;
+	initrd_start = (unsigned long)(initrd_header + 2);
+	initrd_end = initrd_start + initrd_header[1];
+
+sanitize:
+	if (initrd_start & ~PAGE_MASK) {
+		printk(KERN_ERR "initrd start must be page aligned\n");
+		goto disable;
 	}
-	return initrd_end;
+	if (initrd_start < PAGE_OFFSET) {
+		printk(KERN_ERR "initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
+	/*
+	 * Sanitize initrd addresses. For example firmware
+	 * can't guess if they need to pass them through
+	 * 64-bits values if the kernel has been built in pure
+	 * 32-bit. We need also to switch from KSEG0 to XKPHYS
+	 * addresses now, so the code can now safely use __pa().
+	 */
+	end = __pa(initrd_end);
+	initrd_end = (unsigned long)__va(end);
+	initrd_start = (unsigned long)__va(__pa(initrd_start));
+
+	ROOT_DEV = Root_RAM0;
+	return PFN_UP(end);
+disable:
+	initrd_start = 0;
+	initrd_end = 0;
+	return 0;
 }
 
 static void __init finalize_initrd(void)
@@ -204,12 +226,12 @@
 		printk(KERN_INFO "Initrd not found or empty");
 		goto disable;
 	}
-	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
 		printk("Initrd extends beyond end of memory");
 		goto disable;
 	}
 
-	reserve_bootmem(CPHYSADDR(initrd_start), size);
+	reserve_bootmem(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -259,8 +281,7 @@
 	 * not selected. Once that done we can determine the low bound
 	 * of usable memory.
 	 */
-	reserved_end = init_initrd();
-	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -432,10 +453,10 @@
 	if (UNCAC_BASE != IO_BASE)
 		return;
 
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext) - 1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata) - 1;
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
 
 	/*
 	 * Request address space for all standard RAM.
@@ -500,7 +521,7 @@
 #endif
 }
 
-int __init fpu_disable(char *s)
+static int __init fpu_disable(char *s)
 {
 	int i;
 
@@ -512,7 +533,7 @@
 
 __setup("nofpu", fpu_disable);
 
-int __init dsp_disable(char *s)
+static int __init dsp_disable(char *s)
 {
 	cpu_data[0].ases &= ~MIPS_ASE_DSP;
 

--=_server-5478-1173343616-0001-2--
