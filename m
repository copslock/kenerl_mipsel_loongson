Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15545; Wed, 5 Jun 1996 16:56:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA15640 for linux-list; Wed, 5 Jun 1996 23:56:43 GMT
Received: from titian (titian.engr.sgi.com [192.102.117.31]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15634; Wed, 5 Jun 1996 16:56:40 -0700
Received: from localhost by titian via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id QAA12520; Wed, 5 Jun 1996 16:56:40 -0700
Message-Id: <199606052356.QAA12520@titian>
To: "David S. Miller" <dm@neteng.engr.sgi.com>
cc: wje@fir.esd.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: netbooting 
In-reply-to: Your message of "Wed, 05 Jun 1996 16:38:09 PDT."
             <199606052338.QAA09961@neteng.engr.sgi.com> 
Date: Wed, 05 Jun 1996 16:56:39 -0700
From: Mike McDonald <mikemac@titian.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>Date: Wed, 5 Jun 1996 16:38:09 -0700
>From: "David S. Miller" <dm@neteng>
>To: wje@fir.esd.sgi.com
>Subject: Re: netbooting
>
>   Date: Wed, 5 Jun 1996 11:35:26 -0700
>   From: wje@fir.esd.sgi.com (William J. Earl)
>
>	On an Indy, the booted kernel (or other program) must be
>   in MIPS ECOFF format.
>
>Know whats strange, I can netboot big endian elf kernels from the ARCS
>command line monitor with zero problems on my target INDY. ;-)
>
>Later,
>David S. Miller
>dm@engr.sgi.com

  My understanding was that sash had to be COFF due to the proms but
that the newer versions of sash understood both COFF and ELF kernels.
Something like that anyway.

  Mike McDonald
  mikemac@engr.sgi.com
