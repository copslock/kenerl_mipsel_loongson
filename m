Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9R0Y7G18984
	for linux-mips-outgoing; Fri, 26 Oct 2001 17:34:07 -0700
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9R0Y3018981
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 17:34:04 -0700
Received: (qmail 11674 invoked from network); 27 Oct 2001 00:34:01 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 27 Oct 2001 00:34:01 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id ECD68300095; Sat, 27 Oct 2001 10:34:00 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP id D83D398
	for <linux-mips@oss.sgi.com>; Sat, 27 Oct 2001 10:34:00 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-mips@oss.sgi.com
Subject: Re: [PATCH] exporting PCI dma functions. 
In-reply-to: Your message of "Fri, 26 Oct 2001 13:13:32 MST."
             <Pine.LNX.4.10.10110261308470.2184-100000@transvirtual.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Oct 2001 10:33:55 +1000
Message-ID: <12047.1004142835@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 26 Oct 2001 13:13:32 -0700 (PDT), 
James Simmons <jsimmons@transvirtual.com> wrote:
>--- Makefile.orig	Fri Oct 26 13:08:58 2001
>+++ Makefile	Fri Oct 26 13:09:24 2001
>@@ -57,6 +57,7 @@
> obj-$(CONFIG_BINFMT_IRIX)	+= irixelf.o irixioctl.o irixsig.o sysirix.o \
> 				   irixinv.o
> obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-low.o gdb-stub.o 
>+export-objs			+= pci-dma.o
> obj-$(CONFIG_PCI)		+= pci-dma.o
> obj-$(CONFIG_PROC_FS)		+= proc.o

export-objs should go at the start of the Makefile, that is the
standard coding style for Makefiles.
