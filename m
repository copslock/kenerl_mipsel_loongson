Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FGH08d032271
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 09:17:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FGH00s032270
	for linux-mips-outgoing; Mon, 15 Apr 2002 09:17:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FGGs8d032265
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 09:16:55 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id BFC898D35; Mon, 15 Apr 2002 18:17:43 +0200 (CEST)
Date: Mon, 15 Apr 2002 18:17:43 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
Message-ID: <20020415181743.A24174@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@oss.sgi.com
References: <20020415154314.A18602@gandalf.physik.uni-konstanz.de> <Pine.GSO.3.96.1020415155842.19735L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020415155842.19735L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 15, 2002 at 04:09:41PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 15, 2002 at 04:09:41PM +0200, Maciej W. Rozycki wrote:
> On Mon, 15 Apr 2002, Guido Guenther wrote:
> 
> > >  Hmm, isn't that broken?  I believe an initial RAM disk should be added to
> > > an ELF image, before converting it to ECOFF.  Not everyone uses ECOFF and
> > > ELF is the "canonical" executable format for Linux.  Everything else is a
> > > derivative.
> > But we currently don't support relinking the ELF kernel to add a ramdisk,
> 
>  I don't know.  We are going to have to if the BOOTP/NFS-root code gets
> removed, which will supposedly happen quite soon.
> 
> > do we [1]? Elf2ecoff/addinitrd is the only way I know of to achieve this
> > and I still don't understand why the recent init_task.c/head.S changes
> > where necessary which broke this.
> 
>  Maybe because that's an ugly hack (as I can see from your description).
Are you telling me the only reason for the changes in init_task.c/head.S
were made to break the elf2ecoff/addinitrd "hack"? Where exactly was
there a hack in head.S/init_task.c. Please point me to the line of code
since I don't understand enough about the kernel to see it.

> 
> > [1] I know that one can link a ramdisk into the ELF image but this
> > ramdisk hat to be available at kernel compile time which is not an option in
> > many situations(e.g. Debian "boot-floppies").
> 
>  It depends on how a kernel gets built.  If we add "-r" to the current
> final link we'll get "vmlinux.o" that is a complete, self-contained
> kernel, that may be linked against a RAM-disk (or just relinked alone) 
> without a problem.  That's actually a generic solution and certainly
> something like this will likely have to get implemented as soon as a
> RAM-disk gets mandatory for block-device-less ;-) configurations. 
That's 2.5 stuff. We should not break expected behavior in 2.4.
 -- Guido
