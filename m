Received:  by oss.sgi.com id <S553772AbRBHLHM>;
	Thu, 8 Feb 2001 03:07:12 -0800
Received: from mail.sonytel.be ([193.74.243.200]:52382 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553763AbRBHLHH>;
	Thu, 8 Feb 2001 03:07:07 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA07551;
	Thu, 8 Feb 2001 12:05:14 +0100 (MET)
Date:   Thu, 8 Feb 2001 12:05:14 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <E14QomC-0003Bu-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.10.10102081204300.23477-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 8 Feb 2001, Alan Cox wrote:
> > Yep, I put it on my m68k TODO list as well ;-)
> > 
> > Alternatively you can make (most of) it a loadable module. I don't think
> > /sbin/modprobe needs the FPU :-)
> 
> Task state init ?

That's why I wrote `(most of)'.

> m68k wants __mac __amiga and __atari as well of course ;)

Yep, one more thing for the list...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
