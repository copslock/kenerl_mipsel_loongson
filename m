Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id MAA120819 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 12:45:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA02231 for linux-list; Thu, 22 Jan 1998 12:43:26 -0800
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA02192 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 12:43:19 -0800
Received: from wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI)
	 id JAA19690; Fri, 23 Jan 1998 09:40:00 +1300
Message-ID: <34C7AE9F.25A38E49@wellington.sgi.com>
Date: Fri, 23 Jan 1998 09:39:59 +1300
From: Alistair Lambie <alambie@wellington.sgi.com>
X-Mailer: Mozilla 4.03C-SGI [en] (X11; I; IRIX 6.5-ALPHA-1274191040 IP22)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <Pine.LNX.3.95.980122005800.20627E-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> On Wed, 21 Jan 1998, Mike Shaver wrote:
> > Alex deVries wrote:
> > I _must_ start working on EFS again.  I assume I've missed the 2.2
> > freeze, but I could still help a lot of people by getting off my a** and
> > finishing it.  My apologies to those who are waiting on it.
> 
> Let me know if I can help.
> 
> Here's a question:  is it possible to boot off of the local disk without
> the image being on an EFS partition? Will I ever be able to have my
> machine have no EFS partition? How will ARC find the image?
> 
Couldn't we just put the vmlinux in the volume header and load it from
there....in fact you probably wouldn't even need sash.  Use dvhtool under irix
to add the image.  You may need to make a bigger volume header to fit it.  I'm
not 100% sure if this will work, but it's worth a try.

Cheers, Alistair

-- 
Alistair Lambie                         alambie@wellington.sgi.com
Silicon Graphics New Zealand                SGI Voicemail: 2431455
Level 5, Cigna House,                           Ph: +64-4-494 6325
40 Mercer St, Wellington, NZ                   Fax: +64-4-494 6321
