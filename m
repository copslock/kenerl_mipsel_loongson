Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MBYhqf028327
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 04:34:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MBYhPE028326
	for linux-mips-outgoing; Mon, 22 Apr 2002 04:34:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MBYcqf028323
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 04:34:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10044;
	Mon, 22 Apr 2002 13:35:23 +0200 (MET DST)
Date: Mon, 22 Apr 2002 13:35:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <Pine.GSO.4.21.0204201102260.16742-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1020422132125.7706C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 20 Apr 2002, Geert Uytterhoeven wrote:

> > Does anyone know how to implement ioperm / iopl type
> > functionality on a mips system. Any example code would
> > be appreciated.
> 
> Like on most architectures that use memory mapped I/O: mmap() the relevant
> portion of /dev/mem and read/write to/from the mapped area.

 Hmm, I admit I haven't looked at this matter, but aren't
in/out/ioperm/iopl implemented as library functions in glibc like for
other architectures doing MMIO?  E.g. Alpha does this an it makes porting
programs like XFree86 and SVGATextMode much more straightforward and less
processor-specific.  That makes sense as they are not processor specific
but rather bus-specific.  If we don't do that, we should.  For platforms
without an (E)ISA or a PCI bus ioperm/iopl would simply return an error.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
