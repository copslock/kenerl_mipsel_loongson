Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IBe3Z18845
	for linux-mips-outgoing; Fri, 18 Jan 2002 03:40:03 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IBdoP18840;
	Fri, 18 Jan 2002 03:39:52 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA16756;
	Fri, 18 Jan 2002 11:38:48 +0100 (MET)
Date: Fri, 18 Jan 2002 11:38:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Carsten Langgaard <carstenl@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
In-Reply-To: <Pine.GSO.3.96.1020117155914.16712A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0201181135580.28329-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.sonytel.be id LAA16756
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g0IBdsP18841
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 17 Jan 2002, Maciej W. Rozycki wrote:
> On Thu, 17 Jan 2002, Carsten Langgaard wrote:
> > But all other architectures does it this way, so I'm just trying to follow
> > the trend.
> 
>  It does not mean other architectures are right here.  Possibly they have
> not hit the problem so far.

Yes we have. On m68k we had to redefine insw() and friends as well.

But I agree it's an ugly hack that's been waiting for a clean up since many
years. We had IDE on m68k in 1994... But IIRC André is working on that (among
other things).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
