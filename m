Received:  by oss.sgi.com id <S553667AbRAOSpy>;
	Mon, 15 Jan 2001 10:45:54 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:55546 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553652AbRAOSpf>;
	Mon, 15 Jan 2001 10:45:35 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0FIgjC16277;
	Mon, 15 Jan 2001 10:42:45 -0800
Message-ID: <3A634542.65815387@mvista.com>
Date:   Mon, 15 Jan 2001 10:45:22 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC:     Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS
References: <Pine.GSO.4.10.10101150730420.4392-100000@escobaria.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven wrote:
> 
> On Fri, 12 Jan 2001, Justin Carlson wrote:
> > I still would rather stick to the switch style of doing things in the future,
> > though, because it's a bit more flexible; if you've got companies that fix
> > errata without stepping PrID revisions or some such, then the table's going to
> > have some strange special cases that don't quite fit.
> >
> > But this is much more workable than what I *thought* you were proposing.  And
> > not worth nearly as much trouble as I've been giving you over it.
> 
> Then don't use a probe table, but a switch based CPU detection routine that
> fills in a table of function pointers. So you need the switch only once.
> 

Geert,

Is there some concerns about using table?

mips_cpu structure is probably a mixture of data and function pointers.  To
use a switch statement, one either supplies a function which will fill out the
rest of member data in the structure, or fills in all the member data in the
case block.  Compared with the table solution, the former case is too
restricting (it mandates every CPU has its own "setup" routine") and the later
case is less clean-looking.

Performance-wise table should be basically identical to switch statements.  It
is a linear search of some integers (PrID).

Jun
