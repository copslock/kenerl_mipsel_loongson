Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4T70AH17997
	for linux-mips-outgoing; Tue, 29 May 2001 00:00:10 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4T708d17994
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 00:00:08 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA03833;
	Tue, 29 May 2001 08:57:33 +0200 (MET DST)
Date: Tue, 29 May 2001 08:57:33 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <Pine.GSO.3.96.1010528190412.15200Q-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10105290856100.27840-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 28 May 2001, Maciej W. Rozycki wrote:
> On Mon, 28 May 2001, Kevin D. Kissell wrote:
> > >  Are vr41xx plain ISA I or crippled ISA II+ CPUs?
> > 
> > Actually, they are crippled MIPS III+ 64-bit CPUs
> 
>  Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
> don't think we want to add _test_and_set() to mips64*-linux. 

Do you want to run a 64-bit kernel on a Vr41xx? Most of these are used in
embedded systems, where the amount of RAM is a few orders of magnitude smaller
than the 32-bit RAM limit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
