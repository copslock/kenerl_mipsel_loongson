Received:  by oss.sgi.com id <S553920AbRAPTXj>;
	Tue, 16 Jan 2001 11:23:39 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:47351 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553913AbRAPTXc>; Tue, 16 Jan 2001 11:23:32 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870766AbRAPTWf>; Tue, 16 Jan 2001 17:22:35 -0200
Date:	Tue, 16 Jan 2001 17:22:35 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        Kanoj Sarcar <kanoj@engr.sgi.com>
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116172235.A1379@bacchus.dhis.org>
References: <20010116172812.B7327@paradigm.rfc822.org> <Pine.GSO.3.96.1010116173639.5546P-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116173639.5546P-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:39:40PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 05:39:40PM +0100, Maciej W. Rozycki wrote:

> > Wouldnt be this correct ? Realsize is size - holes.
> > 
> > Index: mm/page_alloc.c
> > ===================================================================
> > RCS file: /cvs/linux/mm/page_alloc.c,v
> > retrieving revision 1.49
> > diff -u -r1.49 page_alloc.c
> > --- mm/page_alloc.c	2001/01/11 04:02:45	1.49
> > +++ mm/page_alloc.c	2001/01/16 16:26:55
> > @@ -824,7 +824,7 @@
> >  		if (zholes_size)
> >  			realsize -= zholes_size[j];
> >  
> > -		printk("zone(%lu): %lu pages.\n", j, size);
> > +		printk("zone(%lu): %lu pages.\n", j, realsize);
> >  		zone->size = size;
> >  		zone->name = zone_names[j];
> >  		zone->lock = SPIN_LOCK_UNLOCKED;
> 
>  It look reasonable but is it what was really intended?  You should ask
> the author or linux-kernel, I suppose. 

Which probably is Kanoj who is subscribed to this list.

  Ralf
