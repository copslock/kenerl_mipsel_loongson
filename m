Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OG81917555
	for linux-mips-outgoing; Fri, 24 Aug 2001 09:08:01 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OG7vd17552
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 09:07:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA16031;
	Fri, 24 Aug 2001 18:10:09 +0200 (MET DST)
Date: Fri, 24 Aug 2001 18:10:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <3B862174.435C0324@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010824175831.14758A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 24 Aug 2001, Gleb O. Raiko wrote:

> >  Well, other system might as well (e.g. DECstations can), but that doesn't
> > solve the problem -- to access firmware variables you need to know which
> > kind of firmware you are on.
> 
> No way at run-time. You have to choose the box during compilation in
> order to supply linker with proper load address.

 Does your firmware have a fixed load or entry address?  If so, it begs
for a position-independent boot loader (but not PIC in the ELF sense)  --
something like aboot for Alpha that can interpret ELF and optionally unzip
an image beforehand (aboot can't probably execute anywhere, though, as I
don't think gcc is able to emit such code).  Workstation/server class
firmware can usually deal with arbitrary load and entry addresses, but it
requires defining an interface to pass these values to the firmware and
certainly you don't have to put a kitchen sink into every piece of
firmware, especially for lightweight systems. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
