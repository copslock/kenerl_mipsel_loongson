Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 12:49:50 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:38076 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039316AbWJWLts (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 12:49:48 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GbyJK-0000Qa-Pk; Mon, 23 Oct 2006 13:49:42 +0200
Received: from aurel32 by bode.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1GbyFd-0008Ug-BO; Mon, 23 Oct 2006 13:45:53 +0200
Date:	Mon, 23 Oct 2006 13:45:53 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Daniel Jacobowitz <dan@debian.org>
Subject: Re: qemu initrd and ide support
Message-ID: <20061023114553.GA31520@bode.aurel32.net>
References: <20061012211228.GA17383@nevyn.them.org> <452F9744.9010109@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452F9744.9010109@aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 13, 2006 at 03:40:20PM +0200, Aurelien Jarno wrote:
> Hi!
Hi!

> Daniel Jacobowitz a écrit :
> >These patches for qemu let IDE and initrd work in the defconfig.
> >It seems to function - I was able to get as far as partitioning
> >the drive in the debian installer and the next time I started qemu
> >the new partitions were found.  But the installer hangs up trying
> >to format swap.
> >
> >Of course, what would be really nice would be a PCI controller.
> >I'm not brave enough to try.
> >
> >I'm not going to submit the qemu change until I have some better
> >evidence that it all works right (or someone else does).
> >
> 
> First of all, thanks a lot for your work, that makes QEMU mips more usable.
> 
> The IDE part works very well, though there seems to be some problems 
> with userland tools (mke2fs), an instruction is probably not/bad 
> emulated. I now have a system with the root on the IDE drive and with swap.
> 
> The initrd seems to works well, but it generates a strange failure 
> during the boot:
> 
> [...]
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  available.
> checking if image is initramfs...it isn't (bad gzip magic numbers); 
> looks like an initrd
> Bad page state in process 'swapper'
> page:81010000 flags:0x00080000 mapping:00000000 mapcount:0 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
> Call Trace:
>  [<8005c748>] bad_page+0x68/0xa8
>  [<8005ccf0>] free_hot_cold_page+0x1a4/0x1b4
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<80080138>] __fput+0x14c/0x1cc
>  [<8001b094>] free_init_pages+0xa4/0xfc
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<80288d98>] free_initrd+0x28/0x44
>  [<80288e80>] populate_rootfs+0xcc/0x110
>  [<80292860>] spawn_softlockup_task+0x30/0x50
>  [<80010498>] init+0x54/0x300
>  [<80010498>] init+0x54/0x300
>  [<80013074>] kernel_thread_helper+0x10/0x18
>  [<80013064>] kernel_thread_helper+0x0/0x18
> 
> Freeing initrd memory: 2520k freed
> NET: Registered protocol family 16
> NET: Registered protocol family 2
> [...]

As discussed on IRC, it seems the oops does not occurs on all system,
but we don't know what trigger it.

Alternatively, please find attached a patch to QEMU to pass the initrd
arguments directly in text, so that no modifications are needed in the
kernel.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="mips-qemu-initrd.patch"

Index: hw/mips_r4k.c
===================================================================
RCS file: /sources/qemu/qemu/hw/mips_r4k.c,v
retrieving revision 1.20
diff -u -d -p -r1.20 mips_r4k.c
--- hw/mips_r4k.c	18 Sep 2006 01:15:29 -0000	1.20
+++ hw/mips_r4k.c	23 Oct 2006 10:35:54 -0000
@@ -117,7 +117,7 @@ void mips_r4k_init (int ram_size, int vg
     unsigned long bios_offset;
     int ret;
     CPUState *env;
-    long kernel_size;
+    long kernel_size, initrd_size;
 
     env = cpu_init();
     register_savevm("cpu", 0, 3, cpu_save, cpu_load, env);
@@ -158,10 +158,11 @@ void mips_r4k_init (int ram_size, int vg
 	}
 
         /* load initrd */
+        initrd_size = 0;
         if (initrd_filename) {
-            if (load_image(initrd_filename,
-			   phys_ram_base + INITRD_LOAD_ADDR + VIRT_TO_PHYS_ADDEND)
-		== (target_ulong) -1) {
+            initrd_size = load_image(initrd_filename,
+                                     phys_ram_base + INITRD_LOAD_ADDR + VIRT_TO_PHYS_ADDEND);
+            if (initrd_size == (target_ulong) -1) {
                 fprintf(stderr, "qemu: could not load initial ram disk '%s'\n", 
                         initrd_filename);
                 exit(1);
@@ -169,7 +170,17 @@ void mips_r4k_init (int ram_size, int vg
         }
 
 	/* Store command line.  */
-        strcpy (phys_ram_base + (16 << 20) - 256, kernel_cmdline);
+        if (initrd_size > 0) {
+            ret = sprintf(phys_ram_base + (16 << 20) - 256, 
+                          "rd_start=0x%08x rd_size=%li ",
+                          INITRD_LOAD_ADDR,
+                          initrd_size);
+            strcpy (phys_ram_base + (16 << 20) - 256 + ret, kernel_cmdline);
+	}
+	else {
+            strcpy (phys_ram_base + (16 << 20) - 256, kernel_cmdline);
+	}
+
         /* FIXME: little endian support */
         *(int *)(phys_ram_base + (16 << 20) - 260) = tswap32 (0x12345678);
         *(int *)(phys_ram_base + (16 << 20) - 264) = tswap32 (ram_size);

--1yeeQ81UyVL57Vl7--
