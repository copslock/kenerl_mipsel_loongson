Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MFTOqf031780
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 08:29:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MFTO33031779
	for linux-mips-outgoing; Mon, 22 Apr 2002 08:29:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MFTJqf031776
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 08:29:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA15670;
	Mon, 22 Apr 2002 17:30:08 +0200 (MET DST)
Date: Mon, 22 Apr 2002 17:30:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <Pine.GSO.4.21.0204221654140.17279-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1020422170125.7706H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Apr 2002, Geert Uytterhoeven wrote:

> >  Hmm, I admit I haven't looked at this matter, but aren't
> > in/out/ioperm/iopl implemented as library functions in glibc like for
> > other architectures doing MMIO?  E.g. Alpha does this an it makes porting
> 
> Perhaps. Note that you still need some /proc magic to find out the correct
> address to map. Or you can use /dev/ports.

 Well, for Alpha ioperm/iopl functions check the system type in
/proc/cpuinfo (we seem to have enough information there as well) and
failing this they check a result of readlink of /etc/alpha_systype.  Then
an appropriate region of /dev/mem is mmapped with per-page permissions set
up as requested if ioperm is used (with a worse granularity, though) and
subsequent in/out function invocations access the area as appropriate. 
See sysdeps/unix/sysv/linux/alpha/ioperm.c in glibc for details -- it's a
pretty clever solution with good performance and only a few trade-offs.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
