Received:  by oss.sgi.com id <S553826AbRAPQaF>;
	Tue, 16 Jan 2001 08:30:05 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:5129 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553812AbRAPQ3z>;
	Tue, 16 Jan 2001 08:29:55 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B36A67F8; Tue, 16 Jan 2001 17:27:35 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C66FEF597; Tue, 16 Jan 2001 17:28:12 +0100 (CET)
Date:   Tue, 16 Jan 2001 17:28:12 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116172812.B7327@paradigm.rfc822.org>
References: <20010116135737.A13302@bacchus.dhis.org> <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:06:29PM +0100
Organization: rfc822 - pure communication
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

Wouldnt be this correct ? Realsize is size - holes.

Index: mm/page_alloc.c
===================================================================
RCS file: /cvs/linux/mm/page_alloc.c,v
retrieving revision 1.49
diff -u -r1.49 page_alloc.c
--- mm/page_alloc.c	2001/01/11 04:02:45	1.49
+++ mm/page_alloc.c	2001/01/16 16:26:55
@@ -824,7 +824,7 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk("zone(%lu): %lu pages.\n", j, realsize);
 		zone->size = size;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
