Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA115045 for <linux-archive@neteng.engr.sgi.com>; Wed, 13 May 1998 13:11:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA40060
	for linux-list;
	Wed, 13 May 1998 13:08:37 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA43047
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 13 May 1998 13:08:33 -0700 (PDT)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA27084
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 13:08:27 -0700 (PDT)
	mail_from (mjhsieh@life.nthu.edu.tw)
Received: from mjhsieh.life.nthu.edu.tw (mjhsieh.life.nthu.edu.tw [140.114.98.106])
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) with SMTP id EAA11137
	for <linux@cthulhu.engr.sgi.com>; Thu, 14 May 1998 04:06:44 +0800 (CST)
Message-Id: <3.0.3.32.19980514040816.007302f4@140.114.98.21>
X-Sender: mjhsieh@140.114.98.21
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.3 (32)
Date: Thu, 14 May 1998 04:08:16 +0800
To: linux@cthulhu.engr.sgi.com
From: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
Subject: Re: Installer changes...
In-Reply-To: <Pine.LNX.3.95.980513154459.9017D-100000@lager.engsoc.carle
 ton.ca>
References: <3.0.3.32.19980514032548.00730fa8@140.114.98.21>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

At 03:47 PM 1998/5/13 -0400, Alex deVries wrote:
>On Thu, 14 May 1998, Francis M. J. Hsieh wrote:
>> I'm sorry if this was discussed in the maillist.
>> Should there be /etc dirctory after I cpio into my partition? I can't
>> find /etc in my linux partition under installer prompt.
>There should be a /etc in the ext2 file system after you run the
>installer.  As far as I know, there is no way to read an ext2 partition
>from within Irix.

Sure, I browse the partition in installer.

>But it sounds like you're having problems even booting up...
[deleted]
>Hm.  You might want to run it with 'init=/bin/sh' to skip init.

Well, didn't work. :~(
--
Francis Meng Juei Hsieh, Life Science Department, NTHU, Taiwan. 
Welcome to Life Science BBS bbs.life.nthu.edu.tw
