Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02Fahd13045
	for linux-mips-outgoing; Wed, 2 Jan 2002 07:36:43 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02FaVg13041
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 07:36:33 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id D838E590A9; Wed,  2 Jan 2002 09:32:23 -0500 (EST)
Message-ID: <004d01c1939a$e6ab7ed0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Jun Sun" <jsun@mvista.com>, "Jim Paris" <jim@jtan.com>,
   "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0201021040260.1574-100000@vervain.sonytel.be>
Subject: Re: ISA
Date: Wed, 2 Jan 2002 09:36:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Jun Sun" <jsun@mvista.com>; "Jim Paris" <jim@jtan.com>; "Alan Cox"
<alan@lxorguk.ukuu.org.uk>; "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>;
"Linux/MIPS Development" <linux-mips@oss.sgi.com>
Sent: Wednesday, January 02, 2002 4:41 AM
Subject: Re: ISA


> On Tue, 1 Jan 2002, Bradley D. LaRonde wrote:
> > ----- Original Message -----
> > From: "Jun Sun" <jsun@mvista.com>
> > To: "Jim Paris" <jim@jtan.com>
> > Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Geert Uytterhoeven"
> > <Geert.Uytterhoeven@sonycom.com>; "Maciej W. Rozycki"
<macro@ds2.pg.gda.pl>;
> > "Linux/MIPS Development" <linux-mips@oss.sgi.com>
> > Sent: Tuesday, January 01, 2002 2:22 PM
> > Subject: Re: ISA
> >
> >
> > > 1. each address space has an id.
> > > 2. kernel pre-defines a couple of well-known ones, 0 for CPU physical,
> > >    1 for virtual, etc.
> > > 3. When drivers discover the devices, they get the address and also
> > >    the address space id where the address resides.
> > > 4. there are a set of macro's that converts/maps an address or an
> > >    address region from one space to another.
> >
> > The first thing that jumps out at me is that now every bus access has an
> > added switch in it.
> >
> > Either that or drivers would get back access function pointers, but that
> > eliminates the chance to inline trivial bus accesses.
>
> Not completely. ioremap() and friends can handle the address space ID and
> return an appropriate pointer. That pointer can still be handled by
readl() and
> friends.

Yup.  I forgot about having to run all bus addresses through ioremap.

Regards,
Brad
