Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V79AY05833
	for linux-mips-outgoing; Tue, 31 Jul 2001 00:09:10 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V797V05826
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 00:09:08 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA22962;
	Tue, 31 Jul 2001 09:08:31 +0200 (MET DST)
Date: Tue, 31 Jul 2001 09:08:31 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Dave Airlie <airlied@csn.ul.ie>,
   SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010731002421.A19713@lug-owl.de>
Message-ID: <Pine.GSO.4.21.0107310903290.976-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.sonytel.be id JAA22962
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f6V798V05830
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 31 Jul 2001, Jan-Benedict Glaw wrote:
> On Mon, Jul 30, 2001 at 10:06:45PM +0200, Maciej W. Rozycki wrote:
> >  How about merging it into official sources?  This way your work won't get
> > lost and others won't try to reinvent the wheel.
> 
> Of course. I wouldn't even *try* to do sth other. In fact, I'm looking
> around for various specs of various implementations (as seen from
> the bus) of the LANCE chip to see if I could manage the job to
> unify them all together:
> 
> Driver file				      | Mentioned Chip
> ----------------------------------------------+--------------------

    [...]

> ./drivers/net/a2065.c				Am7990

When I wrote this one, I based it on ariadne.ce, but thanks to Jes Sørensen it
should look quite similar to sunlance now.

> ./drivers/net/ariadne.c				Am79c960

The Ariadne is a bit special, because it byteswaps the data bus of the Am79c960
(PC-Net ISA, hence little endian) by hardware so the big endian m68k/PPC Amiga
doesn't have to swap packet data. But that does mean that non-packet data has
to be byteswapped.

    [...]

> I really *hate* to see so many different implementations. That counts
> to about 21..25 pieces of code, always written for the same thing.

So this quote from my quote database is still valid ;-)

<QUOTE>
There are more Lance drivers than there are architectures
					-- Geert Uytterhoeven on linux-kernel
</QUOTE>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
