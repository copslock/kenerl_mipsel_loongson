Received:  by oss.sgi.com id <S554030AbRAQNUV>;
	Wed, 17 Jan 2001 05:20:21 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:49681 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554027AbRAQNUG>;
	Wed, 17 Jan 2001 05:20:06 -0800
Received: from google.engr.sgi.com ([163.154.10.145]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05192; Wed, 17 Jan 2001 05:19:55 -0800 (PST)
	mail_from (kanoj@google.engr.sgi.com)
Received: (from kanoj@localhost)
	by google.engr.sgi.com (SGI-8.9.3/8.9.3) id FAA98450;
	Wed, 17 Jan 2001 05:15:36 -0800 (PST)
From:   Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200101171315.FAA98450@google.engr.sgi.com>
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Wed, 17 Jan 2001 05:15:36 -0800 (PST)
Cc:     macro@ds2.pg.gda.pl (Maciej W. Rozycki),
        flo@rfc822.org (Florian Lohoff), linux-mips@oss.sgi.com,
        kanoj@engr.sgi.com (Kanoj Sarcar)
In-Reply-To: <20010116172235.A1379@bacchus.dhis.org> from "Ralf Baechle" at Jan 16, 2001 05:22:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 
> On Tue, Jan 16, 2001 at 05:39:40PM +0100, Maciej W. Rozycki wrote:
> 
> > > Wouldnt be this correct ? Realsize is size - holes.
> > > 
> > > Index: mm/page_alloc.c
> > > ===================================================================
> > > RCS file: /cvs/linux/mm/page_alloc.c,v
> > > retrieving revision 1.49
> > > diff -u -r1.49 page_alloc.c
> > > --- mm/page_alloc.c	2001/01/11 04:02:45	1.49
> > > +++ mm/page_alloc.c	2001/01/16 16:26:55
> > > @@ -824,7 +824,7 @@
> > >  		if (zholes_size)
> > >  			realsize -= zholes_size[j];
> > >  
> > > -		printk("zone(%lu): %lu pages.\n", j, size);
> > > +		printk("zone(%lu): %lu pages.\n", j, realsize);
> > >  		zone->size = size;
> > >  		zone->name = zone_names[j];
> > >  		zone->lock = SPIN_LOCK_UNLOCKED;
> > 
> >  It look reasonable but is it what was really intended?  You should ask
> > the author or linux-kernel, I suppose. 
> 
> Which probably is Kanoj who is subscribed to this list.
> 
>   Ralf
> 

realsize is fine, and that is what it is in Linus' tree. We want
to report actual number of pages, not number of pages including
the holes in memory.

Kanoj
