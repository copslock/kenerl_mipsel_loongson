Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA266941 for <linux-archive@neteng.engr.sgi.com>; Thu, 14 May 1998 04:43:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA30262
	for linux-list;
	Thu, 14 May 1998 04:42:41 -0700 (PDT)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id EAA29722
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 14 May 1998 04:42:35 -0700 (PDT)
Received: from wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI)
	 id XAA23423; Thu, 14 May 1998 23:41:03 +1200
Message-ID: <355AD84E.F197D39E@wellington.sgi.com>
Date: Thu, 14 May 1998 23:41:02 +1200
From: Alistair Lambie <alambie@wellington.sgi.com>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5-BETA-1274425944 IP22)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Installer changes...
References: <Pine.LNX.3.95.980513154459.9017D-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> On Thu, 14 May 1998, Francis M. J. Hsieh wrote:
> > I'm sorry if this was discussed in the maillist.
> > Should there be /etc dirctory after I cpio into my partition? I can't
> > find /etc in my linux partition under installer prompt.
> 
> There should be a /etc in the ext2 file system after you run the
> installer.  As far as I know, there is no way to read an ext2 partition
> from within Irix.
> 
Alex,

It stops right at the file /dev/need_disks_created.  There are a bunch
of errors before this.  The /dev/need_disks_created file does not seem
to get written to disk correctly....the e2fsck cleans it up by the looks
of things.  I guess there is something about the cpio that the installer
doesn't like.

I tried extracting the cpio archive with Irix cpio and it seems fine.

Does that give any clues?  Just another thought...I'm running Irix
6.5beta.  Wonder if that could be causing a problem with the installer??

Cheers, Alistair


-- 
Alistair Lambie                         alambie@wellington.sgi.com
Silicon Graphics                      SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
