Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OExEC21881
	for linux-mips-outgoing; Tue, 24 Apr 2001 07:59:14 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OExAM21878
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 07:59:11 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3OEwom05593;
	Tue, 24 Apr 2001 11:58:50 -0300
Date: Tue, 24 Apr 2001 11:58:50 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.4-pre5 drivers/sgi/char/Makefile
Message-ID: <20010424115850.C5379@bacchus.dhis.org>
References: <12767.988066712@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12767.988066712@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Tue, Apr 24, 2001 at 08:58:32AM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 24, 2001 at 08:58:32AM +1000, Keith Owens wrote:

> I am trying to make sense of drivers/sgi/char/Makefile in 2.4.4-pre5.
> 
> export-objs     := newport.o shmiq.o sgicons.o usema.o
> obj-y           := newport.o shmiq.o sgicons.o usema.o streamable.o
> 
> obj-$(CONFIG_SGI_SERIAL)        += sgiserial.o
> obj-$(CONFIG_SGI_DS1286)        += ds1286.o
> obj-$(CONFIG_SGI_NEWPORT_GFX)   += graphics.o rrm.o
> 
> None of newport.o shmiq.o sgicons.o usema.o export any symbols so why
> are they defined as export-objs?  The only object that does export
> symbols is graphics_syms.c and no Makefile refers to that source, it
> appears to be dead.
> 
> I recommend removing all export-objs from drivers/sgi/char/Makefile and
> deleting drivers/sgi/char/graphics_syms.c.

The real fix is one of many patches pending to be merged with Linus ...

  Ralf
