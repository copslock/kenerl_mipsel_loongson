Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6M9ttR07053
	for linux-mips-outgoing; Sun, 22 Jul 2001 02:55:55 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6M9tpV07043;
	Sun, 22 Jul 2001 02:55:51 -0700
Received: from rose.sonytel.be (rose.sonytel.be [10.17.0.5])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA12054;
	Sun, 22 Jul 2001 11:55:50 +0200 (MET DST)
Date: Sun, 22 Jul 2001 11:55:25 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, Fuxin Zhang <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: help on linux-mipsel frame buffer
In-Reply-To: <20010721172518.B25467@bacchus.dhis.org>
Message-ID: <Pine.GSO.4.10.10107221149430.8737-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 21 Jul 2001, Ralf Baechle wrote:
> On Sat, Jul 21, 2001 at 12:53:52PM +0200, Geert Uytterhoeven wrote:
> > That's because matroxfb is one of the few frame buffer devices that know how
> > to initialize uninitialized cards.
> 
> Is that true for all of the Matrox PCI cards or which would be your
> recommendation?

I think so.

I know not all features are supported for the latest Matrox cards, but these
are AGP only anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
