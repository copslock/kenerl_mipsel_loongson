Received:  by oss.sgi.com id <S553821AbRAPP6e>;
	Tue, 16 Jan 2001 07:58:34 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:33010 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553809AbRAPP6c>; Tue, 16 Jan 2001 07:58:32 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869419AbRAPP5h>; Tue, 16 Jan 2001 13:57:37 -0200
Date:	Tue, 16 Jan 2001 13:57:37 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116135737.A13302@bacchus.dhis.org>
References: <20010115181133.A2439@paradigm.rfc822.org> <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl> <20010116153618.A1347@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116153618.A1347@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Jan 16, 2001 at 03:36:18PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 03:36:18PM +0100, Florian Lohoff wrote:

> -		base = __pa(p->base << PAGE_SHIFT);	/* Fix up from KSEG0 */
> +		base = p->base << PAGE_SHIFT;

This fix looks good.

> I get further down the road with memory initialisation.
> 
> Also the pages no in zone(0) looks much saner:
> 
> Before:
> 	On node 0 totalpages: 589824
> 	zone(0): 589824 pages.
> 
> 
> After:
> 	On node 0 totalpages: 65536
> 	zone(0): 65536 pages.

I probably already got used too machines with gigs of memory to notice ;-)

> Later on it crashes with:

> start_kernel, 541
> start_kernel, 543
> Calibrating system timer... 1250000 [250.00 MHz CPU]
> Got a bus error IRQ, shouldn't happen yet
> $0: 00000000 1004fc00 00000001 00000000
> $4: 88009cd8 00000000 00000008 00000000
> $8: 1004fc01 1000001f 0000000a 00000001
> $12: 00000000 00000004 00000000 00000001
> $16: 00000000 00000002 0000000a 880083d8
> $20: 00000001 a8746f70 9fc5c2b4 00000000
> $24: 00002590 00000001
> $28: 88008000 88009cd8 00000001 88010118
> epc: 880127b0
> Status: 1004fc03
> Cause: 10004000
> Status: 1004fc03
> Cause: 10004000
> Cause: 10004000

Can you decode the addresses in $epc and $31 for me?

  Ralf
