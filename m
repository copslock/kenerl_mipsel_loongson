Received:  by oss.sgi.com id <S553714AbQLLTGf>;
	Tue, 12 Dec 2000 11:06:35 -0800
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:57852
        "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP
	id <S553686AbQLLTGE>; Tue, 12 Dec 2000 11:06:04 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBCJnsS03207;
	Tue, 12 Dec 2000 11:49:54 -0800
Message-ID: <3A36743C.77A7651E@mvista.com>
Date:   Tue, 12 Dec 2000 10:53:48 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
References: <Pine.GSO.3.96.1001212121526.9082A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
> On Mon, 11 Dec 2000, Jun Sun wrote:
> 
> > I see.  It is funny that you cannot read/write memory beyond high_memory
> > through /dev/mem, but you can re-map it and then read/write through the
> > remapped region.
> 
>  I see it consistent.  The system memory can be treated like a stream of
> bytes.  That's much like any random-access file.  Other devices do not
> necessarily exhibit this behaviour.  They may implement side effects,
> values read may be different from what was written previously.  You may
> even achieve different effects by performing transfers of different
> widths.
> 
> > How do you control the width of bus transfers?  If you have direct access to
> > the device memory, the userland "drivers" should be able to deal with the bus
> > access width correctly.
> 
>  If you declare a location int32_t, gcc will perform a 32-bit access on
> assignment (lw/sw for MIPS).  If you declare a location int16_t, gcc will
> perform a 16-bit access (lh/sh for MIPS).  Ditto for int8_t (and for
> int64_t for 64-bit configurations).  Names of types do not matter, of
> course, sizeof -- does.  I just used the ISO C portable names for
> fixed-size types.  Please note you might need to use the "volatile"
> keyword or gcc might reorder or even optimize out certain accesses.
> 

I see the point now.  It is not such a good idea to map IO memory through a
file API, especially given that we have a working /dev/mem.

Ralf, I "officially" retract my previous patch.

Jun
