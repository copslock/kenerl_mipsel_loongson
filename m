Received:  by oss.sgi.com id <S553743AbRAPGri>;
	Mon, 15 Jan 2001 22:47:38 -0800
Received: from [193.74.243.200] ([193.74.243.200]:30601 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553708AbRAPGrI>;
	Mon, 15 Jan 2001 22:47:08 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA11781;
	Tue, 16 Jan 2001 07:46:39 +0100 (MET)
Date:   Tue, 16 Jan 2001 07:46:39 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Jun Sun <jsun@mvista.com>
cc:     Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS
In-Reply-To: <3A634542.65815387@mvista.com>
Message-ID: <Pine.GSO.4.10.10101160745440.3302-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 15 Jan 2001, Jun Sun wrote:
> Geert Uytterhoeven wrote:
> > On Fri, 12 Jan 2001, Justin Carlson wrote:
> > > I still would rather stick to the switch style of doing things in the future,
> > > though, because it's a bit more flexible; if you've got companies that fix
> > > errata without stepping PrID revisions or some such, then the table's going to
> > > have some strange special cases that don't quite fit.
> > >
> > > But this is much more workable than what I *thought* you were proposing.  And
> > > not worth nearly as much trouble as I've been giving you over it.
> > 
> > Then don't use a probe table, but a switch based CPU detection routine that
> > fills in a table of function pointers. So you need the switch only once.
> 
> Is there some concerns about using table?
> 
> mips_cpu structure is probably a mixture of data and function pointers.  To
> use a switch statement, one either supplies a function which will fill out the
> rest of member data in the structure, or fills in all the member data in the
> case block.  Compared with the table solution, the former case is too
> restricting (it mandates every CPU has its own "setup" routine") and the later
> case is less clean-looking.
> 
> Performance-wise table should be basically identical to switch statements.  It
> is a linear search of some integers (PrID).

Yes. But the advantage of the switch (`code table') over a data table is that
you can easier incorporate tests for special cases.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
