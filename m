Received:  by oss.sgi.com id <S553926AbRAPTY6>;
	Tue, 16 Jan 2001 11:24:58 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:47351 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553922AbRAPTYr>; Tue, 16 Jan 2001 11:24:47 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870766AbRAPTXv>; Tue, 16 Jan 2001 17:23:51 -0200
Date:	Tue, 16 Jan 2001 17:23:51 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116172351.B1379@bacchus.dhis.org>
References: <20010116142449.B13302@bacchus.dhis.org> <Pine.GSO.3.96.1010116172956.5546O-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116172956.5546O-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:34:45PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 05:34:45PM +0100, Maciej W. Rozycki wrote:

> > The Indy has it's memory starting at phys. 0x08000000; a part of it is also
> > mirrored at physical address zero.  So in case of an Indy the totalpages
> > number should indicate 128mb too much which means that Flo's machine should
> > have only 128mb real memory.  Right Florian?
> 
>  The memory map suggests it is so.
> 
>  But how does the Indy handle our kernel being linked at 0x80000000?  Does
> the kernel always fit the mirrored area? 

Indy kernels are linked to 0x88002000.

  Ralf
