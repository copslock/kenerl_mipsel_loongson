Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QKDmd07273
	for linux-mips-outgoing; Fri, 26 Oct 2001 13:13:48 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QKDb007270;
	Fri, 26 Oct 2001 13:13:37 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QKDWE0015352;
	Fri, 26 Oct 2001 13:13:32 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QKDWFg015348;
	Fri, 26 Oct 2001 13:13:32 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 26 Oct 2001 13:13:32 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] exporting PCI dma functions.
In-Reply-To: <Pine.LNX.4.10.10110251019420.8950-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.10.10110261308470.2184-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Several drivers that can be modularcall the functions in pci-dma.c in
arch/mips/kernel. The following patch exports these functions so the
modules don't fail.

--- Makefile.orig	Fri Oct 26 13:08:58 2001
+++ Makefile	Fri Oct 26 13:09:24 2001
@@ -57,6 +57,7 @@
 obj-$(CONFIG_BINFMT_IRIX)	+= irixelf.o irixioctl.o irixsig.o sysirix.o \
 				   irixinv.o
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-low.o gdb-stub.o 
+export-objs			+= pci-dma.o
 obj-$(CONFIG_PCI)		+= pci-dma.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
--- pci-dma.c	Mon Jun 25 12:09:29 2001
+++ /tmp/linux-mips/arch/mips/kernel/pci-dma.c	Fri Oct 26 12:57:32 2001
@@ -8,6 +8,7 @@
  * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
  */
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -47,3 +48,6 @@
 #endif
 	free_pages(addr, get_order(size));
 }
+
+EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(pci_free_consistent);
