Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA109320 for <linux-archive@neteng.engr.sgi.com>; Wed, 13 May 1998 12:28:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA22795
	for linux-list;
	Wed, 13 May 1998 12:26:59 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA23433
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 13 May 1998 12:26:57 -0700 (PDT)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA11236
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 12:26:38 -0700 (PDT)
	mail_from (mjhsieh@life.nthu.edu.tw)
Received: from mjhsieh.life.nthu.edu.tw (mjhsieh.life.nthu.edu.tw [140.114.98.106])
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) with SMTP id DAA11041;
	Thu, 14 May 1998 03:24:17 +0800 (CST)
Message-Id: <3.0.3.32.19980514032548.00730fa8@140.114.98.21>
X-Sender: mjhsieh@140.114.98.21
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.3 (32)
Date: Thu, 14 May 1998 03:25:48 +0800
To: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
From: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
Subject: Re: Installer changes...
In-Reply-To: <Pine.LNX.3.95.980513003341.15722A-100000@lager.engsoc.carl
 eton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

At 12:37 AM 1998/5/13 -0400, you wrote:
>As per Mike Shaver's suggestions, I've made some changes to root-be (now
>version 0.04), which affects Linux-installer (now version 0.2).  The
>changes listed are below. Tehy're all in teh GettingStarted directory.
>root-be chnages include adding ftp, libncurses and /etc/protocols,
>/etc/services and /etc/termcap.
>There's also now a script in /etc/rc.d which creates new sd* devices if
>they aren't created already.

I'm sorry if this was discussed in the maillist.

Should there be /etc dirctory after I cpio into my partition? I can't
find /etc in my linux partition under installer prompt.

BTW, I use the kernel in /pub/test/vmlinux-indy-2.1.99.tar.gz and got
panic. The "NICE" panic message is:

[deleted]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 blah:blah:blah:blah
Partition check
   blah....
   blah....
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 32k freed
Warning: unable to open an initial console.
kernel panic: No init found. Try passing init= optional to kernel.
[halt]

And I use the kernel in GetingStarted directory, and got panic, too.
("should not happened yet")
--
Francis Meng Juei Hsieh, Life Science Department, NTHU, Taiwan. 
Welcome to Life Science BBS bbs.life.nthu.edu.tw
