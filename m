Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id EAA03329
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 04:02:46 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA19733; Wed, 7 Jul 1999 18:59:34 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA37880
	for linux-list;
	Wed, 7 Jul 1999 18:54:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA93683;
	Wed, 7 Jul 1999 18:54:11 -0700 (PDT)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08529; Wed, 7 Jul 1999 18:54:09 -0700 (PDT)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.9.3/8.9.3) with ESMTP id TAA27082;
	Wed, 7 Jul 1999 19:53:57 -0600 (MDT)
	(envelope-from imp@harmony.village.org)
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id TAA05482; Wed, 7 Jul 1999 19:51:37 -0600 (MDT)
Message-Id: <199907080151.TAA05482@harmony.village.org>
To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Subject: Re: Memory corruption 
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        Ulf Carlsson <ulfc@thepuffingroup.com>,
        "William J. Earl" <wje@fir.engr.sgi.com>
In-reply-to: Your message of "Wed, 07 Jul 1999 23:08:57 +0200."
		<XFMail.990707230857.Harald.Koerfgen@home.ivm.de> 
References: <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>  
Date: Wed, 07 Jul 1999 19:51:37 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <XFMail.990707230857.Harald.Koerfgen@home.ivm.de> Harald Koerfgen writes:
: That's definitely true for R3k DECstations, and no, flushing the icache in
: flush_tlb_page() does not help. I have added cacheflushing to all tlb routines,
: copy_page and even rw_swap_page_base() and swap_after_unlock_page() without
: success.

Don'y you want to flush the dcache as well?  I think that you can run
into problems when you have a dirty dcache and then dma into the pages
that are dirty.  Instant karma corruption, no?  Or am I thinking of
some other problem?

Warner
