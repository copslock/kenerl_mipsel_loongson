Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id DAA371943; Fri, 22 Aug 1997 03:46:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA12948 for linux-list; Fri, 22 Aug 1997 03:45:42 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA12936 for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 03:45:35 -0700
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA26567
	for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 03:45:32 -0700
	env-from (oliver@aec.at)
Received: (from oliver@localhost) by aec.at (8.8.3/8.7) id MAA26641; Fri, 22 Aug 1997 12:45:19 +0200
Date: Fri, 22 Aug 1997 12:45:18 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: eak@detroit.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: "unable to handle kernel paging request" at boot
In-Reply-To: <199708211605.LAA08758@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.91.970822124206.26560A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Can you both guys fetch this kernel:
> 
> 	ftp://ftp.nuclecu.unam.mx/incoming/vmlinux 
> 
> and send me the output of the crash? 
>

now i get 

"Unable to handle kernel paging request at virtual address 00003004, epc == 
 880cb0d4, ra == 880cb698"

funny, i now get a scsi error after successfully (?) passing the eth driver 
init:

sda: scsi disk I/O error dev 08:00, sector 0
unable to read part. table

i guess that'd impose some problems to fdisk, too :)

o. 
