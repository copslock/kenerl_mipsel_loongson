Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FE8c8d025005
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 07:08:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FE8clt025004
	for linux-mips-outgoing; Mon, 15 Apr 2002 07:08:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FE8W8d024999
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 07:08:33 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23441;
	Mon, 15 Apr 2002 16:09:41 +0200 (MET DST)
Date: Mon, 15 Apr 2002 16:09:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
In-Reply-To: <20020415154314.A18602@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.GSO.3.96.1020415155842.19735L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Apr 2002, Guido Guenther wrote:

> >  Hmm, isn't that broken?  I believe an initial RAM disk should be added to
> > an ELF image, before converting it to ECOFF.  Not everyone uses ECOFF and
> > ELF is the "canonical" executable format for Linux.  Everything else is a
> > derivative.
> But we currently don't support relinking the ELF kernel to add a ramdisk,

 I don't know.  We are going to have to if the BOOTP/NFS-root code gets
removed, which will supposedly happen quite soon.

> do we [1]? Elf2ecoff/addinitrd is the only way I know of to achieve this
> and I still don't understand why the recent init_task.c/head.S changes
> where necessary which broke this.

 Maybe because that's an ugly hack (as I can see from your description).

> [1] I know that one can link a ramdisk into the ELF image but this
> ramdisk hat to be available at kernel compile time which is not an option in
> many situations(e.g. Debian "boot-floppies").

 It depends on how a kernel gets built.  If we add "-r" to the current
final link we'll get "vmlinux.o" that is a complete, self-contained
kernel, that may be linked against a RAM-disk (or just relinked alone) 
without a problem.  That's actually a generic solution and certainly
something like this will likely have to get implemented as soon as a
RAM-disk gets mandatory for block-device-less ;-) configurations. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
