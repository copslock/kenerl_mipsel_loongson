Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MI1Aqf006648
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 11:01:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MI1Asm006647
	for linux-mips-outgoing; Mon, 22 Apr 2002 11:01:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MI0wqf006638;
	Mon, 22 Apr 2002 11:00:59 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA19526;
	Mon, 22 Apr 2002 20:01:39 +0200 (MET DST)
Date: Mon, 22 Apr 2002 20:01:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
   Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <20020422104417.B10146@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020422194550.17636E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Apr 2002, Ralf Baechle wrote:

> >  Well, for Alpha ioperm/iopl functions check the system type in
> > /proc/cpuinfo (we seem to have enough information there as well) and
> > failing this they check a result of readlink of /etc/alpha_systype.  Then
> > an appropriate region of /dev/mem is mmapped with per-page permissions set
> > up as requested if ioperm is used (with a worse granularity, though) and
> > subsequent in/out function invocations access the area as appropriate. 
> > See sysdeps/unix/sysv/linux/alpha/ioperm.c in glibc for details -- it's a
> > pretty clever solution with good performance and only a few trade-offs.
> 
> Thanks for volunteering ;)

 Sure, but I have too many tasks on my to-do list now and no ISA/PCI MIPS
system to test code.  So anyone impatient enough, please do not hesitate
coding changes yourself.  Surely if you can afford waiting three years or
so, you probably need not worry as I shall have done it by then.  Also I'd
appreciate if someone sent me a system for testing.  This could actually
save you a year or two of waiting. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
