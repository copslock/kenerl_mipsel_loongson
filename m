Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4TCqp824428
	for linux-mips-outgoing; Tue, 29 May 2001 05:52:51 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4TCpsd24395
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 05:52:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA28041;
	Tue, 29 May 2001 12:45:16 +0200 (MET DST)
Date: Tue, 29 May 2001 12:45:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <Pine.GSO.4.10.10105290856100.27840-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010529123456.25861E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 29 May 2001, Geert Uytterhoeven wrote:

> >  Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
> > don't think we want to add _test_and_set() to mips64*-linux. 
> 
> Do you want to run a 64-bit kernel on a Vr41xx? Most of these are used in
> embedded systems, where the amount of RAM is a few orders of magnitude smaller
> than the 32-bit RAM limit.

 I have no preference on a Vr41xx, at least as long as I don't have one. 
You need an ll/sc emulation for it anyway, as you don't want to run ISA I
binaries on it, I suppose. 

 I wonder why ll/sc was skipped from it -- its hardware implementation is
quite simple... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
