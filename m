Received:  by oss.sgi.com id <S553838AbRAPQrp>;
	Tue, 16 Jan 2001 08:47:45 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4056 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553830AbRAPQrd>;
	Tue, 16 Jan 2001 08:47:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA18647;
	Tue, 16 Jan 2001 17:39:40 +0100 (MET)
Date:   Tue, 16 Jan 2001 17:39:40 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116172812.B7327@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010116173639.5546P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Florian Lohoff wrote:

> Wouldnt be this correct ? Realsize is size - holes.
> 
> Index: mm/page_alloc.c
> ===================================================================
> RCS file: /cvs/linux/mm/page_alloc.c,v
> retrieving revision 1.49
> diff -u -r1.49 page_alloc.c
> --- mm/page_alloc.c	2001/01/11 04:02:45	1.49
> +++ mm/page_alloc.c	2001/01/16 16:26:55
> @@ -824,7 +824,7 @@
>  		if (zholes_size)
>  			realsize -= zholes_size[j];
>  
> -		printk("zone(%lu): %lu pages.\n", j, size);
> +		printk("zone(%lu): %lu pages.\n", j, realsize);
>  		zone->size = size;
>  		zone->name = zone_names[j];
>  		zone->lock = SPIN_LOCK_UNLOCKED;

 It look reasonable but is it what was really intended?  You should ask
the author or linux-kernel, I suppose. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
