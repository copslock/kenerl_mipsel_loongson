Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FDgV8d023666
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 06:42:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FDgVAi023665
	for linux-mips-outgoing; Mon, 15 Apr 2002 06:42:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FDgQ8d023659
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 06:42:27 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 1B0CB8D39; Mon, 15 Apr 2002 15:43:15 +0200 (CEST)
Date: Mon, 15 Apr 2002 15:43:15 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
Message-ID: <20020415154314.A18602@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@oss.sgi.com
References: <20020413192811.GA25750@bogon.ms20.nix> <Pine.GSO.3.96.1020415144452.19735I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020415144452.19735I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 15, 2002 at 02:49:11PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 15, 2002 at 02:49:11PM +0200, Maciej W. Rozycki wrote:
> On Sat, 13 Apr 2002, Guido Guenther wrote:
> 
> > some of the recent head.S/init_task.c changes break addinitrd. In 2.4.16
> > we had two segments which allowed elf2ecoff to put everything (besides
> > bss) into one text section (dropping REGINFO) in the ecoff image leaving
> > the data section emtpy. Addinitrd then later merged the initial ramdisk
> > into that empty data section.
> 
>  Hmm, isn't that broken?  I believe an initial RAM disk should be added to
> an ELF image, before converting it to ECOFF.  Not everyone uses ECOFF and
> ELF is the "canonical" executable format for Linux.  Everything else is a
> derivative.
But we currently don't support relinking the ELF kernel to add a ramdisk,
do we [1]? Elf2ecoff/addinitrd is the only way I know of to achieve this
and I still don't understand why the recent init_task.c/head.S changes
where necessary which broke this.
 -- Guido

[1] I know that one can link a ramdisk into the ELF image but this
ramdisk hat to be available at kernel compile time which is not an option in
many situations(e.g. Debian "boot-floppies").
