Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NMwb816772
	for linux-mips-outgoing; Mon, 23 Apr 2001 15:58:37 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3NMwYM16759
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 15:58:35 -0700
Received: (qmail 23824 invoked from network); 23 Apr 2001 22:58:32 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 23 Apr 2001 22:58:32 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: linux-mips@oss.sgi.com
Subject: 2.4.4-pre5 drivers/sgi/char/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 08:58:32 +1000
Message-ID: <12767.988066712@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to make sense of drivers/sgi/char/Makefile in 2.4.4-pre5.

export-objs     := newport.o shmiq.o sgicons.o usema.o
obj-y           := newport.o shmiq.o sgicons.o usema.o streamable.o

obj-$(CONFIG_SGI_SERIAL)        += sgiserial.o
obj-$(CONFIG_SGI_DS1286)        += ds1286.o
obj-$(CONFIG_SGI_NEWPORT_GFX)   += graphics.o rrm.o

None of newport.o shmiq.o sgicons.o usema.o export any symbols so why
are they defined as export-objs?  The only object that does export
symbols is graphics_syms.c and no Makefile refers to that source, it
appears to be dead.

I recommend removing all export-objs from drivers/sgi/char/Makefile and
deleting drivers/sgi/char/graphics_syms.c.
