Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA878111 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 20:15:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA14071
	for linux-list;
	Mon, 18 May 1998 20:15:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id UAA03517
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 20:14:58 -0700 (PDT)
	mail_from (alambie@wellington.sgi.com)
Received: from wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI)
	 id PAA19735; Tue, 19 May 1998 15:13:47 +1200
Message-ID: <3560F8EA.789513D9@wellington.sgi.com>
Date: Tue, 19 May 1998 15:13:46 +1200
From: Alistair Lambie <alambie@wellington.sgi.com>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5-BETA-1274425944 IP22)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: Alistair Lambie <alambie@wellington.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Installer changes...
References: <Pine.LNX.3.95.980514111211.11757A-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> On Thu, 14 May 1998, Alistair Lambie wrote:
> > It stops right at the file /dev/need_disks_created.  There are a bunch
> > of errors before this.  The /dev/need_disks_created file does not seem
> > to get written to disk correctly....the e2fsck cleans it up by the looks
> > of things.  I guess there is something about the cpio that the installer
> > doesn't like.
> 
> Wow.  I really messed it up badly somehow.
> 
> I suspect it's having a problem writing a file that's 0 bytes long.  Let
> me repackage it, and make the file 1 byte.
> 

No, this is not the problem.  The problem is that the /dev directory is
getting too big for 'installer' to handle.  If I repackage the cpio
after deleting some files from the directory all is well.  Maybe we need
to do a very minimal package of the files in the /dev directory and run
some MAKEDEV's on first boot?

> As we speak, I'm debugging the initrd stuff in the kernel to sort out why
> initial ramdisks don't get loaded.
> 

I think this is the way to go for the future...saves maintaining
installer :-)

Cheers, Alistair

-- 
Alistair Lambie                         alambie@wellington.sgi.com
Silicon Graphics                      SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
