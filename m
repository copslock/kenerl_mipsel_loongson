Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32Hkse20439
	for linux-mips-outgoing; Mon, 2 Apr 2001 10:46:54 -0700
Received: from dea.waldorf-gmbh.de (u-29-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.29])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32HkBM20416
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 10:46:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f32DKFK10981
	for linux-mips@oss.sgi.com; Mon, 2 Apr 2001 15:20:15 +0200
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f326W0M29375
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 23:32:01 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA17985;
	Mon, 2 Apr 2001 08:29:36 +0200 (MET DST)
Date: Mon, 2 Apr 2001 08:29:29 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Karel van Houten <vhouten@kpn.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Carsten Langgaard <carstenl@mips.com>,
   Keith M Wesolowski <wesolows@foobazco.org>, David Jez <dave.jez@seznam.cz>,
   linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
In-Reply-To: <200104011721.TAA13517@sparta.research.kpn.com>
Message-ID: <Pine.GSO.4.10.10104020828400.3028-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 1 Apr 2001, Houten K.H.C. van (Karel) wrote:
> "Maciej W. Rozycki" writes:
> >On Wed, 28 Mar 2001, Carsten Langgaard wrote:
> >
> >> Have the kernel fix made it into the CVS.
> >> If not, could you please resent it.
> >
> > I do not consider it clean enough for inclusion into the official kernel
> >at this stage.  It works, though.
> >
> > When appropriately cleaned up, I'll submit it to Linus as it's not
> >MIPS-specific and affects all systems -- mmap() fails equally badly on an
> >i386, for example.  No time to work on the patch at the moment, sorry.

So it may make sense to post the not-yet-cleant-up patch to linux-kernel now.
Perhaps someone there has more time to clean it up.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
