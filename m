Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA23866
	for <pstadt@stud.fh-heilbronn.de>; Fri, 27 Aug 1999 00:39:55 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA04890; Thu, 26 Aug 1999 15:34:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA87301
	for linux-list;
	Thu, 26 Aug 1999 15:28:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA43060
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Aug 1999 15:28:19 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from paladin.real-time.com (paladin.real-time.com [206.10.252.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00216
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Aug 1999 15:28:14 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from real-time.com (mondas.dalekchess.org [206.147.104.202])
	by paladin.real-time.com (8.8.8/8.8.8) with ESMTP id RAA25535;
	Thu, 26 Aug 1999 17:27:47 -0500 (CDT)
Message-ID: <37C5BE0E.54A71DC6@real-time.com>
Date: Thu, 26 Aug 1999 17:22:07 -0500
From: Cory Jon Hollingsworth <cory@real-time.com>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Oeser <oeser@darmstadt.gmd.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Booting linux does not work fine.
References: <37C4F2A9.543E0E98@darmstadt.gmd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Jens Oeser wrote:

> Hi!
>
> I tried to install linux to my sgi indy yesterday, kernel starts up
> normally and hangs after "Freeing unused kernel memory 44k freed". Then
> i only can reboot the machine. I really don't find the thing causing
> that, maybe someone can give me an advise to get linux to work fine.
> Hardware:
> ip22 175mhz
> 64/128mb ram (Depends which machine)
> 2gb hdd (2nd machine 2x1GB).
> hinv says that i have a indy 24bit ... does this card is supported? I
> think so, because kernel messages are printed on the screen, so entire
> linux should do so.
> So how can i get linux working?
>
> regards.
> Jens Oeser

    I had the same problem when I installed Linux on my Tandem, an Indy
like machine.

    You might want to try one of the kernels from
ftp.linux.sgi.com/pub/linux/mips/test.  I had good luck with
vmlinux-indy-2.2.1-990329 which apparently fixes this problem for some of
the R4400 CPU based systems.  Just replace vmlinux in the NFS partition or
boop directory, depending on how you are doing the install, with this new
vmlinux-whatever.

    Good luck.
