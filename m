Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34Dd0W17450
	for linux-mips-outgoing; Wed, 4 Apr 2001 06:39:00 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34DcxM17446
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 06:38:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA16152;
	Wed, 4 Apr 2001 06:36:18 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA20003;
	Wed, 4 Apr 2001 06:36:15 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA17252;
	Wed, 4 Apr 2001 15:35:32 +0200 (MEST)
Message-ID: <3ACB2323.C1653236@mips.com>
Date: Wed, 04 Apr 2001 15:35:31 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: Szabolcs Szakacsits <szaka@f-secure.com>,
   "Scott G. Miller" <scgmille@indiana.edu>, linux-kernel@vger.kernel.org,
   Andy Carlson <naclos@swbell.net>, linux-mips@oss.sgi.com
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
References: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm not sure what the problem is, but the whole deal about checking whether the
controller runs in 16 bit or 32 bit mode, is a little bit tricky.
There doesn't seem to be a clean way to do the check, so it's done by writing a certain
pattern to a register and read it back again.
Doing the check for 32 bit mode first seems to be the right thing to do, but it's
apparently breaks thing for some people with older chipsets.
It work fine on my site in both 16 bit and 32 bit mode, though (I'm using an AMD
Am97C973 chipset).
I can't remember exactly if that part of the fix really was necessary to get the driver
work in 32 bit mode, but at least the rest of the patch is necessary (it has been some
time since I made this fix and I originally did it in the 2.2.12 sources).
So I guess reverting the suggested part of the patch is appropriate.
I'm terrible sorry for causing any inconvenience.

/Carsten

Ralf Baechle wrote:

> Carsten,
>
> seems your pcnet32 changes which made it into 2.4.3 are causing trouble
> on i386 machines.  Can you try to solve that problem?
>
> On Sat, Mar 31, 2001 at 03:58:11PM +0200, Szabolcs Szakacsits wrote:
>
> > On Fri, 30 Mar 2001, Scott G. Miller wrote:
> >
> > > Linux 2.4.3, Debian Woody.  2.4.2 works without problems.  However, in
> > > 2.4.3, pcnet32 loads, gives an error message:
> >
> > 2.4.3 (and -ac's) are also broken as guest in VMWware due to the pcnet32
> > changes [doing 32 bit IO on 16 bit regs on the 79C970A controller].
> > Reverting this part of patch-2.4.3 below made things work again.
> >
> >       Szaka
> >
> > @@ -528,11 +535,13 @@
> >      pcnet32_dwio_reset(ioaddr);
> >      pcnet32_wio_reset(ioaddr);
> >
> > -    if (pcnet32_wio_read_csr (ioaddr, 0) == 4 && pcnet32_wio_check (ioaddr)) {
> > -       a = &pcnet32_wio;
> > +    /* Important to do the check for dwio mode first. */
> > +    if (pcnet32_dwio_read_csr(ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
> > +        a = &pcnet32_dwio;
> >      } else {
> > -       if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
> > -           a = &pcnet32_dwio;
> > +        if (pcnet32_wio_read_csr(ioaddr, 0) == 4 &&
> > +           pcnet32_wio_check(ioaddr)) {
> > +           a = &pcnet32_wio;
> >         } else
> >             return -ENODEV;
> >      }
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
