Received:  by oss.sgi.com id <S553822AbRAPQZy>;
	Tue, 16 Jan 2001 08:25:54 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:45046 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553706AbRAPQZj>; Tue, 16 Jan 2001 08:25:39 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869419AbRAPQYt>; Tue, 16 Jan 2001 14:24:49 -0200
Date:	Tue, 16 Jan 2001 14:24:49 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116142449.B13302@bacchus.dhis.org>
References: <20010116135737.A13302@bacchus.dhis.org> <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:06:29PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 05:06:29PM +0100, Maciej W. Rozycki wrote:

> On Tue, 16 Jan 2001, Ralf Baechle wrote:
> 
> > > Before:
> > > 	On node 0 totalpages: 589824
> > > 	zone(0): 589824 pages.
> > > 
> > > 
> > > After:
> > > 	On node 0 totalpages: 65536
> > > 	zone(0): 65536 pages.
> > 
> > I probably already got used too machines with gigs of memory to notice ;-)
> 
>  The number actually denotes the highest page, regardless of the number of
> pages, so you only need a single page placed far away from address zero to
> observe such large counts.

The Indy has it's memory starting at phys. 0x08000000; a part of it is also
mirrored at physical address zero.  So in case of an Indy the totalpages
number should indicate 128mb too much which means that Flo's machine should
have only 128mb real memory.  Right Florian?

> > Can you decode the addresses in $epc and $31 for me?
> 
>  Probably a memory access in free_all_bootmem() or so.

   Ralf
