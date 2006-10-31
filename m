Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 07:41:09 +0000 (GMT)
Received: from farad.aurel32.net ([82.232.2.251]:28350 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20038467AbWKBHlG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2006 07:41:06 +0000
Received: from [2001:618:400:fc13:2d0:59ff:fe4a:19a9] (helo=henry.aurel32.net)
	by farad.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GfXC5-0007VK-Pi; Thu, 02 Nov 2006 08:40:57 +0100
Received: from aurel32 by henry.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1Gf08b-0005Vo-MY; Tue, 31 Oct 2006 21:23:09 +0100
Date:	Tue, 31 Oct 2006 21:23:09 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	qemu-devel@nongnu.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] QEMU: improvement of the initrd support for mips(el)
Message-ID: <20061031202309.GA16619@henry.aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

The attached patch improves the initrd support of the mips(el) platform
by passing the initrd size and location via the kernel command line. This
removes the need to pass them manually.

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="mips-qemu-initrd.patch"

--- hw/mips_r4k.c.orig	2006-10-30 23:28:58.000000000 +0100
+++ hw/mips_r4k.c	2006-10-31 14:59:33.000000000 +0100
@@ -121,7 +121,7 @@
     unsigned long bios_offset;
     int ret;
     CPUState *env;
-    long kernel_size;
+    long kernel_size, initrd_size;
     int i;
 
     env = cpu_init();
@@ -163,10 +163,11 @@
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
@@ -174,7 +175,17 @@
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

--a8Wt8u1KmwUX3Y2C--
