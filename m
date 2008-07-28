Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 15:06:09 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:48409 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20023171AbYG1OGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 15:06:04 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Mon, 28 Jul 2008 14:05:55 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 28 Jul 2008 09:07:52 -0500
Subject: Re: [PATCH 1/1] Initialization of Alchemy boards
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <488D707A.4090800@movial.fi>
References: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
	 <488D707A.4090800@movial.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Mon, 28 Jul 2008 09:07:43 -0500
Message-Id: <1217254063.9208.3.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Dmitri,

On Mon, 2008-07-28 at 10:08 +0300, Dmitri Vorobiev wrote:
> Kevin Hickey wrote:
> > I found this when I updated to version 2.6.26.  None of my development
> > boards would boot.  It appears that a previous update changed some calls
> > to simple_strtol to strict_strtol but did not account for the different
> > call semantics.
> 
> Hi Kevin,
> 
> 1) you forgot to sign your patch off;
Indeed I did.  Is it sufficient to reply to the original post and add a
sign-off line?
> 2) please consider using git to generate and submit patches. At least according to my experience, it's much more convenient than any other approach.
It's starting to look that way to me.  I started my work here using SVN
because that's what I'm familiar with.  I did some reading about git
this weekend and I think I'm going to adopt it for future kernel
development.
> 3) As I can see, the board-specific code is almost identical for the pb1x00 boards. While at it, would you please try to merge it?
Yes, but in a future patch.  I'd like to get this one accepted ASAP
because it prevents 2.6.26+ from booting on any of our development
boards.  Next, I want to go through all of the db and pb board specific
code and see if I can condense any of it.
> 
> Regards,
> Dmitri
Thanks,
Kevin
> 
> > 
> > Index: arch/mips/au1000/pb1000/init.c
> > ===================================================================
> > --- arch/mips/au1000/pb1000/init.c
> > +++ arch/mips/au1000/pb1000/init.c
> > @@ -52,6 +52,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/pb1100/init.c
> > ===================================================================
> > --- arch/mips/au1000/pb1100/init.c
> > +++ arch/mips/au1000/pb1100/init.c
> > @@ -54,7 +54,7 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/pb1200/init.c
> > ===================================================================
> > --- arch/mips/au1000/pb1200/init.c
> > +++ arch/mips/au1000/pb1200/init.c
> > @@ -53,6 +53,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x08000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/mtx-1/init.c
> > ===================================================================
> > --- arch/mips/au1000/mtx-1/init.c
> > +++ arch/mips/au1000/mtx-1/init.c
> > @@ -55,6 +55,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/pb1500/init.c
> > ===================================================================
> > --- arch/mips/au1000/pb1500/init.c
> > +++ arch/mips/au1000/pb1500/init.c
> > @@ -53,6 +53,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/xxs1500/init.c
> > ===================================================================
> > --- arch/mips/au1000/xxs1500/init.c
> > +++ arch/mips/au1000/xxs1500/init.c
> > @@ -53,6 +53,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/pb1550/init.c
> > ===================================================================
> > --- arch/mips/au1000/pb1550/init.c
> > +++ arch/mips/au1000/pb1550/init.c
> > @@ -53,6 +53,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x08000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > Index: arch/mips/au1000/db1x00/init.c
> > ===================================================================
> > --- arch/mips/au1000/db1x00/init.c
> > +++ arch/mips/au1000/db1x00/init.c
> > @@ -57,6 +57,6 @@
> >  	if (!memsize_str)
> >  		memsize = 0x04000000;
> >  	else
> > -		memsize = strict_strtol(memsize_str, 0, NULL);
> > +		strict_strtol(memsize_str, 0, &memsize);
> >  	add_memory_region(0, memsize, BOOT_MEM_RAM);
> >  }
> > 
> 
-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
