Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA09049 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 11:11:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA29352
	for linux-list;
	Thu, 16 Jul 1998 11:11:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA82015
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 11:11:03 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09169
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 11:11:02 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA16727;
	Thu, 16 Jul 1998 14:10:59 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 16 Jul 1998 14:10:59 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installing noarch packages
In-Reply-To: <199807161617.SAA14485@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980716140918.6127E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


there's a problem with /usr/lib/rpmrc then.  It should have a line like:
arch_compat: mipseb: noarch

If that doesn't work, try adding:
arch_compat: mips: noarch

in it.  Hm.  I thought I'd fixed that.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Thu, 16 Jul 1998, Honza Pazdziora wrote:

> Date: Thu, 16 Jul 1998 18:17:57 +0200 (MET DST)
> From: Honza Pazdziora <adelton@informatics.muni.cz>
> To: Honza Pazdziora <adelton@informatics.muni.cz>
> Cc: adevries@engsoc.carleton.ca, adelton@informatics.muni.cz,
>     linux@cthulhu.engr.sgi.com
> Subject: Installing noarch packages
> 
> 
> Hello,
> 
> when I try to install automake-1.3-2.noarch.rpm, I get
> 
> package automake-1.3-2 is for a different architecture
> error: automake-1.3-2.noarch.rpm cannot be installed
> 
> This is with rpm version 2.5.1 from HH 5.1 PR distribution. I even
> tried to build the automake rpm from src, got rpm fine but then
> ended with the same message. So I assume there is something wrong
> not with the noarch packages but with the rpm.
> 
> BTW: the swap really is recognized and mounted during boot. So
> probably the only fix that is needed is to get rid of that menu
> Repartition / Continue (or change conditions upon which it is
> displayed).
> 
> ------------------------------------------------------------------------
>  Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
>                    I can take or leave it if I please
> ------------------------------------------------------------------------
> 
