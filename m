Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA226321 for <linux-archive@neteng.engr.sgi.com>; Thu, 14 May 1998 03:03:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA09123
	for linux-list;
	Thu, 14 May 1998 03:02:19 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA86567
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 14 May 1998 03:02:17 -0700 (PDT)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id CAA14298
	for <linux@cthulhu.engr.sgi.com>; Thu, 14 May 1998 02:58:24 -0700 (PDT)
	mail_from (mjhsieh@life.nthu.edu.tw)
Received: from mjhsieh.life.nthu.edu.tw (mjhsieh.life.nthu.edu.tw [140.114.98.106])
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) with SMTP id RAA15260;
	Thu, 14 May 1998 17:46:35 +0800 (CST)
Message-Id: <3.0.3.32.19980514174806.006ee2d0@140.114.98.21>
X-Sender: mjhsieh@140.114.98.21
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.3 (32)
Date: Thu, 14 May 1998 17:48:06 +0800
To: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
From: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
Subject: Re: Installer changes...
In-Reply-To: <Pine.LNX.3.95.980513154459.9017D-100000@lager.engsoc.carle
 ton.ca>
References: <3.0.3.32.19980514032548.00730fa8@140.114.98.21>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

At 03:47 PM 1998/5/13 -0400, you wrote:
>On Thu, 14 May 1998, Francis M. J. Hsieh wrote:
>> I'm sorry if this was discussed in the maillist.
>> Should there be /etc dirctory after I cpio into my partition? I can't
>> find /etc in my linux partition under installer prompt.
>There should be a /etc in the ext2 file system after you run the
>installer.

This log is copied from my installation output. Is anyone having idea
what's wrong with the installation?

---->15# ./installer /dev/dsk/dks0d2s0
SGILinux Installer 2.6
Alan Cox (c) 1997 - based on the MacLinux68K installer 2.6
Copyright © 1997 by Christiaan Welvaart



mounted .
cjwsh>MAKEDEV                                
/dev doesn't exist, creating...
making standard devices & console
/dev/mem
/dev/kmem
/dev/null
/dev/port
/dev/zero
/dev/full
/dev/ram
/dev/tty
/dev/tty0
symlinking /dev/console to /dev/tty0

cjwsh>cpio root-be-0.04.cpio
.
.
.
[deleted]
.
.
.
D       dev/vcsa56
(failed to create)
D       dev/vcsa57
(failed to create)
D       dev/vcsa58
(failed to create)
D       dev/vcsa59
(failed to create)
D       dev/vcsa6
(failed to create)
D       dev/zero
(failed to create)
D       dev/vcsa60
(failed to create)
D       dev/vcsa61
(failed to create)
D       dev/vcsa62
(failed to create)
D       dev/vcsa63
(failed to create)
D       dev/vcsa7
(failed to create)
D       dev/vcsa8
(failed to create)
D       dev/vcsa9
(failed to create)
R       dev/need_disks_created
cjwsh>
--
Francis Meng Juei Hsieh, Life Science Department, NTHU, Taiwan. 
Welcome to Life Science BBS bbs.life.nthu.edu.tw
